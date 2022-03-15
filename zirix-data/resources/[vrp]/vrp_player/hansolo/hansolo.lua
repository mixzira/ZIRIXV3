local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = Tunnel.getInterface("vrp_player",src)

RegisterCommand("vtuning",function(source,args)
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(vehicle) then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify","importante","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Chassi:</b> "..parseInt(body/10).."%<br><b>Engine:</b> "..parseInt(engine/10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%",15000)
	end
end)

RegisterCommand("homem",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@confident")
	end
end)

RegisterCommand("mulher",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@heels@c")
	end
end)

RegisterCommand("depressivo",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@depressed@a")
	end
end)

RegisterCommand("depressiva",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@depressed@a")
	end
end)

RegisterCommand("empresario",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@business@a")
	end
end)

RegisterCommand("determinado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@brave@a")
	end	
end)

RegisterCommand("descontraido",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@casual@a")
	end
end)

RegisterCommand("farto",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@fat@a")
	end
end)

RegisterCommand("estiloso",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@hipster@a")
	end
end)

RegisterCommand("ferido",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@injured")
	end
end)

RegisterCommand("nervoso",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@hurry@a")
	end
end)

RegisterCommand("desleixado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@hobo@a")
	end
end)

RegisterCommand("infeliz",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@sad@a")
	end
end)

RegisterCommand("musculoso",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@muscle@a")
	end
end)

RegisterCommand("desligado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@shadyped@a")
	end
end)

RegisterCommand("fadiga",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@buzzed")
	end
end)

RegisterCommand("apressado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@hurry_butch@a")
	end
end)

RegisterCommand("descolado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@money")
	end
end)

RegisterCommand("corridinha",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@quick")
	end
end)

RegisterCommand("piriguete",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@maneater")
	end
end)

RegisterCommand("petulante",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@sassy")
	end
end)

RegisterCommand("arrogante",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@arrogant@a")
	end
end)

RegisterCommand("bebado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@drunk@slightlydrunk")
	end
end)

RegisterCommand("bebado2",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@drunk@verydrunk")
	end
end)

RegisterCommand("bebado3",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@drunk@moderatedrunk")
	end
end)

RegisterCommand("irritado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@fire")
	end
end)

RegisterCommand("intimidado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@intimidation@cop@unarmed")
	end
end)

RegisterCommand("poderosa",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@handbag")
	end
end)

RegisterCommand("chateado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@injured")
	end
end)

RegisterCommand("estilosa",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@posh@")
	end
end)

RegisterCommand("sensual",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@sexy@a")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(config.TimeSalary*60000)
		TriggerServerEvent('salario:pagamento')
	end
end)

function GetPlayers()
  local players = {}
  for i = 0, 256 do
      if NetworkIsPlayerActive(i) then
          players[#players + 1] = i
      end
  end
  return players
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
			local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
			if GetVehicleDoorLockStatus(veh) >= 2 or GetPedInVehicleSeat(veh,-1) then
				TriggerServerEvent("TryDoorsEveryone",veh,2,GetVehicleNumberPlateText(veh))
			end
		end
	end
end)

RegisterNetEvent("SyncDoorsEveryone")
AddEventHandler("SyncDoorsEveryone",function(veh,doors)
	SetVehicleDoorsLocked(veh,doors)
end)

RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()

	if args[1] == "s" then
		if src.checkPassGold() then
			if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_PISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then -- 
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_PISTOL_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_APPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_APPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL50") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_PISTOL50_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNSPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL"),GetHashKey("COMPONENT_SNSPISTOL_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNSPISTOL_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_SNSPISTOL_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_03"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_VINTAGEPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_VINTAGEPISTOL"),GetHashKey("COMPONENT_VINTAGEPISTOL_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CERAMICPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CERAMICPISTOL"),GetHashKey("COMPONENT_CERAMICPISTOL_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_MICROSMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_SMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_SMG_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_ASSAULTSMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_COMBATPDW_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHINEPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MACHINEPISTOL"),GetHashKey("COMPONENT_MACHINEPISTOL_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MINISMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MINISMG"),GetHashKey("COMPONENT_MINISMG_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_ASSAULTSHOTGUN_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_ASSAULTRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_CARBINERIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_CARBINERIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ADVANCEDRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_ADVANCEDRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_SPECIALCARBINE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_BULLPUPRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMPACTRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMPACTRIFLE"),GetHashKey("COMPONENT_COMPACTRIFLE_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MG"),GetHashKey("COMPONENT_MG_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG"),GetHashKey("COMPONENT_COMBATMG_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATMG_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG_MK2"),GetHashKey("COMPONENT_COMBATMG_MK2_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_GUSENBERG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_GUSENBERG"),GetHashKey("COMPONENT_GUSENBERG_CLIP_02"))

			end
		end
	elseif args[1] == "p" then
		if src.checkPassPlatinum() then
			if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_PISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_PISTOL_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_APPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_APPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL50") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_PISTOL50_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNSPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL"),GetHashKey("COMPONENT_SNSPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL"),GetHashKey("COMPONENT_SNSPISTOL_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNSPISTOL_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_SNSPISTOL_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_03"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_SNSPISTOL_MK2_CAMO_02_SLIDE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYPISTOL"),GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_VINTAGEPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_VINTAGEPISTOL"),GetHashKey("COMPONENT_VINTAGEPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_VINTAGEPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CERAMICPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CERAMICPISTOL"),GetHashKey("COMPONENT_CERAMICPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CERAMICPISTOL"),GetHashKey("COMPONENT_CERAMICPISTOL_SUPP"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_MICROSMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_SMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_PI_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_SMG_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_SMG_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_SMG_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_05"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_ASSAULTSMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_COMBATPDW_CLIP_03"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHINEPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MACHINEPISTOL"),GetHashKey("COMPONENT_MACHINEPISTOL_CLIP_03"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MACHINEPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MINISMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MINISMG"),GetHashKey("COMPONENT_MINISMG_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),GetHashKey("COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER"))
				
			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_PUMPSHOTGUN_MK2_CAMO_10"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_ASSAULTSHOTGUN_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_ASSAULTRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_CARBINERIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_CARBINERIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ADVANCEDRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_ADVANCEDRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_SPECIALCARBINE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_BULLPUPRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_BULLPUPRIFLE_VARMOD_LOW"))
			
			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMPACTRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMPACTRIFLE"),GetHashKey("COMPONENT_COMPACTRIFLE_CLIP_03"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MG"),GetHashKey("COMPONENT_MG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MG"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MG"),GetHashKey("COMPONENT_MG_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG"),GetHashKey("COMPONENT_COMBATMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG"),GetHashKey("COMPONENT_COMBATMG_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATMG_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG_MK2"),GetHashKey("COMPONENT_COMBATMG_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG_MK2"),GetHashKey("COMPONENT_COMBATMG_MK2_CAMO_10"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_GUSENBERG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_GUSENBERG"),GetHashKey("COMPONENT_GUSENBERG_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_REVOLVER") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER"),GetHashKey("COMPONENT_REVOLVER_VARMOD_BOSS"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_REVOLVER_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_REVOLVER_MK2_CAMO_IND_01"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNIPERRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNIPERRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MAX"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNIPERRIFLE"),GetHashKey("COMPONENT_SNIPERRIFLE_VARMOD_LUXE"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNIPERRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYSNIPER") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYSNIPER"),GetHashKey("COMPONENT_AT_SCOPE_MAX"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYSNIPER_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYSNIPER_MK2"),GetHashKey("COMPONENT_HEAVYSNIPER_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYSNIPER_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MAX"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYSNIPER_MK2"),GetHashKey("COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MASKMANRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE"),GetHashKey("COMPONENT_MARKSMANRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE"),GetHashKey("COMPONENT_MARKSMANRIFLE_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MASKMANRIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_MARKSMANRIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_MARKSMANRIFLE_MK2_CAMO_09"))

			end
		end
	end
end)

local energetico = false
RegisterNetEvent('energeticos')
AddEventHandler('energeticos',function(status)
	energetico = status
	if energetico then
		SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
	else
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if energetico then
			idle = 5
			RestorePlayerStamina(PlayerId(),1.0)
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        if x == px and y == py then
            if tempo > 0 then
                tempo = tempo - 1
                if tempo == 60 then
                    TriggerEvent("Notify","importante","Você vai ser desconectado em <b>60 segundos</b>.",8000)
                end
            else
                TriggerServerEvent("kickAFK")
            end
        else
            tempo = 1800
        end
        px = x
        py = y
    end
end)

RegisterCommand("capo",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)

local vidros = false
RegisterCommand("vidros",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywins",VehToNet(vehicle))
	end
end)

