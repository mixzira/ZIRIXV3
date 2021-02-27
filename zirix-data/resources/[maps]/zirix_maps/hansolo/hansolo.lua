Citizen.CreateThread(function()
	RequestIpl("kambi_canyon_milo_")
	
-- Canyonhouse
	local interiorid = GetInteriorAtCoords(-2797.70800000,1434.52700000,99.68897000)

	RefreshInterior(interiorid)
	
end)


Citizen.CreateThread(function()
	RequestIpl("gabz_pillbox_milo_")
	local interiorID = GetInteriorAtCoords(311.2546, -592.4204, 42.32737)
	local int = {}
	Wait(10000)
	for i = 1, #int, 1 do
		if IsIplActive(int[i]) then
			RemoveIpl(int[i])
		end
	end
	RefreshInterior(interiorID)
	LoadInterior(interiorID)
end)

local int_arcade1 = GetInteriorAtCoordsWithType(743.26500000,-816.71220000,21.66042000,"int_arcade")
local int_plan1 = GetInteriorAtCoordsWithType(710.87930000,-813.11000000,15.19892000,"int_plan")

RefreshInterior(int_arcade1)
RefreshInterior(int_plan1)

DisableInteriorProp(int_arcade1, "entity_set_arcade_set_ceiling_flat") --blue shell
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_ceiling_beams") --brick
EnableInteriorProp(int_arcade1, "entity_set_screens") -- TV sets
EnableInteriorProp(int_arcade1, "entity_set_big_screen") -- big telly
EnableInteriorProp(int_arcade1, "entity_set_constant_geometry") -- glass shelves + bar
EnableInteriorProp(int_arcade1, "entity_set_ret_light_no_neon")
EnableInteriorProp(int_arcade1, "ch_chint02_00_dropped_ceiling")
EnableInteriorProp(int_arcade1, "entity_set_hip_light_no_neon")
EnableInteriorProp(int_arcade1, "arcade_bar")
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_streetx4") --assault rifles
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_ceiling_mirror") --mirror ceiling

DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict_carpet") -- carpets
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict") --dirty shell
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict") --mud
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict_clean_up") --dirt
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict_clean_up") -- closed vending machines

EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_claw")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_monkey")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_patriot")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_retro")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_brawler")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_racer")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_love")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_cabs")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_gunner") --no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_teller")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_king") --no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_strife") --no

EnableInteriorProp(int_arcade1, "entity_set_plushie_01")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_02")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_03")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_04")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_05")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_06")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_07")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_08") -- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_09")-- a toy

DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_01") --signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_02")--signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_03")--signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_04")--signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_05")--signboard
EnableInteriorProp(int_arcade1, "entity_set_mural_neon_option_06")--signboard
EnableInteriorProp(int_arcade1, "entity_set_mural_neon_option_07")--signboard
EnableInteriorProp(int_arcade1, "entity_set_mural_neon_option_08")--signboard

DisableInteriorProp(int_arcade1, "entity_set_mural_option_01") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_02") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_03") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_04") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_05") --wall paint
EnableInteriorProp(int_arcade1, "entity_set_mural_option_06") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_07") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_08") --wall paint

DisableInteriorProp(int_arcade1, "entity_set_floor_option_01") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_02") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_03") --painted floor
EnableInteriorProp(int_arcade1, "entity_set_floor_option_04") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_05") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_06") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_07") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_08")--painted floor

EnableInteriorProp(int_plan1, "set_plan_casino") --casino on the table
EnableInteriorProp(int_plan1, "set_plan_computer") --comp
EnableInteriorProp(int_plan1, "set_plan_keypad")

EnableInteriorProp(int_plan1, "set_plan_hacker")
EnableInteriorProp(int_plan1, "set_plan_mechanic")
EnableInteriorProp(int_plan1, "set_plan_weapons")

