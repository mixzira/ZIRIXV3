local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_chest",src)
vSERVER = Tunnel.getInterface("vrp_chest")

local chestOpen = ""

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

RegisterNUICallback("chestClose",function(data)
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)

RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(chestOpen),data.item,data.amount)
end)

RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(tostring(chestOpen),data.item,data.amount)
end)

RegisterNetEvent("Chest:UpdateChest")
AddEventHandler("Chest:UpdateChest",function(action)
	SendNUIMessage({ action = action })
end)

RegisterNUICallback("requestChest",function(data,cb)
	local inventory, chest, weight, maxweight, weightchest, maxweightchest, slots, slotschest = vSERVER.openChest(tostring(chestOpen))
	local ip = config.imageServer
	if inventory then
		cb({ inventory = inventory, chest = chest, weight = weight, maxweight = maxweight, weightchest = weightchest, maxweightchest = maxweightchest, slots = slots, slotschest = slotschest, ip = ip })
	end
end)


RegisterNetEvent("vrp_chest:use")
AddEventHandler("vrp_chest:use",function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(config.chest) do
		local distance = GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true)
		local nuser_id = vRP.getNearestPlayer(3)
		if distance < 0.8 and not nuser_id then
			if vSERVER.checkIntPermissions(v.perm) and not chestTimer then
				TransitionToBlurred(1000)
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
				chestOpen = tostring(k)
			end
		end
	end
end)