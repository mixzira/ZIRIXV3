Citizen.CreateThread(function()
	LoadInterior(GetInteriorAtCoords(440.84,-983.14,30.69))
	for _,ipl in pairs(allIpls) do
		loadInt(ipl.coords,ipl.interiorsProps)
	end
end)

function loadInt(coordsTable,table)
	for _,coords in pairs(coordsTable) do
		local interiorID = GetInteriorAtCoords(coords[1],coords[2],coords[3])
		LoadInterior(interiorID)
		for _,propName in pairs(table) do
			Citizen.Wait(10)
			EnableInteriorProp(interiorID,propName)
		end
		RefreshInterior(interiorID)
	end
end

allIpls = {
	{
		interiorsProps = {
			"set_vault_wall_damagedxd",
			"set_vault_door_broken"
		},
		coords = {{ 2488.348, -267.3637, -71.64563 }}
	},
	{
		interiorsProps = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = {{ -1150.7,-1520.7,10.6 }}
	},
	{
		interiorsProps = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = {{ -47.1,-1115.3,26.5 }}
	},
	{
		interiorsProps = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = {{ -802.3,175.0,72.8 }}
	},
	{
		interiorsProps = {
			"meth_lab_basic",
			"meth_lab_production",
			"meth_lab_setup"
		},
		coords = {{ 1009.5,-3196.6,-38.9 }} -- Metanfetamina
	},
	{
		interiorsProps = {
			"security_high",
			"equipment_basic",
			"equipment_upgrade",
			"production_upgrade",
			"table_equipment_upgrade",
			"coke_press_upgrade",
			"security_low",
			"set_up"
		},
		coords = {{ 1093.6,-3196.6,-38.9 }} -- Cocaina
	},
	{
		interiorsProps = {
			"counterfeit_cashpile100a",
			"counterfeit_cashpile100b",
			"counterfeit_cashpile100c",
			"counterfeit_cashpile100d",
			"counterfeit_security",
			"counterfeit_setup",
			"counterfeit_standard_equip",
			"money_cutter",
			"special_chairs",
			"dryera_on",
			"dryerb_on",
			"dryerc_on",
			"dryerd_on"
		},
		coords = {{ 1121.0,-3196.0,-40.4 }} -- Lavagem
	},
	{
		interiorsProps = {
			"coke_stash1",
			"coke_stash2",
			"coke_stash3",
			"decorative_02",
			"furnishings_02",
			"walls_01",
			"mural_02",
			"gun_locker",
			"mod_booth"
		},
		coords = {{ 1107.0,-3157.3,-37.5 }} -- Motoclub
	},
	{
		interiorsProps = {
			"coke_large",
			"decorative_01",
			"furnishings_01",
			"walls_01",
			"lower_walls_default",
			"gun_locker",
			"mod_booth"
		},
		coords = {{ 998.4,-3164.7,-38.9 }} -- Motoclub2
	},
	{
		interiorsProps = {
			"chair01",
			"equipment_basic",
			"interior_upgrade",
			"security_low",
			"set_up"
		},
		coords = {{ 1163.8,-3195.7,-39.0 }} -- Escritório
	},
	{
		interiorsProps = {
			"garage_decor_01",
			"garage_decor_02",
			"garage_decor_03",
			"garage_decor_04",
			"lighting_option01",
			"lighting_option02",
			"lighting_option03",
			"lighting_option04",
			"lighting_option05",
			"lighting_option06",
			"lighting_option07",
			"lighting_option08",
			"lighting_option09",
			"numbering_style01_n3",
			"numbering_style02_n3",
			"numbering_style03_n3",
			"numbering_style04_n3",
			"numbering_style05_n3",
			"numbering_style06_n3",
			"numbering_style07_n3",
			"numbering_style08_n3",
			"numbering_style09_n3",
			"urban_style_set",
			"car_floor_hatch",
			"door_blocker"
		},
		coords = {{ 994.59,-3002.59,-39.64 }} -- Mecanica
	},
	{
		interiorsProps = {
			"bunker_style_a",
			"upgrade_bunker_set",
			"security_upgrade",
			"office_upgrade_set",
			"gun_wall_blocker",
			"gun_range_lights",
			"gun_locker_upgrade",
			"Gun_schematic_set"
		},
		coords = {{ 899.55,-3246.03,-98.04 }} -- Bunker
	},
	{
		interiorsProps = {
			"Int01_ba_clubname_01",
	        "Int01_ba_Style03",
	        "Int01_ba_style03_podium",
	        "Int01_ba_equipment_setup",
	        "Int01_ba_equipment_upgrade",
	        "Int01_ba_security_upgrade",
	        "Int01_ba_dj04",
	        "DJ_01_Lights_01",
	        "DJ_02_Lights_01",
	        "DJ_03_Lights_01",
	        "DJ_04_Lights_01",
	        "Int01_ba_bar_content",
	        "Int01_ba_booze_03",
	        "Int01_ba_trophy01",
	        "Int01_ba_Clutter",
	        "Int01_ba_deliverytruck",
	        "Int01_ba_dry_ice",
	        "light_rigs_off",
	        "Int01_ba_lightgrid_01",
	        "Int01_ba_trad_lights",
	        "Int01_ba_trophy04",
	        "Int01_ba_trophy05",
	        "Int01_ba_trophy07",
	        "Int01_ba_trophy08",
	        "Int01_ba_trophy09",
	        "Int01_ba_trophy10",
	        "Int01_ba_trophy11",
	        "Int01_ba_booze_01",
			"Int01_ba_booze_02",
			"Int01_ba_booze_03",
			"int01_ba_lights_screen",
			"Int01_ba_bar_content"
        },
		coords = {{ -1604.664, -3012.583, -78.00 }} -- Galaxy
	}
}