EnableInteriorProp(int_plan1, "set_plan_vault")
EnableInteriorProp(int_plan1, "set_plan_wall") --stone wall
EnableInteriorProp(int_plan1, "set_plan_setup") --light for plan
EnableInteriorProp(int_plan1, "set_plan_bed") --the room
DisableInteriorProp(int_plan1, "set_plan_pre_setup") -- trash everywhere
DisableInteriorProp(int_plan1, "set_plan_no_bed") --trash in the bed
EnableInteriorProp(int_plan1, "set_plan_garage")
EnableInteriorProp(int_plan1, "set_plan_scribbles")
EnableInteriorProp(int_plan1, "set_plan_arcade_x4")
EnableInteriorProp(int_plan1, "set_plan_plans")
EnableInteriorProp(int_plan1, "set_plan_plastic_explosives")
EnableInteriorProp(int_plan1, "set_plan_cockroaches")
EnableInteriorProp(int_plan1, "set_plan_electric_drill")
EnableInteriorProp(int_plan1, "set_plan_vault_drill")
EnableInteriorProp(int_plan1, "set_plan_vault_laser")
EnableInteriorProp(int_plan1, "set_plan_stealth_outfits")
EnableInteriorProp(int_plan1, "set_plan_hacking_device")
EnableInteriorProp(int_plan1, "set_plan_gruppe_sechs_outfits")
EnableInteriorProp(int_plan1, "set_plan_fireman_helmet")
EnableInteriorProp(int_plan1, "set_plan_drone_parts")
EnableInteriorProp(int_plan1, "set_plan_vault_keycard_01a")
EnableInteriorProp(int_plan1, "set_plan_swipe_card_01b")
EnableInteriorProp(int_plan1, "set_plan_swipe_card_01a")
EnableInteriorProp(int_plan1, "set_plan_vault_drill_alt")
EnableInteriorProp(int_plan1, "set_plan_vault_laser_alt")

local int_id = GetInteriorAtCoords(345.4899597168,294.95315551758,98.191421508789)

EnableInteriorProp(int_id , "Int01_ba_security_upgrade")
EnableInteriorProp(int_id , "Int01_ba_equipment_setup")
DisableInteriorProp(int_id , "Int01_ba_Style01")
DisableInteriorProp(int_id , "Int01_ba_Style02")
EnableInteriorProp(int_id , "Int01_ba_Style03")
DisableInteriorProp(int_id , "Int01_ba_style01_podium")
DisableInteriorProp(int_id , "Int01_ba_style02_podium")
EnableInteriorProp(int_id , "Int01_ba_style03_podium")
EnableInteriorProp(int_id , "int01_ba_lights_screen")
EnableInteriorProp(int_id , "Int01_ba_Screen")
EnableInteriorProp(int_id , "Int01_ba_bar_content")
DisableInteriorProp(int_id , "Int01_ba_booze_01")
DisableInteriorProp(int_id , "Int01_ba_booze_02")
DisableInteriorProp(int_id , "Int01_ba_booze_03")
DisableInteriorProp(int_id , "Int01_ba_dj01")
DisableInteriorProp(int_id , "Int01_ba_dj02")
EnableInteriorProp(int_id , "Int01_ba_dj03")
DisableInteriorProp(int_id , "Int01_ba_dj04")

EnableInteriorProp(int_id , "DJ_01_Lights_01")
DisableInteriorProp(int_id , "DJ_01_Lights_02")
DisableInteriorProp(int_id , "DJ_01_Lights_03")
DisableInteriorProp(int_id , "DJ_01_Lights_04")

DisableInteriorProp(int_id , "DJ_02_Lights_01")
EnableInteriorProp(int_id , "DJ_02_Lights_02")
DisableInteriorProp(int_id , "DJ_02_Lights_03")
DisableInteriorProp(int_id , "DJ_02_Lights_04")

DisableInteriorProp(int_id , "DJ_03_Lights_01")
DisableInteriorProp(int_id , "DJ_03_Lights_02")
EnableInteriorProp(int_id , "DJ_03_Lights_03")
DisableInteriorProp(int_id , "DJ_03_Lights_04")

