fx_version 'bodacious'
game 'gta5'

ui_page 'html/index.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'cl_chat.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'sv_chat.lua'
}

files {
	'html/index.html',
	'html/index.css',
	'html/config.default.js',
	'html/config.js',
	'html/App.js',
	'html/Message.js',
	'html/vendor/vue.2.3.3.min.js',
	'html/vendor/flexboxgrid.6.3.1.min.css',
	'html/vendor/animate.3.5.2.min.css'
}