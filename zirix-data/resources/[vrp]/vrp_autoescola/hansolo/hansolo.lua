local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

dmv = Tunnel.getInterface("vrp_autoescola")

local emaula = false
local onrota = false
local emrota = 0
local area = 0
local erros = 0
local emcolizao = false

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz,cdz = GetGroundZFor_3dCoord(226.11, 375.24, 106.12)
        local distance = GetDistanceBetweenCoords(226.11, 375.24,cdz,x,y,z,true)

        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 226.11, 375.24, 106.12, true ) < 5.1 and not emaula then
            DrawText3D(226.11, 375.24, 107.06, "Pressione [~g~E~w~] para ~g~TIRAR LICENÇA   ~w~[~g~G~w~] para ~g~SEGUNDA VIA~w~.")
            idle = 5
        end
        
        if distance < 1.5 then
            if IsControlJustPressed(0,38) then
                if dmv.checkcarlicense() then
                    if dmv.pagamento() and dmv.checkTime() and not emaula then
                        emaula = true
                        DoScreenFadeOut(1000)
                        Wait(1500)
                        TriggerEvent("autoescola:veiculo")
                    end
                else
                    TriggerEvent("Notify","negado","Você já possuí carteira de habilitação.")
                end
            end
            if IsControlJustPressed(0,47) then
                dmv.givelicense()
            end
        end
        Citizen.Wait(idle)
	end
end)

RegisterNetEvent('autoescola:veiculo')
AddEventHandler('autoescola:veiculo', function()
    DoScreenFadeIn(1000)
    local mhash = GetHashKey('dilettante2')
    local player = GetPlayerFromServerId(src)
    local ped = GetPlayerPed(player)

    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(1)
    end

    local nveh = CreateVehicle(mhash, 213.81, 390.05, 106.85-0.5, 173.2, true, false)
    local netveh = VehToNet(nveh)
    local id = NetworkGetNetworkIdFromEntity(nveh)

    NetworkRegisterEntityAsNetworked(nveh)
    while not NetworkGetEntityIsNetworked(nveh) do
        NetworkRegisterEntityAsNetworked(nveh)
        Citizen.Wait(1)
    end

    if NetworkDoesNetworkIdExist(netveh) then
        SetEntitySomething(nveh,true)
        if NetworkGetEntityIsNetworked(nveh) then
        SetNetworkIdExistsOnAllMachines(netveh,true)
        end
    end

    SetNetworkIdCanMigrate(id,true)
    SetPedIntoVehicle(ped,nveh,-1) 
    SetVehicleNumberPlateText(NetToVeh(netveh),"Auto-E")
    Citizen.InvokeNative(0xAD738C3085FE7E11,NetToVeh(netveh),true,true)
    SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
    SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
    SetModelAsNoLongerNeeded(mhash)
    SetVehRadioStation(NetToVeh(netveh),"OFF")

    Wait(1000)
    TriggerEvent("autoescola:rota")
end)

