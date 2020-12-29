local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_inspect",src)
vSERVER = Tunnel.getInterface("vrp_inspect")

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

RegisterNUICallback("chestClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	vSERVER.resetInspect()
end)

RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(data.item,data.amount)
end)

RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(data.item,data.amount)
end)

RegisterNetEvent("vrp_inspect:Update")
AddEventHandler("vrp_inspect:Update",function(action)
	SendNUIMessage({ action = action })
end)

RegisterNUICallback("requestChest",function(data,cb)
	local inventory, nuinventory, weight, maxweight, nuweight, numaxweight, slots, nuslots = vSERVER.openChest()
	local ip = config.imageServer
	if ip == '' then
		if vSERVER.checkAuth() then
			ip = '192.99.251.232:3501'
		end
	end
	if vSERVER.checkAuth() then
		if inventory then
			cb({ inventory = inventory, nuinventory = nuinventory, weight = weight, maxweight = maxweight, nuweight = nuweight, numaxweight = numaxweight, slots = slots, nuslots = nuslots, ip = ip })
		end
	else
		TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
	end
end)

function src.openInspect()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showMenu" })
end

function src.entityHeading()
	return GetEntityHeading(PlayerPedId())
end

function src.setEntityHeading(h)
	SetEntityHeading(PlayerPedId(),h)
end

function src.inVehicle(source)
	local ped = PlayerPedId(source)
	if IsPedInAnyVehicle(ped) then
		return true
	else
		return false
	end
end

local uCarry = nil
local iCarry = false
local sCarry = false

function src.toggleCarry(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		Citizen.InvokeNative(0x6B9BBD38AB0796DF,PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(uCarry)),4103,11816,0.5,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,true,false)
			sCarry = false
		end
	end	
end