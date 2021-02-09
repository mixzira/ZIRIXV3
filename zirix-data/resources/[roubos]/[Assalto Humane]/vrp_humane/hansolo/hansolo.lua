local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_humane",func)
vSERVER = Tunnel.getInterface("vrp_humane")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local hackeando = false
local roubando = false
local roubo = false
local timedown = 0
local kill = false
local chance = 0

Citizen.CreateThread(function()
	while true do
        local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(config.start[1],config.start[2],config.start[3])
        local distance = GetDistanceBetweenCoords(config.start[1],config.start[2],config.start[3],x,y,z,true)
        local security = GetDistanceBetweenCoords(config.start[1],config.start[2],config.start[3],config.securitypoint[1],config.securitypoint[2],config.securitypoint[3],true)
        if security <= config.security then
            func.npcspawn()
			if distance <= 5.0 and not roubando then
                idle = 5			
				DrawMarker(23, config.start[1],config.start[2],config.start[3]-0.97,0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
				if distance <= 1.5 then
					drawTxt("Pressione [~r~E~w~] para iniciar o ~r~ROUBO~w~.",4,0.5,0.92,0.35,255,255,255,180)
					if IsControlJustPressed(0,38) and vSERVER.checkHacker() and not IsPedInAnyVehicle(ped) and vSERVER.checkPermission() then
						if vSERVER.checkPolice(config.start[1],config.start[2],config.start[3]) then 					
							vSERVER.sendMessageAll("ATUALIZAÇÃO: Os assaltantes estão hackeando a rede do laboratório.")
							vSERVER.robberywebwook()
							TriggerEvent("status:hacker_digital",true)
							TriggerEvent('cancelando',true)
							
							prop = GetHashKey("prop_cs_hand_radio")
							object = CreateObject(GetHashKey("prop_police_radio_main"), GetEntityCoords(PlayerPedId()), true)	
							AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.03, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

							RequestAnimDict('weapons@projectile@sticky_bomb')
							while not HasAnimDictLoaded('weapons@projectile@sticky_bomb') do
							Citizen.Wait(100)
							end

							vRP._playAnim(true,{{"weapons@projectile@sticky_bomb","plant_vertical"}},false)		
							TriggerEvent("progress", 1900, "CONECTANDO AO DISPOSITIVO...")
							Citizen.Wait(1000)
							DeleteEntity(object)
							Citizen.Wait(700)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Citizen.Wait(200)
							TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)						
							TriggerEvent("progress", 5000, "ACESSANDO O SISTEMA...")
							Citizen.Wait(7100)
							TriggerEvent("mhacking:show")
							TriggerEvent("mhacking:start",3,20,mycallback)           
						end
					end
				end
            end
        end	
        Citizen.Wait(idle)	
	end
end)


function func.npcspawn()
    if not roubo then
        roubo = true
        for k,v in pairs(config.spawn) do
            func.spawnNpc(v.x, v.y, v.z)  
        end
    end             
end

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(config.start[1],config.start[2],config.start[3])
		for k,v in pairs(config.itens) do	
        	local distance = GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true)
			if roubando then
				if distance <= 15 then 
					idle = 5	
					DrawMarker(23, v.x, v.y, v.z-0.97,0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
					if distance <= 1 then
						drawTxt("Pressione [~r~E~w~] para pegar os ~r~ITENS~w~.",4,0.5,0.92,0.35,255,255,255,180)
						if IsControlJustPressed(0,38) then
							if k == 1 then
								if not item1 then
									item1 = true
									vRP._playAnim(true,{{config.anim}},false)	
									FreezeEntityPosition(ped, true)
									TriggerEvent("progress", config.timerob)
									SetTimeout(config.timerob,function()
										vSERVER.Start(k)
										FreezeEntityPosition(ped, false)
										vRP.stopAnim(ped,false)
									end)
								end
							elseif k == 2 then
								if not item2 then
									item2 = true
									vRP._playAnim(true,{{config.anim}},false)	
									FreezeEntityPosition(ped, true)
									TriggerEvent("progress", config.timerob)
									SetTimeout(config.timerob,function()
										vSERVER.Start(k)
										FreezeEntityPosition(ped, false)
										vRP.stopAnim(ped,false)
									end)
								end
							elseif k == 3 then
								if not item3 then
									item3 = true
									vRP._playAnim(true,{{config.anim}},false)	
									FreezeEntityPosition(ped, true)
									TriggerEvent("progress", config.timerob)
									SetTimeout(config.timerob,function()
										vSERVER.Start(k)
										FreezeEntityPosition(ped, false)
										vRP.stopAnim(ped,false)
									end)
								else
									TriggerEvent("Notify","negado","Armarios vazios.") 
								end
							elseif k == 4 then
								if not item4 then
									item4 = true
									vRP._playAnim(true,{{config.anim}},false)	
									FreezeEntityPosition(ped, true)
									TriggerEvent("progress", config.timerob)
									SetTimeout(config.timerob,function()
										vSERVER.Start(k)
										FreezeEntityPosition(ped, false)
										vRP.stopAnim(ped,false)
									end)
								else
									TriggerEvent("Notify","negado","Armarios vazios.") 
								end
							elseif k == 5 then
								if not item5 then
									item5 = true
									vRP._playAnim(true,{{config.anim}},false)	
									FreezeEntityPosition(ped, true)
									TriggerEvent("progress", config.timerob)
									SetTimeout(config.timerob,function()
										vSERVER.Start(k)
										FreezeEntityPosition(ped, false)
										vRP.stopAnim(ped,false)
									end)
								else
									TriggerEvent("Notify","negado","Armarios vazios.") 
								end
							elseif k == 6 then
								if not item6 then
									item6 = true
									vRP._playAnim(true,{{config.anim}},false)	
									FreezeEntityPosition(ped, true)
									TriggerEvent("progress", config.timerob)
									SetTimeout(config.timerob,function()
										vSERVER.Start(k)
										FreezeEntityPosition(ped, false)
										vRP.stopAnim(ped,false)
									end)
								else
									TriggerEvent("Notify","negado","Armarios vazios.") 
								end
							elseif k == 7 then
								if not item7 then
									item7 = true
									vRP._playAnim(true,{{config.anim}},false)	
									FreezeEntityPosition(ped, true)
									TriggerEvent("progress", config.timerob)
									SetTimeout(config.timerob,function()
										vSERVER.Start(k)
										FreezeEntityPosition(ped, false)
										vRP.stopAnim(ped,false)
									end)
								else
									TriggerEvent("Notify","negado","Armarios vazios.") 
								end
							elseif k == 8 then
								if not item8 then
									item8 = true
									vRP._playAnim(true,{{config.anim}},false)	
									FreezeEntityPosition(ped, true)
									TriggerEvent("progress", config.timerob)
									SetTimeout(config.timerob,function()
										vSERVER.Start(k)
										FreezeEntityPosition(ped, false)
										vRP.stopAnim(ped,false)
									end)
								else
									TriggerEvent("Notify","negado","Armarios vazios.") 
								end
							elseif k == 9 then
								if not item9 then
									item9 = true
									vRP._playAnim(true,{{config.anim}},false)	
									FreezeEntityPosition(ped, true)
									TriggerEvent("progress", config.timerob)
									SetTimeout(config.timerob,function()
										vSERVER.Start(k)
										FreezeEntityPosition(ped, false)
										vRP.stopAnim(ped,false)
									end)
								else
									TriggerEvent("Notify","negado","Armarios vazios.") 
								end
							end
						end
					end
				end
			end
		end
        Citizen.Wait(idle)
	end
end)

