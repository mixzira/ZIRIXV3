local cfg = {}

cfg.items = {

	--[ Legal Utilities ]----------------------------------------------------------------------------------------------
	
	["mochila"] = { "Mochila",0 },
	["celular"] = { "iFruit XI",0.3 },
	["celular-pro"] = { "iFruit XII",0.3 },
	["jbl"] = { "JBL",0.4 },
	["calculadora"] = { "Calculadora",0.2 },
	["tablet"] = { "Tablet",0.3 },
	["notebook"] = { "Notebook",1.0 },
	["controleremoto"] = { "Controle remoto",0.6 },
	["baterias"] = { "Baterias",0.1 },
	["radio"] = { "WalkTalk",0.3 },
	["chapeu"] = { "Chapeu",0.2 },
	["mascara"] = { "Mascara",0.3 },
	["oculos"] = { "Óculos",0.1 },
	["passaporte"] = { "Passaporte",0.1 },
	["portearmas"] = { "Porte de Armas",0.1 },
	["identidade"] = { "Identidade",0.1 },
	["cnh"] = { "CNH",0.1 },
	["colete"] = { "Colete",2.0 },
	["repairkit"] = { "Kit de Reparos",5.0 },
	["dinheiro"] = { "Dinheiro",0.0 },
	["cartao-debito"] = { "Cartão Débito",0.1 },
	["maquininha"] = { "Maquininha",0.3 },
	["paninho"] = { "Pano de Microfibra",0.1 },
	
	["drone-basic1"] = { "Drone Basico",0.2 },
	["drone-basic2"] = { "Drone Basico",0.2 },
	["drone-basic3"] = { "Drone Basico",0.2 },
	["drone-advanced1"] = { "Drone Avancado",0.2 },
	["drone-advanced2"] = { "Drone Avancado",0.2 },
	["drone-advanced3"] = { "Drone Avancado",0.2 },
	["drone-police"] = { "Drone da Policia",0.2 },

	["carrinho"] = { "Carrinho",0.2 },
	--[ Illegal Utilities ]--------------------------------------------------------------------------------------------

	["dinheiro-sujo"] = { "Dinheiro", 0.0 },
	["algema"] = { "Algema",0.4 },
	["lockpick"] = { "Lockpick",0.2 },
	["capuz"] = { "Capuz",0.1 },
	["placa"] = { "Placa",0.6 },

	--[ Tools ] -------------------------------------------------------------------------------------------------------

	["serra"] = { "Serra",1.0 },
	["furadeira"] = { "Furadeira",1.0 },
	["pa-jardinagem"] = { "Pá de Jardinagem",0.5 },

	--[ Miscs ]--------------------------------------------------------------------------------------------------------

	["garrafa-vazia"] = { "Garrafa vazia",0.1 },
	["ponta-britadeira"] = { "Ponta de britadeira",1.0 },

	--[ Miner Work ]-------------------------------------------------------------------------------------------------------- 
	["minerio-diamante"] = { "Minerio de Diamante",1.0 },
	["minerio-ouro"] = { "Minerio de Ouro",1.0 },
	["minerio-prata"] = { "Minerio de Prata",1.0 },
	["minerio-ferro"] = { "Minerio de Ferro",1.0 },

	["diamante"] = { "Diamante Bruto",1.0 },
	["barra-ouro"] = { "Barra de Ouro",1.0 },
	["barra-prata"] = { "Barra de Prata",1.0 },
	["barra-ferro"] = { "Barra de Ferro",1.0 },

	--[ Drinks ]-------------------------------------------------------------------------------------------------------

	["agua"] = { "Água",0.3 },
	["leite"] = { "Leite",1.0 },
	["cafe"] = { "Café",0.2 },
	["cafecleite"] = { "Café com leite",0.3 },
	["cafeexpresso"] = { "Café Expresso",0.3 },
	["capuccino"] = { "Capuccino",0.5 },
	["frappuccino"] = { "Frapuccino",0.5 },
	["cha"] = { "Chá",0.3 },
	["icecha"] = { "Chá Gelado",0.3 },
	["sprunk"] = { "Sprunk",0.3 },
	["cola"] = { "Cola",0.3 },
	["energetico"] = { "Energético",0.6 },

	--[ Alcoholic Beverages ]------------------------------------------------------------------------------------------

	["pibwassen"] = { "PibWassen",0.6 },
	["tequilya"] = { "Tequilya",0.6 },
	["patriot"] = { "Patriot",0.6 },
	["blarneys"] = { "Blarneys",0.6 },
	["jakeys"] = { "Jakeys",0.6 },
	["barracho"] = { "Barracho",0.6 },
	["ragga"] = { "Ragga",0.6 },
	["nogo"] = { "Nogo",0.6 },
	["mount"] = { "Mount",0.6 },
	["cherenkov"] = { "Cherenkov",0.6 },
	["bourgeoix"] = { "Bourgeoix",0.6 },
	["bleuterd"] = { "Bleuterd",0.6 },

	--[ FastFoods ]----------------------------------------------------------------------------------------------------

	["sanduiche"] = { "Sanduíche",0.3 },
	["rosquinha"] = { "Rosquinha",0.2 },
	["hotdog"] = { "HotDog",0.4 },
	["xburguer"] = { "xBurguer",0.6 },
	["chips"] = { "Batata Chips",0.5 },
	["batataf"] = { "Batata Frita",0.6 },
	["pizza"] = { "Pedaço de Pizza",0.5 },
	["frango"] = { "Frango Frito",0.6 },
	["bcereal"] = { "Barra de Cereal",0.3 },
	["bchocolate"] = { "Barra de Chocolate",0.3 },
	["taco"] = { "Taco",0.5 },

	--[ Drugs ]--------------------------------------------------------------------------------------------------------

	["paracetamil"] = { "Paracetamil",0.2 },
	["voltarom"] = { "Voltarom",0.2 },
	["trandrylux"] = { "Trandrylux",0.2 },
	["dorfrex"] = { "Dorfrex",0.2 },
	["buscopom"] = { "Buscopom",0.2 },

	--[ Prescription ]-------------------------------------------------------------------------------------------------

	["r-paracetamil"] = { "Receituário Paracetamil",0.0 },
	["r-voltarom"] = { "Receituário Voltarom",0.0 },
	["r-trandrylux"] = { "Receituário Trandrylux",0.0 },
	["r-dorfrex"] = { "Receituário Dorfrex",0.0 },
	["r-buscopom"] = { "Receituário Buscopom",0.0 },

	--[ By-product ][ Methamphetamine production ]---------------------------------------------------------------------

	["metanfetamina"] = { "Metanfetamina",0.1 },
	["composito"] = { "Compósito",1.0 },

	--[ Miscellaneous ][ Methamphetamine production ]------------------------------------------------------------------
	
	["nitrato-amonia"] = { "Nitrato de Amônia",0.5 },
	["hidroxido-sodio"] = { "Hidróxido de Sódio",0.5 },
	["pseudoefedrina"] = { "Pseudoefedrina",0.5 },
	["eter"] = { "Éter",0.5 },

	--[ By-product ][ Cocaine production ]-----------------------------------------------------------------------------
	
	["cocaina"] = { "Cocaína",0.1 },
	["pasta-base"] = { "Pasta Base",1.0 },

	--[ Miscellaneous ][ Cocaine production ]--------------------------------------------------------------------------
	
	["acido-sulfurico"] = { "Ácido Sulfúrico",0.5 },
	["folhas-coca"] = { "Folhas de Coca",0.5 },
	["calcio-po"] = { "Cálcio em Pó",0.5 },
	["querosene"] = { "Querosene",0.5 },

	--[ By-product ][ Marijuana production ]-----------------------------------------------------------------------------
	
	["marijuana"] = { "Marijuana",0.1 },

	--[ Miscellaneous ][ Marijuana production ]--------------------------------------------------------------------------
	
	["folha-marijuana"] = { "Folha de Marijuana",0.5 },
	
	--[ Weapons body ][ Weapons Production ]---------------------------------------------------------------------------

	["corpo-fuzil"] = { "Corpo de Fuzil",2.0 },
	["corpo-sub"] = { "Corpo de SUB",1.0 },
	["corpo-pistola"] = { "Corpo de Pistola",1.0 },

	--[ Miscellaneous ][ Weapons Production ]--------------------------------------------------------------------------

	["molas"] = { "Molas",0.1 },
	["placa-metal"] = { "Placa de Metal",1.0 },
	["gatilho"] = { "Gatilho",0.1 },
	["capsulas"] = { "Capsula",0.1 },
	["polvora"] = { "Pacote de Pólvora",0.5 },

	--[ Emprego ][ Leiteiro ]------------------------------------------------------------------------------------------

	["garrafa-leite"] = { "Garrafa com Leite",0.1 },

	--[ Emprego ][ Pescador ]------------------------------------------------------------------------------------------

	["isca"] = { "Isca de Pesca",0.1 },

	--[ Emprego ][ Lenhador ]------------------------------------------------------------------------------------------

	["tora"] = { "Tora de Madeira",0.5 },

	--[ Emprego ][ Lixeiro ]------------------------------------------------------------------------------------------

	["saco-lixo"] = { "Saco de Lixo",0.5 },

	--[ Emprego ][ Carteiro ]------------------------------------------------------------------------------------------

	["encomenda"] = { "Encomenda",0.5 },
	["caixa-vazia"] = { "Caixa Vazia",0.1 },

	--[ Emprego ][ Transporter ]------------------------------------------------------------------------------------------

	["malote"] = { "Malote de Dinheiro",0.5 },

	--[ Emprego ][ Farmer ]------------------------------------------------------------------------------------------

	["semente-marijuana"] = { "Semente Genericas",0.1 },
	["semente-blueberry"] = { "Semente de Blueberry",0.1 },

	["semente-tomate"] = { "Semente de Tomate",0.1 },
	["semente-laranja"] = { "Semente de Laranja",0.1 },


	["laranja"] = { "Laranja",0.1 },
	["tomate"] = { "Tomate",0.1 },
	["blueberry"] = { "Blueberry",0.1 },

	--[ Emprego ][ Vanilla ]------------------------------------------------------------------------------------------

	["camisinha"] = { "Camisinha",0.1 },
	["vibrador"] = { "Vibrador",0.1 },
	["lubrificante"] = { "Lubrificante",0.1 },
	["kit"] = { "Kit de Sex Shop",0.1 },
	
	--[ Desmanche ]------------------------------------------------------------------------------------------
	["transmissao"] = { "Transmissao",0.5 },
	["suspensao"] = { "Suspensao",0.5 },
	["portas"] = { "Portas",1.0 },
	["borrachas"] = { "Borrachas",0.5 },
	["pneus"] = { "Pneus",0.5 },
	["capo"] = { "Capo",1.0 },
	["bateria-carro"] = { "Bateria de Carro",0.7 },
	["motor"] = { "Motor",1.0 },


	--[ Itens queimados ]----------------------------------------------------------------------------------------------

	["celular-queimado"] = { "Celular queimado",0.3 },
	["jbl-queimada"] = { "JBL queimada",0.4 },
	["calculadora-queimada"] = { "Calculadora queimada",0.2 },
	["tablet-queimado"] = { "Tablet queimado",0.3 },
	["notebook-queimado"] = { "Notebook queimado",1.0 },
	["controleremoto-queimado"] = { "Controle remoto queimado",0.6 },
	["baterias-queimadas"] = { "Baterias queimadas",0.1 },
	["radio-queimado"] = { "Rádio queimado",0.2 },
	["maquininha-queimada"] = { "Maquininha queimada",0.3 }
}

local function load_item_pack(name)
	local items = module("cfg/item/"..name)
	if items then
		for k,v in pairs(items) do
			cfg.items[k] = v
		end
	end
end

load_item_pack("armamentos")

return cfg