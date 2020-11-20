local Tools = module("lib/Tools")

local TriggerRemoteEvent = nil
local RegisterLocalEvent = nil
if SERVER then
	TriggerRemoteEvent = TriggerClientEvent
	RegisterLocalEvent = RegisterServerEvent
else
	TriggerRemoteEvent = TriggerServerEvent
	RegisterLocalEvent = RegisterNetEvent
end

local Tunnel = {}

Tunnel.delays = {}

function Tunnel.setDestDelay(dest,delay)
	Tunnel.delays[dest] = { delay,0 }
end

local function tunnel_resolve(itable,key)
	local mtable = getmetatable(itable)
	local iname = mtable.name
	local ids = mtable.tunnel_ids
	local callbacks = mtable.tunnel_callbacks
	local identifier = mtable.identifier
	local fname = key
	local no_wait = false
	if string.sub(key,1,1) == "_" then
		fname = string.sub(key,2)
		no_wait = true
	end

	local fcall = function(...)
		local r = nil
		local profile

		local args = {...} 
		local dest = nil
		if SERVER then
			dest = args[1]
			args = {table.unpack(args,2,table.maxn(args))}
			if dest >= 0 and not no_wait then
				r = async()
			end
		elseif not no_wait then
			r = async()
		end

		local delay_data = nil
		if dest then delay_data = Tunnel.delays[dest] end
		if delay_data == nil then
			delay_data = {0,0}
		end

		local add_delay = delay_data[1]
		delay_data[2] = delay_data[2]+add_delay

		if delay_data[2] > 0 then
			SetTimeout(delay_data[2], function()
				delay_data[2] = delay_data[2]-add_delay
				local rid = -1
				if r then
					rid = ids:gen()
					callbacks[rid] = r
				end

				if SERVER then
					TriggerRemoteEvent(iname..":tunnel_req",dest,fname,args,identifier,rid)
				else
					TriggerRemoteEvent(iname..":tunnel_req",fname,args,identifier,rid)
				end
			end)
		else
			local rid = -1
			if r then
				rid = ids:gen()
				callbacks[rid] = r
			end

			if SERVER then
				TriggerRemoteEvent(iname..":tunnel_req",dest,fname,args,identifier,rid)
			else
				TriggerRemoteEvent(iname..":tunnel_req",fname,args,identifier,rid)
			end
		end

		if r then
			if profile then
				local rets = { r:wait() }
				return table.unpack(rets,1,table.maxn(rets))
			else
				return r:wait()
			end
		end
	end

	itable[key] = fcall
	return fcall
end

function Tunnel.bindInterface(name,interface)
	RegisterLocalEvent(name..":tunnel_req")
	AddEventHandler(name..":tunnel_req",function(member,args,identifier,rid)
		local source = source

		local f = interface[member]

		local rets = {}
		if type(f) == "function" then
			rets = { f(table.unpack(args,1,table.maxn(args))) }
		end

		if rid >= 0 then
			if SERVER then
				TriggerRemoteEvent(name..":"..identifier..":tunnel_res",source,rid,rets)
			else
				TriggerRemoteEvent(name..":"..identifier..":tunnel_res",rid,rets)
			end
		end
	end)
end

function Tunnel.getInterface(name,identifier)
	if not identifier then identifier = GetCurrentResourceName() end
  
	local ids = Tools.newIDGenerator()
	local callbacks = {}
	local r = setmetatable({},{ __index = tunnel_resolve, name = name, tunnel_ids = ids, tunnel_callbacks = callbacks, identifier = identifier })

	RegisterLocalEvent(name..":"..identifier..":tunnel_res")
	AddEventHandler(name..":"..identifier..":tunnel_res",function(rid,args)
		local callback = callbacks[rid]
		if callback then
			ids:free(rid)
			callbacks[rid] = nil
			callback(table.unpack(args,1,table.maxn(args)))
		end
	end)
	return r
end

return Tunnel