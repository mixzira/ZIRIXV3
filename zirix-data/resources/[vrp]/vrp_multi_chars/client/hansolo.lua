local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
zCLIENT = {}
Tunnel.bindInterface('vrp_multi_chars', zCLIENT)
zSERVER = Tunnel.getInterface('vrp_multi_chars')

local cam = nil
local hidePlayers = false
local spawned = false
local myCharacteristics = {}
local pedModelHash = nil

RegisterNUICallback('getCharacters', function(data, cb)
	local chars, slots = zSERVER.getChars()
    if chars then
	    cb({ chars = chars, slots = slots })
    end
end)

RegisterNUICallback('closeNui',function()
    TriggerEvent('closeInterface')
end)

RegisterNUICallback('spawnChar', function(data, cb)
    TriggerServerEvent('chars:teste', data.id)
end)

RegisterNUICallback('joinInTheCity', function(data, cb)
    TriggerServerEvent('chars:charChosen', tonumber(data.id))
    TriggerEvent('closeInterface')
end)

RegisterNUICallback('newChar', function(data, cb)
    TriggerServerEvent('chars:createChar')
end)

RegisterNUICallback('firstChar', function(data, cb)
    TriggerServerEvent('chars:createFirstChar')
end)

RegisterNUICallback('deleteChar', function(data, cb)
	local chars = zSERVER.deleteChar(tonumber(data.id))
	cb({ chars = chars })
end)

function f(n)
    n = n + 0.00000
    return n
end

function removeCamActive()
    if cam and IsCamActive(cam) then
        SetCamCoord(cam, GetGameplayCamCoords())
        SetCamRot(cam, GetGameplayCamRot(2), 2)
        RenderScriptCams(0, 0, 0, 0, 0)
        EnableGameplayCam(true)
        SetCamActive(cam, false)
        DestroyCam(cam)
        cam = nil
    end
end

function changeGender(model)
	local mhash = GetHashKey(model)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		SetPlayerModel(PlayerPedId(), mhash)
		SetModelAsNoLongerNeeded(mhash)
	end
end

function blockControls()
    if hidePlayers == false then
        hidePlayers = true
    else
        hidePlayers = false
    end
end

