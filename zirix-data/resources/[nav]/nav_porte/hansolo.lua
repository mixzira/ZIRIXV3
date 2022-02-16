
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

porte = Tunnel.getInterface("nav_porte")

--[ AÇÕES ]------------------------------------------------------------------------------------------------------------------------------

local armas = {
    { ['x'] = 447.44, ['y'] = -975.54, ['z'] = 30.69 }
}

--[ AÇÕES ]------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped) then
            local x,y,z = table.unpack(GetEntityCoords(ped))
            for k,v in pairs(armas) do
                local distance = Vdist(x,y,z,v.x,v.y,v.z)
                if distance < 10.5 then
                    idle = 5
                    --DrawMarker(23,v.x,v.y,v.z-0.98,0,0,0,0,0,0,0.7,0.7,0.5,255,215,0, 180,0,0,0,0)
                    DrawText3D(v.x, v.y, v.z, "Pressione [~p~E~w~] Comprar o Porte de Armas. ( ~g~€30000 Euros~w~ )")
                    if distance <= 1.5 and IsControlJustPressed(0,38) then
                        if porte.checkcarlicense() then
                            if porte.pagamento() then
                                porte.sucessoArma()
								TriggerEvent("Notify","sucesso","Agora tem Porte de Arma")
                            end
                        else
                            TriggerEvent("Notify","denegado","Já pussui um Porte de Armas.")
                        end
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end
end)

--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------

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
