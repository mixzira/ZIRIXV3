local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

misc = {}
Tunnel.bindInterface('vrp_timesync',misc)

local hours = config.startHour
local minutes = config.startMinutes
local weather = config.standardWeather
local freeze = false
local freezeWeather = false

RegisterServerEvent('vrp_timesync:requestSync')
AddEventHandler('vrp_timesync:requestSync',function()
	TriggerClientEvent('vrp_timesync:updateWeather',-1,weather)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if not freeze then
			minutes = minutes + 1
			
			if minutes >= 60 then
				minutes = 0
				hours = hours + 1
				if hours >= 24 then
					hours = 0
				end
			end
			TriggerClientEvent('vrp_timesync:syncTimers',-1,hours,minutes)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(600000)
		if not freezeWeather then
			weather = config.climate[math.random(5)][1]
			TriggerClientEvent('vrp_timesync:updateWeather',-1,weather)
		end
	end
end)

RegisterCommand(config.climateCommand,function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	
	if user_id then
		if vRP.hasPermission(user_id,config.timePermission) then
			TriggerClientEvent('vrp_timesync:updateWeather',-1,args[1])
		end
	end
end)

RegisterCommand(config.changeHour,function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,config.timePermission) then
			local hour = parseInt(args[1])
			local minute = parseInt(args[2]) 
			if hour and minute and hour >= 0 and hour < 24 and minute >= 0 and minute < 60 then
				hours = hour
				minutes = minute
				TriggerClientEvent('vrp_timesync:syncTimers',-1,hour,minute)
			else
				TriggerClientEvent('Notify',source,"negado", "Valor invalido ou falta de argumentos")
			end
		else
			TriggerClientEvent('Notify',source,"negado", "Voce nao possui permissao para isso")	
		end
	end
end)

RegisterCommand(config.freeze,function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,config.timePermission) then
			freeze = not freeze
			if freeze then
				TriggerClientEvent('Notify',source,"sucesso", "Voce parou o tempo")
			else
				TriggerClientEvent('Notify',source,"sucesso", "Voce retomou o tempo")
			end
		else
			TriggerClientEvent('Notify',source,"negado", "Voce nao possui permissao para isso")	
		end
	end
end)

RegisterCommand(config.freezeWeather,function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,config.timePermission) then
			freezeWeather = not freezeWeather
			if freezeWeather then
				TriggerClientEvent('Notify',source,"sucesso", "Voce parou a troca de clima")
			else
				TriggerClientEvent('Notify',source,"sucesso", "Voce retomou a troca de clima")
			end
		else
			TriggerClientEvent('Notify',source,"negado", "Voce nao possui permissao para isso")	
		end
	end
end)