local cfg = {}

local parts = {
	["Defeitos"] = 0,
	["Barba"] = 1,
	["Sobrancelhas"] = 2,
	["Envelhecimento"] = 3,
	["Maquiagem"] = 4,
	["Blush"] = 5,
	["Rugas"] = 6,
	["Batom"] = 8,
	["Sardas"] = 9,
	["Cabelo no Peito"] = 10,
	["Manchas no Corpo"] = 11,
	["Cabelo"] = 12,
	["Cor Sec. do Cabelo"] = 13
}

cfg.barbershops = {
	{ parts,-815.59,-182.16,37.56 },
	{ parts,139.21,-1708.96,29.30 },
	{ parts,-1282.00,-1118.86,7.00 },
	{ parts,1934.11,3730.73,32.85 },
	{ parts,1211.07,-475.00,66.21 },
	{ parts,-34.97,-150.90,57.08 },
	{ parts,-280.37,6227.01,31.70 },
	{ parts,-3206.92,782.93,14.09 }
}

return cfg