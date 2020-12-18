local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

shop = Tunnel.getInterface('vrp_shops')

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local menuactive = false

local shops = {
	{ ['x'] = 425.57, ['y'] = -806.27, ['z'] = 29.5, ['type'] = 'accessories' },
	{ ['x'] = 75.44, ['y'] = -1392.85, ['z'] = 29.38, ['type'] = 'accessories' },
	{ ['x'] = -822.38, ['y'] = -1073.59, ['z'] = 11.33, ['type'] = 'accessories' },
	{ ['x'] = -1193.17, ['y'] = -767.95, ['z'] = 17.32, ['type'] = 'accessories' },
	{ ['x'] = -163.54, ['y'] = -303.28, ['z'] = 39.74, ['type'] = 'accessories' },
	{ ['x'] = 125.72, ['y'] = -223.82, ['z'] = 54.56, ['type'] = 'accessories' },
	{ ['x'] = -710.04, ['y'] = -152.58, ['z'] = 37.42, ['type'] = 'accessories' },
	{ ['x'] = -1450.05, ['y'] = -237.21, ['z'] = 49.82, ['type'] = 'accessories' },
	{ ['x'] = -3170.62, ['y'] = 1043.74, ['z'] = 20.87, ['type'] = 'accessories' },
	{ ['x'] = -1101.29, ['y'] = 2710.63, ['z'] = 19.11, ['type'] = 'accessories' },
	{ ['x'] = 614.2, ['y'] = 2762.82, ['z'] = 42.09, ['type'] = 'accessories' },
	{ ['x'] = 1196.75, ['y'] = 2710.26, ['z'] = 38.23, ['type'] = 'accessories' },
	{ ['x'] = 1693.84, ['y'] = 4822.9, ['z'] = 42.07, ['type'] = 'accessories' },
	{ ['x'] = 4.82, ['y'] = 6512.48, ['z'] = 31.88, ['type'] = 'accessories' },

	{ ['x'] = 22.65, ['y'] = -1106.97, ['z'] = 29.8, ['type'] = 'ammunation' },
	{ ['x'] = 809.56, ['y'] = -2157.66, ['z'] = 29.62, ['type'] = 'ammunation' },
	{ ['x'] = 1693.71, ['y'] = 3760.54, ['z'] = 34.71, ['type'] = 'ammunation' },
	{ ['x'] = 252.31, ['y'] = -50.68, ['z'] = 69.95, ['type'] = 'ammunation' },
	{ ['x'] = 841.75, ['y'] = -1033.94, ['z'] = 28.2, ['type'] = 'ammunation' },
	{ ['x'] = -330.19, ['y'] = 6084.47, ['z'] = 31.46, ['type'] = 'ammunation' },
	{ ['x'] = -661.63, ['y'] = -934.93, ['z'] = 21.83, ['type'] = 'ammunation' },
	{ ['x'] = -1305.6, ['y'] = -394.94, ['z'] = 36.7, ['type'] = 'ammunation' },
	{ ['x'] = -1117.58, ['y'] = 2699.19, ['z'] = 18.56, ['type'] = 'ammunation' },
	{ ['x'] = 2567.29, ['y'] = 293.96, ['z'] = 108.74, ['type'] = 'ammunation' },
	{ ['x'] = -3172.03, ['y'] = 1088.45, ['z'] = 20.84, ['type'] = 'ammunation' },

	{ ['x'] = -560.27, ['y'] = 286.55, ['z'] = 82.18, ['type'] = 'pub' }, -- Tequi-La-La;
	{ ['x'] = 350.91, ['y'] = 288.7, ['z'] = 91.2, ['type'] = 'pub' }, -- Galaxy Club;
	{ ['x'] = 356.51, ['y'] = 282.83, ['z'] = 94.2, ['type'] = 'pub' }, -- Galaxy Club;
	{ ['x'] = 131.03, ['y'] = -1284.07, ['z'] = 29.28, ['type'] = 'pub' }, -- Vanilla Unicorn;
	{ ['x'] = 741.55, ['y'] = -811.17, ['z'] = 24.28, ['type'] = 'pub' }, -- PixelBar

	{ ['x'] = -633.71, ['y'] = 236.16, ['z'] = 81.89, ['type'] = 'coffeeshop' },

	{ ['x'] = 25.75, ['y'] = -1345.5, ['z'] = 29.5, ['type'] = 'convenienceshop' },
	{ ['x'] = -48.42, ['y'] = -1757.87, ['z'] = 29.43, ['type'] = 'convenienceshop' },
	{ ['x'] = -707.42, ['y'] = -914.59, ['z'] = 19.22, ['type'] = 'convenienceshop' },
	{ ['x'] = -1222.27, ['y'] = -906.59, ['z'] = 12.33, ['type'] = 'convenienceshop' },
	{ ['x'] = -1487.7, ['y'] = -378.6, ['z'] = 40.17, ['type'] = 'convenienceshop' },
	{ ['x'] = 1163.61, ['y'] = -323.94, ['z'] = 69.21, ['type'] = 'convenienceshop' },
	{ ['x'] = 374.21, ['y'] = 327.8, ['z'] = 103.57, ['type'] = 'convenienceshop' },
	{ ['x'] = 2555.58, ['y'] = 382.11, ['z'] = 108.63, ['type'] = 'convenienceshop' },
	{ ['x'] = -2967.83, ['y'] = 391.63, ['z'] = 15.05, ['type'] = 'convenienceshop' },
	{ ['x'] = -3041.04, ['y'] = 585.14, ['z'] = 7.91, ['type'] = 'convenienceshop' },
	{ ['x'] = -3243.91, ['y'] = 1001.32, ['z'] = 12.84, ['type'] = 'convenienceshop' },
	{ ['x'] = 548.13, ['y'] = 2669.47, ['z'] = 42.16, ['type'] = 'convenienceshop' },
	{ ['x'] = 1165.35, ['y'] = 2709.39, ['z'] = 38.16, ['type'] = 'convenienceshop' },
	{ ['x'] = 1960.23, ['y'] = 3742.13, ['z'] = 32.35, ['type'] = 'convenienceshop' },
	{ ['x'] = 1697.98, ['y'] = 4924.48, ['z'] = 42.07, ['type'] = 'convenienceshop' },
	{ ['x'] = 2677.09, ['y'] = 3281.33, ['z'] = 55.25, ['type'] = 'convenienceshop' },
	{ ['x'] = 1729.77, ['y'] = 6416.24, ['z'] = 35.04, ['type'] = 'convenienceshop' },

	{ ['x'] = -658.05, ['y'] = -857.51, ['z'] = 24.5, ['type'] = 'digitalshop' },

	{ ['x'] = 93.26, ['y'] = -230.07, ['z'] = 54.67, ['type'] = 'drugshop' },
	{ ['x'] = 317.13, ['y'] = -1077.07, ['z'] = 29.48, ['type'] = 'drugshop' },
	{ ['x'] = -493.43, ['y'] = -339.9, ['z'] = 42.33, ['type'] = 'drugshop' },

	{ ['x'] = -39.1, ['y'] = -1661.16, ['z'] = 29.5, ['type'] = 'toolshop' }
}

