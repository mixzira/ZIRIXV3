local Tools = module("lib/Tools")

local Proxy = {}

local callbacks = setmetatable({}, { __mode = "v" })
local rscname = GetCurrentResourceName()

local function proxy_resolve(itable,key)
	local mtable = getmetatable(itable)
	local iname = mtable.name
	local ids = mtable.ids
	local callbacks = mtable.callbacks
	local identifier = mtable.identifier

	local fname = key
	local no_wait = false
	if string.sub(key,1,1) == "_" then
		fname = string.sub(key,2)
		no_wait = true
	end

	local fcall = function(...)
		local rid, r
		local profile

		if no_wait then
			rid = -1
		else
			r = async()
			rid = ids:gen()
			callbacks[rid] = r
		end

		local args = {...}

		TriggerEvent(iname..":proxy",fname, args, identifier, rid)
    
		if not no_wait then
			return r:wait()
		end
	end
	itable[key] = fcall
	return fcall
end

function Proxy.addInterface(name,itable)
	AddEventHandler(name..":proxy",function(member,args,identifier,rid)
		local f = itable[member]
		local rets = {}
		if type(f) == "function" then
			rets = {f(table.unpack(args,1,table.maxn(args)))}
		end
		if rid >= 0 then
			TriggerEvent(name..":"..identifier..":proxy_res",rid,rets)
		end
	end)
end

function Proxy.getInterface(name,identifier)
	if not identifier then identifier = GetCurrentResourceName() end
	local ids = Tools.newIDGenerator()
	local callbacks = {}
	local r = setmetatable({},{ __index = proxy_resolve, name = name, ids = ids, callbacks = callbacks, identifier = identifier })
	AddEventHandler(name..":"..identifier..":proxy_res", function(rid,rets)
		local callback = callbacks[rid]
		if callback then
			ids:free(rid)
			callbacks[rid] = nil
			callback(table.unpack(rets,1,table.maxn(rets)))
		end
	end)
	return r
end

return Proxy