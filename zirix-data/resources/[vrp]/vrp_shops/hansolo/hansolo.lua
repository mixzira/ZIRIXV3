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
	local imageService = config.imageService
	if inventory then
		cb({ inventory = inventory, weight = weight, maxweight = maxweight, slots = slots, fslots = fslots, fshopslots = fshopslots, itemsshop = itemsshop, shopName = shopName, imageService = imageService })
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
				dShop = tShop
				ToggleActionMenu(tShop)
				openShop = tShop
			end
		end
	end
end)

Citizen.CreateThread(function()
	while config.showBlip do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(config.shops) do
			for k,v in pairs(v.coords) do
				local bowz,cdz = GetGroundZFor_3dCoord(v.x, v.y, v.z)
				local distance = GetDistanceBetweenCoords(v.x, v.y, cdz, x, y, z, true)
				if distance < 5.0 then
					idle = 5
					DrawMarker(23, v.x, v.y, v.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5, 66, 236, 134, 150,0,0,0,0)
				end
			end
		end
		Citizen.Wait(idle)
	end
end)