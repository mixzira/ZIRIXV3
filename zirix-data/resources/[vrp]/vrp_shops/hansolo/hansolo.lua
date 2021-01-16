local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

vSERVER = Tunnel.getInterface('vrp_shops')

local menuactive = false
local openShop = {}
local tShop = ''
local dShop = ''

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

RegisterNUICallback("shopClose",function(data)
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	menuactive = false
	openShop = nil
	dShop = nil
end)

RegisterNUICallback("buyItem",function(data)
	vSERVER.buyItem(data.item,data.amount,openShop)
end)

RegisterNUICallback("sellItem",function(data)
	print(data.item)
	vSERVER.sellItem(data.item,data.amount,openShop)
end)

RegisterNetEvent("vrp_shops:Update")
AddEventHandler("vrp_shops:Update",function(action)
	SendNUIMessage({ action = action })
end)

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