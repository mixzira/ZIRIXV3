ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

ESX.PlayerData = ESX.GetPlayerData()
end)

local enemyblips = {}
local coords
local usedItem = false
local active = false
local blip
local cleanDead
local enroute
local radius
local marker
local enemies = {}
local box2
local inUse = false
local location = nil
local rand

if not Config.hideBlip then
	Citizen.CreateThread(function()
		while not coords do
			Citizen.Wait(1000)
		end
		marker = AddBlipForCoord(coords.x, coords.y, coords.z)	
		SetBlipSprite(marker, Config.blipSprite)
		SetBlipScale(marker, 0.9)      
	    SetBlipAsShortRange(marker, true)
	    BeginTextCommandSetBlipName("STRING")
	    EndTextCommandSetBlipName(marker)
	    SetBlipColour(marker, 4)
	    if Config.hideBlip then
			RemoveBlip(marker)
		end
	end)
end

Citizen.CreateThread(function()
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    ESX.TriggerServerCallback('bounty:getlocation', function(servercoords)
        coords = servercoords
	end)
end)

RegisterNetEvent('bounty:synctable')
AddEventHandler('bounty:synctable', function(bool)
    inUse = bool
end)

Citizen.CreateThread(function()
	while not coords do
		Citizen.Wait(1000)
	end
	local sleep
	while true do
		sleep = 5
		local player = GetPlayerPed(-1)
		local playercoords = GetEntityCoords(player)
		local dist = #(vector3(playercoords.x, playercoords.y, playercoords.z)-vector3(coords.x, coords.y, coords.z))
		if not inUse then
			if dist <= 3 then
				sleep = 5
				DrawText3Ds(coords.x, coords.y, coords.z, _U'press_start')
				--DrawMarker(1, coords.x, coords.y, coords.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 0.2, 0, 255, 100, 100, false, true, 2, false, false, false, false)
				if IsControlJustPressed(1, 51) then
					decipherAnim()
					main()
				end
			else
				sleep = 2000
			end
		elseif dist <= 3 and inUse then
			sleep = 5
			DrawText3Ds(coords.x, coords.y, coords.z, _U'unavailable')
		else
			sleep = 3000
		end
		Citizen.Wait(sleep)
	end
end)


RegisterNetEvent('bounty:syncMissionClient')
AddEventHandler('bounty:syncMissionClient', function(missionData)
  locations = missionData
  inUse = missionData
end)

