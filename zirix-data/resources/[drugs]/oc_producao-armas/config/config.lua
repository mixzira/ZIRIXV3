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
