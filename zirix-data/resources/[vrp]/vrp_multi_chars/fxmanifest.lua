fx_version 'cerulean'
game 'gta5'

author 'ZIRAFLIX'
contact 'Website: https://www.ziraflix.com.br - E-mail: contato@ziraflix.com - Discord: https://ziraflix.com.br/discord'

ui_page 'interface/darkside.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'config/*',
	'client/*'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'config/*',
	'server/*'
}

files {
	'interface/*',
	'interface/**/*'
}