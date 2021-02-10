config = { }

--[ CONFIGURAÇÃO INICIAL DA PRODUÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- LOCAL ONDE FICA A MAQUINA DE PRODUÇÃO.
config.prodMachine = {
    [1] = { ['x'] = 611.21, ['y'] = -3090.07, ['z'] = 6.07 },
    --[2] = { ['x'] = 605.99, ['y'] = -3093.01, ['z'] = 6.07 },
}

-- PERMISSÕES PARA ACESSAR A MAQUINA.
-- Minimo: 1 - Maximo: 5
config.permissionMachine = {   
    "manager.permissao",
}

--[ CONFIGURAÇÃO DA PRODUÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- MUNICAO A SEREM FABRICADOS.
config.weapons = {
    "m-ak47",
	"m-ak74u",
	"m-uzi",
	"m-magnum44",
	"m-glock"
}

-- ITENS NECESSARIOS PARA CADA MUNICAO.
-- ITEM,QUANTIDADE
config.weapon1 = { "corpo-ak47",1, "placa-metal",10, "molas",3, "gatilho",1 }
config.weapon2 = { "corpo-aks74u",1, "placa-metal",6, "molas",2, "gatilho",1 }
config.weapon3 = { "corpo-uzi",1, "placa-metal",6, "molas",2, "gatilho",1 }
config.weapon4 = { "corpo-magnum",1, "placa-metal",6, "molas",2, "gatilho",1 }
config.weapon5 = { "corpo-glock",1, "placa-metal",6, "molas",2, "gatilho",1 }

-- INDEX DA MUNICAO e QUANTIDADE PARA ADICIONAR AO INVENTARIO APÓS FABRICAR.
config.gweapon1 = { "wbodyWEAPON_ASSAULTRIFLE_MK2", 1 }
config.gweapon2 = { "wbodyWEAPON_COMPACTRIFLE", 1 }
config.gweapon3 = { "wbodyWEAPON_MICROSMG", 1 }
config.gweapon4 = { "wbodyWEAPON_REVOLVER_MK2", 1 }
config.gweapon5 = { "wbodyWEAPON_COMBATPISTOL", 1 }

--[ CONFIGURAÇÃO DA ANIMAÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- ANIMAÇÃO PARA MONTAR A MUNICAO
config.anim = { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }

-- TEMPO PARA REALIZAR A ANIMAÇÃO E PRODUZIR A MUNICAO.
config.time = 10000 -- 10 segundos

--[ CONFIGURAÇÃO DA NUI ]-------------------------------------------------------------------------------------------------------------------------
---- SOMENTE SE ALTERAR ALGO NO BUTTON CLICK DO HTML.

config.button1 = "produzir-m-ak47"
config.button2 = "produzir-m-ak74u"
config.button3 = "produzir-m-uzi"
config.button4 = "produzir-m-magnum44"
config.button5 = "produzir-m-glock"
