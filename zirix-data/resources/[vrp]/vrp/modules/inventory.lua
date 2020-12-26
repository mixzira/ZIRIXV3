local itemlist = {
	["mochilap"] = { index = "mochilap", nome = "Mochila P", type = "usar" },
	["mochilam"] = { index = "mochilam", nome = "Mochila M", type = "usar" },
	["mochilag"] = { index = "mochilag", nome = "Mochila G", type = "usar" },

	["celular"] = { index = "celular", nome = "iFruit XI", type = "usar" },
	["celular-pro"] = { index = "celular-pro", nome = "iFruit XII", type = "usar" },
	["jbl"] = { index = "jbl", nome = "JBL", type = "usar" },
	["calculadora"] = { index = "calculadora", nome = "Calculadora", type = "usar" },
	["tablet"] = { index = "tablet", nome = "Tablet", type = "usar" },
	["notebook"] = { index = "notebook", nome = "Notebook", type = "usar" },
	["controleremoto"] = { index = "controleremoto", nome = "Controle remoto", type = "usar" },
	["baterias"] = { index = "baterias", nome = "Baterias", type = "usar" },
	["radio"] = { index = "radio", nome = "WalkTalk", type = "usar" },
	["chapeu"] = { index = "chapeu", nome = "Chapeu", type = "usar" },
	["mascara"] = { index = "mascara", nome = "Mascara", type = "usar" },
	["oculos"] = { index = "oculos", nome = "Óculos", type = "usar" },
	["passaporte"] = { index = "passaporte", nome = "Passaporte", type = "usar" },
	["portearmas"] = { index = "portearmas", nome = "Porte de Armas", type = "usar" },
	["identidade"] = { index = "identidade", nome = "Identidade", type = "usar" },
	["cnh"] = { index = "cnh", nome = "CNH", type = "usar" },
	["colete"] = { index = "colete", nome = "Colete Balístico", type = "usar" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos", type = "usar" },
	["dinheiro"] = { index = "dinheiro", nome = "Dinheiro", type = "usar" },
	["cartao-debito"] = { index = "cartao-debito", nome = "Cartão de débito", type = "usar" },
	["maquininha"] = { index = "maquininha", nome = "Maquininha", type = "usar" },
	["paninho"] = { index = "paninho", nome = "Pano de Microfibra", type = "usar" },
	["carrinho"] = { index = "carrinho", nome = "Carrinho", type = "usar" },

	["camisinha"] = { index = "camisinha", nome = "Camisinha", type = "usar" },
	["vibrador"] = { index = "vibrador", nome = "Vibrador", type = "usar" },
	["kit"] = { index = "kit", nome = "Kit de Sex Shop", type = "usar" },

	--[ Illegal Utilities ]--------------------------------------------------------------------------------------------

	["dinheiro-sujo"] = { index = "dinheiro-sujo", nome = "Dinheiro", type = "usar" },
	["algema"] = { index = "algema", nome = "Algema", type = "usar" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick", type = "usar" },
	["capuz"] = { index = "capuz", nome = "Capuz", type = "usar" },
	["placa"] = { index = "placa", nome = "Placa", type = "usar" },
	
	--[ Tools ] -------------------------------------------------------------------------------------------------------
	
	["serra"] = { index = "serra", nome = "Serra", type = "usar" },
	["furadeira"] = { index = "furadeira", nome = "Furadeira", type = "usar" },
	["pa-jardinagem"] = { index = "pa-jardinagem", nome = "Pá de Jardinagem", type = "usar" },

	--[ Miscs ]-------------------------------------------------------------------------------------------------------- 

	["garrafa-vazia"] = { index = "garrafa-vazia", nome = "Garrafa vazia", type = "usar" },
	["ponta-britadeira"] = { index = "ponta-britadeira", nome = "Ponta de britadeira", type = "usar" },

	--[ Miner Work ]-------------------------------------------------------------------------------------------------------- 

	["minerio-diamante"] = { index = "minerio-diamante", nome = "Minerio de Diamante", type = "usar" },
	["minerio-ouro"] = { index = "minerio-ouro", nome = "Minerio de Ouro", type = "usar" },
	["minerio-prata"] = { index = "minerio-prata", nome = "Minerio de Prata", type = "usar" },
	["minerio-ferro"] = { index = "minerio-ferro", nome = "Minerio de Ferro", type = "usar" },


	["diamante"] = { index = "diamante", nome = "Diamante Bruto", type = "usar" },
	["barra-ouro"] = { index = "barra-ouro", nome = "Barra de Ouro", type = "usar" },
	["barra-prata"] = { index = "barra-prata", nome = "Barra de Prata", type = "usar" },
	["barra-ferro"] = { index = "barra-ferro", nome = "Barra de Ferro", type = "usar" },

	--[ Drinks ]-------------------------------------------------------------------------------------------------------
	
	["agua"] = { index = "agua", nome = "Água", type = "usar" },
	["leite"] = { index = "leite", nome = "Leite", type = "usar" },
	["cafe"] = { index = "cafe", nome = "Café", type = "usar" },
	["cafecleite"] = { index = "cafecleite", nome = "Café com Leite", type = "usar" },
	["cafeexpresso"] = { index = "cafeexpresso", nome = "Café Expresso", type = "usar" },
	["capuccino"] = { index = "capuccino", nome = "Capuccino", type = "usar" },
	["frappuccino"] = { index = "frappuccino", nome = "Frapuccino", type = "usar" },
	["cha"] = { index = "cha", nome = "Chá", type = "usar" },
	["icecha"] = { index = "icecha", nome = "Chá Gelado", type = "usar" },
	["sprunk"] = { index = "sprunk", nome = "Sprunk", type = "usar" },
	["cola"] = { index = "cola", nome = "Cola", type = "usar" },
	["energetico"] = { index = "energetico", nome = "Energético", type = "usar" },
	
	--[ Alcoholic Beverages ]------------------------------------------------------------------------------------------
	
	["pibwassen"] = { index = "pibwassen", nome = "PibWassen", type = "usar" },
	["tequilya"] = { index = "tequilya", nome = "Tequilya", type = "usar" },
	["patriot"] = { index = "patriot", nome = "Patriot", type = "usar" },
	["blarneys"] = { index = "blarneys", nome = "Blarneys", type = "usar" },
	["jakeys"] = { index = "jakeys", nome = "Jakeys", type = "usar" },
	["barracho"] = { index = "barracho", nome = "Barracho", type = "usar" },
	["ragga"] = { index = "ragga", nome = "Ragga", type = "usar" },
	["nogo"] = { index = "nogo", nome = "Nogo", type = "usar" },
	["mount"] = { index = "mount", nome = "Mount", type = "usar" },
	["cherenkov"] = { index = "cherenkov", nome = "Cherenkov", type = "usar" },
	["bourgeoix"] = { index = "bourgeoix", nome = "Bourgeoix", type = "usar" },
	["bleuterd"] = { index = "bleuterd", nome = "Bleuterd", type = "usar" },
	
	--[ FastFoods ]----------------------------------------------------------------------------------------------------
	
	["sanduiche"] = { index = "sanduiche", nome = "Sanduíche", type = "usar" },
	["rosquinha"] = { index = "rosquinha", nome = "Rosquinha", type = "usar" },
	["hotdog"] = { index = "hotdog", nome = "HotDog", type = "usar" },
	["xburguer"] = { index = "xburguer", nome = "xBurguer", type = "usar" },
	["chips"] = { index = "chips", nome = "Batata Chips", type = "usar" },
	["batataf"] = { index = "batataf", nome = "Batata Frita", type = "usar" },
	["pizza"] = { index = "pizza", nome = "Pedaço de Pizza", type = "usar" },
	["frango"] = { index = "frango", nome = "Frango Frito", type = "usar" },
	["bcereal"] = { index = "bcereal", nome = "Barra de Cereal", type = "usar" },
	["bchocolate"] = { index = "bchocolate", nome = "Barra de Chocolate", type = "usar" },
	["taco"] = { index = "taco", nome = "Taco", type = "usar" },
	
	--[ Drugs ]--------------------------------------------------------------------------------------------------------
	
	["paracetamil"] = { index = "paracetamil", nome = "Paracetamil", type = "usar" },
	["voltarom"] = { index = "voltarom", nome = "Voltarom", type = "usar" },
	["trandrylux"] = { index = "trandrylux", nome = "Trandrylux", type = "usar" },
	["dorfrex"] = { index = "dorfrex", nome = "Dorfrex", type = "usar" },
	["buscopom"] = { index = "buscopom", nome = "Buscopom", type = "usar" },
	
	--[ Prescription ]-------------------------------------------------------------------------------------------------
	
	["r-paracetamil"] = { index = "r-paracetamil", nome = "Receituário Paracetamil", type = "usar" },
	["r-voltarom"] = { index = "r-voltarom", nome = "Receituário Voltarom", type = "usar" },
	["r-trandrylux"] = { index = "r-trandrylux", nome = "Receituário Trandrylux", type = "usar" },
	["r-dorfrex"] = { index = "r-dorfrex", nome = "Receituário Dorfrex", type = "usar" },
	["r-buscopom"] = { index = "r-buscopom", nome = "Receituário Buscopom", type = "usar" },
	
	--[ By-product ][ Methamphetamine production ]---------------------------------------------------------------------

	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina", type = "usar" },
	["composito"] = { index = "composito", nome = "Compósito", type = "usar" },

	--[ Miscellaneous ][ Methamphetamine production ]------------------------------------------------------------------
	
	["nitrato-amonia"] = { index = "nitrato-amonia", nome = "Nitrato de Amônia", type = "usar" },
	["hidroxido-sodio"] = { index = "hidroxido-sodio", nome = "Hidróxido de Sódio", type = "usar" },
	["pseudoefedrina"] = { index = "pseudoefedrina", nome = "Pseudoefedrina", type = "usar" },
	["eter"] = { index = "eter", nome = "Éter", type = "usar" },
	
	--[ By-product ][ Cocaine production ]-----------------------------------------------------------------------------

	["cocaina"] = { index = "cocaina", nome = "Cocaína", type = "usar" },
	["pasta-base"] = { index = "pasta-base", nome = "Pasta Base", type = "usar" },

	--[ Miscellaneous ][ Cocaine production ]--------------------------------------------------------------------------

	["acido-sulfurico"] = { index = "acido-sulfurico", nome = "Ácido Sulfúrico", type = "usar" },
	["folhas-coca"] = { index = "folhas-coca", nome = "Folhas de Coca", type = "usar" },
	["calcio-po"] = { index = "calcio-po", nome = "Cálcio em Pó", type = "usar" },
	["querosene"] = { index = "querosene", nome = "Querosene", type = "usar" },
	
	--[ By-product ][ Marijuana production ]-----------------------------------------------------------------------------

	["marijuana"] = { index = "marijuana", nome = "Marijuana", type = "usar" },

	--[ Miscellaneous ][ Marijuana production ]--------------------------------------------------------------------------

	["folha-marijuana"] = { index = "folha-marijuana", nome = "Folha de Marijuana", type = "usar" },
	
	--[ Weapons body ][ Weapons Production ]---------------------------------------------------------------------------
	
	["corpo-fuzil"] = { index = "corpo-fuzil", nome = "Corpo de Fuzil", type = "usar" },
	["corpo-sub"] = { index = "corpo-sub", nome = "Corpo de SUB", type = "usar" },
	["corpo-pistola"] = { index = "corpo-pistola", nome = "Corpo de Pistola", type = "usar" },

	--[ Miscellaneous ][ Weapons Production ]--------------------------------------------------------------------------
	
	["molas"] = { index = "molas", nome = "Molas", type = "usar" },
	["placa-metal"] = { index = "placa-metal", nome = "Placa de Metal", type = "usar" },
	["gatilho"] = { index = "gatilho", nome = "Gatilho", type = "usar" },
	["capsulas"] = { index = "capsulas", nome = "Capsulas", type = "usar" },
	["polvora"] = { index = "polvora", nome = "Polvora", type = "usar" },

	--[ Emprego ][ Leiteiro ]------------------------------------------------------------------------------------------

	["garrafa-leite"] = { index = "garrafa-leite", nome = "Garrafa com Leite", type = "usar" },

	--[ Emprego ][ Pescador ]------------------------------------------------------------------------------------------

	["isca"] = { index = "isca", nome = "Iscas de Pesca", type = "usar" },

	--[ Emprego ][ Lenhador ]------------------------------------------------------------------------------------------

	["tora"] = { index = "tora", nome = "Tora de Madeira", type = "usar" },

	--[ Emprego ][ Lixeiro ]------------------------------------------------------------------------------------------

	["saco-lixo"] = {index = "saco-lixo", nome = "Saco de Lixo", type = "usar" },

	--[ Emprego ][ Carteiro ]------------------------------------------------------------------------------------------

	["encomenda"] = { index = "encomenda", nome = "Encomenda", type = "usar" },
	["caixa-vazia"] = { index = "caixa-vazia", nome = "Caixa Vazia", type = "usar" },

	--[ Emprego ][ Transporter ]------------------------------------------------------------------------------------------

	["malote"] = { index = "malote", nome = "Malote de Dinheiro", type = "usar" },

	--[ Emprego ][ Farmer ]------------------------------------------------------------------------------------------

	["semente-marijuana"] = { index = "semente-maconha", nome = "Sementes Genericas", type = "usar" },
	["semente-blueberry"] = { index = "semente-blueberry", nome = "Sementes de Blueberry", type = "usar" },
	["semente-tomate"] = { index = "semente-tomate", nome = "Semente de Tomate", type = "usar" },
	["semente-laranja"] = { index = "semente-laranja", nome = "Semente de Laranja", type = "usar" },
	
	["laranja"] = { index = "laranja", nome = "Laranja", type = "usar" },
	["tomate"] = { index = "tomate", nome = "Tomate", type = "usar" },
	["blueberry"] = { index = "blueberry", nome = "Blueberry", type = "usar" },

	--[ Desmanche ]------------------------------------------------------------------------------------------

	["transmissao"] = { index = "transmissao", nome = "Transmissao", type = "usar" },
	["suspensao"] = { index = "suspensao", nome = "Suspensao", type = "usar" },
	["portas"] = { index = "portas", nome = "Portas", type = "usar" },
	["borrachas"] = { index = "borrachas", nome = "Borrachas", type = "usar" },
	["pneus"] = { index = "pneus", nome = "Pneus", type = "usar" },
	["capo"] = { index = "capo", nome = "Capo", type = "usar" },
	["bateria-carro"] = { index = "bateria-carro", nome = "Bateria de Carro", type = "usar" },
	["motor"] = { index = "motor", nome = "Motor", type = "usar" },

	--[ Itens danificados ]--------------------------------------------------------------------------------------------

	["celular-queimado"] = { index = "celular-queimado", nome = "Celular queimado", type = "usar" },
	["jbl-queimada"] = { index = "jbl-queimada", nome = "JBL queimada", type = "usar" },
	["calculadora-queimada"] = { index = "calculadora-queimada", nome = "Calculadora queimada", type = "usar" },
	["tablet-queimado"] = { index = "tablet-queimado", nome = "Tablet queimado", type = "usar" },
	["notebook-queimado"] = { index = "notebook-queimado", nome = "Notebook queimado", type = "usar" },
	["controleremoto-queimado"] = { index = "controleremoto-queimado", nome = "Controle remoto queimado", type = "usar" },
	["baterias-queimadas"] = { index = "baterias-queimadas", nome = "Baterias queimadas", type = "usar" },
	["radio-queimado"] = { index = "radio-queimado", nome = "Rádio queimado", type = "usar" },
	["maquininha-queimada"] = { index = "maquininha-queimada", nome = "Maquininha queimada", type = "usar" },

	--[ Weapons ][ Melee]----------------------------------------------------------------------------------------------

	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga", type = "equipar" },
	["wbody|WEAPON_BAT"] = { index = "tacobaseball", nome = "Taco de Baseball", type = "equipar" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafaquebrada", nome = "Garrafa quebrada", type = "equipar" },
	["wbody|WEAPON_CROWBAR"] = { index = "pecabra", nome = "Pé de Cabra", type = "equipar" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna", type = "equipar" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "tacogolf", nome = "Taco de Golf", type = "equipar" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo", type = "equipar" },
	["wbody|WEAPON_WEAPON_HATCHET"] = { index = "machado", nome = "Machado", type = "equipar" },
	["wbody|WEAPON_WEAPON_KNUCKLES"] = { index = "socoingles", nome = "Soco Inglês", type = "equipar" },
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca", type = "equipar" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Taco de Baseball", type = "equipar" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete", type = "equipar" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete", type = "equipar" },
	["wbody|WEAPON_WHENCH"] = { index = "grifo", nome = "Grifo", type = "equipar" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "machadodebatalha", nome = "Machado De Batalha", type = "equipar" },
	["wbody|WEAPON_POOLCUE"] = { index = "tacosinuca", nome = "Taco de Sinuca", type = "equipar" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "machadopedra", nome = "Machado de Pedra", type = "equipar" },

	--[ Handguns ][ Weapons ]------------------------------------------------------------------------------------------

	["wbody|WEAPON_PISTOL"] = { index = "pt92af", nome = "PT92AF", type = "equipar" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "czp09", nome = "CZ P-09", type = "equipar" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "px4", nome = "Px4", type = "equipar" },
	["wbody|WEAPON_APPISTOL"] = { index = "x2e1911", nome = "XSE 1911", type = "equipar" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser", type = "equipar" },
	["wbody|WEAPON_PISTOL50"] = { index = "derserteagle", nome = "Desert Eagle", type = "equipar" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "waltherppk", nome = "Walther PPK", type = "equipar" },
	["wbody|WEAPON_SNSPISTOL_MK2"] = { index = "waltherppk2", nome = "Walther PPK2", type = "equipar" },
	["wbody|WEAPON_HEAVYPISTOL"] = { index = "wide1911", nome = "Wide 1911", type = "equipar" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "fn1903", nome = "FN 1903", type = "equipar" },
	["wbody|WEAPON_FLAREGUN"] = { index = "sinalizador", nome = "Sinalizador", type = "equipar" },
	["wbody|WEAPON_MARKSMANPISTOL"] = { index = "musketpistol", nome = "Musket Pistol", type = "equipar" },
	["wbody|WEAPON_REVOLVER"] = { index = "asgco2", nome = "ASG CO2", type = "equipar" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "ragingbull", nome = "Raging Bull", type = "equipar" },
	["wbody|WEAPON_DOUBLEACTION"] = { index = "python", nome = "Python", type = "equipar" },
	["wbody|WEAPON_RAYPISTOL"] = { index = "raypistol", nome = "Raypistol", type = "equipar" }, --[ Admin Gun ]--------
	["wbody|WEAPON_CERAMICPISTOL"] = { index = "kochp7", nome = "Koch P7", type = "equipar" },
	["wbody|WEAPON_NAVYREVOLVER"] = { index = "colt1851", nome = "Colt 1851", type = "equipar" },

	--[ Handguns ][ Ammo ]---------------------------------------------------------------------------------------------

	["wammo|WEAPON_PISTOL"] = { index = "m-pt92af", nome = "M-PT92AF", type = "recarregar" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-czp09", nome = "M-CZ P-09", type = "recarregar" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-px4", nome = "M-Px4", type = "recarregar" },
	["wammo|WEAPON_APPISTOL"] = { index = "m-x2e1911", nome = "M-XSE 1911", type = "recarregar" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "M-Taser", type = "recarregar" },
	["wammo|WEAPON_PISTOL50"] = { index = "m-derserteagle", nome = "M-Desert Eagle", type = "recarregar" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-waltherppk", nome = "M-Walther PPK", type = "recarregar" },
	["wammo|WEAPON_SNSPISTOL_MK2"] = { index = "m-waltherppk2", nome = "M-Walther PPK2", type = "recarregar" },
	["wammo|WEAPON_HEAVYPISTOL"] = { index = "m-wide1911", nome = "M-Wide 1911", type = "recarregar" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-fn1903", nome = "M-FN 1903", type = "recarregar" },
	["wammo|WEAPON_FLAREGUN"] = { index = "m-sinalizador", nome = "M-Sinalizador", type = "recarregar" },
	["wammo|WEAPON_MARKSMANPISTOL"] = { index = "m-musketpistol", nome = "M-Musket Pistol", type = "recarregar" },
	["wammo|WEAPON_REVOLVER"] = { index = "m-asgco2", nome = "M-ASG CO2", type = "recarregar" },
	["wammo|WEAPON_REVOLVER_MK2"] = { index = "m-ragingbull", nome = "M-Raging Bull", type = "recarregar" },
	["wammo|WEAPON_DOUBLEACTION"] = { index = "m-python", nome = "M-Python", type = "recarregar" },
	["wammo|WEAPON_RAYPISTOL"] = { index = "m-raypistol", nome = "M-Raypistol", type = "recarregar" }, --[ Admin Gun ]-
	["wammo|WEAPON_CERAMICPISTOL"] = { index = "m-kochp7", nome = "M-Koch P7", type = "recarregar" },
	["wammo|WEAPON_NAVYREVOLVER"] = { index = "m-colt1851", nome = "M-Colt 1851", type = "recarregar" },

	--[ Submachine Guns ][ Weapons ]-----------------------------------------------------------------------------------

	["wbody|WEAPON_MICROSMG"] = { index = "microuzi", nome = "Micro Uzi", type = "equipar" },
	["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5", type = "equipar" },
	["wbody|WEAPON_SMG_MK2"] = { index = "mp5k", nome = "MP5K", type = "equipar" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "p90", nome = "P90", type = "equipar" },
	["wbody|WEAPON_COMBATPDW"] = { index = "mpxsd", nome = "MPX-SD", type = "equipar" },
	["wbody|WEAPON_MACHINEPISTOL"] = { index = "tecdc9", nome = "TEC-DC9", type = "equipar" },
	["wbody|WEAPON_MINISMG"] = { index = "vz82", nome = "VZ.82", type = "equipar" },
	["wbody|WEAPON_RAYCARBINE"] = { index = "raycarbine", nome = "Ray Carbine", type = "equipar" },

	--[ Submachine Guns ][ Ammo ]--------------------------------------------------------------------------------------

	["wammo|WEAPON_MICROSMG"] = { index = "m-microuzi", nome = "M-Micro Uzi", type = "recarregar" },
	["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "M-MP5", type = "recarregar" },
	["wammo|WEAPON_SMG_MK2"] = { index = "m-mp5k", nome = "M-MP5K", type = "recarregar" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "m-p90", nome = "M-P90", type = "recarregar" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-mpxsd", nome = "M-MPX-SD", type = "recarregar" },
	["wammo|WEAPON_MACHINEPISTOL"] = { index = "m-tecdc9", nome = "M-TEC-DC9", type = "recarregar" },
	["wammo|WEAPON_MINISMG"] = { index = "m-vz82", nome = "M-VZ.82", type = "recarregar" },
	["wammo|WEAPON_RAYCARBINE"] = { index = "m-raycarbine", nome = "M-Ray Carbine", type = "recarregar" },

	--[ Shotguns ][ Weapons ]------------------------------------------------------------------------------------------

	["wbody|WEAPON_PUMPSHOTGUN"] = { index = "mossberg590", nome = "Mossberg 590", type = "equipar" },
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington870", nome = "Remington 870", type = "equipar" },
	["wbody|WEAPON_SAWNOFFSHOTGUN"] = { index = "mossberg500", nome = "Mossberg 500", type = "equipar" },
	["wbody|WEAPON_ASSAULTSHOTGUN"] = { index = "uts15", nome = "UTS-15", type = "equipar" },
	["wbody|WEAPON_BULLPUPSHOTGUN"] = { index = "keltecksg", nome = "Kel-Tec KSG ", type = "equipar" },
	["wbody|WEAPON_MUSKET"] = { index = "musket", nome = "Musket", type = "equipar" },
	["wbody|WEAPON_HEAVYSHOTGUN"] = { index = "saiga12", nome = "Saiga 12", type = "equipar" },
	["wbody|WEAPON_DBSHOTGUN"] = { index = "zabala", nome = "Zabala", type = "equipar" },
	["wbody|WEAPON_AUTOSHOTGUN"] = { index = "armselprotecta", nome = "Armsel Protecta", type = "equipar" },

	--[ Shotguns ][ Ammo ]---------------------------------------------------------------------------------------------

	["wammo|WEAPON_PUMPSHOTGUN"] = { index = "m-mossberg590", nome = "M-Mossberg 590", type = "recarregar" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington870", nome = "M-Remington 870", type = "recarregar" },
	["wammo|WEAPON_SAWNOFFSHOTGUN"] = { index = "m-mossberg500", nome = "M-Mossberg 500", type = "recarregar" },
	["wammo|WEAPON_ASSAULTSHOTGUN"] = { index = "m-uts15", nome = "M-UTS-15", type = "recarregar" },
	["wammo|WEAPON_BULLPUPSHOTGUN"] = { index = "m-keltecksg", nome = "M-Kel-Tec KSG ", type = "recarregar" },
	["wammo|WEAPON_MUSKET"] = { index = "m-musket", nome = "M-Musket", type = "recarregar" },
	["wammo|WEAPON_HEAVYSHOTGUN"] = { index = "m-saiga12", nome = "M-Saiga 12", type = "recarregar" },
	["wammo|WEAPON_DBSHOTGUN"] = { index = "m-zabala", nome = "M-Zabala", type = "recarregar" },
	["wammo|WEAPON_AUTOSHOTGUN"] = { index = "m-armselprotecta", nome = "M-Armsel Protecta", type = "recarregar" },

	--[ Assault Rifles ][ Weapons ]------------------------------------------------------------------------------------

	["wbody|WEAPON_ASSAULTRIFLE"] = { index = "ak74", nome = "AK-74", type = "equipar" },
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak47", nome = "AK-47", type = "equipar" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "ar15", nome = "AR-15", type = "equipar" },
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "m4a1", nome = "M4-A1", type = "equipar" },
	["wbody|WEAPON_ADVANCEDRIFLE"] = { index = "tavorctar21", nome = "Tavor CTAR-21", type = "equipar" },
	["wbody|WEAPON_SPECIALCARBINE"] = { index = "g36c", nome = "G36C", type = "equipar" },
	["wbody|WEAPON_SPECIALCARBINE_MK2"] = { index = "g36k", nome = "G36K", type = "equipar" },
	["wbody|WEAPON_BULLPUPRIFLE"] = { index = "noricon86s", nome = "Norinco 86S", type = "equipar" },
	["wbody|WEAPON_BULLPUPRIFLE_MK2"] = { index = "hsvhsd2", nome = "HS VHS-D2", type = "equipar" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "minidraco", nome = "Draco", type = "equipar" },

	--[ Assault Rifles ][ Ammo ]---------------------------------------------------------------------------------------

	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-ak74", nome = "M-AK-74", type = "recarregar" },
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak47", nome = "M-AK-47", type = "recarregar" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-ar15", nome = "M-AR-15", type = "recarregar" },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-m4a1", nome = "M-M4-A1", type = "recarregar" },
	["wammo|WEAPON_ADVANCEDRIFLE"] = { index = "m-tavorctar21", nome = "M-Tavor CTAR-21", type = "recarregar" },
	["wammo|WEAPON_SPECIALCARBINE"] = { index = "m-g36c", nome = "M-G36C", type = "recarregar" },
	["wammo|WEAPON_SPECIALCARBINE_MK2"] = { index = "m-g36k", nome = "M-G36K", type = "recarregar" },
	["wammo|WEAPON_BULLPUPRIFLE"] = { index = "m-noricon86s", nome = "M-Norinco 86S", type = "recarregar" },
	["wammo|WEAPON_BULLPUPRIFLE_MK2"] = { index = "m-hsvhsd2", nome = "M-HS VHS-D2", type = "recarregar" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-minidraco", nome = "M-Draco", type = "recarregar" },

	--[ Light Machine Guns ][ Weapons ]--------------------------------------------------------------------------------

	["wbody|WEAPON_MG"] = { index = "pkm", nome = "PKM", type = "equipar" },
	["wbody|WEAPON_COMBATMG"] = { index = "m60", nome = "M60", type = "equipar" },
	["wbody|WEAPON_COMBATMG_MK2"] = { index = "m6e4", nome = "M60E4", type = "equipar" },
	["wbody|WEAPON_GUSENBERG"] = { index = "thompson", nome = "Thompson", type = "equipar" },

	--[ Light Machine Guns ][ Ammo ]-----------------------------------------------------------------------------------

	["wammo|WEAPON_MG"] = { index = "m-pkm", nome = "M-PKM", type = "recarregar" },
	["wammo|WEAPON_COMBATMG"] = { index = "m-m60", nome = "M-M60", type = "recarregar" },
	["wammo|WEAPON_COMBATMG_MK2"] = { index = "m-m6e4", nome = "M-M60E4", type = "recarregar" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-thompson", nome = "M-Thompson", type = "recarregar" },

	--[ Sniper Rifles ][ Weapons ]-------------------------------------------------------------------------------------

	["wbody|WEAPON_SNIPERRIFLE"] = { index = "awf", nome = "AW-F", type = "equipar" },
	["wbody|WEAPON_HEAVYSNIPER"] = { index = "barrettm107", nome = "Barrett M107", type = "equipar" },
	["wbody|WEAPON_HEAVYSNIPER_MK2"] = { index = "serbubfg504", nome = "Serbu BFG-50A", type = "equipar" },
	["wbody|WEAPON_MASKMANRIFLE"] = { index = "m39", nome = "M39", type = "equipar" },
	["wbody|WEAPON_MASKMANRIFLE_MK2"] = { index = "m1a", nome = "M1A", type = "equipar" },

	--[ Sniper Rifles ][ Ammo ]----------------------------------------------------------------------------------------

	["wammo|WEAPON_SNIPERRIFLE"] = { index = "m-awf", nome = "M-AW-F", type = "recarregar" },
	["wammo|WEAPON_HEAVYSNIPER"] = { index = "m-barrettm107", nome = "M-Barrett M107", type = "recarregar" },
	["wammo|WEAPON_HEAVYSNIPER_MK2"] = { index = "m-serbubfg504", nome = "M-Serbu BFG-50A", type = "recarregar" },
	["wammo|WEAPON_MASKMANRIFLE"] = { index = "m-m39", nome = "M-M39", type = "recarregar" },
	["wammo|WEAPON_MASKMANRIFLE_MK2"] = { index = "m-m1a", nome = "M-M1A", type = "recarregar" },

	--[ Heavy Weapons ][ Weapons ]-------------------------------------------------------------------------------------

	["wbody|WEAPON_RPG"] = { index = "rpg", nome = "RPG", type = "equipar" },
	["wbody|WEAPON_GRENADELAUNCHER"] = { index = "grenadelauncher", nome = "Lançador de Granadas", type = "equipar" },
	["wbody|WEAPON_GRENADELAUNCHER_SMOKE"] = { index = "grenadelaunchersmoke", nome = "Lançador de Granadas de Smoke", type = "equipar" },
	["wbody|WEAPON_MINIGUN"] = { index = "minigun", nome = "Minigun", type = "equipar" },
	["wbody|WEAPON_FIREWORK"] = { index = "firework", nome = "Firework", type = "equipar" },
	["wbody|WEAPON_RAILGUN"] = { index = "railgun", nome = "Railgun", type = "equipar" },
	["wbody|WEAPON_HOMINGLAUNCHER"] = { index = "hominglauncher", nome = "Railgun", type = "equipar" },
	["wbody|WEAPON_COMPACTLAUNCHER"] = { index = "compactlauncher", nome = "Lançador de Granadas Compacto", type = "equipar" },
	["wbody|WEAPON_RAYMINIGUN"] = { index = "rayminigun", nome = "Rayminigun", type = "equipar" },

	--[ Heavy Weapons ][ Ammo ]----------------------------------------------------------------------------------------

	["wammo|WEAPON_RPG"] = { index = "m-rpg", nome = "M-RPG", type = "recarregar" },
	["wammo|WEAPON_GRENADELAUNCHER"] = { index = "m-grenadelauncher", nome = "M-Lançador de Granadas", type = "recarregar" },
	["wammo|WEAPON_GRENADELAUNCHER_SMOKE"] = { index = "m-grenadelaunchersmoke", nome = "M-Lançador de Granadas", type = "recarregar" },
	["wammo|WEAPON_MINIGUN"] = { index = "m-minigun", nome = "M-Minigun", type = "recarregar" },
	["wammo|WEAPON_FIREWORK"] = { index = "m-firework", nome = "M-Firework", type = "recarregar" },
	["wammo|WEAPON_RAILGUN"] = { index = "m-railgun", nome = "M-Railgun", type = "recarregar" },
	["wammo|WEAPON_HOMINGLAUNCHER"] = { index = "m-hominglauncher", nome = "M-Railgun", type = "recarregar" },
	["wammo|WEAPON_COMPACTLAUNCHER"] = { index = "m-compactlauncher", nome = "M-Lançador de Granadas", type = "recarregar" },
	["wammo|WEAPON_RAYMINIGUN"] = { index = "m-rayminigun", nome = "M-Rayminigun", type = "recarregar" },

	--[ Throwables ]---------------------------------------------------------------------------------------------------

	["wbody|WEAPON_GRANADE"] = { index = "granada", nome = "Granada", type = "equipar" },
	["wbody|WEAPON_BZGAS"] = { index = "gaslacrimogeneo", nome = "Gás Lacrimogêneo", type = "equipar" },
	["wbody|WEAPON_MOLOTOV"] = { index = "coquetelmolotov", nome = "Coquetel Molotov", type = "equipar" },
	["wbody|WEAPON_STICKYBOMB"] = { index = "c4", nome = "C4", type = "equipar" },
	["wbody|WEAPON_PROXMINE"] = { index = "minaproximidade", nome = "Mina de Proximidade", type = "equipar" },
	["wbody|WEAPON_SNOWBALL"] = { index = "bolaneve", nome = "Bola de Neve", type = "equipar" },
	["wbody|WEAPON_PIPEBOMB"] = { index = "bombacano", nome = "Bomba de Cano", type = "equipar" },
	["wbody|WEAPON_BALL"] = { index = "bolabaseball", nome = "Bola de Baseball", type = "equipar" },
	["wbody|WEAPON_SMOKEGRENADE"] = { index = "granadagas", nome = "Granada de Gás", type = "equipar" },
	["wammo|WEAPON_FLARE"] = { index = "flare", nome = "Flare", type = "equipar" },

	--[ Miscellaneous ]------------------------------------------------------------------------------------------------

	["wammo|WEAPON_PETROLCAN"] = { index = "galaogasolina", nome = "Galão de Gasolina", type = "equipar" },
	["wammo|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquédas", type = "equipar" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor", type = "equipar" }
}

function vRP.itemNameList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].nome
	end
end

function vRP.itemIndexList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].index
	end
end

function vRP.itemTypeList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].type
	end
end

function vRP.itemBodyList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

vRP.items = {}

function vRP.defInventoryItem(idname,name,weight)
	if weight == nil then
		weight = 0
	end
	local item = { name = name, weight = weight }
	vRP.items[idname] = item
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args),vRP.computeItemWeight(item,args)
	end
	return nil,nil
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item,args)
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

function vRP.giveInventoryItem(user_id,idname,amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry then
			entry.amount = entry.amount + amount
		else
			data.inventory[idname] = { amount = amount }
		end
	end
end

function vRP.tryGetInventoryItem(user_id,idname,amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry and entry.amount >= amount then
			entry.amount = entry.amount - amount

			if entry.amount <= 0 then
				data.inventory[idname] = nil
			end
			return true
		end
	end
	return false
end

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	return math.floor(vRP.expToLevel(vRP.getExp(user_id,"physical","strength")))*3
end

RegisterServerEvent("clearInventoryTwo")
AddEventHandler("clearInventoryTwo",function(id)
    if id then
		local data = vRP.getUserDataTable(id)
		if data then
			data.inventory = {}
		end

		vRPclient._clearWeapons(id)
	end
end)

RegisterServerEvent("clearInventory")
AddEventHandler("clearInventory",function()
    local source = source
	local user_id = vRP.getUserId(source)
	
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        if data then
            data.inventory = {}
        end

        vRP.varyThirst(user_id,-50)
		vRP.varyHunger(user_id,-50)
        vRPclient._clearWeapons(source)
        vRPclient._setHandcuffed(source,false)

        vRP.setExp(user_id,"physical","strength",20)
    end
end)

AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)

--[ VEHICLEGLOBAL ]-------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleGlobal()
	return vehs.vehglobal
end

--[ VEHICLENAME ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleName(vname)
	return vehs.vehglobal[vname].name
end

--[ VEHICLERENTALPRICE ]--------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleRentalPrice(vname)
	return vehs.vehglobal[vname].rentalPrice
end

--[ VEHICLECHEST ]--------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleChest(vname)
	return vehs.vehglobal[vname].mala
end

--[ VEHICLESLOT ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleSlot(vname)
	if vehs.vehglobal[vname].slots == nil then
		return 5
	end
	return vehs.vehglobal[vname].slots
end

--[ VEHICLEPRICE ]--------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehiclePrice(vname)
	return vehs.vehglobal[vname].price
end

--[ VEHICLETYPE ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleType(vname)
	return vehs.vehglobal[vname].tipo
end

--[ ACTIVED ]-------------------------------------------------------------------------------------------------------------------------------------------

local actived = {}
local activedAmount = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(actived) do
			if actived[k] > 0 then
				actived[k] = v - 1
				if actived[k] <= 0 then
					actived[k] = nil
					activedAmount[k] = nil
				end
			end
		end
		Citizen.Wait(100)
	end
end)

--[ SLOT INVENTORY ]------------------------------------------------------------------------------------------------------------------------------------

function vRP.verifySlots(user_id)
	if vRP.getExp(user_id,"physical","strength") == 1900 then -- 90Kg
		return 24
	elseif vRP.getExp(user_id,"physical","strength") == 1320 then -- 75Kg
		return 18
	elseif vRP.getExp(user_id,"physical","strength") == 670 then -- 51Kg
		return 12
	elseif vRP.getExp(user_id,"physical","strength") == 20 then -- 6Kg
		return 6
	end
end

function vRP.getRemaingSlots(user_id)
	local tSlot = vRP.verifySlots(user_id)

	if tSlot ~= nil then
		tSlot = tSlot
	else
		tSlot = 11
	end

	for k,v in pairs(vRP.getInventory(user_id)) do
		tSlot = tSlot - 1
	end

	return tSlot
end

function vRP.haveMoreSlots(user_id)
	if vRP.getRemaingSlots(user_id) > 0 then
		return true
	else
		return false
	end
end

--[ SLOT CHEST ]----------------------------------------------------------------------------------------------------------------------------------------

function vRP.getRemaingChestSlots(chestData,chestSlots)
	local tcSlot = chestSlots

	if tcSlot ~= nil then
		tcSlot = tcSlot
	else
		tcSlot = 11
	end

	local data = vRP.getSData(chestData)
	local result = json.decode(data) or {}

	for k,v in pairs(result) do
		tcSlot = tcSlot - 1
	end

	return tcSlot
end

--[ STORE CHEST ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.storeChestItem(user_id,chestData,itemName,amount,chestWeight,chestSlots)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then

			if parseInt(amount) > 0 then
				activedAmount[user_id] = parseInt(amount)
			else
				return false
			end

			local new_weight = vRP.computeItemsWeight(items) + vRP.getItemWeight(itemName) * parseInt(activedAmount[user_id])

			if new_weight <= parseInt(chestWeight) and vRP.getRemaingChestSlots(chestData,chestSlots) >= 1 then
				if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(activedAmount[user_id])) then
					if items[itemName] ~= nil then
						items[itemName].amount = parseInt(items[itemName].amount) + parseInt(activedAmount[user_id])
					else
						items[itemName] = { amount = parseInt(activedAmount[user_id]) }
					end

					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end

--[ TAKE CHEST ]----------------------------------------------------------------------------------------------------------------------------------------

function vRP.tryChestItem(user_id,chestData,itemName,amount)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then
			if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then

				if parseInt(amount) > 0 then
					activedAmount[user_id] = parseInt(amount)
				else
					return false
				end

				local new_weight = vRP.getInventoryWeight(parseInt(user_id)) + vRP.getItemWeight(itemName) * parseInt(activedAmount[user_id])
				if new_weight <= vRP.getInventoryMaxWeight(parseInt(user_id)) and vRP.getRemaingSlots(parseInt(user_id)) >= 1 then
					vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(activedAmount[user_id]))

					items[itemName].amount = parseInt(items[itemName].amount) - parseInt(activedAmount[user_id])

					if parseInt(items[itemName].amount) <= 0 then
						items[itemName] = nil
					end

					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end