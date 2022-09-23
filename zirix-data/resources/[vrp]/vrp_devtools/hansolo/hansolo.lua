local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
Api = Tunnel.getInterface(GetCurrentResourceName())
local abuserjail = false



RegisterNUICallback(GetCurrentResourceName(),function()
 Api.punish()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('abuserjail')
AddEventHandler('abuserjail',function(status)
	abuserjail = status
	local ped = PlayerPedId()
	if abuserjail then
		--SetEntityInvincible(ped,true)
		FreezeEntityPosition(ped,true)
		--SetEntityVisible(ped,false,false)
		SetTimeout(10000,function()
			--SetEntityInvincible(ped,false)
			FreezeEntityPosition(ped,false)
			--SetEntityVisible(ped,true,false)
		end)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if prisioneiro then
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1700.5,2605.2,45.5,true)
			if distance >= 150 then
				SetEntityCoords(PlayerPedId(),1680.1,2513.0,45.5)
				TriggerEvent("Notify","aviso","O agente penitenciário encontrou você tentando escapar.")
			end
		end
	end
end)