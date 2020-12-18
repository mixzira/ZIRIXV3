local cfg = {}

cfg.list = {
	
	--[ HOSPITAL ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	[1] = { text = true, hash = 854291622, ['x'] = 304.15, ['y'] = -571.72, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[2] = { text = true, hash = 854291622, ['x'] = 307.9, ['y'] = -569.92, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[3] = { text = true, hash = -434783486, ['x'] = 312.78, ['y'] = -571.59, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 4 },
	[4] = { text = true, hash = -1700911976, ['x'] = 313.63, ['y'] = -572.02, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 3 },
	[5] = { text = true, hash = -434783486, ['x'] = 318.55, ['y'] = -573.73, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 6 },
	[6] = { text = true, hash = -1700911976, ['x'] = 319.36, ['y'] = -574.04, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 5 },
	[7] = { text = true, hash = -434783486, ['x'] = 323.93, ['y'] = -575.75, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 8 },
	[8] = { text = true, hash = -1700911976, ['x'] = 324.96, ['y'] = -576.0, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 7 },
	[9] = { text = true, hash = 854291622, ['x'] = 336.74, ['y'] = -580.33, ['z'] = 43.31, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},
	[10] = { text = true, hash = 854291622, ['x'] = 341.58, ['y'] = -582.08, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[11] = { text = true, hash = 854291622, ['x'] = 347.46, ['y'] = -584.25, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[12] = { text = true, hash = 854291622, ['x'] = 339.75, ['y'] = -586.98, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[13] = { text = true, hash = 854291622, ['x'] = 313.22, ['y'] = -596.14, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[14] = { text = true, hash = 854291622, ['x'] = 308.35, ['y'] = -597.45, ['z'] = 43.29, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },

	--[ CONCESSIONARIA ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[15] = { text = true, hash = -2051651622, ['x'] = -32.0, ['y'] = -1102.48, ['z'] = 26.43, lock = true, perm = "concessionaria.permissao", perm2 = "0.permissao", public = false },
	[16] = { text = true, hash = -2051651622, ['x'] = -34.06, ['y'] = -1108.22, ['z'] = 26.43, lock = true, perm = "concessionaria.permissao", perm2 = "0.permissao", public = false },

	--[ DELEGACIA ]------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	[17] = { text = true, hash = -350181704, ['x'] = -1090.76, ['y'] = -809.1, ['z'] = 19.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 18 },
	[18] = { text = true, hash = -350181704, ['x'] = -1091.81, ['y'] = -809.81, ['z'] = 19.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 17 },
	[19] = { text = true, hash = -350181704, ['x'] = -1093.03, ['y'] = -810.84, ['z'] = 19.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 20 },
	[20] = { text = true, hash = -350181704, ['x'] = -1094.02, ['y'] = -811.7, ['z'] = 19.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 19 },
	[21] = { text = true, hash = -350181704, ['x'] = -1061.24, ['y'] = -828.3, ['z'] = 19.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 22 },
	[22] = { text = true, hash = -350181704, ['x'] = -1062.14, ['y'] = -827.25, ['z'] = 19.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 21 },
	[23] = { text = true, hash = -1255368438, ['x'] = -1098.24, ['y'] = -836.12, ['z'] = 19.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 24 },
	[24] = { text = true, hash = -1255368438, ['x'] = -1098.99, ['y'] = -835.12, ['z'] = 19.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 23 },
	[25] = { text = true, hash = -1255368438, ['x'] = -1091.62, ['y'] = -818.15, ['z'] = 19.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 26 },
	[26] = { text = true, hash = -1255368438, ['x'] = -1092.65, ['y'] = -818.88, ['z'] = 19.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 25 },
	
	[27] = { text = true, hash = -1821777087, ['x'] = -1108.41, ['y'] = -832.95, ['z'] = 34.37, lock = true, perm = "sub-chefe-policia.permissao", perm2 = "chefe-policia.permissao", public = false, other = 28 },
	[28] = { text = true, hash = -1821777087, ['x'] = -1109.52, ['y'] = -833.94, ['z'] = 34.37, lock = true, perm = "sub-chefe-policia.permissao", perm2 = "chefe-policia.permissao", public = false, other = 27 },
	[29] = { text = true, hash = -1821777087, ['x'] = -1108.18, ['y'] = -832.75, ['z'] = 30.76, lock = true, perm = "sub-chefe-policia.permissao", perm2 = "chefe-policia.permissao", public = false, other = 30 },
	[30] = { text = true, hash = -1821777087, ['x'] = -1109.16, ['y'] = -833.56, ['z'] = 30.76, lock = true, perm = "sub-chefe-policia.permissao", perm2 = "chefe-policia.permissao", public = false, other = 29 },

	[31] = { text = true, hash = -1255368438, ['x'] = -1098.8, ['y'] = -838.09, ['z'] = 26.85, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 32 },
	[32] = { text = true, hash = -1255368438, ['x'] = -1099.59, ['y'] = -836.91, ['z'] = 26.85, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 31 },
	[33] = { text = true, hash = -1255368438, ['x'] = -1069.89, ['y'] = -824.29, ['z'] = 26.85, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 34 },
	[34] = { text = true, hash = -1255368438, ['x'] = -1068.67, ['y'] = -824.39, ['z'] = 26.85, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 33 },
	[35] = { text = true, hash = -2023754432, ['x'] = -1074.74, ['y'] = -823.05, ['z'] = 14.89, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 36 },
	[36] = { text = true, hash = -2023754432, ['x'] = -1075.85, ['y'] = -823.8, ['z'] = 14.89, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 35 },
	[37] = { text = true, hash = -2023754432, ['x'] = -1085.98, ['y'] = -831.8, ['z'] = 14.89, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 38 },
	[38] = { text = true, hash = -2023754432, ['x'] = -1086.79, ['y'] = -830.67, ['z'] = 14.89, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 37 },
	[39] = { text = true, hash = -2023754432, ['x'] = -1094.88, ['y'] = -835.49, ['z'] = 14.29, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 40 },
	[40] = { text = true, hash = -2023754432, ['x'] = -1093.83, ['y'] = -834.63, ['z'] = 14.29, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 39 },
	[41] = { text = true, hash = -2023754432, ['x'] = -1102.41, ['y'] = -847.43, ['z'] = 13.69, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 42 },
	[42] = { text = true, hash = -2023754432, ['x'] = -1101.27, ['y'] = -846.71, ['z'] = 13.69, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 41 },
	[43] = { text = true, hash = -1255368438, ['x'] = -1072.94, ['y'] = -826.95, ['z'] = 11.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 44 },
	[44] = { text = true, hash = -1255368438, ['x'] = -1071.92, ['y'] = -826.11, ['z'] = 11.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 43 },
	[45] = { text = true, hash = -1255368438, ['x'] = -1086.93, ['y'] = -830.99, ['z'] = 11.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 46 },
	[46] = { text = true, hash = -1255368438, ['x'] = -1086.07, ['y'] = -831.95, ['z'] = 11.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 45 },
	[47] = { text = true, hash = -1255368438, ['x'] = -1093.83, ['y'] = -834.55, ['z'] = 10.28, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 48 },
	[48] = { text = true, hash = -1255368438, ['x'] = -1094.91, ['y'] = -835.43, ['z'] = 10.28, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 47 },
	[49] = { text = true, hash = -1255368438, ['x'] = -1079.15, ['y'] = -825.78, ['z'] = 11.16, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 50 },
	[50] = { text = true, hash = -1255368438, ['x'] = -1078.0, ['y'] = -825.04, ['z'] = 11.16, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 49 },

	[51] = { text = true, hash = -147325430, ['x'] = -1090.01, ['y'] = -841.09, ['z'] = 37.71, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[52] = { text = true, hash = -147325430, ['x'] = -1091.16, ['y'] = -841.59, ['z'] = 34.37, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[53] = { text = true, hash = -147325430, ['x'] = -1091.14, ['y'] = -841.45, ['z'] = 30.37, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[54] = { text = true, hash = -147325430, ['x'] = -1091.24, ['y'] = -841.58, ['z'] = 26.49, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[55] = { text = true, hash = -147325430, ['x'] = -1091.13, ['y'] = -841.61, ['z'] = 22.36, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[55] = { text = true, hash = -147325430, ['x'] = -1091.09, ['y'] = -841.49, ['z'] = 18.36, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[56] = { text = true, hash = -147325430, ['x'] = -1091.24, ['y'] = -841.55, ['z'] = 14.29, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[57] = { text = true, hash = -147325430, ['x'] = -1091.05, ['y'] = -841.35, ['z'] = 10.01, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[58] = { text = true, hash = -147325430, ['x'] = -1092.65, ['y'] = -842.73, ['z'] = 4.89, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[59] = { text = true, hash = -147325430, ['x'] = -1077.26, ['y'] = -830.16, ['z'] = 27.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[60] = { text = true, hash = -147325430, ['x'] = -1077.21, ['y'] = -830.22, ['z'] = 19.05, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[61] = { text = true, hash = -147325430, ['x'] = -1077.18, ['y'] = -830.3, ['z'] = 15.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[62] = { text = true, hash = -147325430, ['x'] = -1077.22, ['y'] = -830.15, ['z'] = 11.04, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[63] = { text = true, hash = -147325430, ['x'] = -1071.24, ['y'] = -833.63, ['z'] = 5.49, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[64] = { text = true, hash = -2023754432, ['x'] = -1089.8, ['y'] = -848.27, ['z'] = 4.89, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 65 },
	[65] = { text = true, hash = -2023754432, ['x'] = -1090.66, ['y'] = -847.27, ['z'] = 4.89, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 64 },
	[66] = { text = true, hash = -2023754432, ['x'] = -1097.9, ['y'] = -833.82, ['z'] = 4.89, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 67 },
	[67] = { text = true, hash = -2023754432, ['x'] = -1098.7, ['y'] = -832.76, ['z'] = 4.89, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 66 },
	[68] = { text = true, hash = -2023754432, ['x'] = -1101.86, ['y'] = -833.1, ['z'] = 4.89, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[69] = { text = true, hash = -2023754432, ['x'] = -1091.15, ['y'] = -835.62, ['z'] = 5.46, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 70 },
	[70] = { text = true, hash = -2023754432, ['x'] = -1092.01, ['y'] = -834.5, ['z'] = 5.46, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 69 },
	
	[71] = { text = true, hash = 631614199, ['x'] = -1087.17, ['y'] = -829.52, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[72] = { text = true, hash = 631614199, ['x'] = -1089.17, ['y'] = -829.68, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[73] = { text = true, hash = 631614199, ['x'] = -1086.21, ['y'] = -827.41, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[74] = { text = true, hash = 631614199, ['x'] = -1091.5, ['y'] = -826.45, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[75] = { text = true, hash = 631614199, ['x'] = -1088.61, ['y'] = -824.34, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[76] = { text = true, hash = 631614199, ['x'] = -1093.92, ['y'] = -823.29, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[77] = { text = true, hash = 631614199, ['x'] = -1091.03, ['y'] = -821.16, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[78] = { text = true, hash = 631614199, ['x'] = -1096.32, ['y'] = -820.2, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[79] = { text = true, hash = 631614199, ['x'] = -1073.24, ['y'] = -827.01, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[80] = { text = true, hash = -2023754432, ['x'] = -1085.46, ['y'] = -812.21, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 81 },
	[81] = { text = true, hash = -2023754432, ['x'] = -1086.33, ['y'] = -811.06, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 80 },
	[82] = { text = true, hash = -2023754432, ['x'] = -1090.5, ['y'] = -812.62, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[83] = { text = true, hash = -2023754432, ['x'] = -1078.11, ['y'] = -814.16, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[84] = { text = true, hash = -2023754432, ['x'] = -1081.74, ['y'] = -816.81, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[85] = { text = true, hash = -2023754432, ['x'] = -1074.85, ['y'] = -818.61, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[86] = { text = true, hash = -2023754432, ['x'] = -1078.34, ['y'] = -821.13, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false },
	[87] = { text = true, hash = -2023754432, ['x'] = -1073.95, ['y'] = -822.04, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 89 },
	[89] = { text = true, hash = -2023754432, ['x'] = -1075.1, ['y'] = -822.75, ['z'] = 5.48, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 88 },
	[90] = { text = true, hash = -2023754432, ['x'] = -1057.25, ['y'] = -839.41, ['z'] = 5.01, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 91 },
	[91] = { text = true, hash = -2023754432, ['x'] = -1058.32, ['y'] = -840.36, ['z'] = 5.01, lock = true, perm = "policia.permissao", perm2 = "paisana-policia.permissao", public = false, other = 90 },

	--[ ARCADE ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[92] = { text = true, hash = 855881614, ['x'] = 735.11, ['y'] = -815.53, ['z'] = 22.67, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false },
	[93] = { text = true, hash = -1777641513, ['x'] = 740.42, ['y'] = -809.69, ['z'] = 24.31, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false, other = 94 },
	[94] = { text = true, hash = 2056855795, ['x'] = 740.42, ['y'] = -809.69, ['z'] = 24.31, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false, other = 93 },
	[95] = { text = true, hash = 346272656, ['x'] = 717.64, ['y'] = -767.56, ['z'] = 24.91, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false },

	--[ VANILLA ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[96] = { text = true, hash = -495720969, ['x'] = 113.81, ['y'] = -1296.78, ['z'] = 29.27, lock = true, perm = "orgmthree.permissao", perm2 = "lider-orgmthree.permissao", public = false },
	[97] = { text = true, hash = -626684119, ['x'] = 99.74, ['y'] = -1293.36, ['z'] = 29.27, lock = true, perm = "orgmthree.permissao", perm2 = "lider-orgmthree.permissao", public = false },
	[98] = { text = true, hash = 668467214, ['x'] = 95.53, ['y'] = -1285.2, ['z'] = 29.28, lock = true, perm = "orgmthree.permissao", perm2 = "lider-orgmthree.permissao", public = false },

	--[ TEQUI-LA-LA ]----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[99] = { text = true, hash = -626684119, ['x'] = -560.23, ['y'] = 292.3, ['z'] = 82.18, lock = true, perm = "orgmtwo.permissao", perm2 = "lider-orgmtwo.permissao", public = false },

	--[ DELEGACIA ANTIGA ]-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[100] = { text = true, hash = -1215222675, ['x'] = 434.73, ['y'] = -981.44, ['z'] = 30.72, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false, other = 101 },
	[101] = { text = true, hash = 320433149, ['x'] = 434.63, ['y'] = -982.51, ['z'] = 30.72, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false, other = 100 },
	[102] = { text = true, hash = -2023754432, ['x'] = 469.28, ['y'] = -1014.51, ['z'] = 26.39, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false, other = 103 },
	[103] = { text = true, hash = -2023754432, ['x'] = 468.25, ['y'] = -1014.47, ['z'] = 26.39, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false, other = 102 },

	[104] = { text = true, hash = 631614199, ['x'] = 461.85, ['y'] = -993.72, ['z'] = 24.92, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false }, -- Cela Admin;
	[105] = { text = true, hash = 631614199, ['x'] = 461.87, ['y'] = -998.3, ['z'] = 24.92, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false }, -- Cela Admin;
	[106] = { text = true, hash = 631614199, ['x'] = 461.89, ['y'] = -1001.98, ['z'] = 24.92, lock = true, perm = "0.permissao", perm2 = "0.permissao", public = false }, -- Cela Admin;

	--[ BANCOS ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[107] = { text = true, hash = 73386408, ['x'] = 151.49, ['y'] = -1037.91, ['z'] = 29.38, lock = false, perm = "0", perm2 = "0", public = true, other = 108 },
	[108] = { text = true, hash = -1152174184, ['x'] = 150.29, ['y'] = -1037.5, ['z'] = 29.38, lock = false, perm = "0", perm2 = "0", public = true, other = 107 },
	
	[109] = { text = true, hash = 73386408, ['x'] = -1213.74, ['y'] = -327.6, ['z'] = 37.79, lock = false, perm = "0", perm2 = "0", public = true, other = 110 },
	[110] = { text = true, hash = -1152174184, ['x'] = -1214.85, ['y'] = -328.17, ['z'] = 37.79, lock = false, perm = "0", perm2 = "0", public = true, other = 109 },

	[111] = { text = true, hash = 73386408, ['x'] = -349.41, ['y'] = -47.13, ['z'] = 49.04, lock = false, perm = "0", perm2 = "0", public = true, other = 112 },
	[112] = { text = true, hash = -1152174184, ['x'] = -350.67, ['y'] = -46.57, ['z'] = 49.04, lock = false, perm = "0", perm2 = "0", public = true, other = 111 },

	[113] = { text = true, hash = 73386408, ['x'] = 315.69, ['y'] = -276.11, ['z'] = 54.17, lock = false, perm = "0", perm2 = "0", public = true, other = 114 },
	[114] = { text = true, hash = -1152174184, ['x'] = 314.58, ['y'] = -275.74, ['z'] = 54.17, lock = false, perm = "0", perm2 = "0", public = true, other = 113 },

	[115] = { text = true, hash = 110411286, ['x'] = 258.83, ['y'] = 203.75, ['z'] = 106.29, lock = false, perm = "0", perm2 = "0", public = true, other = 116 },
	[116] = { text = true, hash = 110411286, ['x'] = 260.07, ['y'] = 203.44, ['z'] = 106.29, lock = false, perm = "0", perm2 = "0", public = true, other = 115 },

	[117] = { text = true, hash = 110411286, ['x'] = 231.8, ['y'] = 215.74, ['z'] = 106.29, lock = false, perm = "0", perm2 = "0", public = true, other = 118 },
	[118] = { text = true, hash = 110411286, ['x'] = 232.37, ['y'] = 214.79, ['z'] = 106.29, lock = false, perm = "0", perm2 = "0", public = true, other = 117 },

	[119] = { text = true, hash = 73386408, ['x'] = -2965.68, ['y'] = 483.63, ['z'] = 15.7, lock = false, perm = "0", perm2 = "0", public = true, other = 120 },
	[120] = { text = true, hash = -1152174184, ['x'] = -2965.87, ['y'] = 482.29, ['z'] = 15.7, lock = false, perm = "0", perm2 = "0", public = true, other = 119 },

	[121] = { text = true, hash = 73386408, ['x'] = 1174.61, ['y'] = 2703.69, ['z'] = 38.18, lock = false, perm = "0", perm2 = "0", public = true, other = 122, },
	[122] = { text = true, hash = -1152174184, ['x'] = 1175.89, ['y'] = 2703.54, ['z'] = 38.18, lock = false, perm = "0", perm2 = "0", public = true, other = 121 },

	[123] = { text = true, hash = -353187150, ['x'] = -111.0, ['y'] = 6463.4, ['z'] = 31.65, lock = false, perm = "0", perm2 = "0", public = true, other = 124 },
	[124] = { text = true, hash = -1666470363, ['x'] = -110.02, ['y'] = 6462.68, ['z'] = 31.64, lock = false, perm = "0", perm2 = "0", public = true, other = 123 },

	--[ LOJA DE ROUPAS ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	[125] = { text = true, hash = -1148826190, ['x'] = 418.59, ['y'] = -808.1, ['z'] = 29.5, lock = false, perm = "0", perm2 = "0", public = true, other = 126 },
	[126] = { text = true, hash = 868499217, ['x'] = 418.57, ['y'] = -806.96, ['z'] = 29.5, lock = false, perm = "0", perm2 = "0", public = true, other = 125 },

	[127] = { text = true, hash = -1148826190, ['x'] = 82.39, ['y'] = -1391.1, ['z'] = 29.4, lock = false, perm = "0", perm2 = "0", public = true, other = 128 },
	[128] = { text = true, hash = 868499217, ['x'] = 82.34, ['y'] = -1392.05, ['z'] = 29.39, lock = false, perm = "0", perm2 = "0", public = true, other = 127 },

	[129] = { text = true, hash = -1148826190, ['x'] = -817.44, ['y'] = -1078.59, ['z'] = 11.34, lock = false, perm = "0", perm2 = "0", public = true, other = 130 },
	[130] = { text = true, hash = 868499217, ['x'] = -818.23, ['y'] = -1079.09, ['z'] = 11.34, lock = false, perm = "0", perm2 = "0", public = true, other = 129 },

	[131] = { text = true, hash = 1780022985, ['x'] = -1200.69, ['y'] = -777.62, ['z'] = 17.33, lock = false, perm = "0", perm2 = "0", public = true },

	[132] = { text = true, hash = -1922281023, ['x'] = -157.11, ['y'] = -305.92, ['z'] = 39.74, lock = false, perm = "0", perm2 = "0", public = true, other = 133 },
	[133] = { text = true, hash = -1922281023, ['x'] = -156.65, ['y'] = -304.89, ['z'] = 39.74, lock = false, perm = "0", perm2 = "0", public = true, other = 132 },

	[134] = { text = true, hash = 1780022985, ['x'] = 126.97, ['y'] = -211.46, ['z'] = 54.56, lock = false, perm = "0", perm2 = "0", public = true },

	[135] = { text = true, hash = -1922281023, ['x'] = -715.75, ['y'] = -156.7, ['z'] = 37.42, lock = false, perm = "0", perm2 = "0", public = true, other = 136 },
	[136] = { text = true, hash = -1922281023, ['x'] = -716.32, ['y'] = -155.95, ['z'] = 37.42, lock = false, perm = "0", perm2 = "0", public = true, other = 135 },

	[137] = { text = true, hash = -1922281023, ['x'] = -1455.06, ['y'] = -232.22, ['z'] = 49.8, lock = false, perm = "0", perm2 = "0", public = true, other = 138 },
	[138] = { text = true, hash = -1922281023, ['x'] = -1455.79, ['y'] = -232.98, ['z'] = 49.8, lock = false, perm = "0", perm2 = "0", public = true, other = 137 },

	[139] = { text = true, hash = 1780022985, ['x'] = -3168.6, ['y'] = 1055.91, ['z'] = 20.87, lock = false, perm = "0", perm2 = "0", public = true },

	[140] = { text = true, hash = -1148826190, ['x'] = -1095.34, ['y'] = 2706.59, ['z'] = 19.11, lock = false, perm = "0", perm2 = "0", public = true, other = 141 },
	[141] = { text = true, hash = 868499217, ['x'] = -1096.13, ['y'] = 2705.84, ['z'] = 19.11, lock = false, perm = "0", perm2 = "0", public = true, other = 140 },

	[142] = { text = true, hash = 1780022985, ['x'] = 618.09, ['y'] = 2751.24, ['z'] = 42.09, lock = false, perm = "0", perm2 = "0", public = true },

	[143] = { text = true, hash = -1148826190, ['x'] = 1198.53, ['y'] = 2703.16, ['z'] = 38.23, lock = false, perm = "0", perm2 = "0", public = true, other = 144 },
	[144] = { text = true, hash = 868499217, ['x'] = 1197.34, ['y'] = 2703.18, ['z'] = 38.23, lock = false, perm = "0", perm2 = "0", public = true, other = 143 },

	[145] = { text = true, hash = -1148826190, ['x'] = 1687.23, ['y'] = 4820.07, ['z'] = 42.07, lock = false, perm = "0", perm2 = "0", public = true, other = 146 },
	[146] = { text = true, hash = 868499217, ['x'] = 1687.14, ['y'] = 4821.18, ['z'] = 42.07, lock = false, perm = "0", perm2 = "0", public = true, other = 145 },

	[147] = { text = true, hash = -1148826190, ['x'] = -1.33, ['y'] = 6516.32, ['z'] = 31.88, lock = false, perm = "0", perm2 = "0", public = true, other = 148 },
	[148] = { text = true, hash = 868499217, ['x'] = -0.56, ['y'] = 6516.93, ['z'] = 31.88, lock = false, perm = "0", perm2 = "0", public = true, other = 147 },

	--[ LOJA DE DEPARTAMENTOS ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[149] = { text = true, hash = 997554217, ['x'] = 29.51, ['y'] = -1349.07, ['z'] = 29.5, lock = false, perm = "0", perm2 = "0", public = true, other = 150 },
	[150] = { text = true, hash = 1196685123, ['x'] = 28.85, ['y'] = -1349.0, ['z'] = 29.5, lock = false, perm = "0", perm2 = "0", public = true, other = 149 },

	[151] = { text = true, hash = 997554217, ['x'] = 2559.11, ['y'] = 385.75, ['z'] = 108.63, lock = false, perm = "0", perm2 = "0", public = true, other = 152 },
	[152] = { text = true, hash = 1196685123, ['x'] = 2559.18, ['y'] = 385.14, ['z'] = 108.63, lock = false, perm = "0", perm2 = "0", public = true, other = 151 },

	[153] = { text = true, hash = 2065277225, ['x'] = 1159.91, ['y'] = -326.42, ['z'] = 69.21, lock = false, perm = "0", perm2 = "0", public = true, other = 154 },
	[154] = { text = true, hash = -868672903, ['x'] = 1159.21, ['y'] = -326.61, ['z'] = 69.22, lock = false, perm = "0", perm2 = "0", public = true, other = 153 },

	[155] = { text = true, hash = 2065277225, ['x'] = -711.33, ['y'] = -916.43, ['z'] = 19.22, lock = false, perm = "0", perm2 = "0", public = true, other = 156 },
	[156] = { text = true, hash = -868672903, ['x'] = -712.26, ['y'] = -916.38, ['z'] = 19.22, lock = false, perm = "0", perm2 = "0", public = true, other = 155 },

	[157] = { text = true, hash = 2065277225, ['x'] = -52.62, ['y'] = -1756.72, ['z'] = 29.43, lock = false, perm = "0", perm2 = "0", public = true, other = 158 },
	[158] = { text = true, hash = -868672903, ['x'] = -53.37, ['y'] = -1756.19, ['z'] = 29.44, lock = false, perm = "0", perm2 = "0", public = true, other = 157 },

	[159] = { text = true, hash = 997554217, ['x'] = 376.98, ['y'] = 323.35, ['z'] = 103.58, lock = false, perm = "0", perm2 = "0", public = true, other = 160 },
	[160] = { text = true, hash = 1196685123, ['x'] = 376.16, ['y'] = 323.71, ['z'] = 103.57, lock = false, perm = "0", perm2 = "0", public = true, other = 159 },

	[161] = { text = true, hash = 997554217, ['x'] = -3240.08, ['y'] = 1004.82, ['z'] = 12.88, lock = false, perm = "0", perm2 = "0", public = true, other = 162 },
	[162] = { text = true, hash = -802238381, ['x'] = -3240.05, ['y'] = 1004.13, ['z'] = 12.88, lock = false, perm = "0", perm2 = "0", public = true, other = 161 },

	[163] = { text = true, hash = 997554217, ['x'] = 1731.67, ['y'] = 6411.22, ['z'] = 35.04, lock = false, perm = "0", perm2 = "0", public = true, other = 164 },
	[164] = { text = true, hash = 1196685123, ['x'] = 1730.9, ['y'] = 6411.67, ['z'] = 35.04, lock = false, perm = "0", perm2 = "0", public = true, other = 163 },

	[165] = { text = true, hash = 997554217, ['x'] = 543.87, ['y'] = 2672.46, ['z'] = 42.16, lock = false, perm = "0", perm2 = "0", public = true, other = 166 },
	[166] = { text = true, hash = 1196685123, ['x'] = 544.51, ['y'] = 2672.65, ['z'] = 42.16, lock = false, perm = "0", perm2 = "0", public = true, other = 165 },

	[167] = { text = true, hash = 997554217, ['x'] = 1965.17, ['y'] = 3741.0, ['z'] = 32.35, lock = false, perm = "0", perm2 = "0", public = true, other = 168 },
	[168] = { text = true, hash = 1196685123, ['x'] = 1964.65, ['y'] = 3740.53, ['z'] = 32.35, lock = false, perm = "0", perm2 = "0", public = true, other = 167 },

	[169] = { text = true, hash = 99755421, ['x'] = 2682.16, ['y'] = 3283.16, ['z'] = 55.25, lock = false, perm = "0", perm2 = "0", public = true, other = 170 },
	[170] = { text = true, hash = 1196685123, ['x'] = 2681.66, ['y'] = 3281.94, ['z'] = 55.25, lock = false, perm = "0", perm2 = "0", public = true, other = 169 },

	[171] = { text = true, hash = 2065277225, ['x'] = 1698.73, ['y'] = 4928.8, ['z'] = 42.08, lock = false, perm = "0", perm2 = "0", public = true, other = 172 },
	[172] = { text = true, hash = -868672903, ['x'] = 1699.33, ['y'] = 4929.51, ['z'] = 42.07, lock = false, perm = "0", perm2 = "0", public = true, other = 171 },

	[173] = { text = true, hash = 2065277225, ['x'] = -1822.19, ['y'] = 788.68, ['z'] = 138.19, lock = false, perm = "0", perm2 = "0", public = true, other = 174 },
	[174] = { text = true, hash = -868672903, ['x'] = -1822.69, ['y'] = 788.08, ['z'] = 138.2, lock = false, perm = "0", perm2 = "0", public = true, other = 173 },

	[175] = { text = true, hash = -1212951353, ['x'] = 1394.52, ['y'] = 3600.16, ['z'] = 34.99, lock = false, perm = "0", perm2 = "0", public = true, other = 176 },
	[176] = { text = true, hash = -1212951353, ['x'] = 1393.75, ['y'] = 3599.84, ['z'] = 34.99, lock = false, perm = "0", perm2 = "0", public = true, other = 175 },

	[177] = { text = true, hash = -1212951253,['x'] = -2973.29, ['y'] = 390.85, ['z'] = 15.05, lock = false, perm = "0", perm2 = "0", public = true },

	[178] = { text = true, hash = 997554217, ['x'] = -3038.79, ['y'] = 589.73, ['z'] = 7.92, lock = false, perm = "0", perm2 = "0", public = true, other = 179 },
	[179] = { text = true, hash = 1196685123, ['x'] = -3038.62, ['y'] = 589.17, ['z'] = 7.92, lock = false, perm = "0", perm2 = "0", public = true, other = 178 },

	[180] = { text = true, hash = -1212951353, ['x'] = 1140.99, ['y'] = -981.29, ['z'] = 46.42, lock = false, perm = "0", perm2 = "0", public = true },

	[181] = { text = true, hash = -1212951353, ['x'] = 1166.24, ['y'] = 2703.95, ['z'] = 38.16, lock = false, perm = "0", perm2 = "0", public = true },

	[182] = { text = true, hash = -1212951353, ['x'] = -1490.84, ['y'] = -383.03, ['z'] = 40.17, lock = false, perm = "0", perm2 = "0", public = true },

	[183] = { text = true, hash = -1212951353, ['x'] = -1226.19, ['y'] = -902.87, ['z'] = 12.33, lock = false, perm = "0", perm2 = "0", public = true },


	--[ FARMÁCIA ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[184] = { text = true, hash = 2059227086, ['x'] = 96.73, ['y'] = -225.84, ['z'] = 54.69, lock = false, perm = "0", perm2 = "0", public = true, other = 185 },
	[185] = { text = true, hash = 1417577297, ['x'] = 97.22, ['y'] = -226.06, ['z'] = 54.69, lock = false, perm = "0", perm2 = "0", public = true, other = 184 },

	[186] = { text = true, hash = 2059227086, ['x'] = 325.14, ['y'] = -1075.09, ['z'] = 29.49, lock = false, perm = "0", perm2 = "0", public = true, other = 187 },
	[187] = { text = true, hash = 1417577297, ['x'] = 325.68, ['y'] = -1074.92, ['z'] = 29.49, lock = false, perm = "0", perm2 = "0", public = true, other = 186 },

	--[ SALÃO DE BELEZA ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[188] = { text = true, hash = -1663512092, ['x'] = -822.71, ['y'] = -187.92, ['z'] = 37.57, lock = false, perm = "0", perm2 = "0", public = true, other = 189 },
	[189] = { text = true, hash = 145369505, ['x'] = -822.9, ['y'] = -187.51, ['z'] = 37.57, lock = false, perm = "0", perm2 = "0", public = true, other = 188 },

	[190] = { text = true, hash = -1844444717, ['x'] = 133.2, ['y'] = -1711.53, ['z'] = 29.3, lock = false, perm = "0", perm2 = "0", public = true },

	[191] = { text = true, hash = -1844444717, ['x'] = -1287.8, ['y'] = -1116.54, ['z'] = 7.0, lock = false, perm = "0", perm2 = "0", public = true },

	[192] = { text = true, hash = -1844444717, ['x'] = 1933.58, ['y'] = 3725.55, ['z'] = 32.85, lock = false, perm = "0", perm2 = "0", public = true },

	[193] = { text = true, hash = -1844444717, ['x'] = 1207.81, ['y'] = -470.87, ['z'] = 66.21, lock = false, perm = "0", perm2 = "0", public = true },

	[194] = { text = true, hash = -1844444717, ['x'] = -30.68, ['y'] = -147.84, ['z'] = 57.08, lock = false, perm = "0", perm2 = "0", public = true },

	[195] = { text = true, hash = -1844444717, ['x'] = -281.31, ['y'] = 6232.11, ['z'] = 31.7, lock = false, perm = "0", perm2 = "0", public = true },

	--[ AMMUNATION ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[196] = { text = true, hash = -8873588, ['x'] = 1699.19, ['y'] = 3752.87, ['z'] = 34.71, lock = false, perm = "0", perm2 = "0", public = true, other = 197 },
	[197] = { text = true, hash = 97297972, ['x'] = 1698.82, ['y'] = 3752.1, ['z'] = 34.71, lock = false, perm = "0", perm2 = "0", public = true, other = 196 },

	[198] = { text = true, hash = -8873588, ['x'] = 244.21, ['y'] = -45.55, ['z'] = 69.95, lock = false, perm = "0", perm2 = "0", public = true, other = 199 },
	[199] = { text = true, hash = 97297972, ['x'] = 244.51, ['y'] = -45.05, ['z'] = 69.95, lock = false, perm = "0", perm2 = "0", public = true, other = 198 },

	[200] = { text = true, hash = -8873588, ['x'] = 843.47, ['y'] = -1024.63, ['z'] = 28.2, lock = false, perm = "0", perm2 = "0", public = true, other = 201 },
	[201] = { text = true, hash = 97297972, ['x'] = 844.39, ['y'] = -1024.59, ['z'] = 28.21, lock = false, perm = "0", perm2 = "0", public = true, other = 200 },

	[202] = { text = true, hash = -8873588, ['x'] = -324.91, ['y'] = 6076.66, ['z'] = 31.46, lock = false, perm = "0", perm2 = "0", public = true, other = 202 },
	[203] = { text = true, hash = 97297972, ['x'] = -325.64, ['y'] = 6075.78, ['z'] = 31.46, lock = false, perm = "0", perm2 = "0", public = true, other = 203 },

	[204] = { text = true, hash = -8873588, ['x'] = -663.63, ['y'] = -944.07, ['z'] = 21.83, lock = false, perm = "0", perm2 = "0", public = true, other = 205 },
	[205] = { text = true, hash = 97297972, ['x'] = -664.37, ['y'] = -944.18, ['z'] = 21.83, lock = false, perm = "0", perm2 = "0", public = true, other = 204 },

	[206] = { text = true, hash = -8873588, ['x'] = -1314.0, ['y'] = -390.82, ['z'] = 36.7, lock = false, perm = "0", perm2 = "0", public = true, other = 207 },
	[207] = { text = true, hash = 97297972, ['x'] = -1313.81, ['y'] = -389.95, ['z'] = 36.7, lock = false, perm = "0", perm2 = "0", public = true, other = 206 },

	[208] = { text = true, hash = -8873588, ['x'] = -1112.72, ['y'] = 2691.17, ['z'] = 18.58, lock = false, perm = "0", perm2 = "0", public = true, other = 209 },
	[209] = { text = true, hash = 97297972, ['x'] = -1113.46, ['y'] = 2690.46, ['z'] = 18.57, lock = false, perm = "0", perm2 = "0", public = true, other = 208 },

	[210] = { text = true, hash = -8873588, ['x'] = 2569.37, ['y'] = 303.19, ['z'] = 108.74, lock = false, perm = "0", perm2 = "0", public = true, other = 211 },
	[211] = { text = true, hash = 97297972, ['x'] = 2569.98, ['y'] = 303.28, ['z'] = 108.74, lock = false, perm = "0", perm2 = "0", public = true, other = 210 },

	[212] = { text = true, hash = -8873588, ['x'] = -3164.24, ['y'] = 1082.87, ['z'] = 20.85, lock = false, perm = "0", perm2 = "0", public = true, other = 213 },
	[213] = { text = true, hash = 97297972, ['x'] = -3164.64, ['y'] = 1082.25, ['z'] = 20.84, lock = false, perm = "0", perm2 = "0", public = true, other = 212 },

	[214] = { text = true, hash = -8873588, ['x'] = 17.6, ['y'] = -1115.11, ['z'] = 29.8, lock = false, perm = "0", perm2 = "0", public = true, other = 215 },
	[215] = { text = true, hash = 97297972, ['x'] = 17.04, ['y'] = -1114.9, ['z'] = 29.8, lock = false, perm = "0", perm2 = "0", public = true, other = 214 },

	[216] = { text = true, hash = -8873588, ['x'] = 811.45, ['y'] = -2148.41, ['z'] = 29.62, lock = false, perm = "0", perm2 = "0", public = true, other = 217 },
	[217] = { text = true, hash = 97297972, ['x'] = 812.53, ['y'] = -2148.36, ['z'] = 29.62, lock = false, perm = "0", perm2 = "0", public = true, other = 216 },


	--[ TATUAGENS]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[218] = { text = true, hash = 543652229, ['x'] = 1321.87, ['y'] = -1650.05, ['z'] = 52.29, lock = false, perm = "0", perm2 = "0", public = true },

	[219] = { text = true, hash = 543652229, ['x'] = -1154.73, ['y'] = -1423.55, ['z'] = 4.96, lock = false, perm = "0", perm2 = "0", public = true },

	[220] = { text = true, hash = 543652229, ['x'] = 321.1, ['y'] = 178.71, ['z'] = 103.59, lock = false, perm = "0", perm2 = "0", public = true },

	[221] = { text = true, hash = 543652229, ['x'] = -3168.23, ['y'] = 1074.23, ['z'] = 20.83, lock = false, perm = "0", perm2 = "0", public = true },

	[221] = { text = true, hash = -1212951353, ['x'] = 1860.46, ['y'] = 3749.21, ['z'] = 33.04, lock = false, perm = "0", perm2 = "0", public = true },

	[223] = { text = true, hash = -1212951353, ['x'] = -289.78, ['y'] = 6199.54, ['z'] = 31.49, lock = false, perm = "0", perm2 = "0", public = true },

	--[ lOJA DE FERRAMENTAS]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[224] = { text = true, hash = 1183182250, ['x'] = -42.81, ['y'] = -1661.5, ['z'] = 29.5, lock = false, perm = "0", perm2 = "0", public = true, other = 225 },
	[225] = { text = true, hash = -44475594, ['x'] = -43.36, ['y'] = -1662.19, ['z'] = 29.5, lock = false, perm = "0", perm2 = "0", public = true, other = 224},

	[226] = { text = true, hash = -1821777087, ['x'] = -39.89, ['y'] = -1674.67, ['z'] = 29.5, lock = false, perm = "0", perm2 = "0", public = true, other = 227 },
	[227] = { text = true, hash = -1821777087, ['x'] = -40.89, ['y'] = -1673.8, ['z'] = 29.5, lock = false, perm = "0", perm2 = "0", public = true, other = 226 },

	--[ WEAZEL NEWS ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[228] = { text = true, hash = 1476344400, ['x'] = -597.8, ['y'] = -932.28, ['z'] = 23.84, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 229 },
	[229] = { text = true, hash = 206447435, ['x'] = -597.91, ['y'] = -931.64, ['z'] = 23.84, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 228 },

	[230] = { text = true, hash = 1476344400, ['x'] = -598.02, ['y'] = -930.07, ['z'] = 23.7, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 231 },
	[231] = { text = true, hash = 206447435, ['x'] = -597.95, ['y'] = -929.44, ['z'] = 23.84, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 230 },

	[232] = { text = true, hash = 1476344400, ['x'] = -597.88, ['y'] = -928.06, ['z'] = 23.84, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 233 },
	[233] = { text = true, hash = 206447435, ['x'] = -597.86, ['y'] = -927.6, ['z'] = 23.84, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 232 },

	[234] = { text = true, hash = 105027640, ['x'] = -593.03, ['y'] = -912.9, ['z'] = 23.82, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 235 },
	[235] = { text = true, hash = 970882927, ['x'] = -592.01, ['y'] = -913.08, ['z'] = 23.82, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 234 },

	[236] = { text = true, hash = 105027640, ['x'] = -590.33, ['y'] = -913.02, ['z'] = 23.82, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 237 },
	[237] = { text = true, hash = 970882927, ['x'] = -589.29, ['y'] = -913.02, ['z'] = 23.82, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 236 },

	[238] = { text = true, hash = -1482724697, ['x'] = -575.5, ['y'] = -939.54, ['z'] = 23.82, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 239 },
	[239] = { text = true, hash = 1991608532, ['x'] = -574.69, ['y'] = -939.66, ['z'] = 23.82, lock = true, perm = "jornal.permissao", perm2 = "lider-jornal.permissao", public = false, other = 238 },

	--[ WEAZEL NEWS ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[240] = { text = true, hash = -1116041313, ['x'] = 128.39, ['y'] = -1298.07, ['z'] = 29.27, lock = true, perm = "orgmthree.permissao", perm2 = "lider-orgmthree.permissao", public = false },

	--[ GALAXY ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[241] = { text = true, hash = -1989765534, ['x'] = 355.12, ['y'] = 301.11, ['z'] = 104.04, lock = true, perm = "orgmone.permissao", perm2 = "lider-orgmone.permissao", public = false },
	[242] = { text = true, hash = -1555108147, ['x'] = 377.9, ['y'] = 268.46, ['z'] = 95.0, lock = true, perm = "orgmone.permissao", perm2 = "lider-orgmone.permissao", public = false },
	[243] = { text = true, hash = 1695461688, ['x'] = 380.79, ['y'] = 266.44, ['z'] = 91.2, lock = true, perm = "orgmone.permissao", perm2 = "lider-orgmone.permissao", public = false },

	--[ WEAZEL NEWS ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[244] = { text = true, hash = 993120320, ['x'] = -564.43, ['y'] = 276.6, ['z'] = 83.14, lock = true, perm = "orgmtwo.permissao", perm2 = "lider-orgmtwo.permissao", public = false },

	--[ FABRICA COCA SUL ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[245] = { text = true, hash = 1427451548, ['x'] = 449.98, ['y'] = -1981.07, ['z'] = 24.49, lock = true, perm = "orgdone.permissao", perm2 = "lider-orgdone.permissao", public = false },

	--[ WEAZEL NEWS ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	--[246] = { text = true, hash = 1427451548, ['x'] = 449.98, ['y'] = -1981.07, ['z'] = 24.49, lock = true, perm = "orgdone.permissao", perm2 = "lider-orgdone.permissao", public = false },

	--[ WEAZEL NEWS ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[247] = { text = true, hash = 1427451548, ['x'] = 2522.19, ['y'] = 4124.19, ['z'] = 38.67, lock = true, perm = "orgdtwo.permissao", perm2 = "lider-orgdtwo.permissao", public = false },

	--[ EMS ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	[248] = { text = true, hash = 493136920, ['x'] = -440.25, ['y'] = -322.48, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[249] = { text = true, hash = 665455406, ['x'] = -443.59, ['y'] = -319.91, ['z'] = 34.92, lock = false, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 250 },
	[250] = { text = true, hash = 665455406, ['x'] = -444.77, ['y'] = -320.49, ['z'] = 34.92, lock = false, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 249 },
	[251] = { text = true, hash = 493136920, ['x'] = -442.88, ['y'] = -316.06, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[252] = { text = true, hash = 493136920, ['x'] = -446.85, ['y'] = -306.34, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[253] = { text = true, hash = 493136920, ['x'] = -449.26, ['y'] = -300.65, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[254] = { text = true, hash = 493136920, ['x'] = -452.53, ['y'] = -292.61, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[255] = { text = true, hash = 493136920, ['x'] = -457.46, ['y'] = -294.52, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[256] = { text = true, hash = 493136920, ['x'] = -455.34, ['y'] = -299.69, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[257] = { text = true, hash = 493136920, ['x'] = -452.97, ['y'] = -305.26, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[258] = { text = true, hash = 493136920, ['x'] = -451.93, ['y'] = -308.24, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[259] = { text = true, hash = 493136920, ['x'] = -449.65, ['y'] = -313.89, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	[260] = { text = true, hash = 493136920, ['x'] = -448.24, ['y'] = -316.89, ['z'] = 34.92, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false },
	
	[262] = { text = true, hash = 665455406, ['x'] = -456.6, ['y'] = -288.52, ['z'] = 34.92, lock = false, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 263 },
	[263] = { text = true, hash = 665455406, ['x'] = -457.52, ['y'] = -289.0, ['z'] = 34.92, lock = false, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 262 },


	--[Casa da Fazenda ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	[264] = { text = true, hash = -52575179, ['x'] = 1390.36, ['y'] = 1162.6, ['z'] = 114.34, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false, other = 265 },
	[265] = { text = true, hash = -1032171637, ['x'] = 1390.46, ['y'] = 1162.09, ['z'] = 114.34, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false, other = 264 },

	[266] = { text = true, hash = -1032171637, ['x'] = 1408.18, ['y'] = 1164.38, ['z'] = 114.34, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false, other = 267 },
	[267] = { text = true, hash = -52575179, ['x'] = 1408.24, ['y'] = 1165.01, ['z'] = 114.34, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false, other = 266 },

	[268] = { text = true, hash = -1032171637,['x'] = 1408.17, ['y'] = 1159.7, ['z'] = 114.34, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false, other = 269 },
	[269] = { text = true, hash = -52575179, ['x'] = 1408.24, ['y'] = 1160.34, ['z'] = 114.34, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false, other = 268 },

	[270] = { text = true, hash = 262671971, ['x'] = 1406.7, ['y'] = 1128.22, ['z'] = 114.34, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false},

	[271] = { text = true, hash = -2023754432, ['x'] = 1396.67, ['y'] = 1134.2, ['z'] = 109.75, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false},

	[272] = { text = true, hash = -2023754432, ['x'] = 1398.01, ['y'] = 1143.06, ['z'] = 109.75, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false},

	[273] = { text = true, hash = -1032171637, ['x'] = 1390.72, ['y'] = 1131.97, ['z'] = 114.34, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false, other = 274 },
	[274] = { text = true, hash = -52575179, ['x'] = 1390.63, ['y'] = 1132.47, ['z'] = 114.34, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false, other = 273 },
	
	[275] = { text = true, hash = 262671971, ['x'] = 1395.88, ['y'] = 1141.5, ['z'] = 114.66, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false, other = 276 },
	[276] = { text = true, hash = 1504256620, ['x'] = 1395.81, ['y'] = 1142.09, ['z'] = 114.66, lock = true, perm = "orggone.permissao", perm2 = "lider-orggone.permissao", public = false, other = 275 },

	--[Los Santos Custon1 ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	[277] = { text = true, hash = -550347177, ['x'] = -356.13, ['y'] = -134.68, ['z'] = 39.01, perm = "mecanico.permissao", perm2 = "lider-mecanico.permissao", public = false},

	--[Hospital]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	
    [278] = { text = true, hash = 665455406, ['x'] = -456.9, ['y'] = -288.7, ['z'] = -130.87, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", other = 279 },
	[279] = { text = true, hash = 665455406, ['x'] = -457.21, ['y'] = -288.98, ['z'] = -130.87, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", other = 278 },

	[280] = { text = true, hash = 493136920, ['x'] = -458.32, ['y'] = -292.65, ['z'] = -130.87, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[281] = { text = true, hash = 493136920, ['x'] = -452.76, ['y'] = -292.34, ['z'] = -130.87, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[282] = { text = true, hash = 493136920, ['x'] = -455.42, ['y'] = -299.67, ['z'] = -130.87, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[283] = { text = true, hash = 493136920, ['x'] = -449.47, ['y'] = -299.96, ['z'] = -130.87, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[284] = { text = true, hash = 493136920, ['x'] = -447.0, ['y'] = -306.31, ['z'] = -130.87, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[284] = { text = true, hash = 493136920, ['x'] = -451.66, ['y'] = -308.19, ['z'] = -130.87, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[285] = { text = true, hash = 665455406, ['x'] = -495.72, ['y'] = -333.25, ['z'] = 69.53, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 286 },
	[286] = { text = true, hash = 665455406, ['x'] = -495.75, ['y'] = -333.85, ['z'] = 69.53, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 285 },

	[287] = { text = true, hash = 493136920, ['x'] = -496.51, ['y'] = -337.96, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[288] = { text = true, hash = -551608542, ['x'] = -500.9, ['y'] = -335.83, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[289] = { text = true, hash = -551608542 ,['x'] = -500.53, ['y'] = -325.58, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[290] = { text = true, hash = -551608542, ['x'] = -502.41, ['y'] = -311.66, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[291] = { text = true, hash = -551608542, ['x'] = -503.61, ['y'] = -302.51, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[292] = { text = true, hash = 493136920, ['x'] = -484.32, ['y'] = -337.14, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[293] = { text = true, hash = 493136920, ['x'] = -483.77, ['y'] = -333.8, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[294] = { text = true, hash = 493136920, ['x'] = -476.93, ['y'] = -337.93, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[295] = { text = true, hash = 493136920, ['x'] = -476.21, ['y'] = -334.66, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},
	
	[296] = { text = true, hash = 493136920, ['x'] = -468.92, ['y'] = -335.75, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[297] = { text = true, hash = 493136920, ['x'] = -469.5, ['y'] = -338.91, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},
	
	[298] = { text = true, hash = 493136920, ['x'] = -461.33, ['y'] = -336.79, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[299] = { text = true, hash = 493136920, ['x'] = -462.37, ['y'] = -339.86, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[300] = { text = true, hash = 493136920, ['x'] = -453.78, ['y'] = -336.38, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	[301] = { text = true, hash = 493136920, ['x'] = -445.09, ['y'] = -342.29, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

   	[302] = { text = true, hash = 493136920, ['x'] = -440.14, ['y'] = -337.85, ['z'] = 69.53, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	
	[304] = { text = true, hash = 665455406, ['x'] = -444.56, ['y'] = -320.25, ['z'] = 69.53, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false, other = 305 },
	[305] = { text = true, hash = 665455406, ['x'] = -443.9, ['y'] = -320.08, ['z'] = 69.53, lock = true, perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false,other = 304 },

	[306] = { text = true, hash = 493136920, ['x'] = -446.91, ['y'] = -306.34, ['z'] = -130.87, lock = true,perm = "ems.permissao", perm2 = "paisana-ems.permissao", public = false},

	--[ Prefeitura ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[307] = { text = true, hash = -384927587, ['x'] = -545.96, ['y'] = -190.9, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 308 },
	[308] = { text = true, hash = -384927587, ['x'] = -546.39, ['y'] = -190.21, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 307 },
	[309] = { text = true, hash = -881696544, ['x'] = -541.16, ['y'] = -190.05, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false},
	[310] = { text = true, hash = 1335309163, ['x'] = -537.35, ['y'] = -183.37, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false},
	[311] = { text = true, hash = 1335309163, ['x'] = -541.25, ['y'] = -189.99, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false},
    [312] = { text = true, hash = 1335309163, ['x'] = -535.09, ['y'] = -186.68, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false},
	[313] = { text = true, hash = -384927587, ['x'] = -532.0, ['y'] = -183.28, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 314 },
	[314] = { text = true, hash = -384927587, ['x'] = -532.67, ['y'] = -182.23, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 313 },
	[315] = { text = true, hash = 736699661, ['x'] = -527.55, ['y'] = -185.06, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false},
	[316] = { text = true, hash = 736699661, ['x'] = -511.3, ['y'] = -205.25, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 317 },
	[317] = { text = true, hash = 736699661, ['x'] = -511.89, ['y'] = -205.56, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 316 },
	[318] = { text = true, hash = 736699661, ['x'] = -521.14, ['y'] = -181.46, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false},
	[319] = { text = true, hash = 1042741067, ['x'] = -519.95, ['y'] = -178.57, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false},
	[320] = { text = true, hash = 1042741067, ['x'] = -522.36, ['y'] = -174.31, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false},
	[321] = { text = true, hash = -384927587, ['x'] = -556.52, ['y'] = -196.16, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 322 },
	[322] = { text = true, hash = -384927587, ['x'] = -556.31, ['y'] = -196.79, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 321 },
	[323] = { text = true, hash = 1042741067, ['x'] = -557.62, ['y'] = -199.54, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 324 },
	[324] = { text = true, hash = 1042741067, ['x'] = -558.39, ['y'] = -200.01, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 323 },
	[325] = { text = true, hash = 1042741067, ['x'] = -561.37, ['y'] = -197.26, ['z'] = 38.22, lock = true,perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false},
	[326] = { text = true, hash = 1956494919, ['x'] = -567.42, ['y'] = -200.72, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 327 },
	[327] = { text = true, hash = 1956494919, ['x'] = -568.13, ['y'] = -201.1, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 326 },
	[328] = { text = true, hash = -384927587, ['x'] = -570.43, ['y'] = -204.2, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 329 },
	[329] = { text = true, hash = -384927587, ['x'] = -570.03, ['y'] = -204.8, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 328 },
	[330] = { text = true, hash = -739665083, ['x'] = -569.66, ['y'] = -209.71, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[331] = { text = true, hash = -739665083, ['x'] = -576.83, ['y'] = -213.81, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[332] = { text = true, hash = 1042741067, ['x'] = -579.66, ['y'] = -213.06, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[333] = { text = true, hash = 1042741067, ['x'] = -582.08, ['y'] = -208.79, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

 	--[Mansão-F]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	[334] = { text = true, hash = 159994461, ['x'] = -816.55, ['y'] = 178.52, ['z'] = 72.23, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 325 },
	[335] = { text = true, hash = -1686014385, ['x'] = -816.21, ['y'] = 178.09, ['z'] = 72.23, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 324 },
	[336] = { text = true, hash = -1454760130, ['x'] = -793.52, ['y'] = 181.18, ['z'] = 72.84, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 327 },
	[337] = { text = true, hash = 1245831483, ['x'] = -793.9, ['y'] = 181.81, ['z'] = 72.84, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[338] = { text = true, hash = -1454760130,['x'] = -795.83, ['y'] = 177.42, ['z'] = 72.84, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 339 },
	[339] = { text = true, hash = 1245831483,['x'] = -795.83, ['y'] = 177.42, ['z'] = 72.84, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false, other = 338 },
	[340] = { text = true, hash = -1563640173, ['x'] = -806.85, ['y'] = 185.62, ['z'] = 72.49, lock = true,perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

	--[Mansão-M]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
 	[341] = { text = true, hash = 308207762, ['x'] = -806.85, ['y'] = 185.62, ['z'] = 72.49, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

 	--[Mansão-p]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
 	[342] = { text = true, hash = 308207762, ['x'] = -3216.85, ['y'] = 815.42, ['z'] = 8.94, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
 
	--[ Hotel 1º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[343] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 31.37, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[344] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 31.37, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[345] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 31.37, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[346] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 31.37, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[347] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 31.37, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[348] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 31.37, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[349] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 31.37, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

	--[ Hotel 2º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[350] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 34.8, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[351] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 34.8, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[352] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 34.8, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[353] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 34.8, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[354] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 34.8, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[355] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 34.8, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[356] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 34.8, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

 	--[ Hotel 3º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[357] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[358] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[359] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[360] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[361] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[362] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[363] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 38.22, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

 	--[ Hotel 4º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[364] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 41.54, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[365] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 41.54, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[366] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 41.54, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[367] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 41.54, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[368] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 41.54, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[369] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 41.54, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[370] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 41.54, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

 	--[ Hotel 5º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[371] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 44.86, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[372] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 44.86, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[373] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 44.86, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[374] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 44.86, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[375] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 44.86, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[376] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 44.86, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[377] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 44.86, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

 	--[ Hotel 6º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[378] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 48.18 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[379] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 48.18 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[380] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 48.18 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[381] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 48.18 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[382] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 48.18 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[383] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 48.18 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[384] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 48.18 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

  	--[ Hotel 7º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[385] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 51.58 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[386] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 51.58 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[387] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 51.58 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[388] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 51.58 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[389] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 51.58 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[390] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 51.58 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[391] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 51.58 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

  	--[ Hotel 8º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[392] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 54.91 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[393] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 54.91 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[394] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 54.91 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[395] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 54.91 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[396] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 54.91 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[397] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 54.91 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[398] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 54.91 , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

  	--[ Hotel 9º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[399] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 58.22  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[400] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 58.22  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[401] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 58.22  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[402] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 58.22  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[403] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 58.22  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[404] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 58.22  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[405] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 58.22  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

   	--[ Hotel 10º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[406] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 61.51  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[407] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 61.51  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[408] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 61.51  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[409] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 61.51  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[410] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 61.51  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[411] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 61.51  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[412] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 61.51  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

   	--[ Hotel 11º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[413] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 64.82  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[414] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 64.82  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[415] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 64.82  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[416] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 64.82  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[417] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 64.82  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[418] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 64.82  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[419] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 64.82  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

   	--[ Hotel 12º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[420] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 68.19  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[421] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 68.19  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[422] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 68.19  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[423] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 68.19  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[424] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 68.19  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[425] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 68.19  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[426] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 68.19  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

  	--[ Hotel 13º ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 
	[427] = { text = false, hash = 1398355146, ['x'] = -1002.79, ['y'] = -775.57, ['z'] = 71.66  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[428] = { text = false, hash = 1398355146, ['x'] = -1002.75, ['y'] = -767.98, ['z'] = 71.66  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[429] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -753.32, ['z'] = 71.66  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[430] = { text = false, hash = 1398355146, ['x'] = -1002.84, ['y'] = -745.8, ['z'] = 71.66  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[431] = { text = false, hash = 1398355146, ['x'] = -1002.87, ['y'] = -738.47, ['z'] = 71.66  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[432] = { text = false, hash = 1398355146, ['x'] = -1002.86, ['y'] = -731.06, ['z'] = 71.66  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },
	[433] = { text = false, hash = 1398355146, ['x'] = -1002.89, ['y'] = -760.65, ['z'] = 71.66  , lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false },

	[434] = { text = true, hash = 1557126584, ['x'] = 449.86, ['y'] = -986.31, ['z'] = 30.69, lock = true, perm = "ems1.permissao", perm2 = "paisana1-ems1.permissao", public = false }
}

return cfg	