local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONECTION ]--------------------------------------------------------------------------------------------------------------------------

vRPNserver = Tunnel.getInterface("vrp_trunkchest")

--[ STARTFOCUS ]-------------------------------------------------------------------------------------------------------------------------

RegisterKeyMapping('vrp_trunkchest:trunk', '[V] Porta Malas', 'keyboard', 'O')

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

--[ INVCLOSE ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("invClose",function(data)
	vRPNserver.chestClose()
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })

	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trytrunk",VehToNet(vehicle))
	end
end)

--[ TRUNK ]------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("trunkchest:Open")
AddEventHandler("trunkchest:Open",function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		TransitionToBlurred(1000)
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu" })

		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			TriggerServerEvent("trytrunk",VehToNet(vehicle))
		end
	end
end)

--[ TAKEITEM ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("takeItem",function(data)
	vRPNserver.takeItem(data.item,data.amount)
end)

--[ STOREITEM ]--------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("storeItem",function(data)
	vRPNserver.storeItem(data.item,data.amount,data.vehname)
end)

--[ REQUESTINVENTORIES ]-----------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestInventories",function(data,cb)
	
	local inventory, trunkinventory, weight, maxweight, trunkweight, maxtrunkweight = vRPNserver.Inventories()
	
	if inventory then
		cb({ inventory = inventory, trunkinventory = trunkinventory, weight = weight, maxweight = maxweight, trunkweight = trunkweight, maxtrunkweight = maxtrunkweight })
	end
end)

--[ AUTO ]-------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("Trunk:UpdateTrunk")
AddEventHandler("Trunk:UpdateTrunk",function(action)
	SendNUIMessage({ action = action })
end)

--[ OPEN/CLOSE TRUNK OF VEHICLE ]--------------------------------------------------------------------------------------------------------

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)