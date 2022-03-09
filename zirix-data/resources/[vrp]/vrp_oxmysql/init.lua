local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")

local queries = {}

function onInit(cfg)
    return MySQL ~= nil
end

function onPrepare(name, query)
    queries[name] = query
end

function onQuery(name, params, mode)
    local query = queries[name]

    if mode == "execute" then
        return MySQL.update.await(query, params)
    elseif mode == "scalar" then
        return MySQL.scalar.await(query, params)
    else
        local result = MySQL.query.await(query, params)
        if query:find(";.-SELECT.+LAST_INSERT_ID%(%)") then
            return { { id = result[1].insertId } }, result[1].affectedRows
        end
        return result, #result
    end
end

async(function()
    vRP.registerDBDriver("oxmysql", onInit, onPrepare, onQuery)
end)