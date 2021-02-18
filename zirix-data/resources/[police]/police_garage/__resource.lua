resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "nui/ui.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client.lua",
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua",
}

files {
	"nui/assets/css/bootstrap.min.css",
	"nui/assets/css/style.css",
	"nui/ui.html",
	"nui/ui.js",
	"nui/img/carros/*",
}