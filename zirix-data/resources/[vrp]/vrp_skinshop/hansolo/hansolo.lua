local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPrp = {}
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP")
Tunnel.bindInterface("vrp_skinshop", vRPrp)
Proxy.addInterface("vrp_skinshop", vRPrp)

local lojaderoupa = {
    { x = 428.47, y = -800.0, z = 29.5, provador = { x = 428.47, y = -800.0, z = 29.5, heading = 94.31 }, home = false },
    { x = 72.68, y = -1399.14, z = 29.38, provador = { x = 72.68, y = -1399.14, z = 29.38, heading = 271.47 }, home = false },
    { x = -829.11, y = -1074.34, z = 11.33, provador = { x = -829.11, y = -1074.34, z = 11.33, heading = 221.63 }, home = false },
    { x = -1188.31, y = -765.26, z = 17.32, provador = { x = -1188.31, y = -765.26, z = 17.32, heading = 138.23 }, home = false },
    { x = -158.81, y = -296.32, z = 39.74, provador = { x = -158.81, y = -296.32, z = 39.74, heading = 159.87 }, home = false },
    { x = 123.22, y = -228.6, z = 54.56, provador = { x = 123.22, y = -228.6, z = 54.56, heading = 340.62 }, home = false },
    { x = -708.15, y = -160.96, z = 37.42, provador = { x = -708.15, y = -160.96, z = 37.42, heading = 31.71 }, home = false },
    { x = -1457.34, y = -241.74, z = 49.81, provador = { x = -1457.34, y = -241.74, z = 49.81, heading = 317.52 }, home = false },
    { x = -3173.37, y = 1038.94, z = 20.87, provador = { x = -3173.37, y = 1038.94, z = 20.87, heading = 338.00 }, home = false },
    { x = -1107.87, y = 2708.42, z = 19.11, provador = { x = -1107.87, y = 2708.42, z = 19.11, heading = 229.84 }, home = false },
    { x = 614.55, y = 2768.46, z = 42.09, provador = { x = 614.55, y = 2768.46, z = 42.09, heading = 177.90 }, home = false },
    { x = 1190.47, y = 2712.88, z = 38.23, provador = { x = 1190.47, y = 2712.88, z = 38.23, heading = 182.06 }, home = false },
    { x = 1695.82, y = 4829.31, z = 42.07, provador = { x = 1695.82, y = 4829.31, z = 42.07, heading = 99.29 }, home = false },
    { x = 11.13, y = 6514.7, z = 31.88, provador = { x = 11.13, y = 6514.7, z = 31.88, heading = 48.03 }, home = false },
    { x = -437.42, y = -307.67, z = 34.92, provador = { x = -437.42, y = -307.67, z = 34.92, heading = 202.06 }, home = false },
    { x = -599.36, y = -915.0, z = 33.59, provador = { x = -599.36, y = -915.0, z = 33.59, heading = 359.08 }, home = false },
    { x = -345.31, y = -123.05, z = 39.01, provador = { x = -345.31, y = -123.05, z = 39.01, heading = 255.18 }, home = false },
    { x = -1381.04, y = -470.96, z = 72.05, provador = { x = -1381.04, y = -470.96, z = 72.05, heading = 96.86 }, home = false },
    { x = -3219.28, y = 783.71, z = 14.09, provador = { x = -3219.28, y = 783.71, z = 14.09, heading = 299.99 }, home = true },
    { x = -3219.41, y = 811.05, z = 8.95, provador = { x = -3219.41, y = 811.05, z = 8.95, heading = 96.41 }, home = true },
    { x = -572.94, y = -201.79, z = 42.71, provador = { x = -572.94, y = -201.79, z = 42.71, heading = 28.96 }, home = false }
}

local parts = {
    mascara = 1,
    mao = 3,
    calca = 4,
    mochila = 5,
    sapato = 6,
    gravata = 7,
    camisa = 8,
    jaqueta = 11,
    bone = "p0",
    oculos = "p1",
    brinco = "p2",
    relogio = "p6",
    bracelete = "p7"
}

local carroCompras = {
    mascara = false,
    mao = false,
    calca = false,
    mochila = false,
    sapato = false,
    gravata = false,
    camisa = false,
    jaqueta = false,
    bone = false,
    oculos = false,
    brinco = false,
    relogio = false,
    bracelete = false
}

