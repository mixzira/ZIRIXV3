local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local userlogin = {}
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		local data = vRP.getUData(user_id,"vRP:spawnController")
		local sdata = json.decode(data) or 0
		if sdata then
			Citizen.Wait(1000)
			processSpawnController(source,sdata,user_id)
		end
	end
end)

function processSpawnController(source,statusSent,user_id)
	if statusSent == 2 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			doSpawnPlayer(source,user_id,false)
		else
			doSpawnPlayer(source,user_id,true)
		end
	elseif statusSent == 1 or statusSent == 0 then
		userlogin[user_id] = true
		TriggerClientEvent("character-creator:characterCreate",source)
	end
end

RegisterServerEvent("character-creator:finishedCharacter")
AddEventHandler("character-creator:finishedCharacter",function(currentCharacterMode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"currentCharacterMode",json.encode(currentCharacterMode))
		vRP.setUData(user_id,"vRP:spawnController",json.encode(2))
		
		vRP.execute("vRP/update_user_first_spawn",{ user_id = user_id, firstname = "Indigente", name = "Individuo", age = 21 })
		
		doSpawnPlayer(source,user_id,true)
		
		if vRP.getInventoryItemAmount(user_id,"passaporte") <= 0 then
			vRP.giveInventoryItem(user_id,"passaporte",1)
		end
	end
end)

function doSpawnPlayer(source,user_id,firstspawn)
	TriggerClientEvent("character-creator:normalSpawn",source,firstspawn)
	TriggerEvent("creator-barbershop:init",user_id)
end