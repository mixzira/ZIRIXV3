local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_niobio",func)
vSERVER = Tunnel.getInterface("vrp_niobio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local hackeando = false
local roubando = false
local roubo = false
local cdsx = 3611.11
local cdsy = 3728.08
local cdsz = 29.69

local npcs = {
	[1] = { ['x'] = 3612.76, ['y'] = 3720.9, ['z'] = 29.69 },
	[2] = { ['x'] = 3611.66, ['y'] = 3721.77, ['z'] = 29.69 },
	[3] = { ['x'] = 3609.8, ['y'] = 3712.92, ['z'] = 29.69 },
	[4] = { ['x'] = 3600.96, ['y'] = 3705.5, ['z'] = 29.69 },
	[5] = { ['x'] = 3599.21, ['y'] = 3717.51, ['z'] = 29.69 },
	[6] = { ['x'] = 3601.1, ['y'] = 3727.3, ['z'] = 29.69 },
	[7] = { ['x'] = 3593.3, ['y'] = 3707.13, ['z'] = 29.69 },
	[8] = { ['x'] = 3595.52, ['y'] = 3694.35, ['z'] = 28.83 },
	[9] = { ['x'] = 3591.59, ['y'] = 3678.09, ['z'] = 27.63 },
	[10] = { ['x'] = 3571.52, ['y'] = 3693.61, ['z'] = 27.25 },
	[11] = { ['x'] = 3558.42, ['y'] = 3683.4, ['z'] = 28.13 },
	[12] = { ['x'] = 3554.96, ['y'] = 3666.5, ['z'] = 28.13 },
	[13] = { ['x'] = 3546.48, ['y'] = 3644.33, ['z'] = 28.13 },
	[14] = { ['x'] = 3527.44, ['y'] = 3651.16, ['z'] = 27.53 },
	[15] = { ['x'] = 3530.92, ['y'] = 3668.48, ['z'] = 28.13 },
}

local lochacker = {
	[1] = { ['x'] = 3512.76, ['y'] = 3720.9, ['z'] = 29.69 },
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(cdsx,cdsy,cdsz)
        local distance = GetDistanceBetweenCoords(cdsx,cdsy,cdsz,x,y,z,true)
        local security = GetDistanceBetweenCoords(cdsx,cdsy,cdsz,3619.98,3743.32,28.7,true)
        if security <= 50 then
            func.npcspawn()
            if distance <= 5.0 and not roubando then
                idle = 5
                Opacidade = math.floor(255 - (distance * 10))
                TextoMarker(cdsx,cdsy,cdsz+0.4, "APERTE ~r~[ E ]~w~ PARA INICIAR O ROUBO", Opacidade, 0.54, 0.54)
                DrawMarker(27,cdsx,cdsy,cdsz-0.5, 0, 0, 0, 0, 0, 0, 1.501,1.5001,0.5001,255,0,0,155, 0, 0, 0, 1)
                TextoMarker(cdsx,cdsy,cdsz+0.7, '~r~UNIDADE: LABORATÓRIO HUMANE - NIÓBIO', Opacidade, 0.54, 0.54)
                if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then               
                    if vSERVER.checkPolice(cdsx,cdsy,cdsz) then                   
                        vSERVER.startNiobio()
                        roubando = true
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
        for k,v in pairs(npcs) do
            func.spawnNpc(v.x, v.y, v.z)  
        end
    end             
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = GetEntityCoords(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(lochacker) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and roubando then
                    idle = 4
					drawTxt("PRESSIONE  ~r~G~w~  PARA INICIAR A HACKEAR",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,47) and vSERVER.checkPermission() and vSERVER.checkHacker() then	
                        vSERVER.sendMessageAll("ATUALIZAÇÃO: Os assaltantes estão hackeando a rede do laboratório.")
                        TriggerEvent("status:hacker_digital",true)
						TriggerEvent('cancelando',true)
						
						prop = GetHashKey("prop_cs_hand_radio")
						object = CreateObject(GetHashKey("prop_police_radio_main"), GetEntityCoords(PlayerPedId()), true)	
						AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.03, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
 
						RequestAnimDict('weapons@projectile@sticky_bomb')
						while not HasAnimDictLoaded('weapons@projectile@sticky_bomb') do
						Citizen.Wait(100)
						end 

						TaskPlayAnim(ped, 'weapons@projectile@sticky_bomb', 'plant_vertical', 8.0, -8, -1, 49, 0, 0, 0, 0)		
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
        Citizen.Wait(idle)
	end
end)

local chance = 1
local bomba = GetHashKey("prop_bomb_01_s") 
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
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
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
	else
		chance = chance + 1
		TriggerEvent("mhacking:hide")
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local timedown = 0
local robbers = {
	[1] = { ['x'] = 3559.88, ['y'] = 3674.68, ['z'] = 28.13 }	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERSBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not robbery then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(robbers) do
                idle = 4
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance <= 1.1 and GetEntityHealth(ped) > 101 then					
					drawText("PRESSIONE  ~r~E~w~  PARA INICIAR O ROUBO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and timedown <= 0 then										
						timedown = 3
                        if chance > 6 then
                        chance = 6
                        end						
						vSERVER.Start(chance,v.x,v.y,v.z)
                        vSERVER.sendMessageAll("ATUALIZAÇÃO: A Segurança dos Cofres foi violada de acordo com a segurança do laboratório. A Polícia está a caminho do local.") 
					end
				end
			end
		else
            idle = 4
			drawText("PARA CANCELAR O ROUBO SAIA DA SALA",4,0.5,0.88,0.36,255,255,255,50)
			drawText("AGUARDE ~g~"..timedown.." SEGUNDOS~w~ ATÉ QUE TERMINE O ROUBO",4,0.5,0.9,0.46,255,255,255,150)
			if GetEntityHealth(PlayerPedId()) <= 101 then
				robbery = false
				vSERVER.pararroubo()
			end
		end
        Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.inicioroubo(time,x2,y2,z2)
	robbery = true
	timedown = time
	SetPedComponentVariation(PlayerPedId(),5,45,0,2)
	Citizen.CreateThread(function()
		while robbery do
			Citizen.Wait(500)
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(x,y,z,x2,y2,z2)
			if distance >= 5.0 then
				robbery = false
				vSERVER.pararroubo()
			end
		end
	end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if timedown >= 1 then
			timedown = timedown - 1
			if timedown == 0 then
				robbery = false
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
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

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawText(text,font,x,y,scale,r,g,b,a)
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

function TextoMarker(x,y,z, text, Opacidade, s1, s2)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    if onScreen then 
        SetTextScale(s1, s2)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, Opacidade)
        SetTextDropshadow(0, 0, 0, 0, Opacidade)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function func.spawnNpc(x,y,z)
    Citizen.Wait(5)
    local phash = GetHashKey("s_m_m_security_01")
    while not HasModelLoaded(phash) do
        RequestModel(phash)
        Citizen.Wait(10)
    end

    SetModelAsNoLongerNeeded(phash)

    pveh01 = CreatePed(PED_TYPE_MISSION, phash, x, y, z, 0.0, true,false)           

    setPedPropertys(pveh01,"WEAPON_COMBATPISTOL")

    SetEntityAsMissionEntity(pveh01,true,true)  
end

function setPedPropertys(npc,weapon)
	SetPedShootRate(npc,550)
	SetPedSuffersCriticalHits(npc,0)
	SetPedAlertness(npc,1000)
	AddArmourToPed(npc,100)
	SetPedAccuracy(npc,80)
	SetPedArmour(npc,100)
	SetPedCanSwitchWeapon(npc,true)
	SetEntityHealth(npc,300)
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