function main()
	TriggerServerEvent('bounty:updatetable', true)
	inUse = true
	rand = math.random(1,#Config.locations)
	location = Config.locations[rand]
	SetNewWaypoint(location.addBlip.x,location.addBlip.y)
	addBlip(location.addBlip.x,location.addBlip.y,location.addBlip.z)
	if Config.useMythic then
		exports['mythic_notify']:DoLongHudText('inform', _U'search_area')
	end
	local player = GetPlayerPed(-1)
	local playerpos
	enroute = true
	local howmany
	Citizen.CreateThread(function()
		while enroute == true do
			Citizen.Wait(200)
			playerpos = GetEntityCoords(player)
			local disttocoord = #(vector3(location.enemy.x, location.enemy.y, location.enemy.z)-vector3(playerpos.x,playerpos.y,playerpos.z))
			if disttocoord < Config.distance then
				if Config.useMythic then
					exports['mythic_notify']:DoLongHudText('inform', _U'kill_all')
				end
				spawnPed(location.enemy.x,location.enemy.y,location.enemy.z)
				enroute = false
				if Config.removeArea then
					RemoveBlip(radius)
				end			
				return
			else
				Citizen.Wait(1000)
			end
		end
	end)
	Citizen.CreateThread(function()
		while inUse do
			playerpos = GetEntityCoords(player)												
			local disttocoord = #(vector3(location.enemy.x, location.enemy.y, location.enemy.z)-vector3(playerpos.x,playerpos.y,playerpos.z))
			if IsEntityDead(player) then
				Citizen.Wait(1000)
				clearmission()
				return
			else
				howmany = checkisdead()
				if howmany == Config.enemies then
					Citizen.Wait(2000)
					clearmission()
					success(location.crate.x, location.crate.y, location.crate.z, location.crate.h)
				end	
				if disttocoord > Config.maxDistance and not enroute then
					exports['mythic_notify']:DoLongHudText('inform', _U'max_dist')
					maxDist()
					return
				end
			end
			Citizen.Wait(1000)
		end
	end)
	if Config.printRemaining then
		Citizen.CreateThread(function()
			local sleep = 5
			while inUse do
				if not enroute then
					sleep = 5
					DrawText2D("Enemies Killed: "..howmany,0,1,0.5,0.92,0.6,255,255,255,255)
				else
					sleep = 1000
				end
				Citizen.Wait(sleep)
			end
		end)
	end
end

function maxDist()
	inUse = false
	TriggerServerEvent('bounty:updatetable', false)
	RemoveBlip(radius)
	RemoveBlip(blip)
	usedItem = false
	active = false
	for a = 1, #enemies do
		if DoesEntityExist(enemies[a]) then
			DeleteEntity(enemies[a])
		end
	end
end

function success(x,y,z,h)
	local box = GetHashKey(Config.boxProp)
	box2 = CreateObject(box, x,y,z-1, true, true, false)
	local crate = false
	local player = GetPlayerPed(-1)
	if Config.useMythic then
		exports['mythic_notify']:DoLongHudText('inform', _U'search_evidence')
	end
	FreezeEntityPosition(box2, true)
	SetEntityHeading(box2, h)
	Citizen.CreateThread(function()
		while not crate do 
			local sleep = 5
			local playercoords = GetEntityCoords(player)
			local disttocoord = #(vector3(x,y,z)-vector3(playercoords.x, playercoords.y, playercoords.z))
			if disttocoord <= 3 then
				sleep = 5
				DrawText3Ds(x,y,z, _U'search_crate')
				if IsControlJustPressed(1, 51) then
					crate = true
					TaskTurnPedToFaceEntity(player, box2, 5500)
					FreezeEntityPosition(GetPlayerPed(-1), true)
					if Config.progBar then
						exports['progressBars']:startUI(5500, _U'searching')
					end
					playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 6000)
					Citizen.Wait(5000)
					DoScreenFadeOut(1000)
					Citizen.Wait(1500)
					DoScreenFadeIn(2000)
					FreezeEntityPosition(GetPlayerPed(-1), false)
					DeleteEntity(box2)
					if Config.useMythic then
						exports['mythic_notify']:DoLongHudText('success', _U'receive_tags')
					end
					TriggerServerEvent('bounty:GiveItem', location.crate.x, location.crate.y, location.crate.z, location.crate.h)
					Citizen.Wait(2000)
					Config.locations[rand]['active'] = false
					TriggerServerEvent('bounty:syncMission', locations)
				end
			else
				sleep = 1200
			end
			Citizen.Wait(sleep)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		sleep = 5
		local player = GetPlayerPed(-1)
		local playercoords = GetEntityCoords(player)
		local disttocoord = #(vector3(2475.588, -384.1472, 94.39928)-vector3(playercoords.x, playercoords.y, playercoords.z))
		if disttocoord < 3 then
			DrawText3Ds(2475.588, -384.1472, 94.39928, _U'deliver_tags')
			if IsControlJustPressed(1, 51) then
				TriggerServerEvent('bounty:delivery')
				Citizen.Wait(2000)
			end
		else
			sleep = 1500
		end
		Citizen.Wait(sleep)
	end
end)

