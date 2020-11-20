local items = {}

local nomes = {

	--[ Melee]-----------------------------------
	
	Dagger = "Adaga",
	Bat = "Taco de Beisebol",
	Bottle = "Garrafa",
	Crowbar = "Pé de Cabra",
	Flashlight = "Lanterna",
	Golfclub = "Taco de Golf",
	Hammer = "Martelo",
	Hatchet = "Machado",
	Knuckle = "Soco-Inglês",
	Knife = "Faca",
	Machete = "Machete",
	Switchblade = "Canivete",
	Nightstick = "Cacetete",
	Wrench = "Chave de Grifo",
	Battleaxe = "Machado de Batalha",
	Poolcue = "Taco de Sinuca",
	Stone_hatchet = "Machado de Pedra",
	
	--[ Handguns ]-------------------------------

	Pistol = "PT 92AF",
	Pistol_mk2 = "CZ P-09",
	Combatpistol = "Px4",
	Appistol = "XSE 1911",
	Stungun = "Taser",
	Pistol50 = "Desert Eagle",
	Snspistol = "Walther PPK",
	Snspistol_mk2 = "Walther PPK2",
	Heavypistol = "Wide 1911",
	Vintagepistol = "FN 1903",
	Flaregun = "Sinalizador",
	Marksmanpistol = "Musket Pistol",
	Revolver = "ASG CO2",
	Revolver_mk2 = "Raging Bull",
	Doubleaction = "Python",
	Raypistol = "Raypistol",
	Ceramicpistol = "Koch P7",
	Navyrevolver = "Colt 1851",
	
	--[ Submachine Guns ]------------------------

	Microsmg = "Micro Uzi",
	Smg = "MP5",
	Smg_mk2 = "MP5K",
	Assaultsmg = "P90",
	Combatpdw = "MPX-SD",
	Machinepistol = "TEC-DC9",
	Minismg = "VZ.82",
	Raycarbine = "Raycarbine",
	
	--[ Shotguns ]-------------------------------

	Pumpshotgun = "Mossberg 590",
	Pumpshotgun_mk2 = "Remington 870",
	Sawnoffshotgun = "Mossberg 500",
	Assaultshotgun = "UTS-15",
	bullpupshotgun = "Kel-Tec KSG",
	Musket = "Musket",
	Heavyshotgun = "Saiga 12",
	Dbshotgun = "Zabala",
	Autoshotgun = "Armsel Protecta",
	
	--[ Assault Rifles ]-------------------------

	Assaultrifle = "AK-74",
	Assaultrifle_mk2 = "AK-47",
	Carbinerifle = "AR-15",
	Carbinerifle_mk2 = "M4-A1",
	Advancedrifle = "Tavor CTAR-21",
	Specialcarbine = "G36C",
	Specialcarbine_mk2 = "G36K",
	Bullpuprifle = "Norinco 86S",
	Bullpuprifle_mk2 = "HS VHS-D2",
	Compactrifle = "Draco",
	
	--[ Light Machine Guns ]---------------------

	Mg = "PKM",
	Combatmg = "M60",
	Combatmg_mk2 = "M60E4",
	Gusenberg = "Thompson",
	
	--[ Sniper Rifles ]--------------------------

	Sniperrifle = "AW-F",
	Heavysniper = "Barrett M107",
	Heavysniper_mk2 = "Serbu BFG-50A",
	Maskmanrifle = "M39",
	Maskmanrifle_mk2 = "M1A",

	--[ Heavy Weapons ]--------------------------

	Rpg = "RPG",
	Grenadelauncher = "Lançador de Granadas",
	Grenadelauncher_smoke = "Lançador de Granadas de Fumaça",
	Minigun = "Minigun",
	Firework = "Firework",
	Railgun = "Railgun",
	Hominglauncher = "Lançador de Misseis",
	Compactlauncher = "Lançador de Granadas Compacto",
	Rayminigun = "Rayminigun",

	--[ Throwables ]-----------------------------

	Granade = "Granada",
	Bzgas = "Gás Lacrimogêneo",
	Molotov = "Coquetel Molotov",
	Stickybomb = "C4",
	Proxmine = "Mina de Proximidade",
	Snowball = "Bola de Neve",
	Pipebomb = "Bomba de Cano",
	Ball = "Bola de Baseball",
	Smokegrenade = "Granada de Gás",
	Flare = "Flare",
	
	--[ Miscellaneous ]--------------------------
	
	Petrolcan = "Galão de Gasolina",
	Gadget_parachute = "Paraquedas",
	Fireextinguisher = "Extintor"
}

local get_wname = function(weapon_id)
	local name = string.gsub(weapon_id,"WEAPON_","")
	name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
	return nomes[name]
end

local wammo_name = function(args)
	if args[2] == "WEAPON_PETROLCAN" then
		return "Combustível"
	else
		return "Munição de "..get_wname(args[2])
	end
end

local wbody_name = function(args)
	return get_wname(args[2])
end

items["wbody"] = { wbody_name,5 }
items["wammo"] = { wammo_name,0.02 }

return items