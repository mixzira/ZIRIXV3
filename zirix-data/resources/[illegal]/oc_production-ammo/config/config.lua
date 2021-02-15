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

-- ITENS NECESSARIOS PARA MUNICAO.
-- ITEM,QUANTIDADE
config.weapon1 = { "capsulas",30, "polvora",30 }
config.weapon2 = { "capsulas",30, "polvora",20 }
config.weapon3 = { "capsulas",30, "polvora",15 }
config.weapon4 = { "capsulas",6, "polvora",6 }
config.weapon5 = { "capsulas",12, "polvora",6 }

-- INDEX DA MUNICAO e QUANTIDADE PARA ADICIONAR AO INVENTARIO APÓS FABRICAR.
config.gweapon1 = { "wammoWEAPON_ASSAULTRIFLE_MK2", 30}
config.gweapon2 = { "wammoWEAPON_COMPACTRIFLE", 30 }
config.gweapon3 = { "wammoWEAPON_MICROSMG", 30 }
config.gweapon4 = { "wammoWEAPON_REVOLVER_MK2", 6 }
config.gweapon5 = { "wammoWEAPON_COMBATPISTOL", 12 }

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

-- MUNICAO A SEREM FABRICADOS.
config.weapons = {
    "m-ak47",
	"m-ak74u",
	"m-uzi",
	"m-magnum44",
	"m-glock"
}
