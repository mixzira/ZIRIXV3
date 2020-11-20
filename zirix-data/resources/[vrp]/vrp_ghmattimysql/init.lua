local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")

local API = exports["GHMattiMySQL"]

local function on_init(cfg)
	return API ~= nil
end

local queries = {}

local function on_prepare(name,query)
	queries[name] = query
end

local function on_query(name,params,mode)
	local query = queries[name]
	local _params = {}
	_params._ = true

	for k,v in pairs(params) do
		_params["@"..k] = v
	end

	local r = async()

	if mode == "execute" then
		API:QueryAsync(query,_params,function(affected)
			r(affected or 0)
		end)
	elseif mode == "scalar" then
		API:QueryScalarAsync(query,_params,function(scalar)
			r(scalar)
		end)
	else
		API:QueryResultAsync(query,_params,function(rows)
			r(rows,#rows)
		end)
	end
	return r:wait()
end

Citizen.CreateThread(function()
	API:Query("SELECT 1")
	vRP.registerDBDriver("ghmattimysql",on_init,on_prepare,on_query)
end)