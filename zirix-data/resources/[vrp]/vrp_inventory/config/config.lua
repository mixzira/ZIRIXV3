config = {}

--[[
	ATENÇÃO!!!
	1. Caso utilize o serviço de Straming de imagens da ZIRAFLIX, solicite via Ticket a ativação do seu serviço, para receber o endereçamento da sua rede de streaming;
	2. Caso NÃO utilize, insira abaixo o IP da sua maquina e/ou serviço de images, seguindo do diretório. Exemplo: "127.0.0.1:3355/images".
]]

config.imageService = '191.96.79.96:3358/ziraflix-images-service/319321727630835712'

config.openKey = 'OEM_3' -- "

config.webhookDrop = ''
config.webhookSend = ''
config.webhookEquip = ''
config.webhookUnequip = ''

config.webhookIcon = 'https://i.imgur.com/CtQB816.png'
config.webhookBottomText = 'DIAMOND CITY - '
config.webhookColor = 16431885
 
config.equipBackpack = false

config.item = {
    ['cafe'] = { 'amb@world_human_aa_coffee@idle_a', 'idle_a', 'prop_fib_coffee', 'Tomando', -70, 0 }
}