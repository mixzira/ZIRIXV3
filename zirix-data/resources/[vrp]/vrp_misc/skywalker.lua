local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]------------------------------------------------------------------------------------

misc = {}
Tunnel.bindInterface("vrp_misc",misc)

--[ VARIABLES ]-------------------------------------------------------------------------------------

SetConvarServerInfo("tags", "zirix, ziraflix")
SetConvarServerInfo("DevelopedBy", "ZIRAFLIX")
SetConvarServerInfo("Discord", "discord.gg/ziraflix")
SetConvarServerInfo("Website", "www.ziraflix.com")

local cooldown = {}

local damageItens = {
	{ item = "celular", damageItem = "celular-queimado" },
	{ item = "jbl", damageItem = "jbl-queimada" },
	{ item = "calculadora", damageItem = "calculadora-queimada" },
	{ item = "tablet", damageItem = "tablet-queimado" },
	{ item = "notebook", damageItem = "notebook-queimado" },
	{ item = "controleremoto", damageItem = "controleremoto-queimado" },
	{ item = "baterias", damageItem = "baterias-queimadas" },
	{ item = "radio", damageItem = "radio-queimado" },
	
	{ item = "passaporte", damageItem = nil },
	{ item = "portearmas", damageItem = nil },
	{ item = "identidade", damageItem = nil },
	{ item = "cnh", damageItem = nil },
	{ item = "repairkit", damageItem = nil },
	{ item = "dinheiro", damageItem = nil },
	{ item = "cartao-debito", damageItem = nil },
	{ item = "maquininha", damageItem = "maquininha-queimada" },

	{ item = "drone-basic1", damageItem = nil },
	{ item = "drone-basic2", damageItem = nil },
	{ item = "drone-basic3", damageItem = nil },
	{ item = "drone-advanced1", damageItem = nil },
	{ item = "drone-advanced2", damageItem = nil },
	{ item = "drone-advanced3", damageItem = nil },
	{ item = "drone-police", damageItem = nil },
	{ item = "carrinho", damageItem = nil },

	{ item = "camisinha", damageItem = nil },
	{ item = "vibrador", damageItem = nil },
	{ item = "kit", damageItem = nil },
	
	{ item = "dinheiro-sujo", damageItem = nil },
	{ item = "algema", damageItem = nil },
	{ item = "lockpick", damageItem = nil },
	{ item = "capuz", damageItem = nil },
	{ item = "placa", damageItem = nil },

	{ item = "serra", damageItem = nil },
	{ item = "furadeira", damageItem = nil },
	{ item = "pa-jardinagem", damageItem = nil },

	{ item = "garrafa-vazia", damageItem = nil },
	{ item = "ponta-britadeira", damageItem = nil },

	{ item = "minerio-diamante", damageItem = nil },
	{ item = "minerio-ouro", damageItem = nil },
	{ item = "minerio-prata", damageItem = nil },
	{ item = "minerio-ferro", damageItem = nil },

	{ item = "diamante", damageItem = nil },
	{ item = "barra-ouro", damageItem = nil },
	{ item = "barra-prata", damageItem = nil },
	{ item = "barra-ferro", damageItem = nil },
	
	{ item = "agua", damageItem = nil },
	{ item = "leite", damageItem = nil },
	{ item = "cafe", damageItem = nil },
	{ item = "cafecleite", damageItem = nil },
	{ item = "cafeexpresso", damageItem = nil },
	{ item = "capuccino", damageItem = nil },
	{ item = "frappuccino", damageItem = nil },
	{ item = "cha", damageItem = nil },
	{ item = "icecha", damageItem = nil },
	{ item = "sprunk", damageItem = nil },
	{ item = "cola", damageItem = nil },
	{ item = "energetico", damageItem = nil },

	{ item = "pibwassen", damageItem = nil },
	{ item = "tequilya", damageItem = nil },
	{ item = "patriot", damageItem = nil },
	{ item = "blarneys", damageItem = nil },
	{ item = "jakeys", damageItem = nil },
	{ item = "barracho", damageItem = nil },
	{ item = "ragga", damageItem = nil },
	{ item = "nogo", damageItem = nil },
	{ item = "mount", damageItem = nil },
	{ item = "cherenkov", damageItem = nil },
	{ item = "bourgeoix", damageItem = nil },
	{ item = "bleuterd", damageItem = nil },

	{ item = "sanduiche", damageItem = nil },
	{ item = "rosquinha", damageItem = nil },
	{ item = "hotdog", damageItem = nil },
	{ item = "xburguer", damageItem = nil },
	{ item = "chips", damageItem = nil },
	{ item = "batataf", damageItem = nil },
	{ item = "pizza", damageItem = nil },
	{ item = "frango", damageItem = nil },
	{ item = "bcereal", damageItem = nil },
	{ item = "bchocolate", damageItem = nil },
	{ item = "taco", damageItem = nil },

	{ item = "paracetamil", damageItem = nil },
	{ item = "voltarom", damageItem = nil },
	{ item = "trandrylux", damageItem = nil },
	{ item = "dorfrex", damageItem = nil },
	{ item = "buscopom", damageItem = nil },

	{ item = "r-paracetamil", damageItem = nil },
	{ item = "r-voltarom", damageItem = nil },
	{ item = "r-trandrylux", damageItem = nil },
	{ item = "r-dorfrex", damageItem = nil },
	{ item = "r-buscopom", damageItem = nil },

	{ item = "metanfetamina", damageItem = nil },
	{ item = "composito", damageItem = nil },

	{ item = "nitrato-amonia", damageItem = nil },
	{ item = "hidroxido-sodio", damageItem = nil },
	{ item = "pseudoefedrina", damageItem = nil },
	{ item = "eter", damageItem = nil },

	{ item = "cocaina", damageItem = nil },
	{ item = "pasta-base", damageItem = nil },

	{ item = "acido-sulfurico", damageItem = nil },
	{ item = "folhas-coca", damageItem = nil },
	{ item = "calcio-po", damageItem = nil },
	{ item = "querosene", damageItem = nil },

	{ item = "marijuana", damageItem = nil },
	{ item = "folha-marijuana", damageItem = nil },

	{ item = "corpo-ak47", damageItem = nil },
	{ item = "corpo-aks74u", damageItem = nil },
	{ item = "corpo-uzi", damageItem = nil },
	{ item = "corpo-glock", damageItem = nil },
	{ item = "corpo-magnum", damageItem = nil },

	{ item = "molas", damageItem = nil },
	{ item = "placa-metal", damageItem = nil },
	{ item = "gatilho", damageItem = nil },
	{ item = "capsulas", damageItem = nil },
	{ item = "polvora", damageItem = nil },

	{ item = "garrafa-leite", damageItem = nil },

	{ item = "isca", damageItem = nil },

	{ item = "tora", damageItem = nil },

	{ item = "saco-lixo", damageItem = nil },

	{ item = "encomenda", damageItem = nil },
	{ item = "caixa-vazia", damageItem = nil },

	{ item = "malote", damageItem = nil },

	{ item = "semente-marijuana", damageItem = nil },
	{ item = "semente-blueberry", damageItem = nil },

	{ item = "laranja", damageItem = nil },
	{ item = "tomate", damageItem = nil },
	{ item = "blueberry", damageItem = nil },

	{ item = "transmissao", damageItem = nil },
	{ item = "suspensao", damageItem = nil },
	{ item = "portas", damageItem = nil },
	{ item = "borrachas", damageItem = nil },
	{ item = "pneus", damageItem = nil },
	{ item = "capo", damageItem = nil },
	{ item = "bateria-carro", damageItem = nil },
	{ item = "motor", damageItem = nil },

	{ item = "wbody|WEAPON_DAGGER", damageItem = nil },
	{ item = "wbody|WEAPON_BAT", damageItem = nil },
	{ item = "wbody|WEAPON_BOTTLE", damageItem = nil },
	{ item = "wbody|WEAPON_CROWBAR", damageItem = nil },
	{ item = "wbody|WEAPON_FLASHLIGHT", damageItem = nil },
	{ item = "wbody|WEAPON_GOLFCLUB", damageItem = nil },
	{ item = "wbody|WEAPON_HAMMER", damageItem = nil },
	{ item = "wbody|WEAPON_WEAPON_HATCHET", damageItem = nil },
	{ item = "wbody|WEAPON_WEAPON_KNUCKLES", damageItem = nil },
	{ item = "wbody|WEAPON_KNIFE", damageItem = nil },
	{ item = "wbody|WEAPON_MACHETE", damageItem = nil },
	{ item = "wbody|WEAPON_SWITCHBLADE", damageItem = nil },
	{ item = "wbody|WEAPON_NIGHTSTICK", damageItem = nil },
	{ item = "wbody|WEAPON_WHENCH", damageItem = nil },
	{ item = "wbody|WEAPON_BATTLEAXE", damageItem = nil },
	{ item = "wbody|WEAPON_POOLCUE", damageItem = nil },
	{ item = "wbody|WEAPON_STONE_HATCHET", damageItem = nil },

	{ item = "wbody|WEAPON_PISTOL", damageItem = nil },
	{ item = "wbody|WEAPON_PISTOL_MK2", damageItem = nil },
	{ item = "wbody|WEAPON_COMBATPISTOL", damageItem = nil },
	{ item = "wbody|WEAPON_APPISTOL", damageItem = nil },
	{ item = "wbody|WEAPON_STUNGUN", damageItem = nil },
	{ item = "wbody|WEAPON_PISTOL50", damageItem = nil },
	{ item = "wbody|WEAPON_SNSPISTOL", damageItem = nil },
	{ item = "wbody|WEAPON_SNSPISTOL_MK2", damageItem = nil },
	{ item = "wbody|WEAPON_HEAVYPISTOL", damageItem = nil },
	{ item = "wbody|WEAPON_VINTAGEPISTOL", damageItem = nil },
	{ item = "wbody|WEAPON_FLAREGUN", damageItem = nil },
	{ item = "wbody|WEAPON_MARKSMANPISTOL", damageItem = nil },
	{ item = "wbody|WEAPON_REVOLVER", damageItem = nil },
	{ item = "wbody|WEAPON_REVOLVER_MK2", damageItem = nil },
	{ item = "wbody|WEAPON_DOUBLEACTION", damageItem = nil },
	{ item = "wbody|WEAPON_RAYPISTOL", damageItem = nil },
	{ item = "wbody|WEAPON_CERAMICPISTOL", damageItem = nil },
	{ item = "wbody|WEAPON_NAVYREVOLVER", damageItem = nil },

	{ item = "wammo|WEAPON_PISTOL", damageItem = nil },
	{ item = "wammo|WEAPON_PISTOL_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_COMBATPISTOL", damageItem = nil },
	{ item = "wammo|WEAPON_APPISTOL", damageItem = nil },
	{ item = "wammo|WEAPON_STUNGUN", damageItem = nil },
	{ item = "wammo|WEAPON_PISTOL50", damageItem = nil },
	{ item = "wammo|WEAPON_SNSPISTOL", damageItem = nil },
	{ item = "wammo|WEAPON_SNSPISTOL_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_HEAVYPISTOL", damageItem = nil },
	{ item = "wammo|WEAPON_VINTAGEPISTOL", damageItem = nil },
	{ item = "wammo|WEAPON_FLAREGUN", damageItem = nil },
	{ item = "wammo|WEAPON_MARKSMANPISTOL", damageItem = nil },
	{ item = "wammo|WEAPON_REVOLVER", damageItem = nil },
	{ item = "wammo|WEAPON_REVOLVER_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_DOUBLEACTION", damageItem = nil },
	{ item = "wammo|WEAPON_RAYPISTOL", damageItem = nil },
	{ item = "wammo|WEAPON_CERAMICPISTOL", damageItem = nil },
	{ item = "wammo|WEAPON_NAVYREVOLVER", damageItem = nil },

	{ item = "wbody|WEAPON_MICROSMG", damageItem = nil },
	{ item = "wbody|WEAPON_SMG", damageItem = nil },
	{ item = "wbody|WEAPON_SMG_MK2", damageItem = nil },
	{ item = "wbody|WEAPON_ASSAULTSMG", damageItem = nil },
	{ item = "wbody|WEAPON_COMBATPDW", damageItem = nil },
	{ item = "wbody|WEAPON_MACHINEPISTOL", damageItem = nil },
	{ item = "wbody|WEAPON_MINISMG", damageItem = nil },
	{ item = "wbody|WEAPON_RAYCARBINE", damageItem = nil },

	{ item = "wammo|WEAPON_MICROSMG", damageItem = nil },
	{ item = "wammo|WEAPON_SMG", damageItem = nil },
	{ item = "wammo|WEAPON_SMG_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_ASSAULTSMG", damageItem = nil },
	{ item = "wammo|WEAPON_COMBATPDW", damageItem = nil },
	{ item = "wammo|WEAPON_MACHINEPISTOL", damageItem = nil },
	{ item = "wammo|WEAPON_MINISMG", damageItem = nil },
	{ item = "wammo|WEAPON_RAYCARBINE", damageItem = nil },

	{ item = "wammo|WEAPON_PUMPSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_PUMPSHOTGUN_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_SAWNOFFSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_ASSAULTSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_BULLPUPSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_MUSKET", damageItem = nil },
	{ item = "wammo|WEAPON_HEAVYSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_DBSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_AUTOSHOTGUN", damageItem = nil },

	{ item = "wammo|WEAPON_PUMPSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_PUMPSHOTGUN_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_SAWNOFFSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_ASSAULTSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_BULLPUPSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_MUSKET", damageItem = nil },
	{ item = "wammo|WEAPON_HEAVYSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_DBSHOTGUN", damageItem = nil },
	{ item = "wammo|WEAPON_AUTOSHOTGUN", damageItem = nil },

	{ item = "wbody|WEAPON_ASSAULTRIFLE", damageItem = nil },
	{ item = "wbody|WEAPON_ASSAULTRIFLE_MK2", damageItem = nil },
	{ item = "wbody|WEAPON_CARBINERIFLE", damageItem = nil },
	{ item = "wbody|WEAPON_CARBINERIFLE_MK2", damageItem = nil },
	{ item = "wbody|WEAPON_ADVANCEDRIFLE", damageItem = nil },
	{ item = "wbody|WEAPON_SPECIALCARBINE", damageItem = nil },
	{ item = "wbody|WEAPON_SPECIALCARBINE_MK2", damageItem = nil },
	{ item = "wbody|WEAPON_BULLPUPRIFLE", damageItem = nil },
	{ item = "wbody|WEAPON_BULLPUPRIFLE_MK2", damageItem = nil },
	{ item = "wbody|WEAPON_COMPACTRIFLE", damageItem = nil },

	{ item = "wammo|WEAPON_ASSAULTRIFLE", damageItem = nil },
	{ item = "wammo|WEAPON_ASSAULTRIFLE_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_CARBINERIFLE", damageItem = nil },
	{ item = "wammo|WEAPON_CARBINERIFLE_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_ADVANCEDRIFLE", damageItem = nil },
	{ item = "wammo|WEAPON_SPECIALCARBINE", damageItem = nil },
	{ item = "wammo|WEAPON_SPECIALCARBINE_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_BULLPUPRIFLE", damageItem = nil },
	{ item = "wammo|WEAPON_BULLPUPRIFLE_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_COMPACTRIFLE", damageItem = nil },

	{ item = "wbody|WEAPON_MG", damageItem = nil },
	{ item = "wbody|WEAPON_COMBATMG", damageItem = nil },
	{ item = "wbody|WEAPON_COMBATMG_MK2", damageItem = nil },
	{ item = "wbody|WEAPON_GUSENBERG", damageItem = nil },

	{ item = "wammo|WEAPON_MG", damageItem = nil },
	{ item = "wammo|WEAPON_COMBATMG", damageItem = nil },
	{ item = "wammo|WEAPON_COMBATMG_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_GUSENBERG", damageItem = nil },

	{ item = "wbody|WEAPON_SNIPERRIFLE", damageItem = nil },
	{ item = "wbody|WEAPON_HEAVYSNIPER", damageItem = nil },
	{ item = "wbody|WEAPON_HEAVYSNIPER_MK2", damageItem = nil },
	{ item = "wbody|WEAPON_MASKMANRIFLE", damageItem = nil },
	{ item = "wbody|WEAPON_MASKMANRIFLE_MK2", damageItem = nil },

	{ item = "wammo|WEAPON_SNIPERRIFLE", damageItem = nil },
	{ item = "wammo|WEAPON_HEAVYSNIPER", damageItem = nil },
	{ item = "wammo|WEAPON_HEAVYSNIPER_MK2", damageItem = nil },
	{ item = "wammo|WEAPON_MASKMANRIFLE", damageItem = nil },
	{ item = "wammo|WEAPON_MASKMANRIFLE_MK2", damageItem = nil },

	{ item = "wbody|WEAPON_RPG", damageItem = nil },
	{ item = "wbody|WEAPON_GRENADELAUNCHER", damageItem = nil },
	{ item = "wbody|WEAPON_GRENADELAUNCHER_SMOKE", damageItem = nil },
	{ item = "wbody|WEAPON_MINIGUN", damageItem = nil },
	{ item = "wbody|WEAPON_FIREWORK", damageItem = nil },
	{ item = "wbody|WEAPON_RAILGUN", damageItem = nil },
	{ item = "wbody|WEAPON_HOMINGLAUNCHER", damageItem = nil },
	{ item = "wbody|WEAPON_COMPACTLAUNCHER", damageItem = nil },
	{ item = "wbody|WEAPON_RAYMINIGUN", damageItem = nil },

	{ item = "wammo|WEAPON_RPG", damageItem = nil },
	{ item = "wammo|WEAPON_GRENADELAUNCHER", damageItem = nil },
	{ item = "wammo|WEAPON_GRENADELAUNCHER_SMOKE", damageItem = nil },
	{ item = "wammo|WEAPON_MINIGUN", damageItem = nil },
	{ item = "wammo|WEAPON_FIREWORK", damageItem = nil },
	{ item = "wammo|WEAPON_RAILGUN", damageItem = nil },
	{ item = "wammo|WEAPON_HOMINGLAUNCHER", damageItem = nil },
	{ item = "wammo|WEAPON_COMPACTLAUNCHER", damageItem = nil },
	{ item = "wammo|WEAPON_RAYMINIGUN", damageItem = nil },

	{ item = "wbody|WEAPON_GRANADE", damageItem = nil },
	{ item = "wbody|WEAPON_BZGAS", damageItem = nil },
	{ item = "wbody|WEAPON_MOLOTOV", damageItem = nil },
	{ item = "wbody|WEAPON_STICKYBOMB", damageItem = nil },
	{ item = "wbody|WEAPON_PROXMINE", damageItem = nil },
	{ item = "wbody|WEAPON_SNOWBALL", damageItem = nil },
	{ item = "wbody|WEAPON_PIPEBOMB", damageItem = nil },
	{ item = "wbody|WEAPON_BALL", damageItem = nil },
	{ item = "wbody|WEAPON_SMOKEGRENADE", damageItem = nil },
	{ item = "wbody|WEAPON_FLARE", damageItem = nil },

	{ item = "wbody|WEAPON_PETROLCAN", damageItem = nil },
	{ item = "wbody|GADGET_PARACHUTE", damageItem = nil },
	{ item = "wbody|WEAPON_FIREEXTINGUISHER", damageItem = nil }
}

