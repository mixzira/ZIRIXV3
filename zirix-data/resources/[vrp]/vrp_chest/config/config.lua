config = {}

--[[
	ATENÇÃO!!!
	1. Caso utilize o serviço de Straming de imagens da ZIRAFLIX, solicite via Ticket a ativação do seu serviço, para receber o endereçamento da sua rede de streaming;
	2. Caso NÃO utilize, insira abaixo o IP da sua maquina e/ou serviço de images, seguindo do diretório. Exemplo: "127.0.0.1:3355/images".
]]

config.imageService = '' 

config.webhookBottomText = 'CLEAN TWO - '
config.webhookIcon = 'https://i.imgur.com/CtQB816.png'
config.webhookColor = 16431885

config.policePermission = 'policia.permissao'

config.chest = {
	['teste'] = { ['x'] = 26.68, ['y'] = -1352.85, ['z'] = 29.34, ['weight'] = 20, ['slots'] = 6, ['perm'] = 'ems.permissao', ['webhook'] = '' },
    ['ems'] = { ['x'] = -453.53, ['y'] = -308.39, ['z'] = 34.92, ['weight'] = 5000, ['slots'] = 500, ['perm'] = 'ems.permissao', ['webhook'] = '' },
	['policia-arsenal'] = { ['x'] = -1098.8, ['y'] = -825.99, ['z'] = 14.29, ['weight'] = 5000, ['slots'] = 500, ['perm'] = 'policia.permissao', ['webhook'] = '' },
	['policia-evidencias'] = { ['x'] = -1074.87, ['y'] = -821.42, ['z'] = 11.04, ['weight'] = 5000, ['slots'] = 500, ['perm'] = 'policia.permissao', ['webhook'] = '' },
	['orgdone-factory'] = { ['x'] = 449.77, ['y'] = -1975.58, ['z'] = 17.29, ['weight'] = 1000, ['slots'] = 100, ['perm'] = 'orgdone.permissao', ['webhook'] = '' },
	['orgdtwo-factory'] = { ['x'] = 2523.88, ['y'] = 4118.89, ['z'] = 31.47, ['weight'] = 1000, ['slots'] = 100, ['perm'] = 'orgdtwo.permissao', ['webhook'] = '' },
	['orgdthree-factory'] = { ['x'] = 560.85, ['y'] = 2670.75, ['z'] = 35.05, ['weight'] = 1000, ['slots'] = 100, ['perm'] = 'orgdthree.permissao', ['webhook'] = '' },
	['orgdfour-factory'] = { ['x'] = 800.05, ['y'] = -100.66, ['z'] = 74.92, ['weight'] = 1000, ['slots'] = 100, ['perm'] = 'orgdfour.permissao', ['webhook'] = '' },
	['orgdfive-factory'] = { ['x'] = 148.84, ['y'] = -1708.25, ['z'] = 22.21, ['weight'] = 1000, ['slots'] = 100, ['perm'] = 'orgdfive.permissao', ['webhook'] = '' },
	['orgdsix-factory'] = { ['x'] = -150.37, ['y'] = 6293.06, ['z'] = 24.58, ['weight'] = 1000, ['slots'] = 100, ['perm'] = 'orgdsix.permissao', ['webhook'] = '' },
	['orggone-factory'] = { ['x'] = 1397.65, ['y'] = 1139.13, ['z'] = 109.75, ['weight'] = 1000, ['slots'] = 100, ['perm'] = 'orggone.permissao', ['webhook'] = '' },
	['orggone-base'] = { ['x'] = 1403.24, ['y'] = 1152.4, ['z'] = 114.34, ['weight'] = 2000, ['slots'] = 200, ['perm'] = 'orggone.permissao', ['webhook'] = '' },
	['orggtwo-factory'] = { ['x'] = 2854.57, ['y'] = 4448.12, ['z'] = 41.33, ['weight'] = 1000, ['slots'] = 100, ['perm'] = 'orggtwo.permissao', ['webhook'] = '' },
	['orgmone-base'] = { ['x'] = 378.97, ['y'] = 258.34, ['z'] = 92.2, ['weight'] = 3000, ['slots'] = 300, ['perm'] = 'orgmone.permissao', ['webhook'] = '' },
	['orgmtwo-base'] = { ['x'] = 732.26, ['y'] = -795.21, ['z'] = 18.08, ['weight'] = 3000, ['slots'] = 300, ['perm'] = 'orgmtwo.permissao', ['webhook'] = '' },
	['orgmthree-base'] = { ['x'] = 93.19, ['y'] = -1291.4, ['z'] = 29.27, ['weight'] = 3000, ['slots'] = 300, ['perm'] = 'orgmthree.permissao', ['webhook'] = '' },
	['lscustoms-bau'] = { ['x'] = -344.75, ['y'] = -128.05, ['z'] = 39.01, ['weight'] = 2000, ['slots'] = 200, ['perm'] = 'mecanico.permissao', ['webhook'] = '' }
}