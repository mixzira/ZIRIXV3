local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

misc = Tunnel.getInterface("vrp_machines")

RegisterNetEvent("vrp_machines:use")
AddEventHandler("vrp_machines:use",function()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped,0)
    local propMachine = nil
    local machineItem = nil
    

    for k,v in pairs(config.propItemMachines) do
        local machine = GetClosestObjectOfType(pedCoords["x"],pedCoords["y"],pedCoords["z"],1.0,GetHashKey(v.prop),true,true,true)
        SetEntityAsMissionEntity(machine, true, true)
        if DoesEntityExist(machine) then
            tstMachine = GetEntityCoords(machine, 0)
            local distance = GetDistanceBetweenCoords(tstMachine['x'], tstMachine['y'], tstMachine['z'], pedCoords['x'], pedCoords['y'], pedCoords['z'], true)
            if distance <= 1.2 and not IsPedInAnyVehicle(ped) then
                machineCoords = GetEntityCoords(machine, 0)
                propMachine = v.prop
                machineItem = v.item
                
            end
        end
    end

    if machineCoords ~= nil then
        if GetDistanceBetweenCoords(pedCoords["x"],pedCoords["y"],pedCoords["z"],machineCoords["x"],machineCoords["y"],machineCoords["z"] < 0.9) and not IsPedInAnyVehicle(ped) then
            if misc.buyMachine(machineItem) then
                SetTimeout(6000,function()
                    misc.machinePayment(machineItem)
                end)
            end
        end
    end
end)