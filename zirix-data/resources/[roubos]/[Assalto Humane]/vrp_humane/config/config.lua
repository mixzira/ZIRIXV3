config = {}

--[ CONFIGURAÇÃO INICIAL DO ROUBO ]-------------------------------------------------------------------------------------------------------------------------

-- Localização do hackeamento para inciar o roubo.
config.start = { 3611.11, 3728.08, 29.69 }

-- Item necessario para roubar e quantidade (NAO CONSUMIVEL)
config.need = { "celular", 1 }
config.need1 = { "celular-pro", 1 }

-- Notify caso nao tenha o item.
config.nnotify = "Precisa de um <b>Celular</b> para hackear."

-- Inicio da Notify quando inicia o roubo. (Mostra no chat geral)
config.snotify = "[DIAMOND] Laboratório Humane:"

-- Permissao para não conseguir roubar. (policiais e ems)
config.permission1 = "policia.permissao"
config.permission2 = "paramedico.permissao"
config.permission3 = "paisanapolicia.permissao"
config.permission4 = "paisanaparamedico.permissao" 

-- Permissao para ser notificado quando acontecer o roubo. (Policia)
config.permission = "policia.permissao"

-- Quantidade minima para acontecer o roubo. (Policia)
config.qtdpolice = -1

-- Tempo para roubar novamente.
config.time = 21600 -- 6 horas

--[ SPAWN NPC ]-------------------------------------------------------------------------------------------------------------------------

-- Distancia que o NPC vai dar spawn.
config.security = 50

-- Local de medição para o config.security.
config.securitypoint = { 3619.98, 3743.32, 28.7 }

-- Skin do NPC.
config.skin = "s_m_m_security_01"    ---Segurança

-- Arma do NPC.
config.weapon = "WEAPON_COMBATPISTOL"

-- Vida do NPC
config.health = 200

-- Colete do NPC
config.armour = 100

-- Local de spawn dos NPCs
config.spawn = {
	[1] = { ['x'] = 3612.76, ['y'] = 3720.9, ['z'] = 29.69 },
	[2] = { ['x'] = 3611.66, ['y'] = 3721.77, ['z'] = 29.69 },
	[3] = { ['x'] = 3609.8, ['y'] = 3712.92, ['z'] = 29.69 },
	[4] = { ['x'] = 3600.96, ['y'] = 3705.5, ['z'] = 29.69 },
	[5] = { ['x'] = 3599.21, ['y'] = 3717.51, ['z'] = 29.69 },
	[6] = { ['x'] = 3601.1, ['y'] = 3727.3, ['z'] = 29.69 },
	[7] = { ['x'] = 3593.3, ['y'] = 3707.13, ['z'] = 29.69 },
	[8] = { ['x'] = 3595.52, ['y'] = 3694.35, ['z'] = 28.83 },
	[9] = { ['x'] = 3591.59, ['y'] = 3678.09, ['z'] = 27.63 },
	[10] = { ['x'] = 3571.52, ['y'] = 3693.61, ['z'] = 27.25 },
	[11] = { ['x'] = 3558.42, ['y'] = 3683.4, ['z'] = 28.13 },
	[12] = { ['x'] = 3554.96, ['y'] = 3666.5, ['z'] = 28.13 },
	[13] = { ['x'] = 3546.48, ['y'] = 3644.33, ['z'] = 28.13 },
	[14] = { ['x'] = 3527.44, ['y'] = 3651.16, ['z'] = 27.53 },
	[15] = { ['x'] = 3530.92, ['y'] = 3668.48, ['z'] = 28.13 },
}

--[ CONFIGURAÇÕES ROUBO ]-------------------------------------------------------------------------------------------------------------------------

-- Tempo levado para roubar cada armario.
config.timerob = 10000 -- = 10 segundos

-- Animação realizada para roubar.
config.anim = "mini@repair","fixing_a_player"

--[ ITEM GANHO AO ROUBAR ]-------------------------------------------------------------------------------------------------------------------------
-- Localização dos armarios, item ganho, e quantidade do item quando roubado.

config.itens = {
    [1] = { ['x'] = 3559.38, ['y'] = 3672.16, ['z'] = 28.13, ['item'] = "cocaina", ['qtd'] = 7 },
	[2] = { ['x'] = 3559.83, ['y'] = 3674.53, ['z'] = 28.13, ['item'] = "lsd", ['qtd'] = 8 },
	[3] = { ['x'] = 3539.33, ['y'] = 3659.52, ['z'] = 28.13, ['item'] = "metanfetamina", ['qtd'] = 3 },
	[4] = { ['x'] = 3535.09, ['y'] = 3660.52, ['z'] = 28.13, ['item'] = "pasta-base", ['qtd'] = 75 },
	[5] = { ['x'] = 3534.86, ['y'] = 3662.96, ['z'] = 28.13, ['item'] = "ergolina", ['qtd'] = 75 },
	[6] = { ['x'] = 3537.71, ['y'] = 3660.11, ['z'] = 28.13, ['item'] = "calcio-po", ['qtd'] = 75 },
	[7] = { ['x'] = 3539.21, ['y'] = 3668.16, ['z'] = 28.13, ['item'] = "folhas-coca", ['qtd'] = 75 },
	[8] = { ['x'] = 3562.71, ['y'] = 3672.06, ['z'] = 28.13, ['item'] = "pseudoefedrina", ['qtd'] = 73 },
	[9] = { ['x'] = 3562.71, ['y'] = 3672.06, ['z'] = 28.13, ['item'] = "dinheiro", ['qtd'] = 57000 },
}

--[ CONFIGURAÇÃO WEBHOOK ]-------------------------------------------------------------------------------------------------------------------------

-- Link do webhook.
config.webhookhumane = "https://discord.com/api/webhooks/808806409100984320/F-oBlSLWpZmZ5AHkjQ_bRG3Gg8KAr1J9v3umBiBGEuFi_CxBVLOmCxQEOlERAZOsgEBP"

-- link da imagem.
config.image = "https://i.imgur.com/CtQB816.png"