local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

vRPN = {}
Tunnel.bindInterface("vrp_doors",vRPN)
Proxy.addInterface("vrp_doors",vRPN)

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local idgens = Tools.newIDGenerator()
local cfg = module("vrp_doors","config/config")
local timers = {}
local pick = {}
local blips = {}

--[ SPAWN | EVENT ]-------------------------------------------------------------------------------------------------------------

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		TriggerClientEvent('vrpdoorsystem:load',source,cfg.list)
	end
end)

--[ OPEN DOOR PERMISSION | EVENT ]----------------------------------------------------------------------------------------------

RegisterServerEvent('vrpdoorsystem:open')
AddEventHandler('vrpdoorsystem:open',function(id)
	local source = source
	local user_id = vRP.getUserId(source)
	
	if vRP.hasPermission(user_id,cfg.list[id].perm) or vRP.hasPermission(user_id,cfg.list[id].perm2) or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		cfg.list[id].lock = not cfg.list[id].lock
		TriggerClientEvent('vrpdoorsystem:statusSend',-1,id,cfg.list[id].lock)
		if cfg.list[id].other ~= nil then
			local idsecond = cfg.list[id].other
			cfg.list[idsecond].lock = cfg.list[id].lock
			TriggerClientEvent('vrpdoorsystem:statusSend',-1,idsecond,cfg.list[id].lock)
		end
	end
end)

--[ TIMERS ID | THREAD ]--------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
	end
end)

--[ OPEN DOOR TIME | FUNCTION ]-------------------------------------------------------------------------------------------------

function vRPN.timeOpen(id)
	TriggerClientEvent('vrpdoorsystem:statusSend',-1,id,false)
	if cfg.list[id].other ~= nil then
		local idsecond = cfg.list[id].other
		cfg.list[idsecond].lock = cfg.list[id].lock
		TriggerClientEvent('vrpdoorsystem:statusSend',-1,idsecond,false)
	end
end

--[ CLOSE DOOR TIME | FUNCTION ]------------------------------------------------------------------------------------------------

function vRPN.timeClose(id)
	if timers[id] == 0 or not timers[id] then
		TriggerClientEvent('vrpdoorsystem:statusSend',-1,id,true)
		if cfg.list[id].other ~= nil then
			local idsecond = cfg.list[id].other
			cfg.list[idsecond].lock = cfg.list[id].lock
			TriggerClientEvent('vrpdoorsystem:statusSend',-1,idsecond,true)
		end
	else
		TriggerClientEvent('vrpdoorsystem:statusSend',-1,id,false)
		if cfg.list[id].other ~= nil then
			local idsecond = cfg.list[id].other
			cfg.list[idsecond].lock = cfg.list[id].lock
			TriggerClientEvent('vrpdoorsystem:statusSend',-1,idsecond,false)
		end
	end
end

--[ FORCE OPEN DOOR | FUNCTION ]------------------------------------------------------------------------------------------------

function vRPN.forceOpen(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if timers[id] == 0 or not timers[id] then
		timers[id] = 120
		TriggerClientEvent('vrpdoorsystem:statusSend',-1,id,false)
		if cfg.list[id].other ~= nil then
			if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and vRP.tryGetInventoryItem(user_id,"lockpick",1) then
				local idsecond = cfg.list[id].other
				cfg.list[idsecond].lock = cfg.list[id].lock
				TriggerClientEvent('vrpdoorsystem:statusSend',-1,idsecond,false)

				local policia = vRP.getUsersByPermission("policia.permissao")
				local x,y,z = vRPclient.getPosition(source)

				for k,v in pairs(policia) do
					local player = vRP.getUserSource(parseInt(v))
					if player then
						async(function()
							local id = idgens:gen()
							vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
							TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Alarme de estabelecimento disparando.")
							pick[id] = vRPclient.addBlip(player,x,y,z,10,1,"Ocorrência",0.5,false)
							SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
						end)
					end
				end
			end
		end
	end
end