RegisterNetEvent("syncwins")
AddEventHandler("syncwins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if vidros then
					vidros = false
					RollUpWindow(v,0)
					RollUpWindow(v,1)
					RollUpWindow(v,2)
					RollUpWindow(v,3)
				else
					vidros = true
					RollDownWindow(v,0)
					RollDownWindow(v,1)
					RollDownWindow(v,2)
					RollDownWindow(v,3)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        DisableControlAction(0,36,true)
        if not IsPedInAnyVehicle(ped) then
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0,36) then
                if agachar then
                    ResetPedStrafeClipset(ped)
                    ResetPedMovementClipset(ped,0.25)
                    agachar = false
                else
                    SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                    SetPedMovementClipset(ped,"move_ped_crouched",0.25)
                    agachar = true
                end
            end
        end
    end
end)

RegisterCommand("portas",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		if parseInt(args[1]) == 5 then
			TriggerServerEvent("trytrunk",VehToNet(vehicle))
		else
			TriggerServerEvent("trydoors",VehToNet(vehicle),args[1])
		end
	end
end)

RegisterNetEvent("syncdoors")
AddEventHandler("syncdoors",function(index,door)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,0) and GetVehicleDoorAngleRatio(v,1)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if door == "1" then
					if GetVehicleDoorAngleRatio(v,0) == 0 then
						SetVehicleDoorOpen(v,0,0,0)
					else
						SetVehicleDoorShut(v,0,0)
					end
				elseif door == "2" then
					if GetVehicleDoorAngleRatio(v,1) == 0 then
						SetVehicleDoorOpen(v,1,0,0)
					else
						SetVehicleDoorShut(v,1,0)
					end
				elseif door == "3" then
					if GetVehicleDoorAngleRatio(v,2) == 0 then
						SetVehicleDoorOpen(v,2,0,0)
					else
						SetVehicleDoorShut(v,2,0)
					end
				elseif door == "4" then
					if GetVehicleDoorAngleRatio(v,3) == 0 then
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,3,0)
					end
				elseif door == nil then
					if isopen == 0 then
						SetVehicleDoorOpen(v,0,0,0)
						SetVehicleDoorOpen(v,1,0,0)
						SetVehicleDoorOpen(v,2,0,0)
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,0,0)
						SetVehicleDoorShut(v,1,0)
						SetVehicleDoorShut(v,2,0)
						SetVehicleDoorShut(v,3,0)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)

RegisterNetEvent('setchapeu')
AddEventHandler('setchapeu',function(modelo,cor)
	local ped = PlayerPedId()

	if not modelo then
		if GetEntityHealth(ped) > 101 then
			vRP._playAnim(true,{{"mini@ears_defenders","takeoff_earsdefenders_idle"}},false)
			Wait(500)
			ClearPedTasks(ped)
			ClearPedProp(ped,0)
			return
		end
	end

	if GetEntityHealth(ped) > 101 and src.checkChapeu() then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		end
	end
end)

RegisterNetEvent('setmascara')
AddEventHandler('setmascara',function(modelo,cor)
	local ped = PlayerPedId()

	if modelo == nil then
		if GetEntityHealth(ped) > 101 then
			vRP._playAnim(true,{{"missfbi4","takeoff_mask"}},false)
			Wait(1100)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,0,0,2)
			return
		end
	end

	if GetEntityHealth(ped) > 101 and src.checkMascara() then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Wait(1500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,parseInt(modelo),parseInt(cor),2)
		end
	end
end)

RegisterNetEvent('setoculos')
AddEventHandler('setoculos',function(modelo,cor)
	local ped = PlayerPedId()

	if not modelo then
		if GetEntityHealth(ped) > 101 then
			vRP._playAnim(true,{{"mini@ears_defenders","takeoff_earsdefenders_idle"}},false)
			Wait(500)
			ClearPedTasks(ped)
			ClearPedProp(ped,1)
			return
		end
	end

	if GetEntityHealth(ped) > 101 and src.checkOculos() then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		end
	end
end)

RegisterNetEvent('setcolete')
AddEventHandler('setcolete',function()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		vRP._playAnim(true,{{"missfbi4","takeoff_mask"}},false)
		Wait(1100)
		ClearPedTasks(ped)
		SetPedComponentVariation(ped,1,0,0,2)
		return
	end
end)

local reboque = nil
local rebocado = nil
RegisterCommand("tow",function(source,args)
    local vehicle = GetPlayersLastVehicle()
    local vehicletow = IsVehicleModel(vehicle,GetHashKey("flatbed"))

    if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
        rebocado = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
        if IsEntityAVehicle(vehicle) and IsEntityAVehicle(rebocado) then
            TriggerServerEvent("trytow",VehToNet(vehicle),VehToNet(rebocado))
        end
    end
end)

