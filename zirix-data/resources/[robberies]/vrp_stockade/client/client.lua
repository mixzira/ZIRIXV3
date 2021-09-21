-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_stockade",src)
vSERVER = Tunnel.getInterface("vrp_stockade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pos = 0
local blip = nil
local nveh = nil
local pveh01 = nil
local pveh02 = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDENADAS --750.85,1273.92,360.3
-----------------------------------------------------------------------------------------------------------------------------------------
local CoordenadaX, CoordenadaY, CoordenadaZ = 750.85, 1273.92, 360.3
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -1221.98, ['y'] = -317.20, ['z'] = 37.60, ['x2'] = 3592.08, ['y2'] = 3763.92, ['z2'] = 29.97, ['h'] = 296.26 },
	[2] = { ['x'] = -347.37, ['y'] = -26.85, ['z'] = 47.44, ['x2'] = 1245.13, ['y2'] = -3142.11, ['z2'] = 5.55, ['h'] = 248.83 },
	[3] = { ['x'] = 315.79, ['y'] = -264.95, ['z'] = 53.89, ['x2'] = -959.25, ['y2'] = -3047.97, ['z2'] = 13.94, ['h'] = 247.07 },
	[4] = { ['x'] = 136.28, ['y'] = -1022.26, ['z'] = 29.31, ['x2'] = -1134.31, ['y2'] = 2693.17, ['z2'] = 18.80, ['h'] = 248.58 },
	[5] = { ['x'] = -2960.66, ['y'] = 466.03, ['z'] = 15.17, ['x2'] = 1710.03, ['y2'] = -1631.85, ['z2'] = 112.48, ['h'] = 84.10 },
	[6] = { ['x'] = -130.42, ['y'] = 6467.32, ['z'] = 31.40, ['x2'] = 2712.63, ['y2'] = 1521.84, ['z2'] = 24.50, ['h'] = 133.70 },
	[7] = { ['x'] = 1172.25, ['y'] = 2686.18, ['z'] = 37.97, ['x2'] = -446.65, ['y2'] = -452.10, ['z2'] = 32.95, ['h'] = 107.89 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local RusherOtimizar = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		if Vdist(750.85,1273.92,360.3,x,y,z) <= 3 then
			RusherOtimizar = 5
			DrawMarker(21,750.85,1273.92,360.3-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,255,255,25,0,0,0,1)
			if Vdist(750.85,1273.92,360.3,x,y,z) <= 1 then
				RusherOtimizar = 4
				drawTxt("~g~E~w~  PARA HACKEAR",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and vSERVER.checkTimers() then
					TriggerEvent('cancelando',true)
					vRP._playAnim(false,{{"anim@heists@ornate_bank@hack","hack_loop"}},true)
					laptop = CreateObject(GetHashKey("prop_laptop_01a"),x-0.6,y+0.2,z-1,true,true,true)
					SetEntityHeading(ped,85.77)
					SetEntityHeading(laptop,85.77)
					TriggerEvent("mhacking:show")
					TriggerEvent("mhacking:start",3,20,mycallback)
				end
			end
		end
		Citizen.Wait(RusherOtimizar)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
function mycallback(success,time)
	if success then
		TriggerEvent("mhacking:hide")
		vSERVER.checkStockade()
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
	else
		TriggerEvent("mhacking:hide")
		vSERVER.resetTimer()
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
	end
end

RegisterCommand("cancelar", function()
	TriggerEvent("mhacking:hide")
		vSERVER.resetTimer()
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startStockade()
	pos = math.random(#locs)
		-- src.spawnStockade(locs[pos].x,locs[pos].y,locs[pos].z,locs[pos].x2,locs[pos].y2,locs[pos].z2,locs[pos].h)
		src.spawnStockade(739.73,1294.01,360.3,719.83, 1276.78, 360.3, 29.31)
		-- 739.73, 1294.01, 360.3
		-- 719.83, 1276.78, 360.3
	TriggerEvent("Notify","sucesso","Hackeado com sucesso, instalado o rastreador no carro forte.",8000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.spawnStockade(x,y,z,x2,y2,z2,h)

	local i = 0
	local vhash = GetHashKey("stockade")
	while not HasModelLoaded(vhash) and i < 10000 do
		RequestModel(vhash)
		Citizen.Wait(10)
		i = i + 1
	end

	local i2 = 0
	local phash = GetHashKey("s_m_m_security_01")
	while not HasModelLoaded(phash) and i2 < 10000 do
		RequestModel(phash)
		Citizen.Wait(10)
		i2 = i2 + 1
	end

	SetModelAsNoLongerNeeded(phash)

	if HasModelLoaded(vhash) then
		nveh = CreateVehicle(vhash,x,y,z,h,true,false)
		local netveh = VehToNet(nveh)

		NetworkRegisterEntityAsNetworked(nveh)
		while not NetworkGetEntityIsNetworked(nveh) do
			NetworkRegisterEntityAsNetworked(nveh)
			Citizen.Wait(1)
		end

		if NetworkDoesNetworkIdExist(netveh) then
			SetEntitySomething(nveh,true)
			if NetworkGetEntityIsNetworked(nveh) then
				SetNetworkIdExistsOnAllMachines(netveh,true)
			end
		end

		setBlipsStockade(nveh)
		SetVehicleOnGroundProperly(nveh)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,"STOCKADE")
		SetEntityAsMissionEntity(nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehicleDoorsLockedForAllPlayers(nveh,true)

		pveh01 = CreatePedInsideVehicle(nveh,4,phash,-1,true,false)
		pveh02 = CreatePedInsideVehicle(nveh,4,phash,0,true,false)
		setPedPropertys(pveh01,"WEAPON_MICROSMG")
		setPedPropertys(pveh02,"WEAPON_MICROSMG")

		SetEntityAsMissionEntity(pveh01,true,true)
		SetEntityAsMissionEntity(pveh02,true,true)

		SetModelAsNoLongerNeeded(mhash)

		TaskVehicleDriveToCoordLongrange(pveh01,nveh,x2,y2,z2,20.0,1074528293,1.0)
	end
end

function setPedPropertys(npc,weapon)
	SetPedShootRate(npc,850)
	SetPedSuffersCriticalHits(npc,0)
	SetPedAlertness(npc,100)
	AddArmourToPed(npc,100)
	SetPedAccuracy(npc,100)
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
	SetPedCombatRange(npc,50)
	SetPedPathAvoidFire(npc,1)
	SetPedPathCanUseLadders(npc,1)
	SetPedPathCanDropFromHeight(npc,1)
	SetPedPathPreferToAvoidWater(npc,1)
	SetPedGeneratesDeadBodyEvents(npc,1)
	GiveWeaponToPed(npc,GetHashKey(weapon),5000,true,true)
	SetPedRelationshipGroupHash(npc,GetHashKey("security_guard"))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if DoesEntityExist(nveh) and DoesEntityExist(pveh01) and DoesEntityExist(pveh02) then
			local x,y,z = table.unpack(GetEntityCoords(nveh))
			local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(nveh,0.0,-4.0,0.5))

			if IsPedDeadOrDying(pveh01) and IsPedDeadOrDying(pveh02) and not DoesEntityExist(bomba) then
				vSERVER.markOcorrency(x,y,z)
				local coordsCar = GetWorldPositionOfEntityBone(nveh, GetEntityBoneIndexByName(nveh,"door_dside_r"))
				local distancia = GetDistanceBetweenCoords(myCoords.x,myCoords.y, myCoords.z, coordsCar.x, coordsCar.y, coordsCar.z, true)

				if distancia <= 5 then
					idle = 1
					draw3DText(coordsCar.x, coordsCar.y+1, coordsCar.z, "[~g~E~w~] PARA DETONAR")
					if IsControlJustPressed(1,38) and vSERVER.checkExplosive() then
						TriggerEvent("Notify","sucesso","C4 plantada com sucesso! Se afaste para a explosão!",10000)
						TriggerEvent('iniciandoroubo',source)
						bomba = CreateObject(GetHashKey("prop_c4_final_green"),x,y,z,true,true,false)
						AttachEntityToEntity(bomba,nveh,GetEntityBoneIndexByName(nveh,"door_dside_r"),0.78,0.0,0.0,180.0,-90.0,180.0,false,false,false,true,2,true)
						
						SetTimeout(10000,function()
							TriggerServerEvent("tryDeleteEntity",PedToNet(pveh01))
							TriggerServerEvent("tryDeleteEntity",PedToNet(pveh02))
							TriggerServerEvent("tryDeleteEntity",ObjToNet(bomba))
							SetVehicleDoorOpen(nveh,2,0,0)
							SetVehicleDoorOpen(nveh,3,0,0)
							AddExplosion(GetEntityCoords(nveh),1,1.0,true,true,true)
							vSERVER.dropSystem(x2,y2,z2)
							pveh01 = nil
							pveh02 = nil
							if DoesBlipExist(blip) then
								RemoveBlip(blip)
								blip = nil
							end
						end)
					end
				end
			end	
					
			if Vdist2(locs[pos].x2,locs[pos].y2,locs[pos].z2,x,y,z) <= 30.0 then
				TriggerServerEvent("tryDeleteVehicle",VehToNet(nveh))
				TriggerServerEvent("tryDeleteEntity",PedToNet(pveh01))
				TriggerServerEvent("tryDeleteEntity",PedToNet(pveh02))
				nveh = nil
				pveh01 = nil
				pveh02 = nil
				if DoesBlipExist(blip) then
					RemoveBlip(blip)
					blip = nil
				end
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

function setBlipsStockade(entity)
	blip = AddBlipForEntity(entity)
	SetBlipSprite(blip,1)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,1)
	SetBlipScale(blip,0.4)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Carro Forte")
	EndTextCommandSetBlipName(blip)
end

function draw3DText(x,y,z, text)
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