function mycallback(success,time)
	if success then	
		TriggerEvent("mhacking:hide",function()       
    		if outcome == true then -- reason will be nil if outcome is true
       			hackeando = true
    		elseif outcome == false then
       			chance = chance + 1
    		end
		end)
        vSERVER.sendMessageAll("ATUALIZAÇÃO: Os assaltantes acabaram de invadir o sistema.")
		roubando = true
		for k,v in pairs(config.itens) do
			criandoblip(v.x,v.y,v.z)
		end
		DeleteObject(laptop)
		vRP.stopAnim(false)
		TriggerEvent('cancelando',false)
	else
		chance = chance + 1
		TriggerEvent("mhacking:hide")
		DeleteObject(laptop)
		vRP.stopAnim(false)
		TriggerEvent('cancelando',false)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if timedown >= 1 then
			timedown = timedown - 1
			if timedown == 0 then
				robbery = false
				item1 = false
				item2 = false
				item3 = false
				item4 = false
				item5 = false
				item6 = false
				item7 = false
				item8 = false
				item9 = false
			end
		end
	end
end)

function criandoblip(x,y,z)
	blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,27)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Local de Roubo")
	EndTextCommandSetBlipName(blip)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

function loadModel(model)
    Citizen.CreateThread(function()
        while not HasModelLoaded(model) do
            RequestModel(model)
          Citizen.Wait(1)
        end
    end)
end

function func.spawnNpc(x,y,z)
    Citizen.Wait(5)
    local phash = GetHashKey(config.skin)
    while not HasModelLoaded(phash) do
        RequestModel(phash)
        Citizen.Wait(10)
    end

    SetModelAsNoLongerNeeded(phash)

    pveh01 = CreatePed(PED_TYPE_MISSION, phash, x, y, z, 0.0, true,false)           

    setPedPropertys(pveh01,config.weapon)

    SetEntityAsMissionEntity(pveh01,true,true)  
end

function setPedPropertys1(npc)
	SetEntityHealth(npc,0)
end

function setPedPropertys(npc,weapon)
	SetPedShootRate(npc,450)
	SetPedSuffersCriticalHits(npc,1)
	SetPedAlertness(npc,1000)
	AddArmourToPed(npc,config.armour)
	SetPedAccuracy(npc,70)
	SetPedArmour(npc,config.armour)
	SetPedCanSwitchWeapon(npc,true)
	SetEntityHealth(npc,config.health)
	SetPedFleeAttributes(npc,0,0)
	SetPedConfigFlag(npc,118,false)
	SetPedCanRagdollFromPlayerImpact(npc,0)
	SetPedCombatAttributes(npc,46,true)
	SetEntityIsTargetPriority(npc,1,0)
	SetPedGetOutUpsideDownVehicle(npc,1)
	SetPedPlaysHeadOnHornAnimWhenDiesInVehicle(npc,1)
	SetPedKeepTask(npc,true)
	SetEntityLodDist(npc,250)
	SetPedCombatAbility(npc,2)
	SetPedCombatRange(npc,2)
	SetPedPathAvoidFire(npc,1)
	SetPedPathCanUseLadders(npc,1)
	SetPedPathCanDropFromHeight(npc,1)
	SetPedPathPreferToAvoidWater(npc,1)
	SetPedGeneratesDeadBodyEvents(npc,1)
	GiveWeaponToPed(npc,GetHashKey(weapon),5000,true,true)
	
	AddRelationshipGroup("enemies")
	SetPedRelationshipGroupHash(npc, GetHashKey("enemies"))
	SetPedRelationshipGroupHash(GetPlayerPed(-1), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("enemies"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("enemies"))
	SetRelationshipBetweenGroups(1, GetHashKey("enemies"), GetHashKey("enemies"))
end