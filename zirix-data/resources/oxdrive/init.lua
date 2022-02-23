local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")

local function blob2string(blob)
    for i,c in pairs(blob) do
        blob[i] = string.char(c)
    end

    return table.concat(blob)
end

local function getTableToResult(result)
    if type(result) == 'table' then 
        for i in next, result do 
            if type(result[i]) == 'table' then 
                for k in next, result[i] do 
                    if type(result[i][k]) == 'table' then 
                        return table.unpack(result)
                    end
                end
            end
        end
    end
    return result
end

local queries = {}
local driver = exports.oxmysql

local function on_init(cfg)
    return driver ~= nil
end

local function on_prepare(name, query)
    queries[name] = query
end

local function on_query(name, params, mode)
    local query = queries[name]
    if type(query) ~= 'string' then
        print('^1Prepare inexistent ('..tostring(name)..').^0') 
        return 
    end
    local _params = {_ = true}
    for k,v in pairs(params) do 
        _params[k] = v 
    end
    local r = promise.new()
    if mode == "execute" then
        driver:query(query, _params, function(data)
            local data = data or {}
            r:resolve(data.affectedRows or 0)
        end)
    elseif mode == "scalar" then
        driver:scalar(query, _params, function(scalar)
            r:resolve(scalar)
        end)
    else
        driver:query(query, _params, function(rows)
            r:resolve(rows)
        end)
    end
    local resolve = Citizen.Await(r)
    return getTableToResult(resolve)
end

Citizen.CreateThreadNow(function()
    vRP.registerDBDriver("oxmysql", on_init, on_prepare, on_query)
end)