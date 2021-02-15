config = { }

--[ CONFIGURAÇÃO INICIAL DA PRODUÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- LOCAL ONDE FICA A MAQUINA DE PRODUÇÃO.
config.prodMachine = {
    [1] = { ['x'] = 610.38, ['y'] = -3092.68, ['z'] = 6.07 },
}

-- PERMISSÕES PARA ACESSAR A MAQUINA.
-- Minimo: 1 - Maximo: 5
config.permissionMachine = {   
    "manager.permissao",
}

--[ CONFIGURAÇÃO DA PRODUÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- ITENS NECESSARIOS PARA CADA DROGA.
-- ITEM,QUANTIDADE
config.lowquant = { "ergolina",1, "calcio-po",10, "plastico",5 }
config.medquant = { "ergolina",2, "calcio-po",15, "plastico",10 }
config.highquant = { "ergolina",3, "calcio-po",20, "plastico",15 }

-- INDEX DA DROGA e QUANTIDADE PARA ADICIONAR AO INVENTARIO APÓS FABRICAR.
config.glowquant = { "lsd", 5 }
config.gmedquant = { "lsd", 10 }
config.ghighquant = { "lsd", 15 }

--[ CONFIGURAÇÃO DA ANIMAÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- ANIMAÇÃO PARA FAZER A DROGA
config.anim = { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }

-- TEMPO PARA REALIZAR A ANIMAÇÃO E PRODUZIR A DROGA.
config.time = 10000 -- 10 segundos

--[ CONFIGURAÇÃO DA NUI ]-------------------------------------------------------------------------------------------------------------------------
---- SOMENTE SE ALTERAR ALGO NO BUTTON CLICK DO HTML.

config.button1 = "lsd-baixa"
config.button2 = "lsd-media"
config.button3 = "lsd-alta"


-- DROGA A SER FABRICADOS.
config.lsd = {
    "lsd-baixa",  -- BAIXA QUANTIDADE
	"lsd-media",  -- MEDIA QUANTIDADE
	"lsd-alta",  -- ALTA QUANTIDADE
}