RegisterNetEvent('autoescola:rota')
AddEventHandler('autoescola:rota', function()

    TriggerEvent("Notify","importante","Sua aula de direção começou.")
    Wait(5000)
    TriggerEvent("Notify","importante","Siga a rota marcada em seu GPS seguindo as instruções de direção.")
    Wait(5000)
    TriggerEvent("Notify","importante","Você está sendo avaliado, seus erros podem acarretar na falha do seu teste.")
    Wait(5000)

    bliprota = AddBlipForCoord(214.75, 363.58, 106.23)
    SetBlipScale(bliprota,0.4)
    N_0x80ead8e2e1d5d52e(bliprota)
    SetBlipRoute(bliprota, 1)
    onrota = true
    emrota = 1
end)

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        
        if onrota then
            idle = 5
        end

        local source = source
        local user_id = vRP.getUserId(source)
        
        if emrota == 1 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 214.75, 363.58, 106.23, true) > 4.0001 then
                DrawMarker(21, 214.75, 363.58, 106.23, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(237.44, 346.18, 105.56)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","Verifique os dois lados da via, para garantir que está livre para proceguir.")
                Wait(5000)
                FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)

                area = 2
                emrota = 2
            end
        end

        if emrota == 2 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 237.44, 346.18, 105.56, true) > 4.0001 then
                DrawMarker(21, 237.44, 346.18, 105.56, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(549.12, 247.5, 103.11)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","Não é obrigatório esperar os semafaros em Diamond City, porém você deve parar em todos e garantir que a via está livre para seguir.")
                Wait(5000)
                FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)

                emrota = 3
            end
        end

        if emrota == 3 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 549.12, 247.5, 103.11, true) > 4.0001 then
                DrawMarker(21, 549.12, 247.5, 103.11, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(913.36, 520.65, 120.55)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","Atenção e cuidado ao atravessar esquinas.")

                emrota = 4
            end
        end

        if emrota == 4 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 913.36, 520.65, 120.55, true) > 4.0001 then
                DrawMarker(21, 913.36, 520.65, 120.55, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(1064.49, 407.65, 91.1)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","Dirigir embriagado é crime!")

                emrota = 5
            end
        end

        if emrota == 5 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1064.49, 407.65, 91.1, true) > 4.0001 then
                DrawMarker(21, 1064.49, 407.65, 91.1, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(532.59, -323.64, 43.58)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","O limite de velocidade das auto-estradas é de 120Km/h.")

                area = 3
                emrota = 7
            end
        end

        if emrota == 7 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 532.59, -323.64, 43.58, true) > 4.0001 then
                DrawMarker(21, 532.59, -323.64, 43.58, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(246.92, -221.15, 54.04)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","É proíbido estacionar em áreas cuja uma faixa vermelha está pintada na calçada.")

                area = 2
                emrota = 8
            end
        end

        if emrota == 8 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 246.92, -221.15, 54.04, true) > 4.0001 then
                DrawMarker(21, 246.92, -221.15, 54.04, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(-57.2, -103.0, 57.8)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","O limite de velocidade de áreas comerciais é de 80Km/h.")

                emrota = 9
            end
        end

        if emrota == 9 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -57.2, -103.0, 57.8, true) > 4.0001 then
                DrawMarker(21, -57.2, -103.0, 57.8, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(-40.29, 18.62, 72.01)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","O limite de velocidade de áreas residenciais é de 60Km/h.")
                Wait(5000)
                FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)

                area = 1
                emrota = 10
            end
        end

        if emrota == 10 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -40.29, 18.62, 72.01, true) > 4.0001 then
                DrawMarker(21, -40.29, 18.62, 72.01, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(30.87, 233.73, 109.55)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","Transitar com veículos danificados é crime!")

                emrota = 11
            end
        end

        if emrota == 11 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 30.87, 233.73, 109.55, true) > 4.0001 then
                DrawMarker(21, 30.87, 233.73, 109.55, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(201.65, 358.25, 106.4)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","Veículos de emergência possuem prioridade, de passagem!")

                emrota = 12
            end
        end

        if emrota == 12 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 201.65, 358.25, 106.4, true) > 4.0001 then
                DrawMarker(21, 201.65, 358.25, 106.4, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                bliprota = AddBlipForCoord(220.14, 377.39, 106.46)
                SetBlipScale(bliprota,0.4)
                N_0x80ead8e2e1d5d52e(bliprota)
                SetBlipRoute(bliprota, 1)

                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                TriggerEvent("Notify","importante","Você terminou seu teste, estacione na auto-escola para finalizar o percurso.")

                emrota = 13
            end
        end

        if emrota == 13 then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 220.14, 377.39, 106.46, true) > 4.0001 then
                DrawMarker(21, 220.14, 377.39, 106.46, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
            else
                if bliprota ~= nil and DoesBlipExist(bliprota) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bliprota))
                end

                onaero = false
                bliprota = nil
                emrota = 0

                FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
                DoScreenFadeOut(1000)
                Wait(1500)
                TriggerEvent('autoescola:final')
            end
        end

        Citizen.Wait(idle)
    end
end)

