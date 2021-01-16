config = {}

config.imageServer = '' -- Deixe vazio caso você ultilize o serviço de straming de imagens da ZIRAFLIX;

config.webhook = ''

config.webhookBottomText = 'ZIRIX V3 BY ZIRAFLIX - '
config.webhookIcon = 'https://i.imgur.com/Y5Zktwm.png'
config.webhookColor = 16431885

config.shops = { 
    ['shop1'] = {
        ['info'] = { 
            ['name'] = 'Mercado', 
            ['id'] = 52, 
            ['color'] = 2,
        },
        ['coords'] = {
            { ['x'] = 25.66, ['y'] = -1344.98, ['z'] = 29.5 },
            { ['x'] = 25.68, ['y'] = -1347.28, ['z'] = 29.5 },
            { ['x'] = 29.55, ['y'] = -1339.53, ['z'] = 29.5 }
        },
        ['purchase'] = { ['x'] = 29.59, ['y'] = -1339.56, ['z'] = 29.5 },
        ['vault'] = {
            ['position'] = { ['x'] = 28.2, ['y'] = -1339.19, ['z'] = 29.5 },
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
            ['barracho'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['patriot'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false },
            ['pibwassen'] = { ['amount'] = 100, ['price'] = 30, ['require'] = nil, ['gunlicense'] = false }
        },
        ['maxstock'] = 100,
        ['price'] = 1958000,
        ['forsale'] = true
    }
}

config.options = {
    ['stock-medium'] = { ['name'] = 'Estoque médio', ['price'] = 100000, ['description'] = 'Uma capacidade de produtos maior para o seu estabelecimento.', ['stock'] = 200 },
    ['stock-large'] = { ['name'] = 'Estoque grande', ['price'] = 200000, ['description'] = 'Uma capacidade de produtos maior para o seu estabelecimento.', ['stock'] = 300 },
    ['stock-elarge'] = { ['name'] = 'Estoque extra grande', ['price'] = 1200000, ['description'] = 'Uma capacidade de produtos maior para o seu estabelecimento.', ['stock'] = 500 },
    ['security-medium'] = { ['name'] = 'Segurança média', ['price'] = 600000, ['description'] = 'Segurança nunca é demais! Garanta um cofre reforçado.', ['security'] = 2 },
    ['security-high'] = { ['name'] = 'Segurança alta', ['price'] = 1200000, ['description'] = 'Segurança nunca é demais! Garanta um cofre reforçado e cameras de vigilancia.', ['security'] = 3 }
}