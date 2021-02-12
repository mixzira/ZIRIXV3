local enroute = false
local mechPed = nil

function setCars(cars)
    SendNUIMessage({event = 'updateCars', cars = cars})
end

RegisterNUICallback('getCars', function(data)
    ESX.TriggerServerCallback('gcPhone:getCars', function(data)
        for i = 1, #data do
            model = GetDisplayNameFromVehicleModel(data[i]["props"].model)
            data[i]["props"].model = model
        end
        setCars(data)
    end)
end)

RegisterNUICallback('getCarsValet', function(data)
    if enroute then
        ESX.ShowNotification(_U('vale_gete'))
        return
    end

    local gameVehicles = ESX.Game.GetVehicles()

	for i = 1, #gameVehicles do
		local vehicle = gameVehicles[i]

        if DoesEntityExist(vehicle) then
            if ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)) == ESX.Math.Trim(data.props.plate) then
                local vehicleCoords = GetEntityCoords(vehicle)
                SetNewWaypoint(vehicleCoords.x, vehicleCoords.y)
				ESX.ShowNotification(_U('vale_getr'))
				return
			end
        end
    end

    TriggerServerEvent("gcPhone:valet-car-set-outside", data.props.plate)
    
    local player = PlayerPedId()
    local playerPos = GetEntityCoords(player)

    local driverhash = 999748158
    local vehhash = data.props.model

    while not HasModelLoaded(driverhash) and RequestModel(driverhash) or not HasModelLoaded(vehhash) and RequestModel(vehhash) do
        RequestModel(driverhash)
        RequestModel(vehhash)
        Citizen.Wait(0)
    end

    SpawnVehicle(playerPos.x, playerPos.y, playerPos.z, vehhash, driverhash, data.props)
end)

function SpawnVehicle(x, y, z, vehhash, driverhash, props)                                                     --Spawning Function
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(x + math.random(-100, 100), y + math.random(-100, 100), z, 0, 3, 0)

    ESX.Game.SpawnVehicle(vehhash, spawnPos, spawnHeading, function(callback_vehicle)
        SetVehicleHasBeenOwnedByPlayer(callback_vehicle, true)
        
        SetEntityAsMissionEntity(callback_vehicle, true, true)
        ClearAreaOfVehicles(GetEntityCoords(callback_vehicle), 5000, false, false, false, false, false);  
        SetVehicleOnGroundProperly(callback_vehicle)
        ESX.Game.SetVehicleProperties(callback_vehicle, props)
        
        mechPed = CreatePedInsideVehicle(callback_vehicle, 26, driverhash, -1, true, false)
        
        mechBlip = AddBlipForEntity(callback_vehicle)
        SetBlipFlashes(mechBlip, true)  
        SetBlipColour(mechBlip, 5)

        GoToTarget(x, y, z, callback_vehicle, mechPed, vehhash)
    end)
end

function GoToTarget(x, y, z, vehicle, driver, vehhash, target)
    enroute = true
    while enroute do
        Citizen.Wait(500)
        local player = PlayerPedId()
        local playerPos = GetEntityCoords(player)
        SetDriverAbility(driver, 1.0)
        SetDriverAggressiveness(driver, 0.0)
        TaskVehicleDriveToCoord(driver, vehicle, playerPos.x, playerPos.y, playerPos.z, 20.0, 0, vehhash, 4457279, 1, true)
        local distanceToTarget = #(playerPos - GetEntityCoords(vehicle))
        if distanceToTarget < 15 or distanceToTarget > 150 then
            RemoveBlip(mechBlip)
            TaskVehicleTempAction(driver, vehicle, 27, 6000)
            --SetVehicleUndriveable(vehicle, true)
            SetEntityHealth(mechPed, 2000)
            SetPedDropsWeaponsWhenDead(mechPed, false)
            SetPedAccuracy(mechPed, 100)
            GiveWeaponToPed(mechPed, GetHashKey('WEAPON_PUMPSHOTGUN'), 120, 0, 1)
            SetPedCanRagdoll(mechPed, false)
            GoToTargetWalking(x, y, z, vehicle, driver)
            enroute = false
        end
    end
end

function GoToTargetWalking(x, y, z, vehicle, driver)
    Citizen.Wait(500)
    TaskWanderStandard(driver, 10.0, 10)
    TriggerServerEvent('gcPhone:finish')
    Citizen.Wait(35000)
    DeletePed(mechPed)
    mechPed = nil
end