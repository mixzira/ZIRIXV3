local menu_state = {}

local apontar = false
local cancelando = false
local menu_celular = false
local apontando = false
local cooldown = 0
local object = nil

local anims = {
	{ dict = "random@mugging3","handsup_standing_base", anim = "handsup_standing_base" },
	{ dict = "random@arrests@busted", anim = "idle_a" },
	{ dict = "anim@heists@heist_corona@single_team", anim = "single_team_loop_boss" },
	{ dict = "mini@strip_club@idles@bouncer@base", anim = "base" },
	{ dict = "anim@mp_player_intupperfinger", anim = "idle_a_fp" },
	{ dict = "random@arrests", anim = "generic_radio_enter" },
	{ dict = "mp_player_int_upperpeace_sign", anim = "mp_player_int_peace_sign" }
}

--[ COOLDOWN ]---------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if cooldown > 0 then
			cooldown = cooldown - 1
		end
	end
end)

function tvRP.openMenuData(menudata)
	SendNUIMessage({ act = "open_menu", menudata = menudata })
end

function tvRP.closeMenu()
	SendNUIMessage({ act = "close_menu" })
end

function tvRP.getMenuState()
	return menu_state
end

function tvRP.getAgachar()
    return agachar
end	

function tvRP.getCancelando()
	return cancelando
end

RegisterNetEvent('cancelando')
AddEventHandler('cancelando',function(status)
    cancelando = status
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000

		if cancelando then
			idle = 5
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,29,true)
			DisableControlAction(0,38,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,56,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,137,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,169,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)			
		end

		if menu_celular then
			idle = 5
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,16,true)
			DisableControlAction(0,17,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,56,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,170,true)				
			DisableControlAction(0,182,true)	
			DisableControlAction(0,187,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,344,true)			
		end

		if menu_state.opened then
			idle = 5
			DisableControlAction(0,75)
		end

		for _,block in pairs(anims) do
			if IsEntityPlayingAnim(PlayerPedId(),block.dict,block.anim,3) or object then
				idle = 5
			    BlockWeaponWheelThisFrame()
				DisableControlAction(0,16,true)
				DisableControlAction(0,17,true)
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true)
				DisableControlAction(0,137,true)
				DisableControlAction(0,245,true)
				DisableControlAction(0,257,true)
			end
		end
		Citizen.Wait(idle)
	end
end)

function tvRP.prompt(title,default_text)
	SendNUIMessage({ act = "prompt", title = title, text = tostring(default_text) })
	SetNuiFocus(true)
end

function tvRP.request(id,text,time)
	SendNUIMessage({ act = "request", id = id, text = tostring(text), time = time })
end

RegisterNUICallback("menu",function(data,cb)
	if data.act == "close" then
		vRPserver._closeMenu(data.id)
	elseif data.act == "valid" then
		vRPserver._validMenuChoice(data.id,data.choice,data.mod)
	end
end)

RegisterNUICallback("menu_state",function(data,cb)
	menu_state = data
end)

RegisterNUICallback("prompt",function(data,cb)
	if data.act == "close" then
		SetNuiFocus(false)
		vRPserver._promptResult(data.result)
	end
end)

RegisterNUICallback("request",function(data,cb)
	if data.act == "response" then
		vRPserver._requestResult(data.id,data.ok)
	end
end)

RegisterNUICallback("init",function(data,cb)
	SendNUIMessage({ act = "cfg", cfg = {} })
	TriggerEvent("vRP:NUIready")
end)

function tvRP.setDiv(name,css,content)
	SendNUIMessage({ act = "set_div", name = name, css = css, content = content })
end

function tvRP.setDivContent(name,content)
	SendNUIMessage({ act = "set_div_content", name = name, content = content })
end

function tvRP.removeDiv(name)
	SendNUIMessage({ act = "remove_div", name = name })
end

function tvRP.loadAnimSet(dict)
	RequestAnimSet(dict)
	while not HasAnimSetLoaded(dict) do
		Citizen.Wait(10)
	end
	SetPedMovementClipset(PlayerPedId(),dict,0.25)