function zCLIENT.spawnChar(user_id)
    SendNUIMessage({ action = 'hideSpawnButton' })
    local clothingsChar, characteristics = zSERVER.setupCharacteristics(user_id)
    myCharacteristics.complexionModel = tonumber(characteristics.complexionModel)
    myCharacteristics.noseBridge = tonumber(characteristics.noseBridge)
    myCharacteristics.chinWidth = tonumber(characteristics.chinWidth)
    myCharacteristics.jawWidth = tonumber(characteristics.jawWidth)
    myCharacteristics.noseHeight = tonumber(characteristics.noseHeight)
    myCharacteristics.eyebrowsWidth = tonumber(characteristics.eyebrowsWidth)
    myCharacteristics.chinPosition = tonumber(characteristics.chinPosition)
    myCharacteristics.eyebrowsModel = tonumber(characteristics.eyebrowsModel)
    myCharacteristics.eyebrowsColor = tonumber(characteristics.eyebrowsColor)
    myCharacteristics.eyesColor = tonumber(characteristics.eyesColor)
    myCharacteristics.blushModel = tonumber(characteristics.blushModel)
    myCharacteristics.noseShift = tonumber(characteristics.noseShift)
    myCharacteristics.frecklesModel = tonumber(characteristics.frecklesModel)
    myCharacteristics.jawHeight = tonumber(characteristics.jawHeight)
    myCharacteristics.secondHairColor = tonumber(characteristics.secondHairColor)
    myCharacteristics.shapeMix = tonumber(characteristics.shapeMix)
    myCharacteristics.cheekboneWidth = tonumber(characteristics.cheekboneWidth)
    myCharacteristics.gender = tonumber(characteristics.gender)
    myCharacteristics.lipstickColor = tonumber(characteristics.lipstickColor)
    myCharacteristics.beardModel = tonumber(characteristics.beardModel)
    myCharacteristics.lips = tonumber(characteristics.lips)
    myCharacteristics.eyebrowsHeight = tonumber(characteristics.eyebrowsHeight)
    myCharacteristics.skinColor = tonumber(characteristics.skinColor)
    myCharacteristics.sundamageModel = tonumber(characteristics.sundamageModel)
    myCharacteristics.cheeksWidth = tonumber(characteristics.cheeksWidth)
    myCharacteristics.chestColor = tonumber(characteristics.chestColor)
    myCharacteristics.noseLength = tonumber(characteristics.noseLength)
    myCharacteristics.lipstickModel = tonumber(characteristics.lipstickModel)
    myCharacteristics.makeupModel = tonumber(characteristics.makeupModel)
    myCharacteristics.chinShape = tonumber(characteristics.chinShape)
    myCharacteristics.fathersID = tonumber(characteristics.fathersID)
    myCharacteristics.noseWidth = tonumber(characteristics.noseWidth)
    myCharacteristics.blushColor = tonumber(characteristics.blushColor)
    myCharacteristics.neckWidth = tonumber(characteristics.neckWidth)
    myCharacteristics.blemishesModel = tonumber(characteristics.blemishesModel)
    myCharacteristics.noseTip = tonumber(characteristics.noseTip)
    myCharacteristics.mothersID = tonumber(characteristics.mothersID)
    myCharacteristics.chinLength = tonumber(characteristics.chinLength)
    myCharacteristics.chestModel = tonumber(characteristics.chestModel)
    myCharacteristics.beardColor = tonumber(characteristics.beardColor)
    myCharacteristics.firstHairColor = tonumber(characteristics.firstHairColor)
    myCharacteristics.hairModel = tonumber(characteristics.hairModel)
    myCharacteristics.ageingModel = tonumber(characteristics.ageingModel)
    myCharacteristics.cheekboneHeight = tonumber(characteristics.cheekboneHeight)
    myCharacteristics.hairfade = tonumber(characteristics.hairfade)

    local hairf = config.hairfades[tonumber(characteristics.hairfade)]
    myCharacteristics.hairfadedlc = hairf and hairf.dlc or nil
    myCharacteristics.hairfadetexture = hairf and hairf.texture or nil

    if myCharacteristics.gender == 1 then
        pedModelHash = GetHashKey('mp_f_freemode_01')
    else
        pedModelHash = GetHashKey('mp_m_freemode_01')
    end

    if pedModelHash then
		local i = 0
		while not HasModelLoaded(pedModelHash) and i < 10000 do
			RequestModel(pedModelHash)
			Citizen.Wait(10)
		end

		if HasModelLoaded(pedModelHash) then
			SetPlayerModel(PlayerId(), pedModelHash)
			SetModelAsNoLongerNeeded(pedModelHash)
		end
	end

    if not spawned then
        DoScreenFadeOut(1300)
        Wait(1800)
        SetCamCoord(cam, -773.2, 340.8, 211.44 + 0.52)
        SetCamRot(cam, 175.9, 180.0, 170.0)
        SetFocusEntity(PlayerPedId())
        SetEntityCoordsNoOffset(PlayerPedId(), -772.82, 343.4, 211.4, true, true, true)
        SetEntityHeading(PlayerPedId(), f(175))
        FreezeEntityPosition(PlayerPedId(), true)
	    SetEntityInvincible(PlayerPedId(), true)
        SetEntityVisible(PlayerPedId(), true, true)
        Wait(1800)
        DoScreenFadeIn(2000)
    end

    TaskUpdateSkinOptions(PlayerPedId())
    TaskUpdateFaceOptions(PlayerPedId())
    TaskUpdateHeadOptions(PlayerPedId())
    TaskUpdateClothingOptions(PlayerPedId(), clothingsChar)

    continuousFadeOutNetwork = true
    spawned = true

    SendNUIMessage({ action = 'showSpawnButton' })
end

function TaskUpdateSkinOptions(model)
    local data = myCharacteristics  
    SetPedHeadBlendData(model, data.fathersID, data.mothersID, 0, data.skinColor, 0, 0, f(data.shapeMix), 0, 0, false)
    SetPedEyeColor(model, data.eyesColor)
end

