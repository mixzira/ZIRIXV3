config = { }

--[ CONFIGURAÇÃO INICIAL DA PRODUÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- LOCAL ONDE FICA A MAQUINA DE PRODUÇÃO.
config.prodMachine = {
    [1] = { ['x'] = 612.8, ['y'] = -3091.26, ['z'] = 6.07 },
}

-- PERMISSÕES PARA ACESSAR A MAQUINA.
-- Minimo: 1 - Maximo: 5
config.permissionMachine = {   
    "manager.permissao",
}

--[ CONFIGURAÇÃO DA PRODUÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- ITENS NECESSARIOS PARA CADA DROGA.
-- ITEM,QUANTIDADE
config.lowquant = { "pseudoefedrina",1, "nitrato-amonia",10, "plastico",5 }
config.medquant = { "pseudoefedrina",2, "nitrato-amonia",15, "plastico",10 }
config.highquant = { "pseudoefedrina",3, "nitrato-amonia",20, "plastico",15 }

-- INDEX DA DROGA e QUANTIDADE PARA ADICIONAR AO INVENTARIO APÓS FABRICAR.
config.glowquant = { "metanfetamina", 5 }
config.gmedquant = { "metanfetamina", 10 }
config.ghighquant = { "metanfetamina", 15 }

--[ CONFIGURAÇÃO DA ANIMAÇÃO ]-------------------------------------------------------------------------------------------------------------------------

-- ANIMAÇÃO PARA FAZER A DROGA
config.anim = { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }

-- TEMPO PARA REALIZAR A ANIMAÇÃO E PRODUZIR A DROGA.
config.time = 10000 -- 10 segundos

--[ CONFIGURAÇÃO DA NUI ]-------------------------------------------------------------------------------------------------------------------------
---- SOMENTE SE ALTERAR ALGO NO BUTTON CLICK DO HTML.

config.button1 = "meta-baixa"
config.button2 = "meta-media"
config.button3 = "meta-alta"

-- DROGA A SER FABRICADOS.
config.meta = {
    "meta-baixa",  -- BAIXA QUANTIDADE
	"meta-media",  -- MEDIA QUANTIDADE
	"meta-alta",  -- ALTA QUANTIDADE
}
