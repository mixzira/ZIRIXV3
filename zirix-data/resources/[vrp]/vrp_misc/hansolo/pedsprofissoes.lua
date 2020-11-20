local pedlist = {
	{ ['x'] = 425.95, ['y'] = 6463.24, ['z'] = 28.78, ['h'] = 316.13, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 431.44, ['y'] = 6459.07, ['z'] = 28.76, ['h'] = 316.13, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 436.61, ['y'] = 6454.43, ['z'] = 28.75, ['h'] = 316.13, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 428.62, ['y'] = 6477.39, ['z'] = 28.75, ['h'] = 140.66, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 433.62, ['y'] = 6472.58, ['z'] = 28.78, ['h'] = 238.11, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },

	-- Venda de Coca;
	{ ['x'] = 499.6, ['y'] = -523.81, ['z'] = 24.88, ['h'] = 83.23, ['hash'] = 0xE497BBEF, ['hash2'] = "s_m_y_dealer_01" },
	{ ['x'] = -1089.67, ['y'] = -2397.98, ['z'] = 13.95, ['h'] = 150.52, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
	 
	-- Venda de Meta;
	{ ['x'] = -326.38, ['y'] = -1300.5, ['z'] = 31.35, ['h'] = 95.37, ['hash'] = 0x69F46BF3, ['hash2'] = "s_f_y_factory_01" }, -- Venda Éter;
	{ ['x'] = -51.91, ['y'] = -2761.0, ['z'] = 6.09, ['h'] = 1.51, ['hash'] = 0xCAE9E5D5, ['hash2'] = "csb_cletus" }, -- Outros;

	-- Venda Armas;
	{ ['x'] = 991.28, ['y'] = -1551.53, ['z'] = 30.85, ['h'] = 277.29, ['hash'] = 0x9E08633D, ['hash2'] = "s_m_y_ammucity_01" }, -- Outros;
	{ ['x'] = 1123.05, ['y'] = -1304.66, ['z'] = 34.72, ['h'] = 3.25, ['hash'] = 0x0DE9A30A, ['hash2'] = "s_m_m_ammucountry" }, -- Outros;

	{ ['x'] = 1224.92, ['y'] = -2911.34, ['z'] = 5.93, ['h'] = 101.14, ['hash'] = 0xB3F3EE34, ['hash2'] = "s_m_y_blackops_01" }, -- Contrabandista;

	{ ['x'] = 226.11, ['y'] = 375.24, ['z'] = 106.12, ['h'] = 169.15, ['hash'] = 0xE7565327, ['hash2'] = "cs_andreas" }, -- Auto escola;
	
	{ ['x'] = -40.43, ['y'] = -1660.33, ['z'] = 29.5, ['h'] = 229.66, ['hash'] = 0x75D30A91, ['hash2'] = "s_m_y_dwservice_01" }, -- Loja de Ferramentas;

	{ ['x'] = -139.14, ['y'] = -633.85, ['z'] = 168.83, ['h'] = 6.66, ['hash'] = 0x2799EFD8, ['hash2'] = "a_f_y_business_01" }, -- Agência de empregos;

	{ ['x'] = -553.76, ['y'] = -189.24, ['z'] = 38.22, ['h'] = 207.79, ['hash'] = 0x7E6A64B7, ['hash2'] = "a_m_m_business_01" } -- Prefeitura;
	
}

Citizen.CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(GetHashKey(v.hash2))
		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(10)
		end
		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetBlockingOfNonTemporaryEvents(ped,true)
	end
end)