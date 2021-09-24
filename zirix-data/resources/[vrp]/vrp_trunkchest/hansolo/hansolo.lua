local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONECTION ]--------------------------------------------------------------------------------------------------------------------------

vRPNserver = Tunnel.getInterface("vrp_trunkchest")
local vehicle = 0
local open = false
--[ STARTFOCUS ]-------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

--[ INVCLOSE ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("invClose",function(data)
	vRPNserver.chestClose()
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	open = false
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trytrunk",VehToNet(vehicle))
	end
end)

--[ TRUNK ]------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("vrp_trunkchest:Open")
AddEventHandler("vrp_trunkchest:Open",function()
	local ped = PlayerPedId()
	vehicle = vRP.getNearestVehicle(7)

	if config.realism then
		local nuser_id = vRP.getNearestPlayer(5)
		local trunkpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
		local playerpos = GetEntityCoords(GetPlayerPed(-1))
		local distanceToTrunk = GetDistanceBetweenCoords(trunkpos, playerpos, 1)
		if not IsPedInAnyVehicle(ped) and distanceToTrunk < 1.85 then
			if not nuser_id then
				if vRPNserver.trytrunk() then
					TransitionToBlurred(1000)
					SetNuiFocus(true,true)
					SendNUIMessage({ action = "showMenu" })
					open = true
					if IsEntityAVehicle(vehicle)  then
						TriggerServerEvent("trytrunk",VehToNet(vehicle))
					end
				end
			else
				TriggerEvent("Notify", "negado", "Não pode abrir o porta-malas com jogadores próximos a você")
			end
		end
	else
		local nuser_id = vRP.getNearestPlayer(6)
		local playerpos = GetEntityCoords(GetPlayerPed(-1))
		local wheel = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "wheel_rr"))
		local wheel2 = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "wheel_lr"))
		local x,y,z = table.unpack(wheel)
		local x2,y2,z2 = table.unpack(wheel2)
		local x3,y3,z3 = (x+x2)/2,(y+y2)/2,(z+z2)/2
		local distanceToVeh = 0
		if GetVehicleClass(vehicle) == 8 or GetVehicleClass(vehicle) == 15 or GetVehicleClass(vehicle) == 16 then
			distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(vehicle), playerpos, 1)
		else
			distanceToVeh = GetDistanceBetweenCoords(x3,y3,z3, playerpos, 1)
		end
		if not IsPedInAnyVehicle(ped) and distanceToVeh < 3 then
			if not nuser_id then
				if vRPNserver.trytrunk() then
					TransitionToBlurred(1000)
					SetNuiFocus(true,true)
					SendNUIMessage({ action = "showMenu" })
					open = true
					if IsEntityAVehicle(vehicle) then
						TriggerServerEvent("trytrunk",VehToNet(vehicle))
					end
				end
			else
				TriggerEvent("Notify", "negado", "Não pode abrir o porta-malas com jogadores próximos a você")
			end
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
	local inventory, trunkinventory, weight, maxweight, trunkweight, maxtrunkweight, tSlot, tcSlot = vRPNserver.Inventories()
	local imageService = config.imageService
	if inventory then
		cb({ inventory = inventory, trunkinventory = trunkinventory, weight = weight, maxweight = maxweight, trunkweight = trunkweight, maxtrunkweight = maxtrunkweight, tSlot = tSlot, tcSlot = tcSlot, imageService = imageService })	
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

Citizen.CreateThread(function()

	while true do
		if open then
			if not IsVehicleSeatFree(vehicle, -1) then
				vRPNserver.chestClose()
				TransitionFromBlurred(1000)
				SetNuiFocus(false,false)
				SendNUIMessage({ action = "hideMenu" })
				open = false
				if IsEntityAVehicle(vehicle) then
					TriggerServerEvent("trytrunk",VehToNet(vehicle))
				end
			end
		end
		Citizen.Wait(1000)
	end

end)