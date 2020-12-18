local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]-------------------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("vrp_chest",src)
vSERVER = Tunnel.getInterface("vrp_chest")

--[ VARIABLES ]--------------------------------------------------------------------------------------------------------------------------

local chestTimer = false
local chestOpen = ""

--[ STARTFOCUS ]-------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

--[ CHESTCLOSE ]-------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("chestClose",function(data)
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)

--[ TAKEITEM ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(chestOpen),data.item,data.amount)
end)

--[ STOREITEM ]--------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(tostring(chestOpen),data.item,data.amount)
end)

--[ AUTO-UPDATE ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("Chest:UpdateChest")
AddEventHandler("Chest:UpdateChest",function(action)
	SendNUIMessage({ action = action })
end)

--[ REQUESTCHEST ]-----------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestChest",function(data,cb)
	local inventory, chest, weight, maxweight, weightchest, maxweightchest, slots, slotschest = vSERVER.openChest(tostring(chestOpen))
	local ip = config.imageServer
	print(slotschest)
	if ip == '' then
		if vSERVER.checkAuth() then
			ip = '192.99.251.232:3501'
		end
	end
	if inventory then
		cb({ inventory = inventory, chest = chest, weight = weight, maxweight = maxweight, weightchest = weightchest, maxweightchest = maxweightchest, slots = slots, slotschest = slotschest, ip = ip })
	end
end)

--[ CHEST ]------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("vrp_chest:use")
AddEventHandler("vrp_chest:use",function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(config.chest) do
		local distance = GetDistanceBetweenCoords(x,y,z,v[2],v[3],v[4],true)
		local nuser_id = vRP.getNearestPlayer(3)
		if distance < 0.8 and not nuser_id then
			if vSERVER.checkIntPermissions(v[1]) and not chestTimer then
				if vSERVER.checkAuth() then
					chestTimer = true
					TransitionToBlurred(1000)
					SetNuiFocus(true,true)
					SendNUIMessage({ action = "showMenu" })
					chestOpen = tostring(v[1])
					SetTimeout(3000,function()
						chestTimer = false
					end)
				else
					TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
				end
			end
		end
	end
end)