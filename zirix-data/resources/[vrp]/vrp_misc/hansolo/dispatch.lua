local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local blips = {}
local tasertime = false
local isBlackout = false
local oldSpeed = 0
local mouseRagdol = false
local ragdoll = false
local ragdol = false
local hurt = false
local bunnyhop = 0

--[ DISPATCH ]---------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	for i = 1,120 do
		EnableDispatchService(i,false)
	end
end)

--[[ DESABILITAR X NA MOTO ]--------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local idle = 1000
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(vehicle,0) == ped and GetVehicleClass(vehicle) == 8 then
				local idle = 250
				DisableControlAction(0,73,true) 
			end
		end
		Citizen.Wait(idle)
	end
end)]]

--[ DESABILITAR A CORONHADA ]------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
		local ped = PlayerPedId()
		local idle = 1000
		if IsPedArmed(ped,6) then
			idle = 10
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
		end
		Citizen.Wait(idle)
    end
end)

--[ REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO ]---------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				local speed = GetEntitySpeed(vehicle)*2.236936
				if speed >= 40 then
					SetPlayerCanDoDriveBy(PlayerId(),false)
				else
					SetPlayerCanDoDriveBy(PlayerId(),true)
				end
			end
		end
	end
end)

--[ DESATIVA O CONTROLE DO CARRO ENQUANTO ESTIVER NO AR ]--------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		local idle = 1000
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABicycle(model) and not IsThisModelABike(model) and not IsThisModelAQuadbike(model) and IsEntityInAir(veh) then
				idle = 5
				DisableControlAction(0,59)
                DisableControlAction(0,60)
            end
		end
		Citizen.Wait(idle)
    end
end)

--[ ESTOURAR OS PNEUS ]------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped then
                local speed = GetEntitySpeed(vehicle)*2.236936
                if speed >= 180 and math.random(100) >= 97 then
                    if GetVehicleTyresCanBurst(vehicle) == false then return end
                    local pneus = GetVehicleNumberOfWheels(vehicle)
                    local pneusEffects
                    if pneus == 2 then
                        pneusEffects = (math.random(2)-1)*4
                    elseif pneus == 4 then
                        pneusEffects = (math.random(4)-1)
                        if pneusEffects > 1 then
                            pneusEffects = pneusEffects + 2
                        end
                    elseif pneus == 6 then
                        pneusEffects = (math.random(6)-1)
                    else
                        pneusEffects = 0
                    end
                    SetVehicleTyreBurst(vehicle,pneusEffects,false,1000.0)
                end
            end
        end
    end
end)

--[ BLIPS ]------------------------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v.x,v.y,v.z)
		SetBlipSprite(blip,v.sprite)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v.color)
		SetBlipScale(blip,v.scale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.nome)
		EndTextCommandSetBlipName(blip)
	end
end)

--[ BLACKOUT ]---------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsEntityAVehicle(vehicle) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
			idle = 10
			local currentSpeed = GetEntitySpeed(vehicle)*2.236936
			if currentSpeed ~= oldSpeed then
				if not isBlackout and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= 50) then
					blackout()
				end
				oldSpeed = currentSpeed
			end
		else
			if oldSpeed ~= 0 then
				oldSpeed = 0
			end
		end
		if isBlackout then
			DisableControlAction(0,63,true)
			DisableControlAction(0,64,true)
			DisableControlAction(0,71,true)
			DisableControlAction(0,72,true)
			DisableControlAction(0,75,true)
		end
		Citizen.Wait(idle)
	end
end)

function blackout()
	TriggerEvent("vrp_sound:source",'heartbeat',0.5)
	if not isBlackout then
		isBlackout = true
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-400)
		Citizen.CreateThread(function()
			DoScreenFadeOut(500)
			while not IsScreenFadedOut() do
				Citizen.Wait(10)
			end
			Citizen.Wait(5000)
			DoScreenFadeIn(5000)
			isBlackout = false
		end)
	end
end

--[ DAMAGE WALK MODE ]-------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) then
			if GetEntityHealth(ped) <= 199 then
				idle = 5
				setHurt()
			elseif hurt and GetEntityHealth(ped) > 200 then
				setNotHurt()
			end
		end
		Citizen.Wait(idle)
	end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPedId(),"move_m@injured",true)
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
	DisableControlAction(0,21) 
	DisableControlAction(0,22)
end

function setNotHurt()
    hurt = false
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
end

--[ COOLDOWN BUNNYHOP ]------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if bunnyhop > 0 then
            bunnyhop = bunnyhop - 5
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedJumping(ped) and bunnyhop <= 0 then
            bunnyhop = 5
        end
        if bunnyhop > 0 then
            DisableControlAction(0,22,true)
        end
        Citizen.Wait(1000)
    end
end)

function setRagdoll(flag)
  ragdoll = flag
end

Citizen.CreateThread(function()
	while true do
		idle = 1000
		if ragdoll then
			idle = 5
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
		end
		Citizen.Wait(idle)
	end
end)

RegisterNetEvent("vrp_misc:Ragdoll")
AddEventHandler("vrp_misc:Ragdoll", function()
	if ragdol then
		setRagdoll(true)
		ragdol = true
	else
		setRagdoll(false)
		ragdol = false
		ClearPedTasks(PlayerPedId())
	end
end)


RegisterNetEvent("vrp_misc:RagdollTime")
AddEventHandler("vrp_misc:RagdollTime", function(time)
	mouseRagdol = true
	setRagdoll(true)
	Wait(time)
	mouseRagdol = false
	setRagdoll(false)
	ClearPedTasks(PlayerPedId())
end)

Citizen.CreateThread(function()
 	while true do
 		Citizen.Wait(1000)
 		if IsControlPressed(0, 303) then  --change key here
 			TriggerEvent("vrp_misc:Ragdoll", source)
 		end
 	end
end)

--[ WATHER ITEM DAMAGE | THREAD ]-------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		
		if IsEntityInWater(ped) then
			idle = 100
			if IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
				misc.damageItem()
			end
			if IsPedSwimming(ped) and IsPedSwimmingUnderWater(ped) then
				misc.damageItem()
			end
		end
		Citizen.Wait(idle)
	end
end)
