fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'Lucas Carvalho'
contact 'https://github.com/almcarvalho'

ui_page('interface/darkside.html')

client_scripts {
	'client/*'
}

server_scripts {
    'index.js'
}

files {
    'interface/*',
    'app/*',
    'app/**/*'
}

dependencies {
    '/server:4890',
    'yarn'
}