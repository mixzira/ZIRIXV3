local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]---------------------------------------------------------------------------------------

misc = Tunnel.getInterface("vrp_trash")

--[ VARIABLES ]----------------------------------------------------------------------------------------

--[ THREADS ]------------------------------------------------------------------------------------------

RegisterNetEvent("vrp_trash:use")
AddEventHandler("vrp_trash:use",function()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped, 0)
    local trashEmpty = false

    for k,v in pairs(config.propTrashCans) do
        local trash = GetClosestObjectOfType(pedCoords["x"], pedCoords["y"], pedCoords["z"], 1.0, GetHashKey(v[1]), true, true, true)
        SetEntityAsMissionEntity(trash, true, true)
        if DoesEntityExist(trash) then
            trashCoords = GetEntityCoords(trash, 0)
        end
    end

    if trashCoords ~= nil then
        if (GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], trashCoords["x"], trashCoords["y"], trashCoords["z"] < 0.5)) then
            if misc.searchTrash(trashCoords["x"]) then
                SetTimeout(6000,function()
                    misc.trashPayment()
                end)
            end
        end
    end
end)

--[ EVENTS ]-------------------------------------------------------------------------------------------

RegisterNetEvent('vrp_trash:trashAnim')
AddEventHandler('vrp_trash:trashAnim', function()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(6000)
    ClearPedTasks(PlayerPedId())
end)

--[ FUNCTIONS ]----------------------------------------------------------------------------------------

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end