--[ STARTFOCUS ]-------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

--[ CHESTCLOSE ]-------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("shopClose",function(data)
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	menuactive = false
end)

--[ BUYITEM ]----------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("buyItem",function(data)
	shop.buyItem(data.item,data.amount)
end)

--[ AUTO-UPDATE ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("Shops:UpdateInventory")
AddEventHandler("Shops:UpdateInventory",function(action)
	SendNUIMessage({ action = action })
end)

--[ MANU | FUNCTION ]-----------------------------------------------------------------------------------------------------------

function ToggleActionMenu(type)
	menuactive = not menuactive
	if menuactive then
		TransitionToBlurred(1000)
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu", type = type })
	else
		TransitionFromBlurred(1000)
		SetNuiFocus(false,false)
		SendNUIMessage({ action = "hideMenu" })
	end
end

RegisterNUICallback('requestShops',function(data,cb)
	local inventory, weight, maxweight, accessories, ammunation, pub, coffeeshop, convenienceshop, digitalshop, drugshop, toolshop, tSlot = shop.openNav()
	local ip = config.imageServer
	if ip == '' then
		if shop.checkAuth() then
			ip = '192.99.251.232:3501'
		end
	end
	if shop.checkAuth() then
		if inventory or accessories or ammunation or pub or coffeeshop or convenienceshop or digitalshop or drugshop or toolshop then
			cb({ inventory = inventory, weight = weight, maxweight = maxweight, accessories = accessories, ammunation = ammunation, pub = pub, coffeeshop = coffeeshop, convenienceshop = convenienceshop, digitalshop = digitalshop, drugshop = drugshop, toolshop = toolshop, tSlot = tSlot, ip = ip })
		end
	else
		TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
	end
end)

--[ KEYMAPPING | OPEN ]-----------------------------------------------------------------------------------------------------

RegisterNetEvent("vrp_shops:open")
AddEventHandler("vrp_shops:open",function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(shops) do		
		local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
		local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
		local shop = shops[k]
		if distance < 1.2 then
			if IsControlJustPressed(0,38) then
				if shop.type == 'accessories' then
					ToggleActionMenu('accessories')
					
				elseif shop.type == 'ammunation' then
					ToggleActionMenu('ammunation')

				elseif shop.type == 'pub' then
					ToggleActionMenu('pub')

				elseif shop.type == 'coffeeshop' then
					ToggleActionMenu('coffeeshop')
					
				elseif shop.type == 'convenienceshop' then
					ToggleActionMenu('convenienceshop')

				elseif shop.type == 'digitalshop' then
					ToggleActionMenu('digitalshop')

				elseif shop.type == 'drugshop' then
					ToggleActionMenu('drugshop')

				elseif shop.type == 'toolshop' then
					ToggleActionMenu('toolshop')

				end
			end
		end
	end
end)

--[ BLIP| THREAD ]-----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		for k,v in pairs(shops) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local shop = shops[k]
			if distance < 5.1 then
				idle = 5
				DrawMarker(23, shop.x, shop.y, shop.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)	
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ TEXT | FUNCTION ]-----------------------------------------------------------------------------------------------------------

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end