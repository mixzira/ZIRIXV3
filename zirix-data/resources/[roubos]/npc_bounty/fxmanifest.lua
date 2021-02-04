fx_version 'bodacious'
games { 'gta5' }

author 'Erratic'
description 'npc_bounty'
version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'config.lua',
    'client/npc_bounty_cl.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'config.lua',
    'server/npc_bounty_sv.lua'
}




