local cfg = {}

cfg.default_customization = {
	model = "mp_m_freemode_01"
}

for i=0,19 do
	cfg.default_customization[i] = { 1,0 }
end

return cfg