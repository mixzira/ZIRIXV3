fx_version 'adamant'
game 'gta5'

ui_page "nui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"hansolo/*.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"skywalker.lua"
}

files {
    "nui/*.html",
	"nui/*.js",
	"nui/*.png",
	"nui/*.css",
	"nui/*.js",
    "nui/**/*.css",
    "nui/**/*.png",
    "nui/**/*"
}
