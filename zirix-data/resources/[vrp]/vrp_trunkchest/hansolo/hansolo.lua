local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONECTION ]--------------------------------------------------------------------------------------------------------------------------

vRPNserver = Tunnel.getInterface("vrp_trunkchest")

--[ STARTFOCUS ]-------------------------------------------------------------------------------------------------------------------------

RegisterKeyMapping('vrp_trunkchest:trunk', '[V] Porta Malas', 'keyboard', config.openKey)

RegisterCommand('vrp_trunkchest:trunk',function(source, args, rawCommand)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		TriggerEvent('Notify','negado','Você não pode fazer isso dentro do carro.')
	else
		TriggerServerEvent('trytrunk:trunk')
	end
end)

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
	local inventory, trunkinventory, weight, maxweight, trunkweight, maxtrunkweight, tSlot, tcSlot = vRPNserver.Inventories()
	local ip = config.imageServer
	if ip == '' then
		if vRPNserver.checkStreaming() then
			ip = '192.99.251.232:3501'
		end
	end
	if vRPNserver.checkAuth() then
		if inventory then
			cb({ inventory = inventory, trunkinventory = trunkinventory, weight = weight, maxweight = maxweight, trunkweight = trunkweight, maxtrunkweight = maxtrunkweight, tSlot = tSlot, tcSlot = tcSlot, ip = ip })	
		end
	else
		TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
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