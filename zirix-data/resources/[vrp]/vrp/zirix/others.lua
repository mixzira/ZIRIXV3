local cfg = {}

cfg.gaptitudes = {
	["physical"] = {
		_title = "Mochila",
		["strength"] = { "Forca",20,1900 }
	}
}

cfg.db = {
	driver = "ghmattimysql",
	host = "127.0.0.1",
	database = "zirix",
	user = "root",
	password = ""
}

cfg.default_customization = {
	model = "mp_m_freemode_01"
}

for i=0,19 do
	cfg.default_customization[i] = { 1,0 }
end

cfg.text = {"\"",false}
cfg.name = {"\"[]{}+=?!_()#@%0123456789/\\|",false}
cfg.homename = { "abcdefghijklmnopqrstuvwxyz",true }
cfg.business_name = {"\"[]{}+=?!_#",false}

return cfg