DisableInteriorProp(int_id , "DJ_04_Lights_01")
DisableInteriorProp(int_id , "DJ_04_Lights_02")
DisableInteriorProp(int_id , "DJ_04_Lights_03")
EnableInteriorProp(int_id , "DJ_04_Lights_04")

DisableInteriorProp(int_id , "light_rigs_off")
EnableInteriorProp(int_id , "Int01_ba_lightgrid_01")
DisableInteriorProp(int_id , "Int01_ba_Clutter")
EnableInteriorProp(int_id , "Int01_ba_equipment_upgrade")
EnableInteriorProp(int_id , "Int01_ba_clubname_01")
DisableInteriorProp(int_id , "Int01_ba_clubname_02")
DisableInteriorProp(int_id , "Int01_ba_clubname_03")
DisableInteriorProp(int_id , "Int01_ba_clubname_04")
DisableInteriorProp(int_id , "Int01_ba_clubname_05")
DisableInteriorProp(int_id , "Int01_ba_clubname_06")
DisableInteriorProp(int_id , "Int01_ba_clubname_07")
DisableInteriorProp(int_id , "Int01_ba_clubname_08")
DisableInteriorProp(int_id , "Int01_ba_clubname_09")

EnableInteriorProp(int_id , "Int01_ba_dry_ice")
DisableInteriorProp(int_id , "Int01_ba_deliverytruck")
DisableInteriorProp(int_id , "Int01_ba_trophy04")
DisableInteriorProp(int_id , "Int01_ba_trophy05")
DisableInteriorProp(int_id , "Int01_ba_trophy07")
DisableInteriorProp(int_id , "Int01_ba_trophy09")
DisableInteriorProp(int_id , "Int01_ba_trophy08")
DisableInteriorProp(int_id , "Int01_ba_trophy11")
DisableInteriorProp(int_id , "Int01_ba_trophy10")
DisableInteriorProp(int_id , "Int01_ba_trophy03")
DisableInteriorProp(int_id , "Int01_ba_trophy01")
DisableInteriorProp(int_id , "Int01_ba_trophy02")
DisableInteriorProp(int_id , "Int01_ba_trad_lights")
DisableInteriorProp(int_id , "Int01_ba_Worklamps")
RefreshInterior(int_id )

