local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRPbs = {}
Tunnel.bindInterface("vrp_barbershop",vRPbs)
Proxy.addInterface("vrp_barbershop",vRPbs)

function f(n)
	n = n + 0.00000
	return n
end

local shops = {
	{ -815.59,-182.16,37.56 },
	{ 139.21,-1708.96,29.30 },
	{ -1282.00,-1118.86,7.00 },
	{ 1934.11,3730.73,32.85 },
	{ 1211.07,-475.00,66.21 },
	{ -34.97,-150.90,57.08 },
	{ -280.37,6227.01,31.70 }
}

default_overlay = {
	["-1"] = { 0,0 },
	["9"] = { 18,0 },
	["7"] = { 11,0 },
	["8"] = { 10,0 },
	["10"] = { 17,0 },
	["11"] = { 12,0 },
	["12"] = { 38,0 },
	["13"] = { 18,0 },
	["6"] = { 12,0 },
	["5"] = { 33,0 },
	["4"] = { 72,0 },
	["3"] = { 15,0 },
	["2"] = { 34,0 },
	["1"] = { 29,0 },
	["0"] = { 24,0 },
	["-2"] = { 32,0 }
}

local canStartTread = false
local currentCharacterMode = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0,
            eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0,
            noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0,
            cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0,
            jawHeight = 0, chinLength = 0, chinPosition = 0,
            chinWidth = 0, chinShape = 0, neckWidth = 0,
            hairModel = 4, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0, eyebrowsColor = 0,
            beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, lipstickModel = -1, lipstickColor = 0,
            blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, frecklesModel = -1, makeupModel = -1 }

custom = currentCharacterMode

function vRPbs.setCharacter(data)
	if data then
		custom = data
		canStartTread = true
	end
end

function vRPbs.getCharacter()
	return custom
end

function vRPbs.setOverlay(data)
	if data then
		custom.blemishesModel = data["0"][1]
		custom.frecklesModel = data["9"][1]
		custom.lipstickModel = data["8"][1]
		custom.lipstickColor = data["8"][2]
		custom.chestModel = data["10"][1]
		custom.chestColor = data["10"][2]
		custom.hairModel = data["12"][1]
		custom.firstHairColor = data["12"][2]
		custom.secondHairColor = data["13"][2]
		custom.complexionModel = data["6"][1]
		custom.blushModel = data["5"][1]
		custom.blushColor = data["5"][2]
		custom.makeupModel = data["4"][1]
		custom.ageingModel = data["3"][1]
		custom.eyebrowsModel = data["2"][1]
		custom.eyebrowsColor = data["2"][2]
		custom.beardModel = data["1"][1]
		custom.beardColor = data["1"][2]
	end
end

function vRPbs.resetOverlay()
	custom.blemishesModel = currentCharacterMode.blemishesModel
	custom.frecklesModel = currentCharacterMode.frecklesModel
	custom.lipstickModel = currentCharacterMode.lipstickModel
	custom.lipstickColor = currentCharacterMode.lipstickColor
	custom.chestModel = currentCharacterMode.chestModel
	custom.chestColor = currentCharacterMode.chestColor
	custom.hairModel = currentCharacterMode.hairModel
	custom.firstHairColor = currentCharacterMode.firstHairColor
	custom.secondHairColor = currentCharacterMode.secondHairColor
	custom.complexionModel = currentCharacterMode.complexionModel
	custom.blushModel = currentCharacterMode.blushModel
	custom.blushColor = currentCharacterMode.blushColor
	custom.makeupModel = currentCharacterMode.makeupModel
	custom.ageingModel = currentCharacterMode.ageingModel
	custom.eyebrowsModel = currentCharacterMode.eyebrowsModel
	custom.eyebrowsColor = currentCharacterMode.eyebrowsColor
	custom.beardModel = currentCharacterMode.beardModel
	custom.beardColor = currentCharacterMode.beardColor
end

function vRPbs.getOverlay()
	local overlay = {
		["0"] = { custom.blemishesModel,0 },
		["9"] = { custom.frecklesModel,0 },
		["8"] = { custom.lipstickModel,custom.lipstickColor },
		["10"] = { custom.chestModel,custom.chestColor },
		["12"] = { custom.hairModel,custom.firstHairColor },
		["13"] = { custom.hairModel,custom.secondHairColor },
		["6"] = { custom.complexionModel,0 },
		["5"] = { custom.blushModel,custom.blushColor },
		["4"] = { custom.makeupModel,0 },
		["3"] = { custom.ageingModel,0 },
		["2"] = { custom.eyebrowsModel,custom.eyebrowsColor },
		["1"] = { custom.beardModel,custom.beardColor }
	}
	return overlay
