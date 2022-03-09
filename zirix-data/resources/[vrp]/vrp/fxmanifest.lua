fx_version 'adamant'
game 'gta5'

ui_page 'gui/index.html'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'lib/utils.lua',
	'base.lua',
	'queue.lua',
	'zirix/*',
	'modules/*'
}

client_scripts {
	'lib/utils.lua',
	'zirix/*',
	'client/*',
}

files {
	'lib/Tunnel.lua',
	'lib/Proxy.lua',
	'lib/Luaseq.lua',
	'lib/Tools.lua',
	'gui/*',
}

server_export 'AddPriority'
server_export 'RemovePriority'