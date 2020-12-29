local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

misc = Tunnel.getInterface("vrp_watercooler")

RegisterNetEvent("vrp_watercooler:use")
AddEventHandler("vrp_watercooler:use",function()
	local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped, 0)

    for k,v in pairs(config.propWaterCooler) do
        local cooler = GetClosestObjectOfType(pedCoords["x"],pedCoords["y"],pedCoords["z"],1.0,GetHashKey(v[1]),true,true,true)
        SetEntityAsMissionEntity(cooler, true, true)
        if DoesEntityExist(cooler) then
            distanceCooler = GetEntityCoords(cooler, 0)
            local distance = GetDistanceBetweenCoords(distanceCooler['x'], distanceCooler['y'], distanceCooler['z'], pedCoords['x'], pedCoords['y'], pedCoords['z'], true)
            if distance <= 1.2 then
                coolerCoords = GetEntityCoords(cooler, 0)
            end
        end
    end

    if coolerCoords ~= nil then
        if GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], coolerCoords["x"], coolerCoords["y"], coolerCoords["z"] <= 0.5) then
            if misc.searchCooler(coolerCoords["x"]) then
                SetTimeout(6000,function()
                    misc.coolerPayment()
                end)
            end
        end
    end
end)