RegisterNetEvent('synctow')
AddEventHandler('synctow',function(vehid,rebid)
    if NetworkDoesNetworkIdExist(vehid) and NetworkDoesNetworkIdExist(rebid) then
        local vehicle = NetToVeh(vehid)
        local rebocado = NetToVeh(rebid)
        if DoesEntityExist(vehicle) and DoesEntityExist(rebocado) then
            if reboque == nil then
                if vehicle ~= rebocado then
                    local min,max = GetModelDimensions(GetEntityModel(rebocado))
                    AttachEntityToEntity(rebocado,vehicle,GetEntityBoneIndexByName(vehicle,"bodyshell"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
                    reboque = rebocado
                end
            else
                AttachEntityToEntity(reboque,vehicle,20,-0.5,-15.0,-0.3,0.0,0.0,0.0,false,false,true,false,20,true)
                DetachEntity(reboque,false,false)
                PlaceObjectOnGroundProperly(reboque)
                reboque = nil
                rebocado = nil
            end
        end
    end
end)

function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end

RegisterNetEvent('reparar')
AddEventHandler('reparar',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryreparar",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncreparar')
AddEventHandler('syncreparar',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local fuel = GetVehicleFuelLevel(v)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleFixed(v)
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
				SetVehicleOnGroundProperly(v)
				SetVehicleFuelLevel(v,fuel)
			end
		end
	end
end)

RegisterNetEvent('repararmotor')
AddEventHandler('repararmotor',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trymotor",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncmotor')
AddEventHandler('syncmotor',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleEngineHealth(v,1000.0)
			end
		end
	end
end)

local carregado = false
RegisterCommand("carregar",function(source,args)
	local ped = PlayerPedId()
	local randomico,npcs = FindFirstPed()
	repeat
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npcs),true)
		if not IsPedAPlayer(npcs) and distancia <= 3 and not IsPedInAnyVehicle(ped) and not IsPedInAnyVehicle(npcs) then
			if carregado then
				ClearPedTasksImmediately(carregado)
				DetachEntity(carregado,true,true)
				TaskWanderStandard(carregado,10.0,10)
				Citizen.InvokeNative(0xAD738C3085FE7E11,carregado,true,true)
				carregado = false
			else
				Citizen.InvokeNative(0xAD738C3085FE7E11,npcs,true,true)
				AttachEntityToEntity(npcs,ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,true,false,2,true)
				carregado = npcs
				sucess = true
			end
		end
	sucess,npcs = FindNextPed(randomico)
	until not sucess
	EndFindPed(randomico)
end)

local sequestrado = nil
RegisterCommand("sequestro2",function(source,args)
	local ped = PlayerPedId()
	local random,npc = FindFirstPed()
	repeat
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npc),true)
		if not IsPedAPlayer(npc) and distancia <= 3 and not IsPedInAnyVehicle(npc) then
			vehicle = vRP.getNearestVehicle(7)
			if IsEntityAVehicle(vehicle) then
				if vRP.getCarroClass(vehicle) then
					if sequestrado then
						AttachEntityToEntity(sequestrado,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-1.2,-0.6,60.0,-90.0,180.0,false,false,false,true,2,true)
						DetachEntity(sequestrado,true,true)
						SetEntityVisible(sequestrado,true)
						SetEntityInvincible(sequestrado,false)
						Citizen.InvokeNative(0xAD738C3085FE7E11,sequestrado,true,true)
						ClearPedTasksImmediately(sequestrado)
						sequestrado = nil
					elseif not sequestrado then
						Citizen.InvokeNative(0xAD738C3085FE7E11,npc,true,true)
						AttachEntityToEntity(npc,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-0.4,-0.1,60.0,-90.0,180.0,false,false,false,true,2,true)
						SetEntityVisible(npc,false)
						SetEntityInvincible(npc,true)
						sequestrado = npc
						complet = true
					end
					TriggerServerEvent("trymala",VehToNet(vehicle))
				end
			end
		end
		complet,npc = FindNextPed(random)
	until not complet
	EndFindPed(random)
end)

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc,moveFunc,disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle,FindNextVehicle,EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles,vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i=1,#vehicles,1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords,coords.x,coords.y,coords.z,true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle,closestDistance
end

