fx_version 'bodacious'
game 'gta5'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/static/css/app.css',
	'html/static/js/app.js',
	'html/static/js/manifest.js',
	'html/static/js/vendor.js',
	'html/static/config/config.json',
	-- Coque
	'html/static/img/**/*',
	'html/static/img/*',
	
	'html/static/fonts/fontawesome-webfont.ttf',

	'html/static/sound/Twitter_Sound_Effect.ogg',
	'html/static/sound/ring.ogg',
	'html/static/sound/ring2.ogg',
	'html/static/sound/tchatNotification.ogg',
	'html/static/sound/Phone_Call_Sound_Effect.ogg'
}

client_script {
	'@vrp/lib/utils.lua',
	'config.lua',
	'client/animation.lua',
	'client/client.lua',
	'client/photo.lua',
	'client/app_tchat.lua',
	'client/instagram.lua',
	'client/bank.lua',
	'client/twitter.lua'
}

server_script {
	'@vrp/lib/utils.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/server.lua',
	'server/app_tchat.lua',
	'server/instagram.lua',
	'server/twitter.lua'
}