end

function tvRP.CarregarAnim(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end

function tvRP.CarregarObjeto(dict,anim,prop,flag,hand,pos1,pos2,pos3,pos4,pos5,pos6)
	local ped = PlayerPedId()

	RequestModel(GetHashKey(prop))
	while not HasModelLoaded(GetHashKey(prop)) do
		Citizen.Wait(10)
	end

	if pos1 then
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object,false,false)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),pos1,pos2,pos3,pos4,pos5,pos6,true,true,false,true,1,true)
	else
		tvRP.CarregarAnim(dict)
		TaskPlayAnim(ped,dict,anim,3-.0,3.0,-1,flag,0,0,0,0)
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object,false,false)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
	end
	Citizen.InvokeNative(0xAD738C3085FE7E11,object,true,true)
end

function tvRP.DeletarObjeto()
    tvRP.stopAnim(true)
    TriggerEvent("binoculos")
    if DoesEntityExist(object) then
        TriggerServerEvent("trydeleteobj",ObjToNet(object))
        object = nil
    end
end

RegisterNetEvent("status:celular")
AddEventHandler("status:celular",function(status)
	menu_celular = status
end)

--[  ]-----------------------------------------------------------------------------

RegisterKeyMapping ( 'vrp:accept' , 'Aceitar' , 'keyboard' , binds.accept )

RegisterCommand('vrp:accept', function()
    SendNUIMessage({ act = "event", event = "Y" })
end, false)

RegisterKeyMapping ( 'vrp:decline' , 'Negar' , 'keyboard' , binds.decline )

RegisterCommand('vrp:decline', function()
    SendNUIMessage({ act = "event", event = "U" })
end, false)

--[  ]-----------------------------------------------------------------------------

RegisterKeyMapping ( 'vrp:up' , 'Cima | [A] Beleza' , 'keyboard' , binds.up )

RegisterCommand('vrp:up', function()
	if menu_state.opened then
		SendNUIMessage({ act = "event", event = "UP" }) 
		tvRP.playSound("NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET") 
	else
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menu_state.opened and not menu_celular and not cancelando and not IsPauseMenuActive() then
			tvRP.playAnim(true,{{"anim@mp_player_intincarthumbs_upbodhi@ps@","enter"}},false)
		end
	end
end, false)

RegisterKeyMapping ( 'vrp:down' , 'Baixo | [A] Saudação' , 'keyboard' , binds.down )

RegisterCommand('vrp:down', function()
	if menu_state.opened then
		SendNUIMessage({ act = "event", event = "DOWN" })
		tvRP.playSound("NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET")
	else
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menu_state.opened and not menu_celular and not cancelando and not IsPauseMenuActive() then
			tvRP.playAnim(true,{{"anim@mp_player_intcelebrationmale@salute","salute"}},false)
		end
	end
end, false)

RegisterKeyMapping ( 'vrp:left' , 'Esquerda | [A] Assobiar' , 'keyboard' , binds.left )

RegisterCommand('vrp:left', function()
	if menu_state.opened then
		SendNUIMessage({ act = "event", event = "LEFT" })
		tvRP.playSound("NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET")
	else
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menu_state.opened and not menu_celular and not cancelando and not IsPauseMenuActive() then
			tvRP.playAnim(true,{{"rcmnigel1c","hailing_whistle_waive_a"}},false)
		end
	end
end, false)

RegisterKeyMapping ( 'vrp:right' , 'Direita | [A] Vergonha!' , 'keyboard' , binds.right )

RegisterCommand('vrp:right', function()
	if menu_state.opened then
		SendNUIMessage({ act = "event", event = "RIGHT" }) 
		tvRP.playSound("NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET")
	else
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menu_state.opened and not menu_celular and not cancelando and not IsPauseMenuActive() then
			tvRP.playAnim(true,{{"anim@mp_player_intcelebrationmale@face_palm","face_palm"}},false)
		end
	end
end, false)