local old_custom = {}

local valor = 0
local precoTotal = 0

local in_loja = false
local atLoja = false

local chegou = false
local noProvador = false

local pos = nil
local camPos = nil
local cam = -1
local dataPart = 1
local texturaSelected = 0
local handsup = false

function SetCameraCoords()
    local ped = PlayerPedId()
	RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    
	if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
		SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)

        pos = GetEntityCoords(PlayerPedId())
        camPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
        SetCamCoord(cam, camPos.x, camPos.y, camPos.z+0.75)
        PointCamAtCoord(cam, pos.x, pos.y, pos.z+0.15)
    end

end

function DeleteCam()
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 0, true, true)
	cam = nil
end

RegisterNUICallback("changePart", function(data, cb)
    dataPart = parts[data.part]
    local ped = PlayerPedId()
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SendNUIMessage({
            changeCategory = true, 
            sexo = "Male", prefix = "M", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
        SendNUIMessage({ 
            changeCategory = true, 
            sexo = "Female", prefix = "F", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    end
end)

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped, true)
        
        for k, v in pairs(lojaderoupa) do
            local provador = lojaderoupa[k].provador

            if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, true ) <= 10 then
                idle = 5
                DrawMarker( 23, lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z-0.99, 0, 0, 0, 0, 0, 0, 1.7, 1.7, 0.5, 111, 220, 250, 180, 0, 0, 0, 0)
            end

            if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, true ) <= 1.1 and not lojaderoupa[k].home and not noProvador then
                DrawText3D(lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, "Pressione [~b~E~w~] para acessar a ~b~LOJA DE ROUPAS~w~.")    
            end

            if GetDistanceBetweenCoords(GetEntityCoords(ped), lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, true ) < 1 then
                if IsControlJustPressed(0, 38) then
                    valor = 0
                    precoTotal = 0
                    noProvador = true
                    old_custom = vRP.getCustomization()
                    old = {}
                    cor = 0
		            dados, tipo = nil
                    TaskGoToCoordAnyMeans(ped, provador.x, provador.y, provador.z, 1.0, 0, 0, 786603, 0xbf800000)
                end
            end

            if noProvador then
                if GetDistanceBetweenCoords(GetEntityCoords(ped), provador.x, provador.y, provador.z, true ) < 0.5 and not chegou then
                    chegou = true
                    valor = 0
                    precoTotal = 0
                    SetEntityHeading(PlayerPedId(), provador.heading)
                    FreezeEntityPosition(ped, true)
                    SetEntityInvincible(ped, false)--mqcu
                    openGuiLojaRoupa()
                end
            end
        end
        Citizen.Wait(idle)
    end
end)