function TaskUpdateFaceOptions(model)
	local data = myCharacteristics
	SetPedEyeColor(model, data.eyesColor)
	SetPedFaceFeature(model, 6, data.eyebrowsHeight)
    SetPedFaceFeature(model, 7, data.eyebrowsWidth)
    SetPedFaceFeature(model, 0, data.noseWidth)
    SetPedFaceFeature(model, 1, data.noseHeight)
    SetPedFaceFeature(model, 2, data.noseLength)
    SetPedFaceFeature(model, 3, data.noseBridge)
    SetPedFaceFeature(model, 4, data.noseTip)
    SetPedFaceFeature(model, 5, data.noseShift)
    SetPedFaceFeature(model, 8, data.cheekboneHeight)
    SetPedFaceFeature(model, 9, data.cheekboneWidth)
    SetPedFaceFeature(model, 10, data.cheeksWidth)
    SetPedFaceFeature(model, 12, data.lips)
    SetPedFaceFeature(model, 13, data.jawWidth)
    SetPedFaceFeature(model, 14, data.jawHeight)
    SetPedFaceFeature(model, 15, data.chinLength)
    SetPedFaceFeature(model, 16, data.chinPosition)
    SetPedFaceFeature(model, 17, data.chinWidth)
    SetPedFaceFeature(model, 18, data.chinShape)
    SetPedFaceFeature(model, 19, data.neckWidth)
end

function TaskUpdateHeadOptions(model)
	local data = myCharacteristics
	SetPedHeadOverlay(model, 2, data.eyebrowsModel, 0.99)
    SetPedHeadOverlayColor(model, 2, 1, data.eyebrowsColor, data.eyebrowsColor)
    SetPedComponentVariation(model, 2, data.hairModel, 0, 0)

    ClearPedDecorations(PlayerPedId())

    if data.hairfadedlc and data.hairfadetexture then
        AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(data.hairfadedlc), GetHashKey(data.hairfadetexture))
    end

    SetPedHairColor(model, data.firstHairColor, data.secondHairColor)
    SetPedHeadOverlay(model, 1, data.beardModel, 0.99)
    SetPedHeadOverlayColor(model, 1, 1, data.beardColor, data.beardColor)
    SetPedHeadOverlay(model, 10, data.chestModel, 0.99)
    SetPedHeadOverlayColor(model, 10, 1, data.chestColor, data.chestColor)
    SetPedHeadOverlay(model, 4, data.makeupModel, 0.99)
    SetPedHeadOverlayColor(model, 4, 0, 0, 0)
    SetPedHeadOverlay(model, 5, data.blushModel, 0.99)
    SetPedHeadOverlayColor(model, 5, 2, data.blushColor, data.blushColor)
    SetPedHeadOverlay(model, 8, data.lipstickModel, 0.99)
    SetPedHeadOverlayColor(model, 8, 2, data.lipstickColor, data.lipstickColor)
    SetPedHeadOverlay(model, 0, data.blemishesModel, 0.99)
    SetPedHeadOverlayColor(model, 0, 0, 0, 0)
    SetPedHeadOverlay(model, 3, data.ageingModel, 0.99)
    SetPedHeadOverlayColor(model, 3, 0, 0, 0)
    SetPedHeadOverlay(model, 6, data.complexionModel, 0.99)
    SetPedHeadOverlayColor(model, 6, 0, 0, 0)
    SetPedHeadOverlay(model, 7, data.sundamageModel, 0.99)
    SetPedHeadOverlayColor(model, 7, 0, 0, 0)
    SetPedHeadOverlay(model, 9, data.frecklesModel, 0.99)
    SetPedHeadOverlayColor(model, 9, 0, 0, 0)
end

