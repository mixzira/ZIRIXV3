local isNearPump = false
local isFueling = false
local currentFuel = 0.0
local currentFuel2 = 0.0
local currentCost = 0.0

function ManageFuelUsage(vehicle)
	if IsVehicleEngineOn(vehicle) then
		SetVehicleFuelLevel(vehicle,GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle),1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
		DecorSetFloat(vehicle,Config.FuelDecor,GetVehicleFuelLevel(vehicle))
	end
end

Citizen.CreateThread(function()
	DecorRegister(Config.FuelDecor,1)
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				ManageFuelUsage(vehicle)
			end
		end
	end
end)

function FindNearestFuelPump()
	local coords = GetEntityCoords(PlayerPedId())
	local fuelPumps = {}
	local handle,object = FindFirstObject()
	local success

	repeat
		if Config.PumpModels[GetEntityModel(object)] then
			table.insert(fuelPumps,object)
		end

		success,object = FindNextObject(handle,object)
	until not success

	EndFindObject(handle)

	local pumpObject = 0
	local pumpDistance = 1000

	for k,v in pairs(fuelPumps) do
		local dstcheck = GetDistanceBetweenCoords(coords,GetEntityCoords(v))

		if dstcheck < pumpDistance then
			pumpDistance = dstcheck
			pumpObject = v
		end
	end
	return pumpObject,pumpDistance
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)
		local pumpObject,pumpDistance = FindNearestFuelPump()
		if pumpDistance < 2.5 then
			isNearPump = pumpObject
		else
			isNearPump = false
			Citizen.Wait(math.ceil(pumpDistance*20))
		end
	end
end)

AddEventHandler('fuel:startFuelUpTick',function(pumpObject,ped,vehicle)
	currentFuel = GetVehicleFuelLevel(vehicle)
	currentFuel2 = GetVehicleFuelLevel(vehicle)
	while isFueling do
		Citizen.Wait(1)
		local oldFuel = DecorGetFloat(vehicle,Config.FuelDecor)
		local fuelToAdd = math.random(1,2) / 100.0
		local extraCost = fuelToAdd / 0.2

		if not pumpObject then
			if GetAmmoInPedWeapon(ped,883325847) - fuelToAdd * 100 >= 0 then
				currentFuel = oldFuel + fuelToAdd
				SetPedAmmo(ped,883325847,math.floor(GetAmmoInPedWeapon(ped,883325847) - fuelToAdd * 100))
			else
				isFueling = false
			end
		else
			currentFuel = oldFuel + fuelToAdd
		end

		if currentFuel > 100.0 then
			currentFuel = 100.0
			isFueling = false
		end

		currentCost = currentCost + extraCost

		SetVehicleFuelLevel(vehicle,currentFuel)
		DecorSetFloat(vehicle,Config.FuelDecor,GetVehicleFuelLevel(vehicle))
	end

	if pumpObject then
		TriggerServerEvent('vrp_legacyfuel:pagamento54',parseInt(currentCost),false,VehToNet(vehicle),GetVehicleFuelLevel(vehicle),currentFuel2)
	end

	currentCost = 0.0
end)

RegisterNetEvent("vrp_legacyfuel:insuficiente54")
AddEventHandler("vrp_legacyfuel:insuficiente54",function(index,fuel)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			SetVehicleFuelLevel(v,fuel)
			DecorSetFloat(v,Config.FuelDecor,GetVehicleFuelLevel(v))
		end
	end
end)

RegisterNetEvent("syncfuel")
AddEventHandler("syncfuel",function(index,fuel)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			SetVehicleFuelLevel(v,fuel)
			DecorSetFloat(v,Config.FuelDecor,GetVehicleFuelLevel(v))
		end
	end
end)

RegisterNetEvent("admfuel")
AddEventHandler("admfuel",function(index,vehicle,fuel)
	local vehicle = GetPlayersLastVehicle()
	if vehicle then
		currentFuel = 100.0
		SetVehicleFuelLevel(vehicle,currentFuel)
	end
end)

RegisterNetEvent('vrp_legacyfuel:galao54')
AddEventHandler('vrp_legacyfuel:galao54',function()
	GiveWeaponToPed(PlayerPedId(),883325847,4500,false,true)
end)