--[ RICHPRESENCE | FUNCTION ]-----------------------------------------------------------------------

function misc.discord()
	local quantidade = 0
	local users = vRP.getUsers()

	for k,v in pairs(users) do
		quantidade = quantidade + 1
	end

	return parseInt(quantidade)
end

--[ RADIO PERMISSION | FUNCTION ]-------------------------------------------------------------------

function misc.permissaoDpla()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"policia.permissao")
end

function misc.permissaoDmla()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"ems.permissao")
end

function misc.permissaoTaxista()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"taxista.permissao")
end

function misc.permissaoMecanico()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"mecanico.permissao")
end

function misc.permissaoBennys()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"bennys.permissao")
end

function misc.permissaoBallas()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"ballas.permissao")
end

function misc.permissaoGrove()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"grove.permissao")
end

function misc.permissaoFamilies()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"families.permissao")
end

function misc.permissaoMedellin()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"medellin.permissao")
end

function misc.permissaoMotoclub()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"motoclub.permissao")
end

function misc.permissaoBratva()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"bratva.permissao")
end

function misc.permissaoNdrangheta()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"ndrangheta.permissao")
end

function misc.permissaoNynax()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"nynax.permissao")
end

function misc.permissaoSemantic()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"semantic.permissao")
end

--[ /RADIO | COMMAND ]------------------------------------------------------------------------------

