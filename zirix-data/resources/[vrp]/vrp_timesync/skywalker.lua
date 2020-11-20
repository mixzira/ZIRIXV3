local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

--[ CONNECTION ]-------------------------------------------------------------------------------------------------------------------------

misc = {}
Tunnel.bindInterface('vrp_timesync',misc)

--[ VARIABLES ]--------------------------------------------------------------------------------------------------------------------------

local hours = config.startHour
local minutes = config.startMinutes
local weather = config.standardWeather

--[ REQUESTSYNC ]------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('vrp_timesync:requestSync')
AddEventHandler('vrp_timesync:requestSync',function()
	TriggerClientEvent('vrp_timesync:updateWeather',-1,weather)
end)

--[ UPDATECLOCK ]------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
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
end)

--[ UPDATETIMERS ]-----------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(600000)
		weather = config.climate[math.random(5)][1]
		TriggerClientEvent('vrp_timesync:updateWeather',-1,weather)
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