function TaskUpdateClothingOptions(model, data)
	SetPedComponentVariation(model, 04, data['4'][1], data['4'][2], 02)
	SetPedComponentVariation(model, 03, data['3'][1], data['3'][2], 02)
	SetPedComponentVariation(model, 08, data['8'][1], data['8'][2], 02)
	SetPedComponentVariation(model, 09, data['9'][1], data['9'][2], 02)
	SetPedComponentVariation(model, 011, data['11'][1], data['11'][2], 02)
	SetPedComponentVariation(model, 06, data['6'][1], data['6'][2], 02)
	SetPedComponentVariation(model, 01, data['1'][1], data['1'][2], 02)
	SetPedComponentVariation(model, 010, data['10'][1], data['10'][2], 02)
	SetPedComponentVariation(model, 07,data['7'][1], data['7'][2], 02)
	SetPedComponentVariation(model, 05, data['5'][1], data['5'][2], 02)
	if data['p0'][1] ~= -1 and data['p0'][1] ~= 0 then
		SetPedPropIndex(model, 00, data['p0'][1], data['p0'][2], 02)
	else
		ClearPedProp(model, 00)
	end
	if data['p1'][1] ~= -1 and data['p1'][1] ~= 0 then
		SetPedPropIndex(model, 01, data['p1'][1], data['p1'][2], 02)
	else
		ClearPedProp(model, 01)
	end
	if data['p2'][1] ~= -1 and data['p2'][1] ~= 0 then
		SetPedPropIndex(model, 02, data['p2'][1], data['p2'][2], 02)
	else
		ClearPedProp(model, 02)
	end
	if data['p6'][1] ~= -1 and data['p6'][1] ~= 0 then
		SetPedPropIndex(model, 06, data['p6'][1], data['p6'][2], 02)
	else
		ClearPedProp(model, 06)
	end
	if data['p7'][1] ~= -1 and data['p7'][1] ~= 0 then
		SetPedPropIndex(model, 07, data['p7'][1], data['p7'][2], 02)
	else
		ClearPedProp(model, 07)
	end
end

RegisterNetEvent('chars:setupChar')
AddEventHandler('chars:setupChar', function()
    DoScreenFadeOut(0)
    DisplayRadar(false)

	FreezeEntityPosition(PlayerPedId(), true)
	SetEntityInvincible(PlayerPedId(), true)
    SetEntityVisible(PlayerPedId(), false, false)

    SetEntityCoordsNoOffset(PlayerPedId(), -75.34, -819.04, 326.18 + 200.0, true, true, true)
    SetEntityHeading(PlayerPedId(), f(175))
    cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', -75.34, -819.04, 326.18 + 200.0, 175.9, 180.0, 170.0, 75.0, false, 0)
    SetCamActive(cam, true)
	RenderScriptCams(true, true, 1, true, true)

    Citizen.Wait(1000)

    blockControls()
    DoScreenFadeIn(500)

    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()

    Citizen.Wait(1000)

    if zSERVER.verifyChars() then
        SendNUIMessage({ action = 'showMenu', type = 'haveChar' })
        SetNuiFocus(true, true)
    else
        SendNUIMessage({ action = 'showMenu', type = 'noHaveChar' })
        SetNuiFocus(true, true)
    end
end)

RegisterNetEvent('closeInterface')
AddEventHandler('closeInterface', function()
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = 'hideMenu' })
    SetEntityVisible(PlayerPedId(), true, true)
    Citizen.Wait(10)
	FreezeEntityPosition(PlayerPedId(), false)
	SetEntityInvincible(PlayerPedId(), false)
    removeCamActive()
    hidePlayers = false
    continuousFadeOutNetwork = false
end)

RegisterNetEvent('closeInterfaceCreateChar')
AddEventHandler('closeInterfaceCreateChar', function()
    DoScreenFadeOut(200)
    SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = 'hideMenu' })
    SetEntityVisible(PlayerPedId(), true, true)
	FreezeEntityPosition(PlayerPedId(), true)
	SetEntityInvincible(PlayerPedId(), true)	
    removeCamActive()
    hidePlayers = false
    continuousFadeOutNetwork = false
    creating = false
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

Citizen.CreateThread(function()
    local keys = { 18, 27, 172, 173, 176, 177, 187, 188, 191, 201 }
    while hidePlayers do
        DisableAllControlActions(0)
        for i = 1, #keys do
            EnableControlAction(0, keys[i], true)
        end
        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if continuousFadeOutNetwork then 
			for id = 0, 256 do
				if id ~= PlayerId() and NetworkIsPlayerActive(id) then
					NetworkFadeOutEntity(GetPlayerPed(id), false)
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterCommand('mult',function(source)
    TriggerEvent('chars:setupChar')
end)