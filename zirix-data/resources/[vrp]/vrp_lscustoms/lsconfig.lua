local colors = {
	{ name = "Black", colorindex = 0 },
	{ name = "Carbon Black", colorindex = 147 },
	{ name = "Hraphite", colorindex = 1 },
	{ name = "Anhracite Black", colorindex = 11 },
	{ name = "Black Steel", colorindex = 2 },
	{ name = "Dark Steel", colorindex = 3 },
	{ name = "Silver", colorindex = 4 },
	{ name = "Bluish Silver", colorindex = 5 },
	{ name = "Rolled Steel", colorindex = 6 },
	{ name = "Shadow Silver", colorindex = 7 },
	{ name = "Stone Silver", colorindex = 8 },
	{ name = "Midnight Silver", colorindex = 9 },
	{ name = "Cast Iron Silver", colorindex = 10 },
	{ name = "Red", colorindex = 27 },
	{ name = "Torino Red", colorindex = 28 },
	{ name = "Formula Red", colorindex = 29 },
	{ name = "Lava Red", colorindex = 150 },
	{ name = "Blaze Red", colorindex = 30 },
	{ name = "Grace Red", colorindex = 31 },
	{ name = "Garnet Red", colorindex = 32 },
	{ name = "Sunset Red", colorindex = 33 },
	{ name = "Cabernet Red", colorindex = 34 },
	{ name = "Wine Red", colorindex = 143 },
	{ name = "Candy Red", colorindex = 35 },
	{ name = "Hot Pink", colorindex = 135 },
	{ name = "Pfsiter Pink", colorindex = 137 },
	{ name = "Salmon Pink", colorindex = 136 },
	{ name = "Sunrise Orange", colorindex = 36 },
	{ name = "Orange", colorindex = 38 },
	{ name = "Bright Orange", colorindex = 138 },
	{ name = "Gold", colorindex = 99 },
	{ name = "Bronze", colorindex = 90 },
	{ name = "Yellow", colorindex = 88 },
	{ name = "Race Yellow", colorindex = 89 },
	{ name = "Dew Yellow", colorindex = 91 },
	{ name = "Dark Green", colorindex = 49 },
	{ name = "Racing Green", colorindex = 50 },
	{ name = "Sea Green", colorindex = 51 },
	{ name = "Olive Green", colorindex = 52 },
	{ name = "Bright Green", colorindex = 53 },
	{ name = "Gasoline Green", colorindex = 54 },
	{ name = "Lime Green", colorindex = 92 },
	{ name = "Midnight Blue", colorindex = 141 },
	{ name = "Galaxy Blue", colorindex = 61 },
	{ name = "Dark Blue", colorindex = 62 },
	{ name = "Saxon Blue", colorindex = 63 },
	{ name = "Blue", colorindex = 64 },
	{ name = "Mariner Blue", colorindex = 65 },
	{ name = "Harbor Blue", colorindex = 66 },
	{ name = "Diamond Blue", colorindex = 67 },
	{ name = "Surf Blue", colorindex = 68 },
	{ name = "Nautical Blue", colorindex = 69 },
	{ name = "Racing Blue", colorindex = 73 },
	{ name = "Ultra Blue", colorindex = 70 },
	{ name = "Light Blue", colorindex = 74 },
	{ name = "Chocolate Brown", colorindex = 96 },
	{ name = "Bison Brown", colorindex = 101 },
	{ name = "Creeen Brown", colorindex = 95 },
	{ name = "Feltzer Brown", colorindex = 94 },
	{ name = "Maple Brown", colorindex = 97 },
	{ name = "Beechwood Brown", colorindex = 103 },
	{ name = "Sienna Brown", colorindex = 104 },
	{ name = "Saddle Brown", colorindex = 98 },
	{ name = "Moss Brown", colorindex = 100 },
	{ name = "Woodbeech Brown", colorindex = 102 },
	{ name = "Straw Brown", colorindex = 99 },
	{ name = "Sandy Brown", colorindex = 105 },
	{ name = "Bleached Brown", colorindex = 106 },
	{ name = "Schafter Purple", colorindex = 71 },
	{ name = "Spinnaker Purple", colorindex = 72 },
	{ name = "Midnight Purple", colorindex = 142 },
	{ name = "Bright Purple", colorindex = 145 },
	{ name = "Cream", colorindex = 107 },
	{ name = "Ice White", colorindex = 111 },
	{ name = "Frost White", colorindex = 112 }
}

local metalcolors = {
	{ name = "Brushed Steel", colorindex = 117 },
	{ name = "Brushed Black Steel", colorindex = 118 },
	{ name = "Brushed Aluminum", colorindex = 119 },
	{ name = "Pure Gold", colorindex = 158 },
	{ name = "Brushed Gold", colorindex = 159 }
}

