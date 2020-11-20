local cfg = {}

cfg.text = {"\"",false}
cfg.name = {"\"[]{}+=?!_()#@%0123456789/\\|",false}
cfg.homename = { "abcdefghijklmnopqrstuvwxyz",true }
cfg.business_name = {"\"[]{}+=?!_#",false}

return cfg