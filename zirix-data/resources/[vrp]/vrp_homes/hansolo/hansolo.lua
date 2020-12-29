local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_homes",src)
vSERVER = Tunnel.getInterface("vrp_homes")

local houseOpen = ""

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

RegisterNUICallback("chestClose",function(data)
	TriggerEvent("vrp_sound:source",'mochila',0.2)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)

RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(houseOpen),data.item,data.amount)
end)

RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(tostring(houseOpen),data.item,data.amount)
end)

RegisterNetEvent("vrp_homes:Update")
AddEventHandler("vrp_homes:Update",function(action)
	SendNUIMessage({ action = action })
end)

RegisterNUICallback("requestVault",function(data,cb)
	local inventory, chest, weight, maxweight, weightchest, maxweightchest, slots, slotschest = vSERVER.openChest(tostring(houseOpen))
	local ip = config.imageServer
	if ip == '' then
		if vSERVER.checkStreaming() then
			ip = '192.99.251.232:3501'
		end
	end	
	if inventory then
		cb({ inventory = inventory, chest = chest, weight = weight, maxweight = maxweight, weightchest = weightchest, maxweightchest = maxweightchest, slots = slots, slotschest = slotschest, ip = ip })
	end
end)

RegisterNetEvent("vrp_homes:join")
AddEventHandler("vrp_homes:join",function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(config.homes) do
		local _,i = GetGroundZFor_3dCoord(v["enter"][1],v["enter"][2],v["enter"][3])
		local distance = Vdist(x,y,z,v["enter"][1],v["enter"][2],i)
		if distance <= 1.5 and vSERVER.checkPermissions(k) then
			if vSERVER.checkAuth() then
				DoScreenFadeOut(1000)
				TriggerEvent("vrp_sound:source","enterexithouse",0.7)
				SetTimeout(1400,function()
					SetEntityCoords(ped,v["exit"][1]+0.0001,v["exit"][2]+0.0001,v["exit"][3]+0.0001-1,1,0,0,1)
					Citizen.Wait(750)
					DoScreenFadeIn(1000)
					houseOpen = tostring(k)
				end)
			else
				TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
			end
		end
	end
end)


RegisterNetEvent("vrp_homes:exit")
AddEventHandler("vrp_homes:exit",function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(config.homes) do
		local _,i = GetGroundZFor_3dCoord(v["exit"][1],v["exit"][2],v["exit"][3])
		local distance = Vdist(x,y,z,v["exit"][1],v["exit"][2],i)
		if distance <= 1.5 then
			if vSERVER.checkAuth() then
				DoScreenFadeOut(1000)
				TriggerEvent("vrp_sound:source","enterexithouse",0.5)
				SetTimeout(1300,function()
					SetEntityCoords(ped,v["enter"][1]+0.0001,v["enter"][2]+0.0001,v["enter"][3]+0.0001-1,1,0,0,1)
					Citizen.Wait(750)
					DoScreenFadeIn(1000)
					houseOpen = ""
				end)
			else
				TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
			end
		end
	end
end)

RegisterNetEvent("vrp_homes:chest")
AddEventHandler("vrp_homes:chest",function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local nuser_id = vRP.getNearestPlayer(3)
	for k,v in pairs(config.homes) do
		local _,i = GetGroundZFor_3dCoord(v["vault"][1],v["vault"][2],v["vault"][3])
		local distance = Vdist(x,y,z,v["vault"][1],v["vault"][2],i)
		if distance <= 2.0 and vSERVER.checkIntPermissions(k) and not nuser_id then
			if vSERVER.checkAuth() then
				TriggerEvent("vrp_sound:source","mochila",0.5)
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
				houseOpen = tostring(k)
			else
				TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
			end
		end
	end
end)

RegisterNetEvent("vrp_homes:invade")
AddEventHandler("vrp_homes:invade",function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(config.homes) do
		local _,i = GetGroundZFor_3dCoord(v["enter"][1],v["enter"][2],v["enter"][3])
		local distance = Vdist(x,y,z,v["enter"][1],v["enter"][2],i)
		if distance <= 1.5 and vSERVER.checkPolice() then
			DoScreenFadeOut(1000)
			TriggerEvent("vrp_sound:source","enterexithouse",0.7)
			SetTimeout(1400,function()
				SetEntityCoords(ped,v["exit"][1]+0.0001,v["exit"][2]+0.0001,v["exit"][3]+0.0001-1,1,0,0,1)
				Citizen.Wait(750)
				DoScreenFadeIn(1000)
			end)
		end
	end
end)

function src.getHomeStatistics()
	return tostring(houseOpen)
end

function src.setBlipsOwner(homeName)
	local blip = AddBlipForCoord(config.homes[homeName]["enter"][1],config.homes[homeName]["enter"][2],config.homes[homeName]["enter"][3])
	SetBlipSprite(blip,411)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,36)
	SetBlipScale(blip,0.4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Residência: ~g~"..homeName)
	EndTextCommandSetBlipName(blip)
end

function src.setBlipsHomes(status)
	for k,v in pairs(status) do
		local blip = AddBlipForCoord(config.homes[v.name]["enter"][1],config.homes[v.name]["enter"][2],config.homes[v.name]["enter"][3])
		SetBlipSprite(blip,411)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,2)
		SetBlipScale(blip,0.4)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Disponível: ~g~"..v.name)
		EndTextCommandSetBlipName(blip)
		SetTimeout(30000,function()
			if DoesBlipExist(blip) then
				RemoveBlip(blip)
			end
		end)
	end
end