Citizen.CreateThread(function()
	RequestIpl("hei_dlc_vw_roofdoors_locked")
	RequestIpl("hei_dlc_windows_casino")
	RequestIpl("hei_dlc_casino_door")
	RequestIpl("vw_dlc_casino_carpark")
	RemoveIpl("apa_distlodlights_large000")
	RemoveIpl("apa_distlodlights_medium000")
	RemoveIpl("apa_distlodlights_medium001")
	RemoveIpl("apa_distlodlights_medium002")
	RemoveIpl("apa_distlodlights_medium003")
	RemoveIpl("apa_distlodlights_medium004")
	RemoveIpl("apa_distlodlights_medium005")
	RemoveIpl("apa_distlodlights_medium006")
	RemoveIpl("apa_distlodlights_medium007")
	RemoveIpl("apa_distlodlights_medium008")
	RemoveIpl("apa_distlodlights_medium009")
	RemoveIpl("apa_distlodlights_medium010")
	RemoveIpl("apa_distlodlights_medium011")
	RemoveIpl("apa_distlodlights_medium012")
	RemoveIpl("apa_distlodlights_medium013")
	RemoveIpl("apa_distlodlights_medium014")
	RemoveIpl("apa_distlodlights_medium015")
	RemoveIpl("apa_distlodlights_medium016")
	RemoveIpl("apa_distlodlights_medium017")
	RemoveIpl("apa_distlodlights_medium018")
	RemoveIpl("apa_distlodlights_medium019")
	RemoveIpl("apa_distlodlights_medium020")
	RemoveIpl("apa_distlodlights_medium021")
	RemoveIpl("apa_distlodlights_medium022")
	RemoveIpl("apa_distlodlights_medium023")
	RemoveIpl("apa_distlodlights_medium024")
	RemoveIpl("apa_distlodlights_medium025")
	RemoveIpl("apa_distlodlights_medium026")
	RemoveIpl("apa_distlodlights_medium027")
	RemoveIpl("apa_distlodlights_medium028")
	RemoveIpl("apa_distlodlights_medium029")
	RemoveIpl("apa_distlodlights_medium030")
	RemoveIpl("apa_distlodlights_medium031")
	RemoveIpl("apa_distlodlights_medium032")
	RemoveIpl("apa_distlodlights_medium033")
	RemoveIpl("apa_distlodlights_medium034")
	RemoveIpl("apa_distlodlights_medium035")
	RemoveIpl("apa_distlodlights_small000")
	RemoveIpl("apa_distlodlights_small001")
	RemoveIpl("apa_distlodlights_small002")
	RemoveIpl("apa_distlodlights_small003")
	RemoveIpl("apa_distlodlights_small004")
	RemoveIpl("apa_distlodlights_small005")
	RemoveIpl("apa_distlodlights_small006")
	RemoveIpl("apa_distlodlights_small007")
	RemoveIpl("apa_distlodlights_small008")
	RemoveIpl("apa_distlodlights_small009")
	RemoveIpl("apa_distlodlights_small010")
	RemoveIpl("apa_distlodlights_small011")
	RemoveIpl("apa_distlodlights_small012")
	RemoveIpl("apa_distlodlights_small013")
	RemoveIpl("apa_distlodlights_small014")
	RemoveIpl("apa_distlodlights_small015")
	RemoveIpl("apa_distlodlights_small016")
	RemoveIpl("apa_distlodlights_small017")
	RemoveIpl("apa_distlodlights_small018")
	RemoveIpl("apa_distlodlights_small019")
	RemoveIpl("apa_distlodlights_small020")
	RemoveIpl("apa_distlodlights_small021")
	RemoveIpl("apa_distlodlights_small022")
	RemoveIpl("apa_distlodlights_small023")
	RemoveIpl("apa_distlodlights_small024")
	RemoveIpl("apa_distlodlights_small025")
	RemoveIpl("apa_distlodlights_small026")
	RemoveIpl("apa_distlodlights_small027")
	RemoveIpl("apa_distlodlights_small028")
	RemoveIpl("apa_distlodlights_small029")
	RemoveIpl("apa_distlodlights_small030")
	RemoveIpl("apa_distlodlights_small031")
	RemoveIpl("apa_distlodlights_small032")
	RemoveIpl("apa_distlodlights_small033")
	RemoveIpl("apa_distlodlights_small034")
	RemoveIpl("apa_distlodlights_small035")
	RemoveIpl("apa_distlodlights_small036")
	RemoveIpl("apa_distlodlights_small037")
	RemoveIpl("apa_distlodlights_small038")
	RemoveIpl("apa_distlodlights_small039")
	RemoveIpl("apa_distlodlights_small040")
	RemoveIpl("apa_distlodlights_small041")
	RemoveIpl("apa_distlodlights_small042")
	RemoveIpl("apa_distlodlights_small043")
	RemoveIpl("apa_distlodlights_small044")
	RemoveIpl("apa_distlodlights_small045")
	RemoveIpl("apa_distlodlights_small046")
	RemoveIpl("apa_distlodlights_small047")
	RemoveIpl("apa_distlodlights_small048")
	RemoveIpl("apa_distlodlights_small049")
	RemoveIpl("apa_distlodlights_small050")
	RemoveIpl("apa_distlodlights_small051")
	RemoveIpl("apa_distlodlights_small052")
	RemoveIpl("apa_distlodlights_small053")
	RemoveIpl("apa_distlodlights_small054")
	RemoveIpl("apa_distlodlights_small055")
	RemoveIpl("apa_distlodlights_small056")
	RemoveIpl("apa_distlodlights_small057")
	RemoveIpl("apa_distlodlights_small058")
	RemoveIpl("apa_distlodlights_small059")
	RemoveIpl("apa_distlodlights_small060")
	RemoveIpl("apa_distlodlights_small061")
	RemoveIpl("apa_distlodlights_small062")
	RemoveIpl("apa_lodlights_large000")
	RemoveIpl("apa_lodlights_medium000")
	RemoveIpl("apa_lodlights_medium001")
	RemoveIpl("apa_lodlights_medium002")
	RemoveIpl("apa_lodlights_medium003")
	RemoveIpl("apa_lodlights_medium004")
	RemoveIpl("apa_lodlights_medium005")
	RemoveIpl("apa_lodlights_medium006")
	RemoveIpl("apa_lodlights_medium007")
	RemoveIpl("apa_lodlights_medium008")
	RemoveIpl("apa_lodlights_medium009")
	RemoveIpl("apa_lodlights_medium010")
	RemoveIpl("apa_lodlights_medium011")
	RemoveIpl("apa_lodlights_medium012")
	RemoveIpl("apa_lodlights_medium013")
	RemoveIpl("apa_lodlights_medium014")
	RemoveIpl("apa_lodlights_medium015")
	RemoveIpl("apa_lodlights_medium016")
	RemoveIpl("apa_lodlights_medium017")
	RemoveIpl("apa_lodlights_medium018")
	RemoveIpl("apa_lodlights_medium019")
	RemoveIpl("apa_lodlights_medium020")
	RemoveIpl("apa_lodlights_medium021")
	RemoveIpl("apa_lodlights_medium022")
	RemoveIpl("apa_lodlights_medium023")
	RemoveIpl("apa_lodlights_medium024")
	RemoveIpl("apa_lodlights_medium025")
	RemoveIpl("apa_lodlights_medium026")
	RemoveIpl("apa_lodlights_medium027")
	RemoveIpl("apa_lodlights_medium028")
	RemoveIpl("apa_lodlights_medium029")
	RemoveIpl("apa_lodlights_medium030")
	RemoveIpl("apa_lodlights_medium031")
	RemoveIpl("apa_lodlights_medium032")
	RemoveIpl("apa_lodlights_medium033")
	RemoveIpl("apa_lodlights_medium034")
	RemoveIpl("apa_lodlights_medium035")
	RemoveIpl("apa_lodlights_small000")
	RemoveIpl("apa_lodlights_small001")
	RemoveIpl("apa_lodlights_small002")
	RemoveIpl("apa_lodlights_small003")
	RemoveIpl("apa_lodlights_small004")
	RemoveIpl("apa_lodlights_small005")
	RemoveIpl("apa_lodlights_small006")
	RemoveIpl("apa_lodlights_small007")
	RemoveIpl("apa_lodlights_small008")
	RemoveIpl("apa_lodlights_small009")
	RemoveIpl("apa_lodlights_small010")
	RemoveIpl("apa_lodlights_small011")
	RemoveIpl("apa_lodlights_small012")
	RemoveIpl("apa_lodlights_small013")
	RemoveIpl("apa_lodlights_small014")
	RemoveIpl("apa_lodlights_small015")
	RemoveIpl("apa_lodlights_small016")
	RemoveIpl("apa_lodlights_small017")
	RemoveIpl("apa_lodlights_small018")
	RemoveIpl("apa_lodlights_small019")
	RemoveIpl("apa_lodlights_small020")
	RemoveIpl("apa_lodlights_small021")
	RemoveIpl("apa_lodlights_small022")
	RemoveIpl("apa_lodlights_small023")
	RemoveIpl("apa_lodlights_small024")
	RemoveIpl("apa_lodlights_small025")
	RemoveIpl("apa_lodlights_small026")
	RemoveIpl("apa_lodlights_small027")
	RemoveIpl("apa_lodlights_small028")
	RemoveIpl("apa_lodlights_small029")
	RemoveIpl("apa_lodlights_small030")
	RemoveIpl("apa_lodlights_small031")
	RemoveIpl("apa_lodlights_small032")
	RemoveIpl("apa_lodlights_small033")
	RemoveIpl("apa_lodlights_small034")
	RemoveIpl("apa_lodlights_small035")
	RemoveIpl("apa_lodlights_small036")
	RemoveIpl("apa_lodlights_small037")
	RemoveIpl("apa_lodlights_small038")
	RemoveIpl("apa_lodlights_small039")
	RemoveIpl("apa_lodlights_small040")
	RemoveIpl("apa_lodlights_small041")
	RemoveIpl("apa_lodlights_small042")
	RemoveIpl("apa_lodlights_small043")
	RemoveIpl("apa_lodlights_small044")
	RemoveIpl("apa_lodlights_small045")
	RemoveIpl("apa_lodlights_small046")
	RemoveIpl("apa_lodlights_small047")
	RemoveIpl("apa_lodlights_small048")
	RemoveIpl("apa_lodlights_small049")
	RemoveIpl("apa_lodlights_small050")
	RemoveIpl("apa_lodlights_small051")
	RemoveIpl("apa_lodlights_small052")
	RemoveIpl("apa_lodlights_small053")
	RemoveIpl("apa_lodlights_small054")
	RemoveIpl("apa_lodlights_small055")
	RemoveIpl("apa_lodlights_small056")
	RemoveIpl("apa_lodlights_small057")
	RemoveIpl("apa_lodlights_small058")
	RemoveIpl("apa_lodlights_small059")
	RemoveIpl("apa_lodlights_small060")
	RemoveIpl("apa_lodlights_small061")
	RemoveIpl("apa_lodlights_small062")
end)

