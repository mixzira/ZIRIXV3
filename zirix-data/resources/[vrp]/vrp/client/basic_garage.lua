function tvRP.getNearestVehicles(radius)
	local r = {}
	local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId()))

	local vehs = {}
	local it,veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end
	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok
	EndFindVehicle(it)

	for _,veh in pairs(vehs) do
		local x,y,z = table.unpack(GetEntityCoords(veh))
		local distance = Vdist(x,y,z,px,py,pz)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end

function tvRP.getNearestVehicle(radius)
	local veh
	local vehs = tvRP.getNearestVehicles(radius)
	local min = radius+0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh 
end

function tvRP.ejectVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
	end
end

function tvRP.isInVehicle()
	return IsPedSittingInAnyVehicle(PlayerPedId())
end

function tvRP.InVehicle()
	local ped = GetPlayerPed(i)
	if IsPedInAnyVehicle(ped) then
		return true
	end
	return false
end

function tvRP.GetVehicleSeat()
    return GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()),-1) == PlayerPedId()
end

--[ VEHLIST ]----------------------------------------------------------------------------------------------------------------------------

local vehList = {
	{ ['name'] = "blista", ['hash'] = -344943009, ['banned'] = false }, -- -- Preço: 22.000,00 | Porta-Malas: 20;
	{ ['name'] = "brioso", ['hash'] = 1549126457, ['banned'] = false },
	{ ['name'] = "dilettante", ['hash'] = -1130810103, ['banned'] = false }, -- Preço: 17.000,00 | Porta-Malas: 25;
	{ ['name'] = "issi2", ['hash'] = -1177863319, ['banned'] = false },
	{ ['name'] = "panto", ['hash'] = -431692672, ['banned'] = false }, -- Preço: 12.000,00 | Porta-Malas: 10;
	{ ['name'] = "prairie", ['hash'] = -1450650718, ['banned'] = false }, -- Preço: 27.000,00 | Porta-Malas: 20;
	{ ['name'] = "rhapsody", ['hash'] = 841808271, ['banned'] = false }, -- Preço: 12.000,00 | Porta-Malas: 10;
	{ ['name'] = "cogcabrio", ['hash'] = 330661258, ['banned'] = false },
	{ ['name'] = "emperor", ['hash'] = -685276541, ['banned'] = false }, -- Preço: 7.000,00 | Porta-Malas: 30;
	{ ['name'] = "emperor2", ['hash'] = -1883002148, ['banned'] = false },
	{ ['name'] = "phoenix", ['hash'] = -2095439403, ['banned'] = false },
	{ ['name'] = "premier", ['hash'] = -1883869285, ['banned'] = false }, -- Preço: 37.000,00 | Porta-Malas: 30;
	{ ['name'] = "glendale", ['hash'] = 75131841, ['banned'] = false },
	{ ['name'] = "intruder", ['hash'] = 886934177, ['banned'] = false }, -- Preço: 11.000,00 | Porta-Malas: 30;
	{ ['name'] = "exemplar", ['hash'] = -5153954, ['banned'] = false },
	{ ['name'] = "f620", ['hash'] = -591610296, ['banned'] = false },
	{ ['name'] = "felon", ['hash'] = -391594584, ['banned'] = false },
	{ ['name'] = "ingot", ['hash'] = -1289722222, ['banned'] = false },
	{ ['name'] = "felon2", ['hash'] = -89291282, ['banned'] = false },
	{ ['name'] = "jackal", ['hash'] = -624529134, ['banned'] = false },
	{ ['name'] = "oracle", ['hash'] = 1348744438, ['banned'] = false }, -- Preço: 28.000,00 | Porta-Malas: 30;
	{ ['name'] = "oracle2", ['hash'] = -511601230, ['banned'] = false },
	{ ['name'] = "sentinel", ['hash'] = 1349725314, ['banned'] = false },
	{ ['name'] = "sentinel2", ['hash'] = 873639469, ['banned'] = false },
	{ ['name'] = "windsor", ['hash'] = 1581459400, ['banned'] = false },
	{ ['name'] = "windsor2", ['hash'] = -1930048799, ['banned'] = false },
	{ ['name'] = "zion", ['hash'] = -1122289213, ['banned'] = false },
	{ ['name'] = "zion2", ['hash'] = -1193103848, ['banned'] = false },
	{ ['name'] = "blade", ['hash'] = -1205801634, ['banned'] = false },
	{ ['name'] = "buccaneer", ['hash'] = -682211828, ['banned'] = false },
	{ ['name'] = "buccaneer2", ['hash'] = -1013450936, ['banned'] = false },
	{ ['name'] = "primo", ['hash'] = -1150599089, ['banned'] = false }, -- Preço: 9.500,00 | Porta-Malas: 30;
	{ ['name'] = "primo2", ['hash'] = -2040426790, ['banned'] = false },
	{ ['name'] = "chino", ['hash'] = 349605904, ['banned'] = false },
	{ ['name'] = "chino2", ['hash'] = -1361687965, ['banned'] = false },
	{ ['name'] = "coquette3", ['hash'] = 784565758, ['banned'] = false },
	{ ['name'] = "dominator", ['hash'] = 80636076, ['banned'] = false },
	{ ['name'] = "dominator2", ['hash'] = 915704871, ['banned'] = false },
	{ ['name'] = "dukes", ['hash'] = 723973206, ['banned'] = false },
	{ ['name'] = "faction", ['hash'] = -2119578145, ['banned'] = false },
	{ ['name'] = "faction2", ['hash'] = -1790546981, ['banned'] = false },
	{ ['name'] = "faction3", ['hash'] = -2039755226, ['banned'] = false },
	{ ['name'] = "gauntlet", ['hash'] = -1800170043, ['banned'] = false },
	{ ['name'] = "gauntlet2", ['hash'] = 349315417, ['banned'] = false },
	{ ['name'] = "hermes", ['hash'] = 15219735, ['banned'] = false },
	{ ['name'] = "hotknife", ['hash'] = 37348240, ['banned'] = false },
	{ ['name'] = "moonbeam", ['hash'] = 525509695, ['banned'] = false },
	{ ['name'] = "moonbeam2", ['hash'] = 1896491931, ['banned'] = false },
	{ ['name'] = "nightshade", ['hash'] = -1943285540, ['banned'] = false },
	{ ['name'] = "picador", ['hash'] = 1507916787, ['banned'] = false },
	{ ['name'] = "ruiner", ['hash'] = -227741703, ['banned'] = false },
	{ ['name'] = "sabregt", ['hash'] = -1685021548, ['banned'] = false },
	{ ['name'] = "sabregt2", ['hash'] = 223258115, ['banned'] = false },
	{ ['name'] = "gburrito", ['hash'] = -1745203402, ['banned'] = false },
	{ ['name'] = "slamvan", ['hash'] = 729783779, ['banned'] = false },
	{ ['name'] = "slamvan2", ['hash'] = 833469436, ['banned'] = false },
	{ ['name'] = "slamvan3", ['hash'] = 1119641113, ['banned'] = false },
	{ ['name'] = "stalion", ['hash'] = 1923400478, ['banned'] = false },
	{ ['name'] = "stalion2", ['hash'] = -401643538, ['banned'] = false },
	{ ['name'] = "tampa", ['hash'] = 972671128, ['banned'] = false },
	{ ['name'] = "vigero", ['hash'] = -825837129, ['banned'] = false },
	{ ['name'] = "virgo", ['hash'] = -498054846, ['banned'] = false },
	{ ['name'] = "virgo2", ['hash'] = -899509638, ['banned'] = false },
	{ ['name'] = "virgo3", ['hash'] = 16646064, ['banned'] = false },
	{ ['name'] = "voodoo", ['hash'] = 2006667053, ['banned'] = false },
	{ ['name'] = "voodoo2", ['hash'] = 523724515, ['banned'] = false },
	{ ['name'] = "yosemite", ['hash'] = 1871995513, ['banned'] = false },
	{ ['name'] = "bfinjection", ['hash'] = 1126868326, ['banned'] = false },
	{ ['name'] = "bifta", ['hash'] = -349601129, ['banned'] = false },
	{ ['name'] = "bodhi2", ['hash'] = -1435919434, ['banned'] = false },
	{ ['name'] = "brawler", ['hash'] = -1479664699, ['banned'] = false },
	{ ['name'] = "trophytruck", ['hash'] = 101905590, ['banned'] = false },
	{ ['name'] = "trophytruck2", ['hash'] = -663299102, ['banned'] = false },
	{ ['name'] = "dubsta3", ['hash'] = -1237253773, ['banned'] = false },
	{ ['name'] = "mesa3", ['hash'] = -2064372143, ['banned'] = false },
	{ ['name'] = "rancherxl", ['hash'] = 1645267888, ['banned'] = false },
	{ ['name'] = "rebel", ['hash'] = -1207771834, ['banned'] = false },
	{ ['name'] = "rebel2", ['hash'] = -2045594037, ['banned'] = false },
	{ ['name'] = "riata", ['hash'] = -1532697517, ['banned'] = false },
	{ ['name'] = "dloader", ['hash'] = 1770332643, ['banned'] = false },
	{ ['name'] = "ratloader", ['hash'] = -667151410, ['banned'] = false },
	{ ['name'] = "sandking", ['hash'] = -1189015600, ['banned'] = false },
	{ ['name'] = "sandking2", ['hash'] = 989381445, ['banned'] = false },
	{ ['name'] = "baller", ['hash'] = -808831384, ['banned'] = false },
	{ ['name'] = "baller2", ['hash'] = 142944341, ['banned'] = false },
	{ ['name'] = "baller3", ['hash'] = 1878062887, ['banned'] = false },
	{ ['name'] = "baller4", ['hash'] = 634118882, ['banned'] = false },
	{ ['name'] = "baller5", ['hash'] = 470404958, ['banned'] = false },
	{ ['name'] = "baller6", ['hash'] = 666166960, ['banned'] = false },
	{ ['name'] = "bjxl", ['hash'] = 850565707, ['banned'] = false },
	{ ['name'] = "cavalcade", ['hash'] = 2006918058, ['banned'] = false },
	{ ['name'] = "cavalcade2", ['hash'] = -789894171, ['banned'] = false },
	{ ['name'] = "contender", ['hash'] = 683047626, ['banned'] = false },
	{ ['name'] = "dubsta", ['hash'] = 1177543287, ['banned'] = false },
	{ ['name'] = "dubsta2", ['hash'] = -394074634, ['banned'] = false },
	{ ['name'] = "fq2", ['hash'] = -1137532101, ['banned'] = false },
	{ ['name'] = "granger", ['hash'] = -1775728740, ['banned'] = false },
	{ ['name'] = "gresley", ['hash'] = -1543762099, ['banned'] = false },
	{ ['name'] = "habanero", ['hash'] = 884422927, ['banned'] = false },
	{ ['name'] = "seminole", ['hash'] = 1221512915, ['banned'] = false }, -- Preço: 41.000,00 | Porta-Malas: 55;
	{ ['name'] = "serrano", ['hash'] = 1337041428, ['banned'] = false },
	{ ['name'] = "xls", ['hash'] = 1203490606, ['banned'] = false },
	{ ['name'] = "xls2", ['hash'] = -432008408, ['banned'] = false },
	{ ['name'] = "asea", ['hash'] = -1809822327, ['banned'] = false }, -- Preço: 32.000,00 | Porta-Malas: 30;
	{ ['name'] = "asterope", ['hash'] = -1903012613, ['banned'] = false }, -- Preço: 49.000,00 | Porta-Malas: 35;
	{ ['name'] = "cog55", ['hash'] = 906642318, ['banned'] = false },
	{ ['name'] = "cog552", ['hash'] = 704435172, ['banned'] = false },
	{ ['name'] = "cognoscenti", ['hash'] = -2030171296, ['banned'] = false },
	{ ['name'] = "cognoscenti2", ['hash'] = -604842630, ['banned'] = false },
	{ ['name'] = "stanier", ['hash'] = -1477580979, ['banned'] = false }, -- Preço: 18.000,00 | Porta-Malas: 30;
	{ ['name'] = "stratum", ['hash'] = 1723137093, ['banned'] = false },
	{ ['name'] = "superd", ['hash'] = 1123216662, ['banned'] = false },
	{ ['name'] = "surge", ['hash'] = -1894894188, ['banned'] = false },
	{ ['name'] = "tailgater", ['hash'] = -1008861746, ['banned'] = false },
	{ ['name'] = "warrener", ['hash'] = 1373123368, ['banned'] = false },
	{ ['name'] = "washington", ['hash'] = 1777363799, ['banned'] = false },
	{ ['name'] = "alpha", ['hash'] = 767087018, ['banned'] = false },
	{ ['name'] = "banshee", ['hash'] = -1041692462, ['banned'] = false },
	{ ['name'] = "bestiagts", ['hash'] = 1274868363, ['banned'] = false },
	{ ['name'] = "blista2", ['hash'] = 1039032026, ['banned'] = false },
	{ ['name'] = "blista3", ['hash'] = -591651781, ['banned'] = false },
	{ ['name'] = "buffalo", ['hash'] = -304802106, ['banned'] = false },
	{ ['name'] = "buffalo2", ['hash'] = 736902334, ['banned'] = false },
	{ ['name'] = "buffalo3", ['hash'] = 237764926, ['banned'] = false },
	{ ['name'] = "carbonizzare", ['hash'] = 2072687711, ['banned'] = false },
	{ ['name'] = "comet2", ['hash'] = -1045541610, ['banned'] = false },
	{ ['name'] = "comet3", ['hash'] = -2022483795, ['banned'] = false },
	{ ['name'] = "comet5", ['hash'] = 661493923, ['banned'] = false },
	{ ['name'] = "coquette", ['hash'] = 108773431, ['banned'] = false },
	{ ['name'] = "elegy", ['hash'] = 196747873, ['banned'] = false },
	{ ['name'] = "elegy2", ['hash'] = -566387422, ['banned'] = false },
	{ ['name'] = "feltzer2", ['hash'] = -1995326987, ['banned'] = false },
	{ ['name'] = "furoregt", ['hash'] = -1089039904, ['banned'] = false },
	{ ['name'] = "fusilade", ['hash'] = 499169875, ['banned'] = false },
	{ ['name'] = "futo", ['hash'] = 2016857647, ['banned'] = false },
	{ ['name'] = "jester", ['hash'] = -1297672541, ['banned'] = false },
	{ ['name'] = "khamelion", ['hash'] = 544021352, ['banned'] = false },
	{ ['name'] = "kuruma", ['hash'] = -1372848492, ['banned'] = false },
	{ ['name'] = "massacro", ['hash'] = -142942670, ['banned'] = false },
	{ ['name'] = "massacro2", ['hash'] = -631760477, ['banned'] = false },
	{ ['name'] = "ninef", ['hash'] = 1032823388 , ['banned'] = false},
	{ ['name'] = "ninef2", ['hash'] = -1461482751, ['banned'] = false },
	{ ['name'] = "omnis", ['hash'] = -777172681, ['banned'] = false },
	{ ['name'] = "pariah", ['hash'] = 867799010, ['banned'] = false },
	{ ['name'] = "penumbra", ['hash'] = -377465520, ['banned'] = false },
	{ ['name'] = "raiden", ['hash'] = -1529242755, ['banned'] = false },
	{ ['name'] = "rapidgt", ['hash'] = -1934452204, ['banned'] = false },
	{ ['name'] = "rapidgt2", ['hash'] = 1737773231, ['banned'] = false },
	{ ['name'] = "ruston", ['hash'] = 719660200, ['banned'] = false },
	{ ['name'] = "schafter3", ['hash'] = -1485523546, ['banned'] = false },
	{ ['name'] = "schafter4", ['hash'] = 1489967196, ['banned'] = false },
	{ ['name'] = "schafter5", ['hash'] = -888242983, ['banned'] = false },
	{ ['name'] = "schwarzer", ['hash'] = -746882698, ['banned'] = false },
	{ ['name'] = "sentinel3", ['hash'] = 1104234922, ['banned'] = false },
	{ ['name'] = "seven70", ['hash'] = -1757836725, ['banned'] = false },
	{ ['name'] = "specter", ['hash'] = 1886268224, ['banned'] = false },
	{ ['name'] = "specter2", ['hash'] = 1074745671, ['banned'] = false },
	{ ['name'] = "streiter", ['hash'] = 1741861769, ['banned'] = false },
	{ ['name'] = "sultan", ['hash'] = 970598228, ['banned'] = false },
	{ ['name'] = "surano", ['hash'] = 384071873, ['banned'] = false },
	{ ['name'] = "tampa2", ['hash'] = -1071380347, ['banned'] = false },
	{ ['name'] = "tropos", ['hash'] = 1887331236, ['banned'] = false },
	{ ['name'] = "verlierer2", ['hash'] = 1102544804, ['banned'] = false },
	{ ['name'] = "btype", ['hash'] = 117401876, ['banned'] = false },
	{ ['name'] = "btype2", ['hash'] = -831834716, ['banned'] = false },
	{ ['name'] = "btype3", ['hash'] = -602287871, ['banned'] = false },
	{ ['name'] = "casco", ['hash'] = 941800958, ['banned'] = false },
	{ ['name'] = "cheetah", ['hash'] = -1311154784, ['banned'] = false },
	{ ['name'] = "coquette2", ['hash'] = 1011753235, ['banned'] = false },
	{ ['name'] = "feltzer3", ['hash'] = -1566741232, ['banned'] = false },
	{ ['name'] = "gt500", ['hash'] = -2079788230, ['banned'] = false },
	{ ['name'] = "infernus2", ['hash'] = -1405937764, ['banned'] = false },
	{ ['name'] = "jb700", ['hash'] = 1051415893, ['banned'] = false },
	{ ['name'] = "mamba", ['hash'] = -1660945322, ['banned'] = false },
	{ ['name'] = "manana", ['hash'] = -2124201592, ['banned'] = false },
	{ ['name'] = "monroe", ['hash'] = -433375717, ['banned'] = false },
	{ ['name'] = "peyote", ['hash'] = 1830407356, ['banned'] = false },
	{ ['name'] = "pigalle", ['hash'] = 1078682497, ['banned'] = false },
	{ ['name'] = "rapidgt3", ['hash'] = 2049897956, ['banned'] = false },
	{ ['name'] = "retinue", ['hash'] = 1841130506, ['banned'] = false },
	{ ['name'] = "stinger", ['hash'] = 1545842587, ['banned'] = false },
	{ ['name'] = "stingergt", ['hash'] = -2098947590, ['banned'] = false },
	{ ['name'] = "torero", ['hash'] = 1504306544, ['banned'] = false },
	{ ['name'] = "tornado", ['hash'] = 464687292, ['banned'] = false },
	{ ['name'] = "tornado2", ['hash'] = 1531094468, ['banned'] = false },
	{ ['name'] = "tornado5", ['hash'] = -1797613329, ['banned'] = false },
	{ ['name'] = "tornado6", ['hash'] = -1558399629, ['banned'] = false },
	{ ['name'] = "turismo2", ['hash'] = -982130927, ['banned'] = false },
	{ ['name'] = "ztype", ['hash'] = 758895617, ['banned'] = false },
	{ ['name'] = "adder", ['hash'] = -1216765807, ['banned'] = false },
	{ ['name'] = "autarch", ['hash'] = -313185164, ['banned'] = false },
	{ ['name'] = "banshee2", ['hash'] = 633712403, ['banned'] = false },
	{ ['name'] = "bullet", ['hash'] = -1696146015, ['banned'] = false },
	{ ['name'] = "cheetah2", ['hash'] = 223240013, ['banned'] = false },
	{ ['name'] = "entityxf", ['hash'] = -1291952903, ['banned'] = false },
	{ ['name'] = "fmj", ['hash'] = 1426219628, ['banned'] = false },
	{ ['name'] = "gp1", ['hash'] = 1234311532, ['banned'] = false },
	{ ['name'] = "infernus", ['hash'] = 418536135, ['banned'] = false },
	{ ['name'] = "nero", ['hash'] = 1034187331, ['banned'] = false },
	{ ['name'] = "nero2", ['hash'] = 1093792632, ['banned'] = false },
	{ ['name'] = "osiris", ['hash'] = 1987142870, ['banned'] = false },
	{ ['name'] = "penetrator", ['hash'] = -1758137366, ['banned'] = false },
	{ ['name'] = "pfister811", ['hash'] = -1829802492, ['banned'] = false },
	{ ['name'] = "reaper", ['hash'] = 234062309, ['banned'] = false },
	{ ['name'] = "sc1", ['hash'] = 1352136073, ['banned'] = false },
	{ ['name'] = "sultanrs", ['hash'] = -295689028, ['banned'] = false },
	{ ['name'] = "t20", ['hash'] = 1663218586, ['banned'] = false },
	{ ['name'] = "tempesta", ['hash'] = 272929391, ['banned'] = false },
	{ ['name'] = "turismor", ['hash'] = 408192225, ['banned'] = false },
	{ ['name'] = "tyrus", ['hash'] = 2067820283, ['banned'] = false },
	{ ['name'] = "vacca", ['hash'] = 338562499, ['banned'] = false },
	{ ['name'] = "visione", ['hash'] = -998177792, ['banned'] = false },
	{ ['name'] = "voltic", ['hash'] = -1622444098, ['banned'] = false },
	{ ['name'] = "zentorno", ['hash'] = -1403128555, ['banned'] = false },
	{ ['name'] = "sadler", ['hash'] = -599568815, ['banned'] = false },
	{ ['name'] = "bison", ['hash'] = -16948145, ['banned'] = false },
	{ ['name'] = "bison2", ['hash'] = 2072156101, ['banned'] = false },
	{ ['name'] = "bobcatxl", ['hash'] = 1069929536, ['banned'] = false },
	{ ['name'] = "burrito", ['hash'] = -1346687836, ['banned'] = false },
	{ ['name'] = "burrito2", ['hash'] = -907477130, ['banned'] = false },
	{ ['name'] = "burrito3", ['hash'] = -1743316013, ['banned'] = false },
	{ ['name'] = "burrito4", ['hash'] = 893081117, ['banned'] = false },
	{ ['name'] = "minivan", ['hash'] = -310465116, ['banned'] = false },
	{ ['name'] = "minivan2", ['hash'] = -1126264336, ['banned'] = false },
	{ ['name'] = "paradise", ['hash'] = 1488164764, ['banned'] = false },
	{ ['name'] = "pony", ['hash'] = -119658072, ['banned'] = false },
	{ ['name'] = "pony2", ['hash'] = 943752001, ['banned'] = false },
	{ ['name'] = "rumpo", ['hash'] = 1162065741, ['banned'] = false },
	{ ['name'] = "rumpo2", ['hash'] = -1776615689, ['banned'] = false },
	{ ['name'] = "rumpo3", ['hash'] = 1475773103, ['banned'] = false },
	{ ['name'] = "speedo", ['hash'] = -810318068, ['banned'] = false },
	{ ['name'] = "surfer", ['hash'] = 699456151, ['banned'] = false },
	{ ['name'] = "youga", ['hash'] = 65402552, ['banned'] = false },
	{ ['name'] = "youga2", ['hash'] = 1026149675, ['banned'] = false },
	{ ['name'] = "rebel", ['hash'] = -1207771834, ['banned'] = false },
	{ ['name'] = "tractor2", ['hash'] = -2076478498, ['banned'] = false },
	{ ['name'] = "huntley", ['hash'] = 486987393, ['banned'] = false },
	{ ['name'] = "landstalker", ['hash'] = 1269098716, ['banned'] = false },
	{ ['name'] = "mesa", ['hash'] = 914654722, ['banned'] = false },
	{ ['name'] = "patriot", ['hash'] = -808457413, ['banned'] = false },
	{ ['name'] = "radi", ['hash'] = -1651067813, ['banned'] = false },
	{ ['name'] = "rocoto", ['hash'] = 2136773105, ['banned'] = false },
	{ ['name'] = "tyrant", ['hash'] = -376434238, ['banned'] = false },
	{ ['name'] = "entity2", ['hash'] = -2120700196, ['banned'] = false },
	{ ['name'] = "cheburek", ['hash'] = -988501280, ['banned'] = false },
	{ ['name'] = "hotring", ['hash'] = 1115909093, ['banned'] = false },
	{ ['name'] = "jester3", ['hash'] = -214906006, ['banned'] = false },
	{ ['name'] = "flashgt", ['hash'] = -1259134696, ['banned'] = false },
	{ ['name'] = "ellie", ['hash'] = -1267543371, ['banned'] = false },
	{ ['name'] = "michelli", ['hash'] = 1046206681, ['banned'] = false },
	{ ['name'] = "fagaloa", ['hash'] = 1617472902, ['banned'] = false },
	{ ['name'] = "dominator2", ['hash'] = -915704871, ['banned'] = false },
	{ ['name'] = "dominator3", ['hash'] = -986944621, ['banned'] = false },
	{ ['name'] = "issi3", ['hash'] = 931280609, ['banned'] = false },
	{ ['name'] = "taipan", ['hash'] = -1134706562, ['banned'] = false },
	{ ['name'] = "gb200", ['hash'] = 1909189272, ['banned'] = false },
	{ ['name'] = "stretch", ['hash'] = -1961627517, ['banned'] = false },
	{ ['name'] = "guardian", ['hash'] = -2107990196, ['banned'] = false },
	{ ['name'] = "kamacho", ['hash'] = -121446169, ['banned'] = false },
	{ ['name'] = "neon", ['hash'] = -1848994066, ['banned'] = false },
	{ ['name'] = "cyclone", ['hash'] = 1392481335, ['banned'] = false },
	{ ['name'] = "italigtb", ['hash'] = -2048333973, ['banned'] = false },
	{ ['name'] = "italigtb2", ['hash'] = -482719877, ['banned'] = false },
	{ ['name'] = "vagner", ['hash'] = 1939284556, ['banned'] = false },
	{ ['name'] = "xa21", ['hash'] = 917809321, ['banned'] = false },
	{ ['name'] = "tezeract", ['hash'] = 1031562256, ['banned'] = false },
	{ ['name'] = "prototipo", ['hash'] = 2123327359, ['banned'] = false },
	{ ['name'] = "patriot2", ['hash'] = -420911112, ['banned'] = false },
	{ ['name'] = "stafford", ['hash'] = 321186144, ['banned'] = false },
	{ ['name'] = "swinger", ['hash'] = 500482303, ['banned'] = false },
	{ ['name'] = "clique", ['hash'] = -1566607184, ['banned'] = false },
	{ ['name'] = "deveste", ['hash'] = 1591739866, ['banned'] = false },
	{ ['name'] = "deviant", ['hash'] = 1279262537, ['banned'] = false },
	{ ['name'] = "impaler", ['hash'] = -2096690334, ['banned'] = false },
	{ ['name'] = "italigto", ['hash'] = -331467772, ['banned'] = false },
	{ ['name'] = "schlagen", ['hash'] = -507495760, ['banned'] = false },
	{ ['name'] = "toros", ['hash'] = -1168952148, ['banned'] = false },
	{ ['name'] = "tulip", ['hash'] = 1456744817, ['banned'] = false },
	{ ['name'] = "vamos", ['hash'] = -49115651, ['banned'] = false },
	{ ['name'] = "freecrawler", ['hash'] = -54332285, ['banned'] = false },	
	{ ['name'] = "fugitive", ['hash'] = 1909141499, ['banned'] = false },
	{ ['name'] = "le7b", ['hash'] = -1232836011, ['banned'] = false },
	{ ['name'] = "lurcher", ['hash'] = 2068293287, ['banned'] = false },
	{ ['name'] = "lynx", ['hash'] = 482197771, ['banned'] = false },
	{ ['name'] = "raptor", ['hash'] = -674927303, ['banned'] = false },
	{ ['name'] = "sheava", ['hash'] = 819197656, ['banned'] = false },
	{ ['name'] = "z190", ['hash'] = 838982985, ['banned'] = false },
	{ ['name'] = "akuma", ['hash'] = 1672195559, ['banned'] = false },
	{ ['name'] = "avarus", ['hash'] = -2115793025, ['banned'] = false },
	{ ['name'] = "bagger", ['hash'] = -2140431165, ['banned'] = false },
	{ ['name'] = "bati", ['hash'] = -114291515, ['banned'] = false },
	{ ['name'] = "bati2", ['hash'] = -891462355, ['banned'] = false },
	{ ['name'] = "bf400", ['hash'] = 86520421, ['banned'] = false },
	{ ['name'] = "carbonrs", ['hash'] = 11251904, ['banned'] = false },
	{ ['name'] = "chimera", ['hash'] = 6774487, ['banned'] = false },
	{ ['name'] = "cliffhanger", ['hash'] = 390201602, ['banned'] = false },
	{ ['name'] = "daemon", ['hash'] = 2006142190, ['banned'] = false },
	{ ['name'] = "daemon2", ['hash'] = -1404136503, ['banned'] = false },
	{ ['name'] = "defiler", ['hash'] = 822018448, ['banned'] = false },
	{ ['name'] = "diablous", ['hash'] = -239841468, ['banned'] = false },
	{ ['name'] = "diablous2", ['hash'] = 1790834270, ['banned'] = false },
	{ ['name'] = "double", ['hash'] = -1670998136, ['banned'] = false },
	{ ['name'] = "enduro", ['hash'] = 1753414259, ['banned'] = false }, -- Preço: 18.000,00 | Porta-Malas: 5;
	{ ['name'] = "esskey", ['hash'] = 2035069708, ['banned'] = false },
	{ ['name'] = "faggio", ['hash'] = -1842748181, ['banned'] = false }, -- Preço: 5.000,00 | Porta-Malas: 5;
	{ ['name'] = "faggio2", ['hash'] = 55628203, ['banned'] = false },
	{ ['name'] = "faggio3", ['hash'] = -1289178744, ['banned'] = false },
	{ ['name'] = "fcr", ['hash'] = 627535535, ['banned'] = false },
	{ ['name'] = "fcr2", ['hash'] = -757735410, ['banned'] = false },
	{ ['name'] = "gargoyle", ['hash'] = 741090084, ['banned'] = false },
	{ ['name'] = "hakuchou", ['hash'] = 1265391242, ['banned'] = false },
	{ ['name'] = "hakuchou2", ['hash'] = -255678177, ['banned'] = false },
	{ ['name'] = "hexer", ['hash'] = 301427732, ['banned'] = false },
	{ ['name'] = "innovation", ['hash'] = -159126838, ['banned'] = false },
	{ ['name'] = "lectro", ['hash'] = 640818791, ['banned'] = false },
	{ ['name'] = "manchez", ['hash'] = -1523428744, ['banned'] = false },
	{ ['name'] = "nemesis", ['hash'] = -634879114, ['banned'] = false },
	{ ['name'] = "nightblade", ['hash'] = -1606187161, ['banned'] = false },
	{ ['name'] = "pcj", ['hash'] = -909201658, ['banned'] = false }, -- Preço: 32.000,00 | Porta-Malas: 5;
	{ ['name'] = "ruffian", ['hash'] = -893578776, ['banned'] = false },
	{ ['name'] = "sanchez", ['hash'] = 788045382, ['banned'] = false },
	{ ['name'] = "sanchez2", ['hash'] = -1453280962, ['banned'] = false },
	{ ['name'] = "sanctus", ['hash'] = 1491277511, ['banned'] = false },
	{ ['name'] = "sovereign", ['hash'] = 743478836, ['banned'] = false },
	{ ['name'] = "thrust", ['hash'] = 1836027715, ['banned'] = false },
	{ ['name'] = "vader", ['hash'] = -140902153, ['banned'] = false },
	{ ['name'] = "vindicator", ['hash'] = -1353081087, ['banned'] = false },
	{ ['name'] = "vortex", ['hash'] = -609625092, ['banned'] = false },
	{ ['name'] = "wolfsbane", ['hash'] = -618617997, ['banned'] = false },
	{ ['name'] = "zombiea", ['hash'] = -1009268949, ['banned'] = false },
	{ ['name'] = "zombieb", ['hash'] = -570033273, ['banned'] = false },
	{ ['name'] = "blazer", ['hash'] = -2128233223, ['banned'] = true },
	{ ['name'] = "blazer4", ['hash'] = -440768424, ['banned'] = true },
	{ ['name'] = "shotaro", ['hash'] = -405626514, ['banned'] = false },
	{ ['name'] = "ratbike", ['hash'] = 1873600305, ['banned'] = false },
	
	{ ['name'] = "policiacharger2018", ['hash'] = 1743739647, ['banned'] = true },
	{ ['name'] = "policiasilverado", ['hash'] = 1884511084, ['banned'] = true },
	{ ['name'] = "policiatahoe", ['hash'] = 1865641415, ['banned'] = true },
	{ ['name'] = "policiataurus", ['hash'] = 112218935, ['banned'] = true },
	{ ['name'] = "policiabmwr1200", ['hash'] = -1624991916, ['banned'] = true },
	{ ['name'] = "policiaheli", ['hash'] = -875050963, ['banned'] = true },
	{ ['name'] = "policiabearcat", ['hash'] = -1748002214, ['banned'] = true },

	{ ['name'] = "ambulance", ['hash'] = 1171614426, ['banned'] = true },
	{ ['name'] = "paramedicoheli", ['hash'] = 2020690903, ['banned'] = false },

	{ ['name'] = "pbus", ['hash'] = -2007026063, ['banned'] = true },
	{ ['name'] = "mule4", ['hash'] = 1945374990, ['banned'] = false },
	{ ['name'] = "rallytruck", ['hash'] = -2103821244, ['banned'] = false },
	{ ['name'] = "riot", ['hash'] = -1205689942, ['banned'] = true },
	{ ['name'] = "coach", ['hash'] = -2072933068, ['banned'] = true },
	{ ['name'] = "bus", ['hash'] = -713569950, ['banned'] = true },
	{ ['name'] = "flatbed", ['hash'] = 1353720154, ['banned'] = true },
	{ ['name'] = "towtruck", ['hash'] = -1323100960, ['banned'] = true },
	{ ['name'] = "towtruck2", ['hash'] = -442313018, ['banned'] = true },
	{ ['name'] = "ratloader", ['hash'] = -667151410, ['banned'] = true },
	{ ['name'] = "ratloader2", ['hash'] = -589178377, ['banned'] = false },
	{ ['name'] = "rubble", ['hash'] = -1705304628, ['banned'] = true },
	{ ['name'] = "taxi", ['hash'] = -956048545, ['banned'] = true },
	{ ['name'] = "boxville2", ['hash'] = -233098306, ['banned'] = false },
	{ ['name'] = "boxville4", ['hash'] = 444171386, ['banned'] = false },
	{ ['name'] = "trash2", ['hash'] = -1255698084, ['banned'] = false },
	{ ['name'] = "tiptruck", ['hash'] = 48339065, ['banned'] = false },
	{ ['name'] = "scorcher", ['hash'] = -186537451, ['banned'] = true },
	{ ['name'] = "tribike", ['hash'] = 1127861609, ['banned'] = true },
	{ ['name'] = "tribike2", ['hash'] = -1233807380, ['banned'] = true },
	{ ['name'] = "tribike3", ['hash'] = -400295096, ['banned'] = true },
	{ ['name'] = "fixter", ['hash'] = -836512833, ['banned'] = true },
	{ ['name'] = "cruiser", ['hash'] = 448402357, ['banned'] = true },
	{ ['name'] = "bmx", ['hash'] = 1131912276, ['banned'] = true },
	{ ['name'] = "dinghy", ['hash'] = 1033245328, ['banned'] = true },
	{ ['name'] = "jetmax", ['hash'] = 861409633, ['banned'] = true },
	{ ['name'] = "marquis", ['hash'] = -1043459709, ['banned'] = true },
	{ ['name'] = "seashark3", ['hash'] = -311022263, ['banned'] = true },
	{ ['name'] = "speeder", ['hash'] = 231083307, ['banned'] = true },
	{ ['name'] = "speeder2", ['hash'] = 437538602, ['banned'] = true },
	{ ['name'] = "squalo", ['hash'] = 400514754, ['banned'] = true },
	{ ['name'] = "suntrap", ['hash'] = -282946103, ['banned'] = true },
	{ ['name'] = "toro", ['hash'] = 1070967343, ['banned'] = true },
	{ ['name'] = "toro2", ['hash'] = 908897389, ['banned'] = true },
	{ ['name'] = "tropic", ['hash'] = 290013743, ['banned'] = true },
	{ ['name'] = "tropic2", ['hash'] = 1448677353, ['banned'] = true },
	{ ['name'] = "phantom", ['hash'] = -2137348917, ['banned'] = true },
	{ ['name'] = "packer", ['hash'] = 569305213, ['banned'] = true },
	{ ['name'] = "supervolito", ['hash'] = 710198397, ['banned'] = true },
	{ ['name'] = "supervolito2", ['hash'] = -1671539132, ['banned'] = true },
	{ ['name'] = "seasparrow", ['hash'] = -726768679, ['banned'] = true },
	{ ['name'] = "cuban800", ['hash'] = -644710429, ['banned'] = true },
	{ ['name'] = "mammatus", ['hash'] = -1746576111, ['banned'] = true },
	{ ['name'] = "vestra", ['hash'] = 1341619767, ['banned'] = true },
	{ ['name'] = "velum2", ['hash'] = 1077420264, ['banned'] = true },
	{ ['name'] = "buzzard2", ['hash'] = 745926877, ['banned'] = true },
	{ ['name'] = "frogger", ['hash'] = 744705981, ['banned'] = true },
	{ ['name'] = "maverick", ['hash'] = -1660661558, ['banned'] = true },
	{ ['name'] = "tanker2", ['hash'] = 1956216962, ['banned'] = true },
	{ ['name'] = "armytanker", ['hash'] = -1207431159, ['banned'] = true },
	{ ['name'] = "tvtrailer", ['hash'] = -1770643266, ['banned'] = true },
	{ ['name'] = "trailerlogs", ['hash'] = 2016027501, ['banned'] = true },
	{ ['name'] = "tr4", ['hash'] = 2091594960, ['banned'] = true },
	{ ['name'] = "pounder", ['hash'] = 2112052861, ['banned'] = false },

	{ ['name'] = "audirs6", ['hash'] = 1676738519, ['banned'] = false },
	{ ['name'] = "bmwm3f80", ['hash'] = -157095615, ['banned'] = false },
	{ ['name'] = "bmwm4gts", ['hash'] = -13524981, ['banned'] = false },
	{ ['name'] = "dodgechargersrt", ['hash'] = 1601422646, ['banned'] = false },
	{ ['name'] = "ferrariitalia", ['hash'] = -1173768715, ['banned'] = false },
	{ ['name'] = "fordmustang", ['hash'] = -1573350092, ['banned'] = false },
	{ ['name'] = "lamborghinihuracan", ['hash'] = 1114244595, ['banned'] = false },
	{ ['name'] = "lancerevolutionx", ['hash'] = 1978088379, ['banned'] = false },
	{ ['name'] = "nissan370z", ['hash'] = -2015218779, ['banned'] = false },
	{ ['name'] = "nissangtr", ['hash'] = -60313827, ['banned'] = false },
	{ ['name'] = "nissanskyliner34", ['hash'] = -4816535, ['banned'] = false },
	{ ['name'] = "panamera17turbo", ['hash'] = 194366558, ['banned'] = false },
	{ ['name'] = "pm19", ['hash'] = -1560751994, ['banned'] = false },
	{ ['name'] = "teslaprior", ['hash'] = 351980252, ['banned'] = false },
	{ ['name'] = "toyotasupra", ['hash'] = 723779872, ['banned'] = false },

	{ ['name'] = "bmwm8", ['hash'] = -1404319008, ['banned'] = false },
	{ ['name'] = "urus", ['hash'] = -520214134, ['banned'] = false },
	{ ['name'] = "divo", ['hash'] = 1503141430, ['banned'] = false }
}