RegisterKeyMapping ( 'vrp:select' , 'Selecionar' , 'keyboard' , binds.select )

RegisterCommand('vrp:select', function()
	if menu_state.opened then
		SendNUIMessage({ act = "event", event = "SELECT" })
		tvRP.playSound("SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET") 
	end
end, false)

RegisterKeyMapping ( 'vrp:cancel' , 'Cancelar' , 'keyboard' , binds.cancel )

RegisterCommand('vrp:cancel', function()
	SendNUIMessage({ act = "event", event = "CANCEL" })
end, false)

--[  ]-----------------------------------------------------------------------------

RegisterKeyMapping ( 'vrp:anim01' , '[A] Cruzar os braços' , 'keyboard' , 'F1' )

RegisterCommand('vrp:anim01', function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menu_state.opened and not menu_celular and not cancelando and not IsPauseMenuActive() then
		if IsEntityPlayingAnim(ped,"anim@heists@heist_corona@single_team","single_team_loop_boss",3) then
			tvRP.DeletarObjeto()
		else
			tvRP.playAnim(true,{{"anim@heists@heist_corona@single_team","single_team_loop_boss"}},true)
		end
	end
end, false)

RegisterKeyMapping ( 'vrp:anim02' , '[A] Aguardar' , 'keyboard' , 'F2' )

RegisterCommand('vrp:anim02', function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menu_state.opened and not menu_celular and not cancelando and not IsPauseMenuActive() then
		if IsEntityPlayingAnim(ped,"mini@strip_club@idles@bouncer@base","base",3) then
			tvRP.DeletarObjeto()
		else
			tvRP.playAnim(true,{{"mini@strip_club@idles@bouncer@base","base"}},true)
		end
	end
end, false)

RegisterKeyMapping ( 'vrp:anim03' , '[A] Dedo do meio' , 'keyboard' , 'F3' )

RegisterCommand('vrp:anim03', function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menu_state.opened and not menu_celular and not cancelando and not IsPauseMenuActive() then
		if IsEntityPlayingAnim(ped,"anim@mp_player_intupperfinger","idle_a_fp",3) then
			tvRP.DeletarObjeto()
		else
			tvRP.playAnim(true,{{"anim@mp_player_intupperfinger","idle_a_fp"}},true)
		end
	end
end, false)

RegisterKeyMapping ( 'vrp:anim05' , '[A] Puto' , 'keyboard' , 'F5' )

RegisterCommand('vrp:anim05', function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menu_state.opened and not menu_celular and not cancelando and not IsPauseMenuActive() then
		tvRP.playAnim(true,{{"misscarsteal4@actor","actor_berating_loop"}},false)
	end
end, false)

RegisterKeyMapping ( 'vrp:cancelAnims' , 'Cancelar animações' , 'keyboard' , 'F6' )

RegisterCommand('vrp:cancelAnims', function()
	local ped = PlayerPedId()
	if cooldown < 1 then
		cooldown = 20
		if GetEntityHealth(ped) > 101 then
			if not menu_state.opened and not cancelando then
				tvRP.DeletarObjeto()
				ClearPedTasks(ped)
			end
		end
	end
end, false)

RegisterKeyMapping ( 'vrp:anim10' , '[A] Mãos na cabeça' , 'keyboard' , 'F10' )

RegisterCommand('vrp:anim10', function()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and not menu_state.opened and not menu_celular and not cancelando and not IsPauseMenuActive() then
		if IsEntityPlayingAnim(ped,"random@arrests@busted","idle_a",3) then
			tvRP.DeletarObjeto()
		else
			tvRP.DeletarObjeto()
			tvRP.playAnim(true,{{"random@arrests@busted","idle_a"}},true)
		end
	end
end, false)

RegisterKeyMapping ( 'vrp:animX' , '[A] Levantar as mãos' , 'keyboard' , 'X' )