local First = vector3(0.0,0.0,0.0)
local Second = vector3(5.0,5.0,5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local closestVehicle,Distance = GetClosestVeh()
		if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
			Vehicle.Coords = GetEntityCoords(closestVehicle)
			Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle),First,Second)
			Vehicle.Vehicle = closestVehicle
			Vehicle.Distance = Distance
			if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
				Vehicle.IsInFront = false
			else
				Vehicle.IsInFront = true
			end
		else
			Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
		end
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(500)
		if Vehicle.Vehicle ~= nil then
			local ped = PlayerPedId()
			if IsControlPressed(0,244) and GetEntityHealth(ped) > 100 and IsVehicleSeatFree(Vehicle.Vehicle,-1) and not IsEntityInAir(ped) and not IsPedBeingStunned(ped) and not IsEntityAttachedToEntity(ped,Vehicle.Vehicle) and not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
				RequestAnimDict('missfinale_c2ig_11')
				TaskPlayAnim(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0,-8.0,-1,35,0,0,0,0)
				NetworkRequestControlOfEntity(Vehicle.Vehicle)

				if Vehicle.IsInFront then
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y*-1+0.1,Vehicle.Dimensions.z+1.0,0.0,0.0,180.0,0.0,false,false,true,false,true)
				else
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y-0.3,Vehicle.Dimensions.z+1.0,0.0,0.0,0.0,0.0,false,false,true,false,true)
				end

				while true do
					Citizen.Wait(5)
					if IsDisabledControlPressed(0,34) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,11,100)
					end

					if IsDisabledControlPressed(0,9) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,10,100)
					end

					if Vehicle.IsInFront then
						SetVehicleForwardSpeed(Vehicle.Vehicle,-1.0)
					else
						SetVehicleForwardSpeed(Vehicle.Vehicle,1.0)
					end

					if not IsDisabledControlPressed(0,244) then
						DetachEntity(ped,false,false)
						StopAnimTask(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0)
						break
					end
				end
			end
		end
	end
end)

RegisterNetEvent("updateRoupas")
AddEventHandler("updateRoupas",function(custom)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if custom[1] == -1 then
			SetPedComponentVariation(ped,1,0,0,2)
		else
			SetPedComponentVariation(ped,1,custom[1],custom[2],2)
		end

		if custom[3] == -1 then
			SetPedComponentVariation(ped,5,0,0,2)
		else
			SetPedComponentVariation(ped,5,custom[3],custom[4],2)
		end

		if custom[5] == -1 then
			SetPedComponentVariation(ped,7,0,0,2)
		else
			SetPedComponentVariation(ped,7,custom[5],custom[6],2)
		end

		if custom[7] == -1 then
			SetPedComponentVariation(ped,3,15,0,2)
		else
			SetPedComponentVariation(ped,3,custom[7],custom[8],2)
		end

		if custom[9] == -1 then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,4,15,0,2)
			end
		else
			SetPedComponentVariation(ped,4,custom[9],custom[10],2)
		end

		if custom[11] == -1 then
			SetPedComponentVariation(ped,8,15,0,2)
		else
			SetPedComponentVariation(ped,8,custom[11],custom[12],2)
		end

		if custom[13] == -1 then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,6,34,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,6,35,0,2)
			end
		else
			SetPedComponentVariation(ped,6,custom[13],custom[14],2)
		end

		if custom[15] == -1 then
			SetPedComponentVariation(ped,11,15,0,2)
		else
			SetPedComponentVariation(ped,11,custom[15],custom[16],2)
		end

		if custom[17] == -1 then
			SetPedComponentVariation(ped,9,0,0,2)
		else
			SetPedComponentVariation(ped,9,custom[17],custom[18],2)
		end

		if custom[19] == -1 then
			SetPedComponentVariation(ped,10,0,0,2)
		else
			SetPedComponentVariation(ped,10,custom[19],custom[20],2)
		end

		if custom[21] == -1 then
			ClearPedProp(ped,0)
		else
			SetPedPropIndex(ped,0,custom[21],custom[22],2)
		end

		if custom[23] == -1 then
			ClearPedProp(ped,1)
		else
			SetPedPropIndex(ped,1,custom[23],custom[24],2)
		end

		if custom[25] == -1 then
			ClearPedProp(ped,2)
		else
			SetPedPropIndex(ped,2,custom[25],custom[26],2)
		end

		if custom[27] == -1 then
			ClearPedProp(ped,6)
		else
			SetPedPropIndex(ped,6,custom[27],custom[28],2)
		end

		if custom[29] == -1 then
			ClearPedProp(ped,7)
		else
			SetPedPropIndex(ped,7,custom[29],custom[30],2)
		end
	end
end)

function DrawText3D(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end