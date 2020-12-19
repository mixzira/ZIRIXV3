local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]-------------------------------------------------------------------------------------------------------------------------

vRPNserver = Tunnel.getInterface("vrp_inventory")

vRPC = {}
Tunnel.bindInterface("vrp_inventory",vRPC)
Proxy.addInterface("vrp_inventory",vRPC)

--[ VARIABLES ]--------------------------------------------------------------------------------------------------------------------------

local invOpen = false
local usandoRemedios = false

--[ STARTFOCUS ]-------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

--[ INVCLOSE ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("invClose",function(data)
	StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
    TriggerEvent("status:celular",false)
end)

RegisterKeyMapping('vrp_inventory:useClick', 'Interação', 'keyboard','E')

RegisterCommand('vrp_inventory:useClick', function()
    TriggerEvent('vrp_trash:use')
    TriggerEvent('vrp_machines:use')
    TriggerEvent('vrp_chest:use')
    TriggerEvent('vrp_homes:join')
    TriggerEvent('vrp_homes:exit')
    TriggerEvent('vrp_homes:chest')
    TriggerEvent('vrp_homes:invade')
    TriggerEvent('vrp_shops:open')
end, false)


RegisterNUICallback("useClick",function(cb)
    TriggerEvent('vrp_trash:use')
    TriggerEvent('vrp_machines:use')
    TriggerEvent('vrp_chest:use')
    TriggerEvent('vrp_homes:join')
    TriggerEvent('vrp_homes:exit')
    TriggerEvent('vrp_homes:chest')
    TriggerEvent('vrp_homes:invade')
end)

RegisterNUICallback("unEquip",function(cb)
    vRPNserver.unEquip()
end)

--[ INVOPEN ]----------------------------------------------------------------------------------------------------------------------------

RegisterKeyMapping('vrp_inventory:openInv', 'Inventário', 'keyboard', config.openKey)

RegisterCommand('vrp_inventory:openInv', function()
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() and not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(ped) and vRPNserver.checkAuth() then
        if not invOpen then
            StartScreenEffect("MenuMGSelectionIn", 0, true)
            invOpen = true
            SetNuiFocus(true,true)
            SendNUIMessage({ action = "showMenu" })
            TriggerEvent("status:celular",true)
        else
            StopScreenEffect("MenuMGSelectionIn")
            SetNuiFocus(false,false)
            SendNUIMessage({ action = "hideMenu" })
            invOpen = false
            TriggerEvent("status:celular",false)
        end
    end
end, false)

--[ CLONEPLATES ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('cloneplates')
AddEventHandler('cloneplates',function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local clonada = GetVehicleNumberPlateText(vehicle)
    if IsEntityAVehicle(vehicle) then
        PlateIndex = GetVehicleNumberPlateText(vehicle)
        SetVehicleNumberPlateText(vehicle,"CLONADA")
        FreezeEntityPosition(vehicle,false)
        if clonada == CLONADA then 
            SetVehicleNumberPlateText(vehicle,PlateIndex)
            PlateIndex = nil
        end
    end
end)

--[ VEHICLEANCHOR ]----------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('vehicleanchor')
AddEventHandler('vehicleanchor',function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    FreezeEntityPosition(vehicle,true)
end)

--[ DROPITEM ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("dropItem",function(data)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        TriggerEvent("Notify","negado","Você não pode dropar itens quando estiver em um veículo.")
    else
        vRPNserver.dropItem(data.item,data.type,data.amount)
    end
end)

--[ SENDITEM ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("sendItem",function(data)
	vRPNserver.sendItem(data.item,data.type,data.amount)
end)

--[ USEITEM ]----------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("useItem",function(data)
	vRPNserver.useItem(data.item,data.type,data.amount)
end)

--[ INVENTORY ]--------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestInventory",function(data,cb)
    local inventario, peso, maxpeso, slots = vRPNserver.Inventory()
    local ip = config.imageServer
    if ip == '' then
        if vRPNserver.checkAuth() then
            ip = '192.99.251.232:3501'
        end
    end
    if vRPNserver.checkAuth()  then
        if inventario then
            cb({ inventario = inventario, peso = peso, maxpeso = maxpeso, slots = slots, ip = ip })
        end
    else
        TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
    end
end)

--[ AUTO-UPDATE ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("vrp_inventory:Update")
AddEventHandler("vrp_inventory:Update",function(action)
	SendNUIMessage({ action = action })
end)

RegisterNetEvent("vrp_inventory:fechar")
AddEventHandler("vrp_inventory:fechar",function(action)
    StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
end)

--[ USO REMÉDIO ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("remedios")
AddEventHandler("remedios",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped,health)
    TriggerEvent("rainda",armour)
    
    if GetEntityHealth(ped) < 300 then
        TriggerEvent("Notify","negado","<b>O remédio não fara feito, pois você precisa de tratamento</b>.",8000)
    else
        if usandoRemedios then
            return
        end

        usandoRemedios = true

        if usandoRemedios then
            repeat
                Citizen.Wait(600)
                if GetEntityHealth(ped) > 230 then
                    SetEntityHealth(ped,GetEntityHealth(ped)+1)
                end
            until GetEntityHealth(ped) >= 400 or GetEntityHealth(ped) <= 280
                TriggerEvent("Notify","sucesso","O medicamento acabou de fazer efeito.",8000)
                usandoRemedios = false
        end
    end
end)

--[ BACKPACK ]---------------------------------------------------------------------------------------------------------------------------

RegisterCommand("mochila",function(source,args)
    if vRPNserver.checkMochila() then
        if args[1] == "1" then
            SetPedComponentVariation(PlayerPedId(),5,52,0,2) -- Deserto;
        elseif args[1] == "2" then
            SetPedComponentVariation(PlayerPedId(),5,52,1,2) -- Camuflada;
        elseif args[1] == "3" then
            SetPedComponentVariation(PlayerPedId(),5,52,2,2) -- Camuflada 2;
        elseif args[1] == "4" then
            SetPedComponentVariation(PlayerPedId(),5,52,3,2) -- Verde;
        elseif args[1] == "5" then
            SetPedComponentVariation(PlayerPedId(),5,52,4,2) -- Preta;
        elseif args[1] == "6" then
            SetPedComponentVariation(PlayerPedId(),5,52,5,2) -- Preta com azul;
        elseif args[1] == "7" then
            SetPedComponentVariation(PlayerPedId(),5,52,6,2) -- Preta com cinza;
        elseif args[1] == "8" then
            SetPedComponentVariation(PlayerPedId(),5,52,7,2) -- Preta com deserto;
        elseif args[1] == "9" then
            SetPedComponentVariation(PlayerPedId(),5,52,8,2) -- Preta com branco;
        elseif args[1] == "10" then
            SetPedComponentVariation(PlayerPedId(),5,52,9,2) -- Preta com preto;
        end
    end
end)

RegisterNetEvent("inventory:mochilaon")
AddEventHandler("inventory:mochilaon",function()
    SetPedComponentVariation(PlayerPedId(),5,52,4,2)
end)

RegisterNetEvent("inventory:mochilaoff")
AddEventHandler("inventory:mochilaoff",function()
    SetPedComponentVariation(PlayerPedId(),5,-1,0,2)
end)

function vRPC.checkVida()
    local ped = PlayerPedId()
    if GetEntityHealth(ped) >= 280 and GetEntityHealth(ped) < 400 then
        return true
    end
    return false
end

--[ DRUNK ]------------------------------------------------------------------------------------------------------------------------------

local drunkStats = 0
local drunkLight = false
local drunkVery = false

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(30000)
        if drunkVery or drunkLight then
            if drunkStats > 0 then
                drunkStats = drunkStats - 1
                if drunkVery then
                    vRP.playScreenEffect("RaceTurbo",180)
                    vRP.playScreenEffect("DrugsTrevorClownsFight",180)
                end
            else
                TriggerEvent("Notify","importante","Você não está mais bebado.")
                ClearPedTasks(PlayerPedId())
                drunkLight = false
                drunkVery = false
            end
        end
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
        if drunkVery then
            idle = 1
            DisableControlAction(0,21) 
            DisableControlAction(0,22)
            DisableControlAction(0,36)
            DisableControlAction(0,70)
            RequestAnimSet("move_m@drunk@verydrunk")
            SetPedMovementClipset(PlayerPedId(),"move_m@drunk@verydrunk",true)
        elseif drunkLight then
            idle = 1
            DisableControlAction(0,21) 
            DisableControlAction(0,22)
            DisableControlAction(0,36)
            DisableControlAction(0,70)
            RequestAnimSet("move_m@drunk@moderatedrunk")
            SetPedMovementClipset(PlayerPedId(),"move_m@drunk@moderatedrunk",true)
        end
        Citizen.Wait(idle)
	end
end)

RegisterNetEvent("inventory:checkDrunk")
AddEventHandler("inventory:checkDrunk",function()
    local strengthStageOne = math.random(1,3)
    local strengthStageTwo = math.random(4,7)
    
    if drunkStats >= strengthStageTwo then
        DoScreenFadeOut(1000)
        Citizen.Wait(1100)
        
        vRP.playScreenEffect("RaceTurbo",180)
        vRP.playScreenEffect("DrugsTrevorClownsFight",180)
  
        Citizen.Wait(7000)
        DoScreenFadeIn(1000)

        TriggerEvent("Notify","importante","Você está bebado, pare de beber!")

        drunkLight = false
        drunkStats = drunkStats + 1
        drunkVery = true

    elseif drunkStats >= strengthStageOne then
        TriggerEvent("Notify","importante","Você está ficando bebado, pare de beber!")
        drunkStats = drunkStats + 1
        drunkLight = true

    else
        drunkStats = drunkStats + 1

    end
end)