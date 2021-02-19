local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRPex = Tunnel.getInterface("police_arsenal")

local menuactive = false
local system = {{ ['x'] = 452.15, ['y'] = -980.11, ['z'] = 30.69},}

RegisterNUICallback("ButtonClick",function(data,cb)
	local ped = PlayerPedId()
	if data == "mk1" then
		if vRPex.checkPermission(config.assault) then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE"))
			GiveWeaponToPed(ped,GetHashKey("weapon_carbinerifle_mk2"),150,0,0)
			vRP.tryFullPayment(source,100)
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para pegar qualquer equipamento do arsenal",9000)
		end
		
	elseif data == "mk2" then
		if vRPex.checkPermission(config.assault) then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),150,0,0)
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para pegar qualquer equipamento do arsenal.",9000)
		end

	elseif data == "smg" then
		if vRPex.checkPermission(config.smg) then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPDW"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_SMG"),130,0,0)
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para pegar qualquer equipamento do arsenal.",9000)
		end

	elseif data == "pdw" then
		if vRPex.checkPermission(config.smg) then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_SMG"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPDW"),130,0,0)
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para pegar qualquer equipamento do arsenal.",9000)
		end

	elseif data == "shotmk2" then
		if vRPex.checkPermission(config.shotgun) then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),10,0,0)
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para pegar qualquer equipamento do arsenal.",9000)
		end

	elseif data == "shotmk1" then
		if vRPex.checkPermission(config.shotgun) then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),10,0,0)
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para pegar qualquer equipamento do arsenal.",9000)
		end

	elseif data == "pistmk2" then
		if vRPex.checkPermission(config.pistols) then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPISTOL"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),75,0,0)
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para pegar qualquer equipamento do arsenal.",9000)
		end

	elseif data == "pistmk1" then
		if vRPex.checkPermission(config.pistols) then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PISTOL_MK2"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),75,0,0)
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para pegar qualquer equipamento do arsenal.",9000)
		end
		
	elseif data == "take-kit" then
		if vRPex.checkPermission(config.basicKit) then
			GiveWeaponToPed(ped,GetHashKey("WEAPON_NIGHTSTICK"),0,0,0)
			GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,0)
			GiveWeaponToPed(ped,GetHashKey("WEAPON_FLASHLIGHT"),0,0,0)
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para pegar qualquer equipamento do arsenal.",9000)
		end
		
	elseif data == "rem-kit" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_NIGHTSTICK"))
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_STUNGUN"))
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_FLASHLIGHT"))
		TriggerEvent("Notify","sucesso","Você guardou seu kit básico.")
		
	elseif data == "clear" then
		RemoveAllPedWeapons(ped,0)
		TriggerEvent("Notify","sucesso","Você guardou todos os equipamentos no arsenal.")

	elseif data == "on-duty" then
		TriggerServerEvent('bdl:onduty')

	elseif data == "off-duty" then
		TriggerServerEvent('bdl:offduty')
		
	elseif data == "onarmor" then
		if vRPex.checkPermission(config.vest) then
			TriggerServerEvent('flix:onarmor')
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para pegar qualquer equipamento do arsenal.",9000)
		end
		
	elseif data == "offarmor" then
		TriggerServerEvent('flix:offarmor')
	
	elseif data == "close" then
		ToggleActionMenu()
	
	end
end)

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000
		for k,v in pairs(system) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local system = system[k]
			if distance <= 5 then
				idle = 5
				DrawMarker(23, system.x, system.y, system.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5, 66, 236, 134, 150,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and vRPex.checkOfficer() then
						if vRPex.checkAuth() then
							ToggleActionMenu()
						else
							TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)