function Round(num,numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num*mult+0.5) / mult
end

AddEventHandler('fuel:refuelFromPump',function(pumpObject,ped,vehicle)
	TaskTurnPedToFaceEntity(ped,vehicle,5000)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0,8.0,-1,50,0,0,0,0)
	TriggerEvent('fuel:startFuelUpTick',pumpObject,ped,vehicle)

	while isFueling do
		Citizen.Wait(1)
		for k,v in pairs(Config.DisableKeys) do
			DisableControlAction(0,v)
		end

		local vehicleCoords = GetEntityCoords(vehicle)
		if pumpObject then
			local stringCoords = GetEntityCoords(pumpObject)
			DrawText3Ds(stringCoords.x,stringCoords.y,stringCoords.z + 1.2,"PRESSIONE ~g~E ~w~PARA CANCELAR")
			DrawText3Ds(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z + 0.5,"TANQUE: ~p~"..Round(currentFuel,1).."%")
		else
			DrawText3Ds(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z + 0.5,"PRESSIONE ~g~E ~w~PARA CANCELAR")
			DrawText3Ds(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z + 0.34,"GALÃO: ~b~"..Round(GetAmmoInPedWeapon(ped,883325847) / 4500 * 100,1).."%~w~    TANQUE: ~p~"..Round(currentFuel,1).."%")
		end

		if not IsEntityPlayingAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) then
			TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0,8.0,-1,50,0,0,0,0)
		end

		if IsControlJustReleased(0,38) or DoesEntityExist(GetPedInVehicleSeat(vehicle,-1)) or (isNearPump and GetEntityHealth(pumpObject) <= 0) then
			isFueling = false
		end
	end

	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if not isFueling and ((isNearPump and GetEntityHealth(isNearPump) > 0) or (GetSelectedPedWeapon(ped) == 883325847 and not isNearPump)) then
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped),-1) == ped then
				local pumpCoords = GetEntityCoords(isNearPump)
				DrawText3Ds(pumpCoords.x,pumpCoords.y,pumpCoords.z + 1.2,"SAIA DO ~p~VEÍCULO ~w~PARA ABASTECER")
			else
				local vehicle = GetPlayersLastVehicle()
				local vehicleCoords = GetEntityCoords(vehicle)
				if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(ped),vehicleCoords) < 2.5 then
					if not DoesEntityExist(GetPedInVehicleSeat(vehicle,-1)) then
						local stringCoords = GetEntityCoords(isNearPump)
						local canFuel = true
						if GetSelectedPedWeapon(ped) == 883325847 then
							stringCoords = vehicleCoords
							if GetAmmoInPedWeapon(ped,883325847) < 100 then
								canFuel = false
							end
						end

						if GetVehicleFuelLevel(vehicle) < 99 and canFuel then
							DrawText3Ds(stringCoords.x,stringCoords.y,stringCoords.z + 1.2,"PRESSIONE ~g~E ~w~PARA ABASTECER")
							if IsControlJustReleased(0,38) then
								isFueling = true
								TriggerEvent('fuel:refuelFromPump',isNearPump,ped,vehicle)
								LoadAnimDict("timetable@gardener@filling_can")
							end
						elseif not canFuel then
							DrawText3Ds(stringCoords.x,stringCoords.y,stringCoords.z + 1.2,"~o~GALÃO VAZIO")
						else
							DrawText3Ds(stringCoords.x,stringCoords.y,stringCoords.z + 1.2,"~g~TANQUE CHEIO")
						end
					end
				elseif isNearPump then
					local stringCoords = GetEntityCoords(isNearPump)
					DrawText3Ds(stringCoords.x,stringCoords.y,stringCoords.z + 1.2,"PRESSIONE ~g~E ~w~PARA COMPRAR UM ~b~GALÃO DE GASOLINA")
					if IsControlJustReleased(0,38) then
						TriggerServerEvent('vrp_legacyfuel:pagamento54',parseInt(300),true)
					end
				else
					Citizen.Wait(250)
				end
			end
		else
			Citizen.Wait(250)
		end
	end
end)

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)

	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(10)
		end
	end
end