RegisterCommand('radio',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	
	if vRP.getInventoryItemAmount(user_id,"radio") >= 1 then
		if args[1] == "f" then
			TriggerClientEvent("vrp_misc:onRadio",source,args[2])
		else
			TriggerClientEvent("vrp_misc:onGroupRadio",source)
		end
	else
		TriggerClientEvent("Notify",source,"aviso","Você <b>não possui</b> um <b>rádio</b> na mochila.") 
	end
end)

--[ WATHER ITEM DAMAGE | EVENT ]--------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(cooldown) do
			if v > 0 then
				cooldown[k] = v - 1
			end
		end
	end
end)

function misc.damageItem()
	local source = source
	local user_id = vRP.getUserId(source)

	for k,v in pairs(damageItens) do
		local item = v.item
		local damageItem = v.damageItem
		local percentage = 0

		if vRP.getInventoryItemAmount(user_id,item) > 0 then
			local itemAmmount = parseInt(vRP.getInventoryItemAmount(user_id,item))
			local itemName = vRP.itemNameList(item)

			if damageItem == nil then
				if cooldown[user_id] == 0 or not cooldown[user_id] then
					cooldown[user_id] = 5
					percentage = math.random(100)
					if percentage >= 60 then
						if vRP.tryGetInventoryItem(user_id,item,itemAmmount) then
							if percentage >= 70 then
								TriggerClientEvent("Notify",source,"negado","<b>Sua mochila está aberta!</b> Você perdeu <b>"..itemName.."</b>.",3000)
							else
								TriggerClientEvent("Notify",source,"negado","<b>Sua mochila está rasgada!</b> Você perdeu <b>"..itemName.."</b>.",3000)
							end
							percentage = 0
							return true
						end
					end
				else
					return false
				end
			else
				if vRP.tryGetInventoryItem(user_id,item,itemAmmount) then
					vRP.giveInventoryItem(user_id,damageItem,itemAmmount)
					TriggerClientEvent("Notify",source,"negado","Seu <b>"..itemName.." queimou</b> quando você entrou na água.",3000)
					return true
				end
			end
		end
	end
end