RegisterNetEvent('autoescola:final')
AddEventHandler('autoescola:final', function()
    local player = GetPlayerFromServerId(src)
    local ped = GetPlayerPed(player)
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    emaula = false

    SetVehicleHasBeenOwnedByPlayer(vehicle,false)
    Citizen.InvokeNative(0xAD738C3085FE7E11,vehicle,true,true)
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle))
    DeleteVehicle(vehicle)

    SetEntityCoords(PlayerPedId(), 231.28, 369.56, 106.14-0.50)
	SetEntityHeading(ped, 253.88)

    Wait(1500)
    DoScreenFadeIn(1000)
    Wait(1000)

    if erros > 3 then
        TriggerEvent("Notify","negado","Você reprovou no teste de direção! Tente novamente em alguns dias. ( Total de erros:"..erros.." )")
        erros = 0
    else
        dmv.sucesso()
        TriggerEvent("Notify","sucesso","Você foi aprovado em seu teste de direção! ( Total de erros:"..erros.." )")
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(3000)
        local ped = PlayerPedId()
        local pedcar = GetVehiclePedIsIn(ped)
        local velocidade = math.ceil(GetEntitySpeed(pedcar)*3.605936)

        if emaula then
            if area == 1 then
                if velocidade > 60  then
                    erros = erros + 1
                    TriggerEvent("Notify","negado","<b>Devagar!</b> Você está exedendo o limite de velocidade. ( Erros:"..erros.." )")
                end
            elseif area == 2 then
                if velocidade > 80  then
                    erros = erros + 1
                    TriggerEvent("Notify","negado","<b>Devagar!</b> Você está exedendo o limite de velocidade. ( Erros:"..erros.." )")
                end
            elseif area == 3 then
                if velocidade > 120  then
                    erros = erros + 1
                    TriggerEvent("Notify","negado","<b>Devagar!</b> Você está exedendo o limite de velocidade. ( Erros:"..erros.." )")
                end
            end
        end
	end
end)

Citizen.CreateThread(function()
	while true do
        local idle = 1000
        if emaula then
            idle = 5
            local ped = PlayerPedId()
            local pedcar = GetVehiclePedIsIn(ped)

            if area == 1 then
                drawTxt("LIMITE DE VELOCIDADE DA VIA: ~p~60~w~KM/h",4,0.5,0.92,0.35,255,255,255,255)
            elseif area == 2 then
                drawTxt("LIMITE DE VELOCIDADE DA VIA: ~p~80~w~KM/h",4,0.5,0.92,0.35,255,255,255,255)
            elseif area == 3 then
                drawTxt("LIMITE DE VELOCIDADE DA VIA: ~p~120~w~KM/h",4,0.5,0.92,0.35,255,255,255,255)
            end

            if HasEntityCollidedWithAnything(pedcar) and not emcolizao then
                emcolizao = true

                SetTimeout(3000,function()
                    emcolizao = false
                    erros = erros + 1
                    TriggerEvent("Notify","negado","<b>Cuidado!</b> Essa colisão lhe custará pontos do seu teste. ( Erros:"..erros.." )")
                end)
            end

            DisableControlAction(1,243,true)
            DisableControlAction(1,213,true)
            DisableControlAction(0,21,true) 
            DisableControlAction(0,24,true)
            DisableControlAction(0,25,true) 
            DisableControlAction(0,47,true) 
            DisableControlAction(0,49,true)
            DisableControlAction(0,44,true) 
            DisableControlAction(0,303,true) 
            DisableControlAction(0,246,true) 
            DisableControlAction(0,311,true) 
            DisableControlAction(0,58,true) 
            DisableControlAction(0,23,true) 
            DisableControlAction(0,263,true) 
            DisableControlAction(0,264,true) 
            DisableControlAction(0,257,true) 
            DisableControlAction(0,140,true) 
            DisableControlAction(0,141,true) 
            DisableControlAction(0,142,true)
            DisableControlAction(0,143,true) 
            DisableControlAction(0,75,true) 
            DisableControlAction(27,75,true)

        end
        Citizen.Wait(idle)
	end
end)

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

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end