--[ VEHLIST ]----------------------------------------------------------------------------------------------------------------------------

function tvRP.vehListHash()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)

	if not IsPedInAnyVehicle(ped) then
		veh = GetPlayersLastVehicle()
	end

	if IsEntityAVehicle(veh) then
		for k,v in pairs(vehList) do
			if v.hash == GetEntityModel(veh) then
				if v.name then
					return veh,v.hash,GetVehicleNumberPlateText(veh),v.name
				end
			end
		end
	end
end

function tvRP.vehList(radius)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)

	if not IsPedInAnyVehicle(ped) then
		veh = tvRP.getNearestVehicle(radius)
	end

	if IsEntityAVehicle(veh) then
		local trunk = GetVehicleDoorAngleRatio(v,5)
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(vehList) do
			if v.hash == GetEntityModel(veh) then
				if v.name then
					local tuning = { GetNumVehicleMods(veh,13),GetNumVehicleMods(veh,12),GetNumVehicleMods(veh,15),GetNumVehicleMods(veh,11),GetNumVehicleMods(veh,16) }
					return veh,VehToNet(veh),GetVehicleNumberPlateText(veh),v.name,GetVehicleDoorsLockedForPlayer(veh,PlayerId()),v.banned,trunk,GetDisplayNameFromVehicleModel(v.name),GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z)),tuning
				end
			end
		end
	end
end