function decipherAnim()
	local player = GetPlayerPed(-1)
    if Config.progBar then
		exports['progressBars']:startUI(8000, _U'decipher')
	end
	
	SetEntityCoords(player, 1275.638, -1710.345, 53.77143, 0.0, 0.0, 0.0, false)
	SetEntityHeading(player, 320.36)
	FreezeEntityPosition(player, true)
	playAnim('anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 8000)
	Citizen.Wait(8500)
	FreezeEntityPosition(player, false)
end

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Citizen.Wait(0) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

function clearmission()
	inUse = false
	TriggerServerEvent('bounty:updatetable', false)
	RemoveBlip(radius)
	RemoveBlip(blip)
	usedItem = false
	active = false
	if Config.cleanDead then
		for a = 1, #enemies do
			if DoesEntityExist(enemies[a]) then
				DeleteEntity(enemies[a])
			end
		end
	end
end

function checkisdead()
	local dead = 0
	for a = 1, #enemies do
		if IsEntityDead(enemies[a]) then
			dead = dead + 1
		end
	end
	return dead
end

function addBlip(x,y,z)
	radius = AddBlipForRadius(x, y, z, Config.radius)
	blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, 433)
	SetBlipColour(blip, 1)
	SetBlipHighDetail(radius, true)
	SetBlipColour(radius, 1)
	SetBlipAlpha (radius, 128)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U'mission_area')
	EndTextCommandSetBlipName(blip)
end

function spawnPed(x,y,z)
	local ped = GetHashKey(Config.spawnedEnemy)
	RequestModel(ped)
	while not HasModelLoaded(ped) do
		Citizen.Wait(0)
	end	

	ESX.TriggerServerCallback("bounty:getCops", function(getCops)
		if Config.waypoint then 
    		SetNewWaypoint(x, y)
    	end
		for i=1,Config.enemies do
			local rnum = math.random(10,50)
			local pick = math.random(1,5)
			local wep
			local enemy

			if getCops >= Config.amountCop then
				--Difficulty 1
				if pick == 1 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty1_1)
				elseif pick == 2 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty1_2)
				elseif pick == 3 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty1_3)
				elseif pick == 4 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty1_4)
				else 
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty1_5)
				end

			elseif getCops < Config.amountCop then
				--Difficulty 2
				if pick == 1 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty2_1)
				elseif pick == 2 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty2_2)
				elseif pick == 3 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty2_3)
				elseif pick == 4 then
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty2_4)
				else 
					enemy = CreatePed(4, ped, x+rnum, y+rnum, z, 100.0, true, true)
					wep = GetHashKey(Config.difficulty2_5)
				end
			end

			AddRelationshipGroup("enemies")
			SetPedRelationshipGroupHash(enemy, GetHashKey("enemies"))
			SetPedRelationshipGroupHash(GetPlayerPed(-1), GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(5, GetHashKey("enemies"), GetHashKey("PLAYER"))
    		SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("enemies"))
			SetRelationshipBetweenGroups(1, GetHashKey("enemies"), GetHashKey("enemies"))
			GiveWeaponToPed(enemy, wep, 500, false, true)
			SetPedCombatAttributes(enemy, 46, true)
			SetPedCombatAbility(enemy, 100)
			SetPedCombatMovement(enemy, 2)
			SetPedCombatRange(enemy, 2)
			SetEntityMaxHealth(enemy, Config.enemyHealth)
			SetEntityHealth(enemy, Config.enemyHealth)
			SetPedAccuracy(enemy, Config.enemyAcc)
			SetPedDropsWeaponsWhenDead(enemy, false)
			table.insert(enemies, enemy)
			if Config.enemyVest then
				SetPedArmour(enemy, Config.enemyArmor)
			end		
		end
	end)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function DrawText2D(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(6)
	SetTextProportional(6)
	SetTextScale(scale/1.0, scale/1.0)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

-- (Optional) Shows your coords, useful if you want to add new locations.

if Config.getCoords then
	RegisterCommand("mycoords", function()
		local player = GetPlayerPed(-1)
	    local x,y,z = table.unpack(GetEntityCoords(player))
	    print("X: "..x.." Y: "..y.." Z: "..z)
	end)
end

-- More optional stuff

--[[AddEventHandler('onClientResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
	  return
	end
	print('The resource ' .. resourceName .. ' has been started on the client.')
end)

AddEventHandler('onClientResourceStop', function (resourceName)
print('The resource ' .. resourceName .. ' has been stopped on the client.')
end)]]
