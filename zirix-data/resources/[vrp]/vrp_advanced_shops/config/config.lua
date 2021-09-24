config = {}

--[[
	ATENÇÃO!!!
	1. Caso utilize o serviço de Straming de imagens da ZIRAFLIX, solicite via Ticket a ativação do seu serviço, para receber o endereçamento da sua rede de streaming;
	2. Caso NÃO utilize, insira abaixo o IP da sua maquina e/ou serviço de images, seguindo do diretório. Exemplo: "127.0.0.1:3355/images".
]]


config.imageService = '191.96.79.96:3358/ziraflix-images-service/319321727630835712'

config.webhook = ''

config.webhookBottomText = 'ZIRIX V3 BY ZIRAFLIX - '
config.webhookIcon = 'https://i.imgur.com/Y5Zktwm.png'
config.webhookColor = 16431885

config.policePermission = 'policia.permissao'
config.contingentPolice = 2
config.requireBomb = false
config.bombName = "c4"
config.bombAmount = 1

config.shops = { 
    ['shop1'] = {
        ['info'] = { ['name'] = 'Mercado', ['id'] = 52, ['color'] = 4, ['x'] = 31.49, ['y'] = -1340.86, ['z'] = 29.5 },
        ['coords'] = {
            { ['x'] = 25.66, ['y'] = -1344.98, ['z'] = 29.5 },
            { ['x'] = 25.68, ['y'] = -1347.28, ['z'] = 29.5 }
        },
        ['purchase'] = { ['x'] = 29.59, ['y'] = -1339.56, ['z'] = 29.5 },
        ['vault'] = {
            ['position'] = { ['x'] = 28.2, ['y'] = -1339.19, ['z'] = 29.5, ['h'] = 358.54, ['x2'] = 28.21, ['y2'] = -1339.52, ['z2'] = 29.5 },
            ['limit'] = 200000
        },
        ['security'] = 1,
        ['stock'] = {
            ['sanduiche'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['rosquinha'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['hotdog'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['xburguer'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['chips'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['batataf'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['pizza'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['taco'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['agua'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['cola'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['sprunk'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['energetico'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['leite'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['barracho'] = { ['amount'] = 0, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['patriot'] = { ['amount'] = 0, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['pibwassen'] = { ['amount'] = 0, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false }
        },
        ['maxstock'] = 100,
        ['price'] = 1958000,
        ['robbery'] = { 50000, 10000 },
        ['forsale'] = true
    },
}

config.options = {
    ['stock-medium'] = { ['name'] = 'Estoque médio', ['price'] = 100000, ['description'] = 'Uma capacidade de produtos maior para o seu estabelecimento.', ['stock'] = 200 },
    ['stock-large'] = { ['name'] = 'Estoque grande', ['price'] = 200000, ['description'] = 'Uma capacidade de produtos maior para o seu estabelecimento.', ['stock'] = 300 },
    ['stock-elarge'] = { ['name'] = 'Estoque extra grande', ['price'] = 1200000, ['description'] = 'Uma capacidade de produtos maior para o seu estabelecimento.', ['stock'] = 500 },
    ['security-medium'] = { ['name'] = 'Segurança média', ['price'] = 600000, ['description'] = 'Segurança nunca é demais! Garanta um cofre reforçado.', ['security'] = 2 },
    ['security-high'] = { ['name'] = 'Segurança alta', ['price'] = 1200000, ['description'] = 'Segurança nunca é demais! Garanta um cofre reforçado e cameras de vigilancia.', ['security'] = 3 }
}