local mattecolors = {
	{ name = "Black", colorindex = 12 },
	{ name = "Gray", colorindex = 13 },
	{ name = "Light Gray", colorindex = 14 },
	{ name = "Ice White", colorindex = 131 },
	{ name = "Blue", colorindex = 83 },
	{ name = "Dark Blue", colorindex = 82 },
	{ name = "Midnight Blue", colorindex = 84 },
	{ name = "Midnight Purple", colorindex = 149 },
	{ name = "Schafter Purple", colorindex = 148 },
	{ name = "Red", colorindex = 39 },
	{ name = "Dark Red", colorindex = 40 },
	{ name = "Orange", colorindex = 41 },
	{ name = "Yellow", colorindex = 42 },
	{ name = "Lime Green", colorindex = 55 },
	{ name = "Green", colorindex = 128 },
	{ name = "Frost Green", colorindex = 151 },
	{ name = "Foliage Green", colorindex = 155 },
	{ name = "Olive Darb", colorindex = 152 },
	{ name = "Dark Earth", colorindex = 153 },
	{ name = "Desert Tan", colorindex = 154 }
}

LSC_Config = {}
LSC_Config.prices = {}
LSC_Config.prices = {
	windowtint = {
		{ name = "Pure Black", tint = 1, price = 2700 },
		{ name = "Darksmoke", tint = 2, price = 2200 },
		{ name = "Lightsmoke", tint = 3, price = 1700 },
		{ name = "Limo", tint = 4, price = 2200 },
		{ name = "Green", tint = 5, price = 1200 },
	},
	chrome = {
		colors = {
			{ name = "Chrome", colorindex = 120 }
		},
		price = 3200
	},
	classic = {
		colors = colors,
		price = 3200
	},
	matte = {
		colors = mattecolors,
		price = 3200
	},
	metallic = {
		colors = colors,
		price = 3200
	},
	metal = {
		colors = metalcolors,
		price = 3200
	},
	chrome2 = {
		colors = {
			{ name = "Chrome", colorindex = 120 }
		},
		price = 1200
	},
	classic2 = {
		colors = colors,
		price = 1200
	},
	matte2 = {
		colors = mattecolors,
		price = 1200
	},
	metallic2 = {
		colors = colors,
		price = 1200
	},
	metal2 = {
		colors = metalcolors,
		price = 1200
	},
	neonlayout = {
		{ name = "Front,Back and Sides", price = 1200 }
	},
	neoncolor = {
		{ name = "White", neon = {255,255,255}, price = 2200 },
		{ name = "Blue", neon = {0,0,255}, price = 2200 },
		{ name = "Electric Blue", neon = {0,150,255}, price = 2200 },
		{ name = "Mint Green", neon = {50,255,155}, price = 2200 },
		{ name = "Lime Green", neon = {0,255,0}, price = 2200 },
		{ name = "Yellow", neon = {255,255,0}, price = 2200 },
		{ name = "Golden Shower", neon = {204,204,0}, price = 2200 },
		{ name = "Orange", neon = {255,128,0}, price = 2200 },
		{ name = "Red", neon = {255,0,0}, price = 2200 },
		{ name = "Pony Pink", neon = {255,102,255}, price = 2200 },
		{ name = "Hot Pink",neon = {255,0,255}, price = 2200 },
		{ name = "Purple", neon = {153,0,153}, price = 2200 },
		{ name = "Brown", neon = {139,69,19}, price = 2200 }
	},
	plates = {
		{ name = "Blue on White 1", plateindex = 0, price = 1700 },
		{ name = "Blue On White 2", plateindex = 3, price = 1700 },
		{ name = "Blue On White 3", plateindex = 4, price = 1700 },
		{ name = "Yellow on Blue", plateindex = 2, price = 1700 },
		{ name = "Yellow on Black", plateindex = 1, price = 1700 }
	},
	wheelaccessories = {
		{ name = "Stock Tires", price = 1200 },
		{ name = "Custom Tires", price = 1700 },
		--{ name = "Bulletproof Tires", price = 10000 },
		{ name = "White Tire Smoke", smokecolor = {254,254,254}, price = 2700 },
		{ name = "Black Tire Smoke", smokecolor = {1,1,1}, price = 2700 },
		{ name = "BLue Tire Smoke", smokecolor = {0,150,255}, price = 2700 },
		{ name = "Yellow Tire Smoke", smokecolor = {255,255,50}, price = 2700 },
		{ name = "Orange Tire Smoke", smokecolor = {255,153,51}, price = 2700 },
		{ name = "Red Tire Smoke", smokecolor = {255,10,10}, price = 2700 },
		{ name = "Green Tire Smoke", smokecolor = {10,255,10}, price = 2700 },
		{ name = "Purple Tire Smoke", smokecolor = {153,10,153}, price = 2700 },
		{ name = "Pink Tire Smoke", smokecolor = {255,102,178}, price = 2700 },
		{ name = "Gray Tire Smoke",smokecolor = {128,128,128}, price = 2700 }
	},
	wheelcolor = {
		colors = colors,
		price = 700
	},
	frontwheel = {
		{ name = "Stock", wtype = 6, mod = -1, price = 1200 },
		{ name = "Speedway", wtype = 6, mod = 0, price = 2700 },
		{ name = "Streetspecial", wtype = 6, mod = 1, price = 2700 },
		{ name = "Racer", wtype = 6, mod = 2, price = 2700 },
		{ name = "Trackstar", wtype = 6, mod = 3, price = 2700 },
		{ name = "Overlord", wtype = 6, mod = 4, price = 2700 },
		{ name = "Trident", wtype = 6, mod = 5, price = 2700 },
		{ name = "Triplethreat", wtype = 6, mod = 6, price = 2700 },
		{ name = "Stilleto", wtype = 6, mod = 7, price = 2700 },
		{ name = "Wires", wtype = 6, mod = 8, price = 2700 },
		{ name = "Bobber", wtype = 6, mod = 9, price = 2700 },
		{ name = "Solidus", wtype = 6, mod = 10, price = 2700 },
		{ name = "Iceshield", wtype = 6, mod = 11, price = 2700 },
		{ name = "Loops", wtype = 6, mod = 12, price = 2700 }
	},
	backwheel = {
		{ name = "Stock", wtype = 6, mod = -1, price = 1200 },
		{ name = "Speedway", wtype = 6, mod = 0, price = 2700 },
		{ name = "Streetspecial", wtype = 6, mod = 1, price = 2700 },
		{ name = "Racer", wtype = 6, mod = 2, price = 2700 },
		{ name = "Trackstar", wtype = 6, mod = 3, price = 2700 },
		{ name = "Overlord", wtype = 6, mod = 4, price = 2700 },
		{ name = "Trident", wtype = 6, mod = 5, price = 2700 },
		{ name = "Triplethreat", wtype = 6, mod = 6, price = 2700 },
		{ name = "Stilleto", wtype = 6, mod = 7, price = 2700 },
		{ name = "Wires", wtype = 6, mod = 8, price = 2700 },
		{ name = "Bobber", wtype = 6, mod = 9, price = 2700 },
		{ name = "Solidus", wtype = 6, mod = 10, price = 2700 },
		{ name = "Iceshield", wtype = 6, mod = 11, price = 2700 },
		{ name = "Loops", wtype = 6, mod = 12, price = 2700 }
	},
	sportwheels = {
		{ name = "Stock", wtype = 0, mod = -1, price = 1200 },
		{ name = "Inferno", wtype = 0, mod = 0, price = 7200 },
		{ name = "Deepfive", wtype = 0, mod = 1, price = 7200 },
		{ name = "Lozspeed", wtype = 0, mod = 2, price = 7200 },
		{ name = "Diamondcut", wtype = 0, mod = 3, price = 7200 },
		{ name = "Chrono", wtype = 0, mod = 4, price = 7200 },
		{ name = "Feroccirr", wtype = 0, mod = 5, price = 7200 },
		{ name = "Fiftynine", wtype = 0, mod = 6, price = 7200 },
		{ name = "Mercie", wtype = 0, mod = 7, price = 7200 },
		{ name = "Syntheticz", wtype = 0, mod = 8, price = 7200 },
		{ name = "Organictyped", wtype = 0, mod = 9, price = 7200 },
		{ name = "Endov1", wtype = 0, mod = 10, price = 7200 },
		{ name = "Duper7", wtype = 0, mod = 11, price = 7200 },
		{ name = "Uzer", wtype = 0, mod = 12, price = 7200 },
		{ name = "Groundride", wtype = 0, mod = 13, price = 7200 },
		{ name = "Spacer", wtype = 0, mod = 14, price = 7200 },
		{ name = "Venum", wtype = 0, mod = 15, price = 7200 },
		{ name = "Cosmo", wtype = 0, mod = 16, price = 7200 },
		{ name = "Dashvip", wtype = 0, mod = 17, price = 7200 },
		{ name = "Icekid", wtype = 0, mod = 18, price = 7200 },
		{ name = "Ruffeld", wtype = 0, mod = 19, price = 7200 },
		{ name = "Wangenmaster", wtype = 0, mod = 20, price = 7200 },
		{ name = "Superfive", wtype = 0, mod = 21, price = 7200 },
		{ name = "Endov2", wtype = 0, mod = 22, price = 7200 },
		{ name = "Slitsix", wtype = 0, mod = 23, price = 7200 }
	},
	suvwheels = {
		{ name = "Stock", wtype = 3, mod = -1, price = 1200 },
		{ name = "Enercy", wtype = 3, mod = 0, price = 7200 },
		{ name = "Benefactor", wtype = 3, mod = 1, price = 7200 },
		{ name = "Cosmo", wtype = 3, mod = 2, price = 7200 },
		{ name = "Bippu", wtype = 3, mod = 3, price = 7200 },
		{ name = "Royalsix", wtype = 3, mod = 4, price = 7200 },
		{ name = "Fagorme", wtype = 3, mod = 5, price = 7200 },
		{ name = "Deluxe", wtype = 3, mod = 6, price = 7200 },
		{ name = "Icedout", wtype = 3, mod = 7, price = 7200 },
		{ name = "Cognscenti", wtype = 3, mod = 8, price = 7200 },
		{ name = "Lozspeedten", wtype = 3, mod = 9, price = 7200 },
		{ name = "Supernova", wtype = 3, mod = 10, price = 7200 },
		{ name = "Obeyrs", wtype = 3, mod = 11, price = 7200 },
		{ name = "Lozspeedballer", wtype = 3, mod = 12, price = 7200 },
		{ name = "Extra vaganzo", wtype = 3, mod = 13, price = 7200 },
		{ name = "Splitsix", wtype = 3, mod = 14, price = 7200 },
		{ name = "Empowered", wtype = 3, mod = 15, price = 7200 },
		{ name = "Sunrise", wtype = 3, mod = 16, price = 7200 },
		{ name = "Dashvip", wtype = 3, mod = 17, price = 7200 },
		{ name = "Cutter", wtype = 3, mod = 18, price = 7200 }
	},
	offroadwheels = {
		{ name = "Stock", wtype = 4, mod = -1, price = 1200 },
		{ name = "Raider", wtype = 4, mod = 0, price = 7200 },
		{ name = "Mudslinger", wtype = 4, modtype = 23, wtype = 4, mod = 1, price = 7200 },
		{ name = "Nevis", wtype = 4, mod = 2, price = 7200 },
		{ name = "Cairngorm", wtype = 4, mod = 3, price = 7200 },
		{ name = "Amazon", wtype = 4, mod = 4, price = 7200 },
		{ name = "Challenger", wtype = 4, mod = 5, price = 7200 },
		{ name = "Dunebasher", wtype = 4, mod = 6, price = 7200 },
		{ name = "Fivestar", wtype = 4, mod = 7, price = 7200 },
		{ name = "Rockcrawler", wtype = 4, mod = 8, price = 7200 },
		{ name = "Milspecsteelie", wtype = 4, mod = 9, price = 7200 },
	},
	tunerwheels = {
		{ name = "Stock", wtype = 5, mod = -1, price = 1200 },
		{ name = "Cosmo", wtype = 5, mod = 0, price = 7200 },
		{ name = "Supermesh", wtype = 5, mod = 1, price = 7200 },
		{ name = "Outsider", wtype = 5, mod = 2, price = 7200 },
		{ name = "Rollas", wtype = 5, mod = 3, price = 7200 },
		{ name = "Driffmeister", wtype = 5, mod = 4, price = 7200 },
		{ name = "Slicer", wtype = 5, mod = 5, price = 7200 },
		{ name = "Elquatro", wtype = 5, mod = 6, price = 7200 },
		{ name = "Dubbed", wtype = 5, mod = 7, price = 7200 },
		{ name = "Fivestar", wtype = 5, mod = 8, price = 7200 },
		{ name = "Slideways", wtype = 5, mod = 9, price = 7200 },
		{ name = "Apex", wtype = 5, mod = 10, price = 7200 },
		{ name = "Stancedeg", wtype = 5, mod = 11, price = 7200 },
		{ name = "Countersteer", wtype = 5, mod = 12, price = 7200 },
		{ name = "Endov1", wtype = 5, mod = 13, price = 7200 },
		{ name = "Endov2dish", wtype = 5, mod = 14, price = 7200 },
		{ name = "Guppez", wtype = 5, mod = 15, price = 7200 },
		{ name = "Chokadori", wtype = 5, mod = 16, price = 7200 },
		{ name = "Chicane", wtype = 5, mod = 17, price = 7200 },
		{ name = "Saisoku", wtype = 5, mod = 18, price = 7200 },
		{ name = "Dishedeight", wtype = 5, mod = 19, price = 7200 },
		{ name = "Fujiwara", wtype = 5, mod = 20, price = 7200 },
		{ name = "Zokusha", wtype = 5, mod = 21, price = 7200 },
		{ name = "Battlevill", wtype = 5, mod = 22, price = 7200 },
		{ name = "Rallymaster", wtype = 5, mod = 23, price = 7200 }
	},
	importwheels = {
		{ name = "Stock", wtype = 0, mod = -1, price = 1200 },
		{ name = "Import 1", wtype = 0, mod = 50, price = 7200 },
		{ name = "Import 2", wtype = 0, mod = 51, price = 7200 },
		{ name = "Import 3", wtype = 0, mod = 52, price = 7200 },
		{ name = "Import 4", wtype = 0, mod = 53, price = 7200 },
		{ name = "Import 5", wtype = 0, mod = 54, price = 7200 },
		{ name = "Import 6", wtype = 0, mod = 55, price = 7200 },
		{ name = "Import 7", wtype = 0, mod = 56, price = 7200 },
		{ name = "Import 8", wtype = 0, mod = 57, price = 7200 },
		{ name = "Import 9", wtype = 0, mod = 58, price = 7200 },
		{ name = "Import 10", wtype = 0, mod = 59, price = 7200 },
		{ name = "Import 11", wtype = 0, mod = 60, price = 7200 },
		{ name = "Import 12", wtype = 0, mod = 61, price = 7200 },
		{ name = "Import 13", wtype = 0, mod = 62, price = 7200 },
		{ name = "Import 14", wtype = 0, mod = 63, price = 7200 },
		{ name = "Import 15", wtype = 0, mod = 64, price = 7200 },
		{ name = "Import 16", wtype = 0, mod = 65, price = 7200 },
		{ name = "Import 17", wtype = 0, mod = 66, price = 7200 },
		{ name = "Import 18", wtype = 0, mod = 67, price = 7200 },
		{ name = "Import 19", wtype = 0, mod = 68, price = 7200 },
		{ name = "Import 20", wtype = 0, mod = 69, price = 7200 },
		{ name = "Import 21", wtype = 0, mod = 70, price = 7200 },
		{ name = "Import 22", wtype = 0, mod = 71, price = 7200 },
		{ name = "Import 23", wtype = 0, mod = 72, price = 7200 },
		{ name = "Import 24", wtype = 0, mod = 73, price = 7200 },
		{ name = "Import 25", wtype = 0, mod = 74, price = 7200 },
		{ name = "Import 26", wtype = 0, mod = 75, price = 7200 },
		{ name = "Import 27", wtype = 0, mod = 76, price = 7200 },
		{ name = "Import 28", wtype = 0, mod = 77, price = 7200 },
		{ name = "Import 29", wtype = 0, mod = 78, price = 7200 },
		{ name = "Import 30", wtype = 0, mod = 79, price = 7200 },
		{ name = "Import 31", wtype = 0, mod = 80, price = 7200 },
		{ name = "Import 32", wtype = 0, mod = 81, price = 7200 },
		{ name = "Import 33", wtype = 0, mod = 82, price = 7200 },
		{ name = "Import 34", wtype = 0, mod = 83, price = 7200 },
		{ name = "Import 35", wtype = 0, mod = 84, price = 7200 },
		{ name = "Import 36", wtype = 0, mod = 85, price = 7200 },
		{ name = "Import 37", wtype = 0, mod = 86, price = 7200 },
		{ name = "Import 38", wtype = 0, mod = 87, price = 7200 },
		{ name = "Import 39", wtype = 0, mod = 88, price = 7200 },
		{ name = "Import 40", wtype = 0, mod = 89, price = 7200 },
		{ name = "Import 41", wtype = 0, mod = 90, price = 7200 },
		{ name = "Import 42", wtype = 0, mod = 91, price = 7200 },
		{ name = "Import 43", wtype = 0, mod = 92, price = 7200 },
		{ name = "Import 44", wtype = 0, mod = 93, price = 7200 },
		{ name = "Import 45", wtype = 0, mod = 94, price = 7200 },
		{ name = "Import 46", wtype = 0, mod = 95, price = 7200 },
		{ name = "Import 47", wtype = 0, mod = 96, price = 7200 },
		{ name = "Import 48", wtype = 0, mod = 97, price = 7200 },
		{ name = "Import 49", wtype = 0, mod = 98, price = 7200 },
		{ name = "Import 50", wtype = 0, mod = 99, price = 7200 },
		{ name = "Import 51", wtype = 0, mod = 100, price = 7200 },
		{ name = "Import 52", wtype = 0, mod = 101, price = 7200 },
		{ name = "Import 53", wtype = 0, mod = 102, price = 7200 },
		{ name = "Import 54", wtype = 0, mod = 103, price = 7200 },
		{ name = "Import 55", wtype = 0, mod = 104, price = 7200 },
		{ name = "Import 56", wtype = 0, mod = 105, price = 7200 },
		{ name = "Import 57", wtype = 0, mod = 106, price = 7200 },
		{ name = "Import 58", wtype = 0, mod = 107, price = 7200 },
		{ name = "Import 59", wtype = 0, mod = 108, price = 7200 },
		{ name = "Import 60", wtype = 0, mod = 109, price = 7200 },
		{ name = "Import 61", wtype = 0, mod = 110, price = 7200 },
		{ name = "Import 62", wtype = 0, mod = 111, price = 7200 },
		{ name = "Import 63", wtype = 0, mod = 112, price = 7200 },
		{ name = "Import 64", wtype = 0, mod = 113, price = 7200 },
		{ name = "Import 65", wtype = 0, mod = 114, price = 7200 },
		{ name = "Import 66", wtype = 0, mod = 115, price = 7200 },
		{ name = "Import 67", wtype = 0, mod = 116, price = 7200 },
		{ name = "Import 68", wtype = 0, mod = 117, price = 7200 },
		{ name = "Import 69", wtype = 0, mod = 118, price = 7200 },
		{ name = "Import 70", wtype = 0, mod = 119, price = 7200 },
		{ name = "Import 71", wtype = 0, mod = 120, price = 7200 },
		{ name = "Import 72", wtype = 0, mod = 121, price = 7200 },
		{ name = "Import 73", wtype = 0, mod = 122, price = 7200 },
		{ name = "Import 74", wtype = 0, mod = 123, price = 7200 },
		{ name = "Import 75", wtype = 0, mod = 124, price = 7200 },
		{ name = "Import 76", wtype = 0, mod = 125, price = 7200 },
		{ name = "Import 77", wtype = 0, mod = 126, price = 7200 },
		{ name = "Import 78", wtype = 0, mod = 127, price = 7200 },
		{ name = "Import 79", wtype = 0, mod = 128, price = 7200 },
		{ name = "Import 80", wtype = 0, mod = 129, price = 7200 },
		{ name = "Import 81", wtype = 0, mod = 130, price = 7200 },
		{ name = "Import 82", wtype = 0, mod = 131, price = 7200 },
		{ name = "Import 83", wtype = 0, mod = 132, price = 7200 },
		{ name = "Import 84", wtype = 0, mod = 133, price = 7200 },
		{ name = "Import 85", wtype = 0, mod = 134, price = 7200 },
		{ name = "Import 86", wtype = 0, mod = 135, price = 7200 },
		{ name = "Import 87", wtype = 0, mod = 136, price = 7200 },
		{ name = "Import 88", wtype = 0, mod = 137, price = 7200 },
		{ name = "Import 89", wtype = 0, mod = 138, price = 7200 },		
		{ name = "Import 90", wtype = 0, mod = 139, price = 7200 },
		{ name = "Import 91", wtype = 0, mod = 140, price = 7200 },
		{ name = "Import 92", wtype = 0, mod = 141, price = 7200 },
		{ name = "Import 93", wtype = 0, mod = 142, price = 7200 },
		{ name = "Import 94", wtype = 0, mod = 143, price = 7200 },
		{ name = "Import 95", wtype = 0, mod = 144, price = 7200 },
		{ name = "Import 96", wtype = 0, mod = 145, price = 7200 },
		{ name = "Import 97", wtype = 0, mod = 146, price = 7200 },
		{ name = "Import 98", wtype = 0, mod = 147, price = 7200 },
		{ name = "Import 99", wtype = 0, mod = 148, price = 7200 },
		{ name = "Import 100", wtype = 0, mod = 149, price = 7200 },
		{ name = "Import 101", wtype = 0, mod = 150, price = 7200 },
		{ name = "Import 102", wtype = 0, mod = 151, price = 7200 },
		{ name = "Import 103", wtype = 0, mod = 152, price = 7200 },
		{ name = "Import 104", wtype = 0, mod = 153, price = 7200 },
		{ name = "Import 105", wtype = 0, mod = 154, price = 7200 },
		{ name = "Import 106", wtype = 0, mod = 155, price = 7200 },
		{ name = "Import 107", wtype = 0, mod = 156, price = 7200 },
		{ name = "Import 108", wtype = 0, mod = 157, price = 7200 },
		{ name = "Import 109", wtype = 0, mod = 158, price = 7200 },
		{ name = "Import 110", wtype = 0, mod = 159, price = 7200 },
		{ name = "Import 111", wtype = 0, mod = 160, price = 7200 },
		{ name = "Import 112", wtype = 0, mod = 161, price = 7200 },
		{ name = "Import 113", wtype = 0, mod = 162, price = 7200 },
	},
	highendwheels = {
		{ name = "Stock", wtype = 7, mod = -1, price = 1200 },
		{ name = "Shadow", wtype = 7, mod = 0, price = 7200 },
		{ name = "Hyper", wtype = 7, mod = 1, price = 7200 },
		{ name = "Blade", wtype = 7, mod = 2, price = 7200 },
		{ name = "Diamond", wtype = 7, mod = 3, price = 7200 },
		{ name = "Supagee", wtype = 7, mod = 4, price = 7200 },
		{ name = "Chromaticz", wtype = 7, mod = 5, price = 7200 },
		{ name = "Merciechlip", wtype = 7, mod = 6, price = 7200 },
		{ name = "Obeyrs", wtype = 7, mod = 7, price = 7200 },
		{ name = "Gtchrome", wtype = 7, mod = 8, price = 7200 },
		{ name = "Cheetahr", wtype = 7, mod = 9, price = 7200 },
		{ name = "Solar", wtype = 7, mod = 10, price = 7200 },
		{ name = "Splitten", wtype = 7, mod = 11, price = 7200 },
		{ name = "Dashvip", wtype = 7, mod = 12, price = 7200 },
		{ name = "Lozspeedten", wtype = 7, mod = 13, price = 7200 },
		{ name = "Carboninferno", wtype = 7, mod = 14, price = 7200 },
		{ name = "Carbonshadow", wtype = 7, mod = 15, price = 7200 },
		{ name = "Carbonz", wtype = 7, mod = 16, price = 7200 },
		{ name = "Carbonsolar", wtype = 7, mod = 17, price = 7200 },
		{ name = "Carboncheetahr", wtype = 7, mod = 18, price = 7200 },
		{ name = "Carbonsracer", wtype = 7, mod = 19, price = 7200 }
	},
	lowriderwheels = {
		{ name = "Stock", wtype = 2, mod = -1, price = 1200 },
		{ name = "Flare", wtype = 2, mod = 0, price = 7200 },
		{ name = "Wired", wtype = 2, mod = 1, price = 7200 },
		{ name = "Triplegolds", wtype = 2, mod = 2, price = 7200 },
		{ name = "Bigworm", wtype = 2, mod = 3, price = 7200 },
		{ name = "Sevenfives", wtype = 2, mod = 4, price = 7200 },
		{ name = "Splitsix", wtype = 2, mod = 5, price = 7200 },
		{ name = "Freshmesh", wtype = 2, mod = 6, price = 7200 },
		{ name = "Leadsled", wtype = 2, mod = 7, price = 7200 },
		{ name = "Turbine", wtype = 2, mod = 8, price = 7200 },
		{ name = "Superfin", wtype = 2, mod = 9, price = 7200 },
		{ name = "Classicrod", wtype = 2, mod = 10, price = 7200 },
		{ name = "Dollar", wtype = 2, mod = 11, price = 7200 },
		{ name = "Dukes", wtype = 2, mod = 12, price = 7200 },
		{ name = "Lowfive", wtype = 2, mod = 13, price = 7200 },
		{ name = "Gooch", wtype = 2, mod = 14, price = 7200 }
	},
	musclewheels = {
		{ name = "Stock", wtype = 1, mod = -1, price = 1200 },
		{ name = "Classicfive", wtype = 1, mod = 0, price = 7200 },
		{ name = "Dukes", wtype = 1, mod = 1, price = 7200 },
		{ name = "Musclefreak", wtype = 1, mod = 2, price = 7200 },
		{ name = "Kracka", wtype = 1, mod = 3, price = 7200 },
		{ name = "Azrea", wtype = 1, mod = 4, price = 7200 },
		{ name = "Mecha", wtype = 1, mod = 5, price = 7200 },
		{ name = "Blacktop", wtype = 1, mod = 6, price = 7200 },
		{ name = "Dragspl", wtype = 1, mod = 7, price = 7200 },
		{ name = "Revolver", wtype = 1, mod = 8, price = 7200 },
		{ name = "Classicrod", wtype = 1, mod = 9, price = 7200 },
		{ name = "Spooner", wtype = 1, mod = 10, price = 7200 },
		{ name = "Fivestar", wtype = 1, mod = 11, price = 7200 },
		{ name = "Oldschool", wtype = 1, mod = 12, price = 7200 },
		{ name = "Eljefe", wtype = 1, mod = 13, price = 7200 },
		{ name = "Dodman", wtype = 1, mod = 14, price = 7200 },
		{ name = "Sixgun", wtype = 1, mod = 15, price = 7200 },
		{ name = "Mercenary", wtype = 1, mod = 16, price = 7200 }
	},
	trim = {
		colors = colors,
		price = 1700
	},
	mods = {
		[48] = {
			startprice = 1700,
			increaseby = 0
		},
		[46] = {
			startprice = 1700,
			increaseby = 0
		},
		[45] = {
			startprice = 1700,
			increaseby = 0
		},
		[44] = {
			startprice = 1700,
			increaseby = 0
		},
		[43] = {
			startprice = 1700,
			increaseby = 0
		},
		[42] = {
			startprice = 1700,
			increaseby = 0
		},
		[41] = {
			startprice = 1700,
			increaseby = 0
		},
		[40] = {
			startprice = 1700,
			increaseby = 0
		},
		[39] = {
			startprice = 1700,
			increaseby = 0
		},
		[38] = {
			startprice = 1700,
			increaseby = 0
		},
		[37] = {
			startprice = 1700,
			increaseby = 0
		},
		[36] = {
			startprice = 1700,
			increaseby = 0
		},
		[35] = {
			startprice = 1700,
			increaseby = 0
		},
		[34] = {
			startprice = 1700,
			increaseby = 0
		},
		[33] = {
			startprice = 1700,
			increaseby = 0
		},
		[32] = {
			startprice = 1700,
			increaseby = 0
		},
		[31] = {
			startprice = 1700,
			increaseby = 0
		},
		[30] = {
			startprice = 1700,
			increaseby = 0
		},
		[29] = {
			startprice = 1700,
			increaseby = 0
		},
		[28] = {
			startprice = 1700,
			increaseby = 0
		},
		[27] = {
			startprice = 1700,
			increaseby = 0
		},
		[26] = {
			startprice = 1700,
			increaseby = 0
		},
		[25] = {
			startprice = 1700,
			increaseby = 0
		},
		[22] = {
			{ name = "Stock", mod = 0, price = 1200 },
			{ name = "Xenon", mod = 1, price = 2700 }
		},
		[18] = {
			{ name = "None", mod = 0, price = 1200 },
			{ name = "Turbo", mod = 1, price = 15500 }
		},
		[16] = {
			{ name = "Blindagem 20%", modtype = 16, mod = 0, price = 55000 },
			{ name = "Blindagem 40%", modtype = 16, mod = 1, price = 65000 },
			{ name = "Blindagem 60%", modtype = 16, mod = 2, price = 75000 },
			{ name = "Blindagem 80%", modtype = 16, mod = 3, price = 85000 },
			{ name = "Blindagem 100%", modtype = 16, mod = 4, price = 95000 }
		},
		[15] = {
			{ name = "Lowered Suspension", mod = 0, price = 22500 },
			{ name = "Street Suspension", mod = 1, price = 27500 },
			{ name = "Sport Suspension", mod = 2, price = 32500 },
			{ name = "Race Suspension", mod = 3, price = 37500 }
		},
		[14] = {
			{ name = "Truck Horn", mod = 0, price = 2700 },
			{ name = "Police Horn", mod = 1, price = 2700 },
			{ name = "Clown Horn", mod = 2, price = 2700 },
			{ name = "Musical Horn 1", mod = 3, price = 2700 },
			{ name = "Musical Horn 2", mod = 4, price = 2700 },
			{ name = "Musical Horn 3", mod = 5, price = 2700 },
			{ name = "Musical Horn 4", mod = 6, price = 2700 },
			{ name = "Musical Horn 5", mod = 7, price = 2700 },
			{ name = "Sad Trombone", mod = 8, price = 2700 },
			{ name = "Classical Horn 1", mod = 9, price = 2700 },
			{ name = "Classical Horn 2", mod = 10, price = 2700 },
			{ name = "Classical Horn 3", mod = 11, price = 2700 },
			{ name = "Classical Horn 4", mod = 12, price = 2700 },
			{ name = "Classical Horn 5", mod = 13, price = 2700 },
			{ name = "Classical Horn 6", mod = 14, price = 2700 },
			{ name = "Classical Horn 7", mod = 15, price = 2700 },
			{ name = "Scale Do", mod = 16, price = 2700 },
			{ name = "Scale Re", mod = 17, price = 2700 },
			{ name = "Scale Mi", mod = 18, price = 2700 },
			{ name = "Scale Fa", mod = 19, price = 2700 },
			{ name = "Scale Sol", mod = 20, price = 2700 },
			{ name = "Scale La", mod = 21, price = 2700 },
			{ name = "Scale Ti", mod = 22, price = 2700 },
			{ name = "Scale Do (High)", mod = 23, price = 2700 },
			{ name = "Jazz Horn 1", mod = 24, price = 2700 },
			{ name = "Jazz Horn 2", mod = 25, price = 2700 },
			{ name = "Jazz Horn 3", mod = 26, price = 2700 },
			{ name = "Jazz Horn Loop", mod = 27, price = 2700 },
			{ name = "Star Spangled Banner 1", mod = 28, price = 2700 },
			{ name = "Star Spangled Banner 2", mod = 29, price = 2700 },
			{ name = "Star Spangled Banner 3", mod = 30, price = 2700 },
			{ name = "Star Spangled Banner 4", mod = 31, price = 2700 },
			{ name = "Classical Horn Loop 1", mod = 32, price = 2700 },
			{ name = "Classical Horn 8", mod = 33, price = 2700 },
			{ name = "Classical Horn Loop 2", mod = 34, price = 2700 },
			{ name = "Halloween Loop 1", mod = 38, price = 2700 },
			{ name = "Halloween Loop 2", mod = 40, price = 2700 },
			{ name = "San Andreas Loop", mod = 42, price = 2700 },
			{ name = "Liberty City Loop", mod = 44, price = 2700 },
			{ name = "Festive Loop 1", mod = 46, price = 2700 },
			{ name = "Festive Loop 2", mod = 47, price = 2700 },
			{ name = "Festive Loop 3", mod = 48, price = 2700 }
		},
		[13] = {
			{ name = "Street Transmission", mod = 0, price = 32000 },
			{ name = "Sports Transmission", mod = 1, price = 37000 },
			{ name = "Race Transmission", mod = 2, price = 42000 }
		},
		[12] = {
			{ name = "Street Brakes", mod = 0, price = 32000 },
			{ name = "Sport Brakes", mod = 1, price = 37000 },
			{ name = "Race Brakes", mod = 2, price = 42000 }
		},
		[11] = {
			{ name = "Street Engine", mod = 0, price = 32000 },
			{ name = "Sports Engine", mod = 1, price = 37000 },
			{ name = "Race Engine", mod = 2, price = 42000 },
			{ name = "Top Engine", mod = 3, price = 47000 }
		},
		[10] = {
			startprice = 2700,
			increaseby = 0
		},
		[8] = {
			startprice = 2700,
			increaseby = 0
		},
		[7] = {
			startprice = 2700,
			increaseby = 0
		},
		[6] = {
			startprice = 2700,
			increaseby = 0
		},
		[5] = {
			startprice = 2700,
			increaseby = 0
		},
		[4] = {
			startprice = 2700,
			increaseby = 0
		},
		[3] = {
			startprice = 2700,
			increaseby = 0
		},
		[2] = {
			startprice = 2700,
			increaseby = 0
		},
		[1] = {
			startprice = 2700,
			increaseby = 0
		},
		[0] = {
			startprice = 2700,
			increaseby = 0
		}
	}
}

LSC_Config.ModelBlacklist = {}

LSC_Config.lock = true
LSC_Config.oldenter = true

LSC_Config.menu = {
	controls = {
		menu_up = 27,
		menu_down = 173,
		menu_left = 174,
		menu_right = 175,
		menu_select = 201,
		menu_back = 177
	},
	position = "left",
	theme = "light",
	maxbuttons = 10,
	width = 0.24,
	height = 0.36
}