RegisterCommand('vrp:animX', function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and not menu_celular and not cancelando and not IsPauseMenuActive() then
		SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
		if IsEntityPlayingAnim(ped,"random@mugging3","handsup_standing_base",3) then
			tvRP.DeletarObjeto()
		else
			tvRP.playAnim(true,{{"random@mugging3","handsup_standing_base"}},true)
		end
	end
end, false)

RegisterKeyMapping ( 'vrp:vehicleZ' , '[V] Ligar motor' , 'keyboard' , 'Z' )

RegisterCommand('vrp:vehicleZ', function()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsIn(ped,false)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			tvRP.DeletarObjeto()
			local running = Citizen.InvokeNative(0xAE31E7DF9B5B132E,vehicle)
			SetVehicleEngineOn(vehicle,not running,true,true)
			if running then
				SetVehicleUndriveable(vehicle,true)
			else
				SetVehicleUndriveable(vehicle,false)
			end
		end
	end
end, false)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local ped = PlayerPedId()

		if IsControlJustPressed(0,29) then
			if GetEntityHealth(ped) > 101 and not menu_celular and not cancelando then
				tvRP.CarregarAnim("anim@mp_point")
				if not apontar then
					SetPedCurrentWeaponVisible(ped,0,1,1,1)
					SetPedConfigFlag(ped,36,1)
					Citizen.InvokeNative(0x2D537BA194896636,ped,"task_mp_pointing",0.5,0,"anim@mp_point",24)
                	apontar = true
            	else
            		Citizen.InvokeNative(0xD01015C7316AE176,ped,"Stop")
					if not IsPedInjured(ped) then
						ClearPedSecondaryTask(ped)
					end
					if not IsPedInAnyVehicle(ped) then
						SetPedCurrentWeaponVisible(ped,1,1,1,1)
					end
					SetPedConfigFlag(ped,36,0)
					ClearPedSecondaryTask(ped)
                	apontar = false
            	end
        	end
		end
		
	end
end)


Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()

		if apontar then
			idle = 10
			local camPitch = GetGameplayCamRelativePitch()
			if camPitch < -70.0 then
				camPitch = -70.0
			elseif camPitch > 42.0 then
				camPitch = 42.0
			end
			camPitch = (camPitch + 70.0) / 112.0

			local camHeading = GetGameplayCamRelativeHeading()
			local cosCamHeading = Cos(camHeading)
			local sinCamHeading = Sin(camHeading)
			if camHeading < -180.0 then
				camHeading = -180.0
			elseif camHeading > 180.0 then
				camHeading = 180.0
			end
			camHeading = (camHeading + 180.0) / 360.0

			local blocked = 0
			local nn = 0
			local coords = GetOffsetFromEntityInWorldCoords(ped,(cosCamHeading*-0.2)-(sinCamHeading*(0.4*camHeading+0.3)),(sinCamHeading*-0.2)+(cosCamHeading*(0.4*camHeading+0.3)),0.6)
			local ray = Cast_3dRayPointToPoint(coords.x,coords.y,coords.z-0.2,coords.x,coords.y,coords.z+0.2,0.4,95,ped,7);
			nn,blocked,coords,coords = GetRaycastResult(ray)

			Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,"Pitch",camPitch)
			Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,"Heading",camHeading*-1.0+1.0)
			Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,"isBlocked",blocked)
			Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,"isFirstPerson",Citizen.InvokeNative(0xEE778F8C7E1142E2,Citizen.InvokeNative(0x19CAFA3C87F7C2FF))==4)
		end
		Citizen.Wait(idle)
	end
end)

--[ SYNCCLEAN ]--------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("syncclean")
AddEventHandler("syncclean",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				tvRP.DeletarObjeto()
			end
		end
	end
end)

--[ SYNCDELETEPED ]----------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("syncdeleteped")
AddEventHandler("syncdeleteped",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToPed(index)
		if DoesEntityExist(v) then
			Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
			SetPedAsNoLongerNeeded(Citizen.PointerValueIntInitialized(v))
			DeletePed(v)
		end
	end
end)