end

function vRPbs.getDrawables(part)
	if part == 12 then
		return tonumber(GetNumberOfPedDrawableVariations(PlayerPedId(),2))
	elseif part == -1 then
		return tonumber(GetNumberOfPedDrawableVariations(PlayerPedId(),0))
	elseif part == -2 then
		return 64
	else
		return tonumber(GetNumHeadOverlayValues(part))
	end
end

function vRPbs.getTextures(part)
	if part == -1 then
		return tonumber(GetNumHairColors())
	else
		return 64
	end
end

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped, true)

		for k,v in pairs(shops) do
			local x,y,z = table.unpack(v)
			if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, x, y, z, true ) < 5.2 then
				idle = 5
				DrawMarker( 23, x, y, z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if canStartTread then
			idle = 1000
			while not IsPedModel(PlayerPedId(),"mp_m_freemode_01") and not IsPedModel(PlayerPedId(),"mp_f_freemode_01") do
				Citizen.Wait(idle)
			end
			if custom then
				TaskUpdateSkinOptions()
				TaskUpdateFaceOptions()
				TaskUpdateHeadOptions()
			end
		end
		Citizen.Wait(idle)
	end
end)

function TaskUpdateSkinOptions()
	local data = custom
	SetPedHeadBlendData(PlayerPedId(),data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)
end

function TaskUpdateFaceOptions()
	local ped = PlayerPedId()
	local data = custom

	-- Olhos
	SetPedEyeColor(ped,data.eyesColor)
	-- Sobrancelha
	SetPedFaceFeature(ped,6,data.eyebrowsHeight)
	SetPedFaceFeature(ped,7,data.eyebrowsWidth)
	-- Nariz
	SetPedFaceFeature(ped,0,data.noseWidth)
	SetPedFaceFeature(ped,1,data.noseHeight)
	SetPedFaceFeature(ped,2,data.noseLength)
	SetPedFaceFeature(ped,3,data.noseBridge)
	SetPedFaceFeature(ped,4,data.noseTip)
	SetPedFaceFeature(ped,5,data.noseShift)
	-- Bochechas
	SetPedFaceFeature(ped,8,data.cheekboneHeight)
	SetPedFaceFeature(ped,9,data.cheekboneWidth)
	SetPedFaceFeature(ped,10,data.cheeksWidth)
	-- Boca/Mandibula
	SetPedFaceFeature(ped,12,data.lips)
	SetPedFaceFeature(ped,13,data.jawWidth)
	SetPedFaceFeature(ped,14,data.jawHeight)
	-- Queixo
	SetPedFaceFeature(ped,15,data.chinLength)
	SetPedFaceFeature(ped,16,data.chinPosition)
	SetPedFaceFeature(ped,17,data.chinWidth)
	SetPedFaceFeature(ped,18,data.chinShape)
	-- Pescoço
	SetPedFaceFeature(ped,19,data.neckWidth)
end

function TaskUpdateHeadOptions()
	local ped = PlayerPedId()
	local data = custom

	-- Cabelo
	SetPedComponentVariation(ped,2,data.hairModel,0,0)
	SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)

	-- Sobrancelha 
	SetPedHeadOverlay(ped,2,data.eyebrowsModel, 0.99)
	SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)

	-- Barba
	SetPedHeadOverlay(ped,1,data.beardModel,0.99)
	SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)

	-- Pelo Corporal
	SetPedHeadOverlay(ped,10,data.chestModel,0.99)
	SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)

	-- Blush
	SetPedHeadOverlay(ped,5,data.blushModel,0.99)
	SetPedHeadOverlayColor(ped,5,2,data.blushColor,data.blushColor)

	-- Battom
	SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)
	SetPedHeadOverlayColor(ped,8,2,data.lipstickColor,data.lipstickColor)

	-- Manchas
	SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)
	SetPedHeadOverlayColor(ped,0,0,0,0)

	-- Envelhecimento
	SetPedHeadOverlay(ped,3,data.ageingModel,0.99)
	SetPedHeadOverlayColor(ped,3,0,0,0)

	-- Aspecto
	SetPedHeadOverlay(ped,6,data.complexionModel,0.99)
	SetPedHeadOverlayColor(ped,6,0,0,0)

	-- Pele
	SetPedHeadOverlay(ped,7,data.sundamageModel,0.99)
	SetPedHeadOverlayColor(ped,7,0,0,0)

	-- Sardas
	SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)
	SetPedHeadOverlayColor(ped,9,0,0,0)

	-- Maquiagem
	SetPedHeadOverlay(ped,4,data.makeupModel,0.99)
	SetPedHeadOverlayColor(ped,4,0,0,0)
end