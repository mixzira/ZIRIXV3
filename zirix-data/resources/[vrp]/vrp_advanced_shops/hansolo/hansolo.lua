local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

vSERVER = Tunnel.getInterface('vrp_advanced_shops')

local shops = {}
local users = {}

local menuactive = false
local openShop = {}
local tShop = ''
local dShop = ''

RegisterNUICallback("buyItem",function(data)
	vSERVER.buyItem(data.item,data.amount,openShop)
end)

RegisterNUICallback("sellItem",function(data)
	vSERVER.sellItem(data.item,data.amount,openShop)
end)

RegisterNUICallback('optionsOn',function()
	SendNUIMessage({ action = 'optionsOn' })
end)

RegisterNUICallback('optionsOff',function()
	SendNUIMessage({ action = 'optionsOff' })
end)

RegisterNUICallback('upgrade',function(data)
	vSERVER.upgradeShop(data.item,data.stock,data.security,openShop)
end)

RegisterNUICallback('upgradePrice',function(data)	
	vSERVER.upgradePrice(data.item,openShop)
end)

RegisterNUICallback("shopClose",function(data)
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	menuactive = false
	openShop = nil
	dShop = nil
	TriggerEvent('cancelando',false)
end)

RegisterNUICallback('requestShops',function(data,cb)
	local sname = dShop
	local inventory, weight, maxweight, slots, fslots, fshopslots, shop, vault, maxvault, options, maxstock, security = vSERVER.openNav(sname)
	local ip = config.imageServer
	if ip == '' then
		if vSERVER.checkStreaming() then
			ip = '192.99.251.232:3501'
		end
	end
	if inventory then
		cb({ inventory = inventory, weight = weight, maxweight = maxweight, slots = slots, fslots = fslots, fshopslots = fshopslots, shop = shop, sname = sname, ip = ip, vault = vault, maxvault = maxvault, options = options, maxstock = maxstock, security = security })
	end
end)

function toggleActionMenu(type)
	menuactive = not menuactive
	if menuactive then
		TransitionToBlurred(1000)
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu", type = type })
		TriggerEvent('cancelando',true)
		if vSERVER.checkOwner(type) then
			SendNUIMessage({ action = 'ownerOn' })
		end
	else
		TransitionFromBlurred(1000)
		SetNuiFocus(false,false)
		SendNUIMessage({ action = "hideMenu" })
		openShop = nil
		tShop = nil
		TriggerEvent('cancelando',false)
	end
end

function createBlip()
	for k,v in pairs(config.shops) do
		local info = v.info
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipColour(info.blip, info.color)
        SetBlipScale(info.blip, 0.6)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.name)
        EndTextCommandSetBlipName(info.blip)
    end
end

RegisterNetEvent("vrp_advanced_shops:open")
AddEventHandler("vrp_advanced_shops:open",function()
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
					toggleActionMenu(dShop)
					openShop = tShop
				else
					--TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
				end
			end
		end
	end
end)

RegisterNetEvent("vrp_advanced_shops:close")
AddEventHandler("vrp_advanced_shops:close",function(action)
    TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	openShop = nil
	tShop = nil
	TriggerEvent('cancelando',false)
end)

RegisterNetEvent("vrp_advanced_shops:Update")
AddEventHandler("vrp_advanced_shops:Update",function(action)
	SendNUIMessage({ action = action })
end)

Citizen.CreateThread(function() 
	createBlip()
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)