Citizen.CreateThread(function()


	RequestIpl("vw_casino_penthouse")
	interiorID = GetInteriorAtCoords(1100.00000000,220.00000000,-50.00000000)
	if IsValidInterior(interiorID) then
	EnableInteriorProp(interiorID, "0x30240D11")
	EnableInteriorProp(interiorID, "0xA3C89BB2")
	
		RefreshInterior(interiorID)
	end
	interiorID = GetInteriorAtCoords(976.63640000,70.294760000,115.16410000)
	if IsValidInterior(interiorID) then
	EnableInteriorProp(interiorID, "teste1")
	EnableInteriorProp(interiorID, "teste2")
	EnableInteriorProp(interiorID, "teste3")
	EnableInteriorProp(interiorID, "teste4")
	--EnableInteriorProp(interiorID, "teste5") --''portas fechadas""
	
	-- EnableInteriorProp(interiorID, "teste6") --''portas fechadas""
	
	-- EnableInteriorProp(interiorID, "teste7")--''portas fechadas""
	
	
-- PATTERN 1 até o 9

	EnableInteriorProp(interiorID, "teste11")  --"pattern_07"e'
-- ARCADES - PROPS - BALOONS

	EnableInteriorProp(interiorID, "teste17") --"arcade"
	EnableInteriorProp(interiorID, "teste18") --"arcade"
	EnableInteriorProp(interiorID, "teste19") --"bagunça"
	EnableInteriorProp(interiorID, "teste20") --"bagunça"
	EnableInteriorProp(interiorID, "teste21") --"bagunça"
--BLOCKERS

	-- EnableInteriorProp(interiorID, "teste22")"pent_lounge_blocker"
	-- EnableInteriorProp(interiorID, "teste23")"pent_guest_blocker"
	-- EnableInteriorProp(interiorID, "teste24")"pent_office_blocker"
	-- EnableInteriorProp(interiorID, "teste25")"pent_cine_blocker"
	-- EnableInteriorProp(interiorID, "teste26")"pent_spa_blocker"
	-- EnableInteriorProp(interiorID, "teste27")"pent_bar_blocker"
	
	--EnableInteriorProp(interiorID, "teste28") --"prop_beer_bottle ---- lixo????w"
	EnableInteriorProp(interiorID, "teste29") --"bebidas no bar"
	--EnableInteriorProp(interiorID, "teste30") --"pent_baloons" azul e branco
	--EnableInteriorProp(interiorID, "teste31") --"leds bar"
	EnableInteriorProp(interiorID, "teste32") --"pent_baloons_col"
	EnableInteriorProp(interiorID, "teste33") --"baloons_col001"
	EnableInteriorProp(interiorID, "teste34") --"baloons" vermelho e preto
	--EnableInteriorProp(interiorID, "teste35") --"baloons" preto e amarelo
	

	SetInteriorPropColor(interiorID, "teste1", 3)
	SetInteriorPropColor(interiorID, "teste2", 3)
	SetInteriorPropColor(interiorID, "teste4", 3)
	SetInteriorPropColor(interiorID, "teste11", 3)
	
	
	RefreshInterior(interiorID)
	end

end)