function openGuiLojaRoupa()
    local ped = PlayerPedId()
    SetNuiFocus(true, true)
    SetCameraCoords()
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SendNUIMessage({ 
            openLojaRoupa = true, 
            sexo = "Male", prefix = "M", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
        SendNUIMessage({ 
            openLojaRoupa = true, 
            sexo = "Female", prefix = "F", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    end
    in_loja = true
end

RegisterNUICallback("leftHeading", function(data, cb)
    local currentHeading = GetEntityHeading(PlayerPedId())
    heading = currentHeading-tonumber(data.value)
    SetEntityHeading(PlayerPedId(), heading)
end)

RegisterNUICallback("handsUp", function(data, cb)
    local dict = "missminuteman_1ig_2"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
    end
    
    if not handsup then
        TaskPlayAnim(PlayerPedId(), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
        handsup = true
    else
        handsup = false
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNUICallback("rightHeading", function(data, cb)
    local currentHeading = GetEntityHeading(PlayerPedId())
    heading = currentHeading+tonumber(data.value)
    SetEntityHeading(PlayerPedId(), heading)
end)

function updateCarroCompras()
    valor = 0
    for k, v in pairs(carroCompras) do
        if carroCompras[k] == true then
            valor = valor + 100
        end
    end
    precoTotal = valor
    return valor
end

RegisterNUICallback("changeColor", function(data, cb)
    if type(dados) == "number" then
        max = GetNumberOfPedTextureVariations(PlayerPedId(), dados, tipo)
    elseif type(dados) == "string" then
        max = GetNumberOfPedPropTextureVariations(PlayerPedId(), parse_part(dados), tipo)
    end

    if data.action == "menos" then
        if cor > 0 then cor = cor - 1 else cor = max end
    elseif data.action == "mais" then
        if cor < max then cor = cor + 1 else cor = 0 end
    end
    if dados and tipo then setRoupa(dados, tipo, cor) end
end)

function changeClothe(type, id)
    dados = type
    tipo = tonumber(parseInt(id))
	cor = 0
    setRoupa(dados, tipo, cor)
end

function setRoupa(dados, tipo, cor)
    local ped = PlayerPedId()

	if type(dados) == "number" then
		SetPedComponentVariation(ped, dados, tipo, cor, 1)
    elseif type(dados) == "string" then
        SetPedPropIndex(ped, parse_part(dados), tipo, cor, 1)
        dados = "p" .. (parse_part(dados))
	end
	  
  	custom = vRP.getCustomization()
  	custom.modelhash = nil

	aux = old_custom[dados]
	v = custom[dados]

    if v[1] ~= aux[1] and old[dados] ~= "custom" then
        carroCompras[dados] = true
        price = updateCarroCompras()
        SendNUIMessage({ action = "setPrice", price = price, typeaction = "add" })
    	old[dados] = "custom"
    end
    if v[1] == aux[1] and old[dados] == "custom" then
        carroCompras[dados] = false
        price = updateCarroCompras()
        SendNUIMessage({ action = "setPrice", price = price, typeaction = "remove" })
    	old[dados] = "0"
	end

	SendNUIMessage({ value = price })
end

RegisterNUICallback("changeCustom", function(data, cb)
    changeClothe(data.type, data.id)
end)

RegisterNUICallback("payament", function(data, cb)
    carroCompras = {
        mascara = false,
        mao = false,
        calca = false,
        mochila = false,
        sapato = false,
        gravata = false,
        camisa = false,
        jaqueta = false,
        bone = false,
        oculos = false,
        brinco = false,
        relogio = false,
        bracelete = false
    }
    TriggerServerEvent("vrp_skinshop:Comprar", tonumber(data.price)) 
end)

RegisterNUICallback("reset", function(data, cb)
    vRP.setCustomization(old_custom)
    closeGuiLojaRoupa()
    ClearPedTasks(PlayerPedId())
end)

function closeGuiLojaRoupa()
    local ped = PlayerPedId()
    DeleteCam()
    SetNuiFocus(false, false)
    SendNUIMessage({ openLojaRoupa = false })
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    PlayerReturnInstancia()
    SendNUIMessage({ action = "setPrice", price = 0, typeaction = "remove" })
    
    in_loja = false
    noProvador = false
    chegou = false
    old_custom = {}
end

RegisterNetEvent('vrp_skinshop:ReceberCompra')
AddEventHandler('vrp_skinshop:ReceberCompra', function(comprar)
    if comprar then
        in_loja = false
        closeGuiLojaRoupa()
    else
        in_loja = false
        vRP.setCustomization(old_custom)
        closeGuiLojaRoupa()
    end
end)

function parse_part(key)
    if type(key) == "string" and string.sub(key, 1, 1) == "p" then
        return tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end

function PlayerInstancia()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = PlayerPedId()
        local otherPlayer = GetPlayerPed(player)
        if ped ~= otherPlayer then
            SetEntityVisible(otherPlayer, false)
            SetEntityNoCollisionEntity(ped, otherPlayer, true)
        end
    end
end

function PlayerReturnInstancia()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = PlayerPedId()
        local otherPlayer = GetPlayerPed(player)
        if ped ~= otherPlayer then
            SetEntityVisible(otherPlayer, true)
            SetEntityCollision(ped, true)
        end
    end
end

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

Citizen.CreateThread(function()
    while true do
        if noProvador then
            PlayerInstancia()
            DisableControlAction(1, 1, true)
            DisableControlAction(1, 2, true)
            DisableControlAction(1, 24, true)
            DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 106, true)
            DisableControlAction(1, 37, true)
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        N_0xf4f2c0d4ee209e20()
        Citizen.Wait(1000)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        closeGuiLojaRoupa()
    end
end)