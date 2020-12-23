local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

vSERVER = Tunnel.getInterface('vrp_shops')

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local menuactive = false
local openShop = {}
local tShop = ''
local dShop = ''

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
	openShop = nil
	dShop = nil
end)

--[ BUYITEM ]----------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("buyItem",function(data)
	vSERVER.buyItem(data.item,data.amount,openShop)
end)

--[ AUTO-UPDATE ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("vrp_shops:Update")
AddEventHandler("vrp_shops:Update",function(action)
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
		openShop = nil
		tShop = nil
	end
end

RegisterNUICallback('requestShops',function(data,cb)
	local shopName = dShop
	local inventory, weight, maxweight, slots, fslots, fshopslots, itemsshop = vSERVER.openNav(dShop)
	local ip = config.imageServer
	if ip == '' then
		if vSERVER.checkStreaming() then
			ip = '192.99.251.232:3501'
		end
	end
	if inventory then
		cb({ inventory = inventory, weight = weight, maxweight = maxweight, slots = slots, fslots = fslots, fshopslots = fshopslots, itemsshop = itemsshop, shopName = shopName, ip = ip })
	end
end)

--[ KEYMAPPING | OPEN ]-----------------------------------------------------------------------------------------------------

RegisterNetEvent("vrp_shops:open")
AddEventHandler("vrp_shops:open",function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(config.shops) do
		tShop = k
		for k,v in pairs(v.coords) do
			local bowz,cdz = GetGroundZFor_3dCoord(v.x, v.y, v.z)
			local distance = GetDistanceBetweenCoords(v.x, v.y, cdz, x, y, z, true)
			if distance < 1.2 then
				if vSERVER.checkAuth() then
					dShop = tShop
					ToggleActionMenu(tShop)
					openShop = tShop
				else
					TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
				end
			end
		end
	end
end)

--[ BLIP| THREAD ]-----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(config.shops) do
			for k,v in pairs(v.coords) do
				local bowz,cdz = GetGroundZFor_3dCoord(v.x, v.y, v.z)
				local distance = GetDistanceBetweenCoords(v.x, v.y, cdz, x, y, z, true)
				if distance < 5.1 then
					idle = 5
					DrawMarker(23, v.x, v.y, v.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,66, 236, 134, 150,0,0,0,0)
				end
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