Citizen.CreateThread(function()
	RequestIpl("ch_int_placement_ch_interior_0_dlc_casino_heist_milo_")
	RequestIpl("ch_int_placement_ch_interior_1_dlc_arcade_milo_")
	RequestIpl("ch_int_placement_ch_interior_2_dlc_plan_milo_")
	RequestIpl("ch_int_placement_ch_interior_3_dlc_casino_back_milo_")
	RequestIpl("ch_int_placement_ch_interior_4_dlc_casino_hotel_milo_")
	RequestIpl("ch_int_placement_ch_interior_5_dlc_casino_loading_milo_")
	RequestIpl("ch_int_placement_ch_interior_6_dlc_casino_vault_milo_")
	RequestIpl("ch_int_placement_ch_interior_7_dlc_casino_utility_milo_")
	RequestIpl("ch_int_placement_ch_interior_8_dlc_tunnel_milo_")
	RequestIpl("ch_int_placement_ch_interior_9_dlc_casino_shaft_milo_")
	
	
-- Vault
	local interiorid = GetInteriorAtCoords(2488.348, -267.3637, -71.64563)

	-- Interior props / entitysets
	-- EnableInteriorProp(interiorid, "set_vault_door") -- Open vault
	-- EnableInteriorProp(interiorid, "set_vault_door_lockedxd") -- Locked vault door
	EnableInteriorProp(interiorid, "set_vault_door_broken") -- Vault door exloded/broken
	EnableInteriorProp(interiorid, "set_vault_wall_damagedxd") -- Vault wall damaged
	
		-- always refresh the interior or they won't appear
	RefreshInterior(interiorid)
	
	
	
	
-- ARCADE
	local interiorid = GetInteriorAtCoords(2730.000, -380.000, -50.000)

	-- Interior props / entitysets
	
	-- MAIN STYLES (Choose one)
	-- EnableInteriorProp(interiorid, "casino_arcade_style_01") 
	EnableInteriorProp(interiorid, "casino_arcade_style_02")
	
	-- DESTROYED VERSION
	-- EnableInteriorProp(interiorid, "casino_arcade_destroyed")
	-- EnableInteriorProp(interiorid, "casino_arcade_destroyed_extras") -- (extras for the destroyed version)
	
	-- TEXTURE STYLES (Choose one)
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_texture_style_01") 
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_texture_style_02") 
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_texture_style_03") 
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_texture_style_04") 
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_texture_style_09")
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_texture_style_10")
	EnableInteriorProp(interiorid, "casino_arcade_extraprops_texture_style_11")
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_texture_style_16")
	
	-- WALL DESIGNS (Choose one)
	EnableInteriorProp(interiorid, "casino_arcade_extraprops_wall_01")
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_wall_02")
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_wall_03")
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_wall_04")
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_wall_05")
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_wall_06")
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_wall_07")
	-- EnableInteriorProp(interiorid, "casino_arcade_extraprops_wall_08")
	
	
	-- PROPS: Can all be used at same time without colliding
	EnableInteriorProp(interiorid, "casino_arcade_extraprops_streetgames_01")
	EnableInteriorProp(interiorid, "casino_arcade_extraprops_wallmonitors")
	EnableInteriorProp(interiorid, "casino_arcade_no_idea") -- Some floor stuff
	EnableInteriorProp(interiorid, "casino_arcade_no_idea2") -- Neon stuff i think
	EnableInteriorProp(interiorid, "casino_arcade_extraprops_barstuff")
	EnableInteriorProp(interiorid, "casino_arcade_extraprops_walltv")
	EnableInteriorProp(interiorid, "casino_arcade_extraprops_lights_01") -- This also has trophies etc
	EnableInteriorProp(interiorid, "casino_arcade_extraprops_lights_02")
	EnableInteriorProp(interiorid, "casino_arcade_extraprops_wire") -- This has extra added arcade game props
	
		-- always refresh the interior or they won't appear
	RefreshInterior(interiorid)
	
-- PLAN GARAGE
	local interiorid = GetInteriorAtCoords(2697.615, -376.3892, -56.46193)

	-- PROPS: Can all be used at same time without colliding
	EnableInteriorProp(interiorid, "casino_plan_hacking")
	EnableInteriorProp(interiorid, "casino_plan_keypads")
	EnableInteriorProp(interiorid, "casino_plan_hacking2")
	EnableInteriorProp(interiorid, "casino_plan_work")
	EnableInteriorProp(interiorid, "casino_plan_work2")
	EnableInteriorProp(interiorid, "casino_plan_vaultplan")
	EnableInteriorProp(interiorid, "casino_plan_work3")
	 EnableInteriorProp(interiorid, "casino_plan_casino_tablemodel") -- Has to be used together with: casino_plan_work3 (its on a table)
	EnableInteriorProp(interiorid, "casino_plan_work4")
	EnableInteriorProp(interiorid, "casino_plan_work5")
	EnableInteriorProp(interiorid, "casino_plan_board_drawing")
	EnableInteriorProp(interiorid, "casino_plan_machines")
	EnableInteriorProp(interiorid, "casino_plan_blueprints")
	EnableInteriorProp(interiorid, "casino_plan_c4")
	EnableInteriorProp(interiorid, "casino_plan_insect")
	EnableInteriorProp(interiorid, "casino_plan_equipment_01")
	EnableInteriorProp(interiorid, "casino_plan_equipment_02")
	EnableInteriorProp(interiorid, "casino_plan_equipment_03")
	EnableInteriorProp(interiorid, "casino_plan_equipment_04")
	EnableInteriorProp(interiorid, "casino_plan_equipment_05")
	EnableInteriorProp(interiorid, "casino_plan_equipment_hat")
	EnableInteriorProp(interiorid, "casino_plan_drone")
	EnableInteriorProp(interiorid, "casino_plan_noidea_xd")
	EnableInteriorProp(interiorid, "casino_plan_equipment_07")
	
	
   --  DESTROYED/OLD GARAGE VERSION	(ONLY LOAD THESE 3)
	-- EnableInteriorProp(interiorid, "casino_plan_destroyed")
	-- EnableInteriorProp(interiorid, "casino_plan_destroyed2") -- Enables the walls
	-- EnableInteriorProp(interiorid, "casino_plan_destroyed3") -- Extra props
	
		-- always refresh the interior or they won't appear
	RefreshInterior(interiorid)	
	
	
	
end)


RegisterCommand("alarm_on", function(source, args, rawCommand)
    local alarmIpl = GetInteriorAtCoordsWithType(1787.004,2593.1984,45.7978,"int_prison_main")

    RefreshInterior(alarmIpl)
    EnableInteriorProp(alarmIpl, "prison_alarm")

    Citizen.CreateThread(function()
        while not PrepareAlarm("PRISON_ALARMS") do
            Citizen.Wait(100)
        end
        StartAlarm("PRISON_ALARMS", true)
    end)
end, false)

RegisterCommand("alarm_off", function(source, args, rawCommand)
    local alarmIpl = GetInteriorAtCoordsWithType(1787.004,2593.1984,45.7978,"int_prison_main")

    RefreshInterior(alarmIpl)
    DisableInteriorProp(alarmIpl, "prison_alarm")

    Citizen.CreateThread(function()
        while not PrepareAlarm("PRISON_ALARMS") do
            Citizen.Wait(100)
        end
        StopAllAlarms(true)
    end)
end, false)
