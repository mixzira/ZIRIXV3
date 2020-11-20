local cfg = {}

local surgery_male = { model = "mp_m_freemode_01" }
local surgery_female = { model = "mp_f_freemode_01" }
local travesti1 = { model = "a_m_m_tranvest_01" }
local travesti2 = { model = "a_m_m_tranvest_02" }
local gogoboy = { model = "u_m_y_staggrm_01" }
local deus = { model = "u_m_m_jesus_01" }
local padre = { model = "cs_priest" }
local pegrande = { model = "cs_orleans" }
local gato = { model = "a_c_cat_01" }
local pug = { model = "a_c_pug" }
local lessie = { model = "a_c_shepherd" }
local poodle = { model = "a_c_westy" }
local onca = { model = "a_c_mtlion" }
local chop = { model = "a_c_chop" }
local macaco = { model = "a_c_chimp" }

for i=0,19 do
	surgery_female[i] = { 1,0 }
	surgery_male[i] = { 1,0 }
end

cfg.cloakroom_types = {
	["Personagem"] = {
		_config = {permissions={"admin.permissao"}},
		["Travesti 1"] = travesti1,
		["Travesti 2"] = travesti2,
		["Gogoboy"] = gogoboy,
		["Deus"] = deus,
		["Padre"] = padre,
		["Pé Grande"] = pegrande,
		["Gato"] = gato,
		["Pug"] = pug,
		["Lessie"] = lessie,
		["Poodle"] = poodle,
		["Onça"] = onca,
		["Chop"] = chop,
		["Macaco"] = macaco
	}
}

cfg.cloakrooms = {
	{ "Personagem",206.82,-1002.02,29.29 }
}

return cfg