config = { }

--[ CONFIGURAÇÃO INICIAL DA PRODUÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- LOCAL ONDE FICA A MAQUINA DE PRODUÇÃO.
config.prodMachine = {
    [1] = { ['x'] = 605.99, ['y'] = -3093.01, ['z'] = 6.07 },
    --[2] = { ['x'] = 605.99, ['y'] = -3093.01, ['z'] = 6.07 },
}

-- PERMISSÕES PARA ACESSAR A MAQUINA.
-- Minimo: 1 - Maximo: 5
config.permissionMachine = {   
    "manager.permissao",
}

--[ CONFIGURAÇÃO DA PRODUÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- ARMAS A SEREM FABRICADOS.
config.weapons = {
    "ak47",
	"ak74u",
	"uzi",
	"magnum44",
	"glock"
}

-- ITENS NECESSARIOS PARA CADA ARMA.
-- ITEM,QUANTIDADE
config.weapon1 = { "corpo-ak47",1, "placa-metal",10, "molas",3, "gatilho",1 }
config.weapon2 = { "corpo-aks74u",1, "placa-metal",6, "molas",2, "gatilho",1 }
config.weapon3 = { "corpo-uzi",1, "placa-metal",6, "molas",2, "gatilho",1 }
config.weapon4 = { "corpo-magnum",1, "placa-metal",6, "molas",2, "gatilho",1 }
config.weapon5 = { "corpo-glock",1, "placa-metal",6, "molas",2, "gatilho",1 }

-- INDEX DA ARMA e QUANTIDADE PARA ADICIONAR AO INVENTARIO APÓS FABRICAR.
config.gweapon1 = { "wbodyWEAPON_ASSAULTRIFLE_MK2", 1 }
config.gweapon2 = { "wbodyWEAPON_COMPACTRIFLE", 1 }
config.gweapon3 = { "wbodyWEAPON_MICROSMG", 1 }
config.gweapon4 = { "wbodyWEAPON_REVOLVER_MK2", 1 }
config.gweapon5 = { "wbodyWEAPON_COMBATPISTOL", 1 }

--[ CONFIGURAÇÃO DA ANIMAÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- ANIMAÇÃO PARA MONTAR A ARMA
config.anim = { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }

-- TEMPO PARA REALIZAR A ANIMAÇÃO E PRODUZIR A ARMA.
config.time = 10000 -- 10 segundos

--[ CONFIGURAÇÃO DA NUI ]-------------------------------------------------------------------------------------------------------------------------
---- SOMENTE SE ALTERAR ALGO NO BUTTON CLICK DO HTML.

config.button1 = "produzir-ak47"
config.button2 = "produzir-ak74u"
config.button3 = "produzir-uzi"
config.button4 = "produzir-magnum44"
config.button5 = "produzir-glock"
