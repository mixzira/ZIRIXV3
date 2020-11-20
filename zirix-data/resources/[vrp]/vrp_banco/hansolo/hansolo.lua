local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

banK = Tunnel.getInterface("vrp_banco")

--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------

inMenu = true
local andamento = false
local segundos = 0
local showblips	= true
local atBanco = false
local BancoMenu	= true
local blip = nil
local hora = 0

--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------

local locais = {
	{ ['id'] = 1, ['x'] = 119.10, ['y'] = -883.70, ['z'] = 31.12, ['h'] = 71.0 },
	{ ['id'] = 2, ['x'] = -1315.80, ['y'] = -834.76, ['z'] = 16.96, ['h'] = 305.0 },
	{ ['id'] = 3, ['x'] = 285.45, ['y'] = 143.39, ['z'] = 104.18, ['h'] = 159.0 },
	{ ['id'] = 4, ['x'] = 1138.23, ['y'] = -468.89, ['z'] = 66.73, ['h'] = 74.0 },
	{ ['id'] = 5, ['x'] = 1077.76, ['y'] = -776.54, ['z'] = 58.25, ['h'] = 182.0 },
	{ ['id'] = 6, ['x'] = -712.89, ['y'] = -818.9, ['z'] = 23.73, ['h'] = 0.0 },
	{ ['id'] = 7, ['x'] = -821.7, ['y'] = -1081.93, ['z'] = 11.14, ['h'] = 31.0 },
	{ ['id'] = 8,['x'] = -1409.79, ['y'] = -100.47, ['z'] = 52.39, ['h'] = 107.0 },
	{ ['id'] = 9, ['x'] = -846.27, ['y'] = -341.33, ['z'] = 38.69, ['h'] = 116.0 },
	{ ['id'] = 10, ['x'] = -2072.44, ['y'] = -317.22, ['z'] = 13.32, ['h'] = 260.0 },
	{ ['id'] = 11, ['x'] = -526.61, ['y'] = -1222.98, ['z'] = 18.46, ['h'] = 153.0 },
	{ ['id'] = 12, ['x'] = -254.39, ['y'] = -692.46, ['z'] = 33.61, ['h'] = 159.0 },
	{ ['id'] = 13, ['x'] = -283.0, ['y'] = 6226.13, ['z'] = 31.5, ['h'] = 313.90 },
	{ ['id'] = 14, ['x'] = 155.91, ['y'] = 6642.9, ['z'] = 31.61, ['h'] = 313.90 }
}

local Bancos = {
	{name='Banco', id=108, x=148.55, y=-1040.32, z=29.38}, --
	{name='Banco', id=108, x=149.87, y=-1040.82, z=29.38}, --
	
	{name='Banco', id=108, x=-1212.6, y=-330.8, z=37.8}, --
	{name='Banco', id=108, x=-1213.95, y=-331.41, z=37.8}, --
	
	{name='Banco', id=108, x=-2962.53, y=482.94, z=15.71}, --
	{name='Banco', id=108, x=-2962.67, y=481.37, z=15.71}, --

	{name='Banco', id=108, x=-113.08, y=6470.28, z=31.63}, --
	{name='Banco', id=108, x=-112.05, y=6469.16, z=31.63}, --
	{name='Banco', id=108, x=-111.05, y=6468.15, z=31.63}, --

	{name='Banco', id=108, x=312.83, y=-278.67, z=54.18}, --
	{name='Banco', id=108, x=314.22, y=-279.18, z=54.18}, --

	{name='Banco', id=108, x=241.41, y=225.45, z=106.29, principal = true}, --
	{name='Banco', id=108, x=243.13, y=224.71, z=106.29, principal = true}, --
	{name='Banco', id=108, x=246.52, y=223.56, z=106.29, principal = true}, --
	{name='Banco', id=108, x=248.34, y=222.87, z=106.29, principal = true}, --
	{name='Banco', id=108, x=251.73, y=221.66, z=106.29, principal = true}, --
	{name='Banco', id=108, x=253.62, y=221.05, z=106.29, principal = true}, --

	{name='Banco', id=108, x=-350.98, y=-49.89, z=49.05}, --
	{name='Banco', id=108, x=-352.36, y=-49.47, z=49.05}, --

	{name='Banco', id=108, x=1175.09, y=2706.91, z=38.1}, --
	{name='Banco', id=108, x=1176.55, y=2706.91, z=38.1} --
}	

local atms = {
	{name='ATM', id=277, x=145.97, y=-1035.17, z=29.35},
	{name='ATM', id=277, x=147.63, y=-1035.69, z=29.35},
	{name='ATM', id=277, x=-586.48, y=-143.28, z=47.21},
	{name='ATM', id=277, x=-588.52, y=-141.19, z=47.21},
	{name='ATM', id=277, x=-587.47, y=-142.29, z=47.21},
	{name='ATM', id=277, x=-577.08, y=-194.81, z=38.22},
	{name='ATM', id=277, x=-527.75, y=-166.08, z=38.24},
	{name='ATM', id=277, x=-537.25, y=-171.61, z=38.22},
	{name='ATM', id=277, x=-386.733, y=6045.953, z=31.501},
	{name='ATM', id=277, x=-283.03, y=6226.09, z=31.5, assaltavel=true},
	{name='ATM', id=277, x=-132.99, y=6366.5, z=31.48},
	{name='ATM', id=277, x=-97.3, y=6455.44, z=31.47},
	{name='ATM', id=277, x=-95.53, y=6457.11, z=31.47}, 
	{name='ATM', id=277, x=155.91, y=6642.9, z=31.61, assaltavel=true},
	{name='ATM', id=277, x=174.14, y=6637.92, z=31.58},
	{name='ATM', id=277, x=1701.21, y=6426.56, z=32.77},
	{name='ATM', id=277, x=1735.27, y=6410.52, z=35.04},
	{name='ATM', id=277, x=1703.03, y=4933.59, z=42.07},
	{name='ATM', id=277, x=1968.09, y=3743.54, z=32.35},
	{name='ATM', id=277, x=1822.67, y=3683.1, z=34.28},
	{name='ATM', id=277, x=540.29, y=2671.14, z=42.16},
	{name='ATM', id=277, x=2564.5, y=2584.79, z=38.09},
	{name='ATM', id=277, x=2558.76, y=351.01, z=108.63},
	{name='ATM', id=277, x=2558.5, y=389.49, z=108.63},
	{name='ATM', id=277, x=1077.76, y=-776.54, z=58.25, assaltavel=true},
	{name='ATM', id=277, x=1166.96, y=-456.13, z=66.81},
	{name='ATM', id=277, x=1153.73, y=-326.8, z=69.21},
	{name='ATM', id=277, x=380.77, y=323.39, z=103.57},
	{name='ATM', id=277, x=285.51, y=143.42, z=104.18, assaltavel=true},
	{name='ATM', id=277, x=158.65, y=234.22, z=106.63},
	{name='ATM', id=277, x=-165.1, y=232.72, z=94.93},
	{name='ATM', id=277, x=-165.16, y=234.77, z=94.93},
	{name='ATM', id=277, x=-1827.26, y=784.89, z=138.31},
	{name='ATM', id=277, x=-1409.74, y=-100.47, z=52.39, assaltavel=true},
	{name='ATM', id=277, x=-1410.35, y=-98.75, z=52.43},
	{name='ATM', id=277, x=-1204.97, y=-326.33, z=37.84},
	{name='ATM', id=277, x=-1205.75, y=-324.82, z=37.86},
	{name='ATM', id=277, x=-1215.64, y=-332.231, z=37.881},
	{name='ATM', id=277, x=-2072.35, y=-317.24, z=13.32, assaltavel=true},
	{name='ATM', id=277, x=-2975.07, y=380.14, z=15.0},
	{name='ATM', id=277, x=-2956.82, y=487.68, z=15.47},
	{name='ATM', id=277, x=-2958.98, y=487.74, z=15.47},
	{name='ATM', id=277, x=-3043.98, y=594.57, z=7.74},
	{name='ATM', id=277, x=-3144.39, y=1127.58, z=20.86},
	{name='ATM', id=277, x=-3241.17, y=997.59, z=12.56},
	{name='ATM', id=277, x=-3240.57, y=1008.61, z=12.84},
	{name='ATM', id=277, x=-1305.36, y=-706.43, z=25.33},
	{name='ATM', id=277, x=-537.81, y=-854.51, z=29.3},
	{name='ATM', id=277, x=-712.95, y=-818.91, z=23.73, assaltavel=true},
	{name='ATM', id=277, x=-710.09, y=-818.91, z=23.73},
	{name='ATM', id=277, x=-717.71, y=-915.73, z=19.22},
	{name='ATM', id=277, x=-526.61, y=-1222.98, z=18.46, assaltavel=true},
	{name='ATM', id=277, x=-256.24, y=-716.02, z=33.53},
	{name='ATM', id=277, x=-203.8, y=-861.4, z=30.27},
	{name='ATM', id=277, x=111.22, y=-775.22, z=31.44},
	{name='ATM', id=277, x=114.39, y=-776.35, z=31.42},
	{name='ATM', id=277, x=112.62, y=-819.41, z=31.34},
	{name='ATM', id=277, x=119.05, y=-883.69, z=31.13, assaltavel=true},
	{name='ATM', id=277, x=-846.25, y=-341.33, z=38.69, assaltavel=true},
	{name='ATM', id=277, x=-846.84, y=-340.21, z=38.69},
	{name='ATM', id=277, x=-1204.98, y=-326.33, z=37.84},
	{name='ATM', id=277, x=-56.96, y=-1752.07, z=29.43},
	{name='ATM', id=277, x=-262.03, y=-2012.33, z=30.15},
	{name='ATM', id=277, x=-273.11, y=-2024.54, z=30.15},
	{name='ATM', id=277, x=24.44, y=-945.97, z=29.36},
	{name='ATM', id=277, x=-254.39, y=-692.46, z=33.61, assaltavel=true},
	{name='ATM', id=277, x=-1570.197, y=-546.651, z=34.955},
	{name='ATM', id=277, x=-1571.03, y=-547.37, z=34.96},
	{name='ATM', id=277, x=-1415.94, y=-212.02, z=46.51},
	{name='ATM', id=277, x=-1430.112, y=-211.014, z=46.500},
	{name='ATM', id=277, x=33.17, y=-1348.23, z=29.5},
	{name='ATM', id=277, x=288.76, y=-1282.29, z=29.65},
	{name='ATM', id=277, x=289.11, y=-1256.81, z=29.45},
	{name='ATM', id=277, x=296.48, y=-894.14, z=29.24},
	{name='ATM', id=277, x=295.74, y=-896.08, z=29.22},
	{name='ATM', id=277, x=1686.753, y=4815.809, z=42.008},
	{name='ATM', id=277, x=-303.28, y=-829.72, z=32.42},
	{name='ATM', id=277, x=5.27, y=-919.85, z=29.56},
	{name='ATM', id=277, x=-1074.01, y=-827.69, z=19.04},
	{name='ATM', id=277, x=-1110.92, y=-836.26, z=19.01},
	{name='ATM', id=277, x=-1074.39, y=-827.47, z=27.04},
	{name='ATM', id=277, x=-660.68, y=-854.05, z=24.49},
	{name='ATM', id=277, x=-1315.75, y=-834.68, z=16.97, assaltavel=true},
	{name='ATM', id=277, x=-1314.78, y=-835.99, z=16.97},
	{name='ATM', id=277, x=1138.23, y=-468.94, z=66.74, assaltavel=true},
	{name='ATM', id=277, x=-821.7, y=-1081.93, z=11.14, assaltavel=true},
	{name='ATM', id=277, x=236.6, y=219.66, z=106.29},
	{name='ATM', id=277, x=237.02, y=218.76, z=106.29},
	{name='ATM', id=277, x=237.48, y=217.83, z=106.29},
	{name='ATM', id=277, x=237.89, y=216.93, z=106.29},
	{name='ATM', id=277, x=238.32, y=215.98, z=106.29},
	{name='ATM', id=277, x=265.82, y=213.89, z=106.29},
	{name='ATM', id=277, x=265.51, y=212.96, z=106.29},
	{name='ATM', id=277, x=265.17, y=212.0, z=106.29},
	{name='ATM', id=277, x=264.81, y=211.06, z=106.29},
	{name='ATM', id=277, x=264.46, y=210.08, z=106.29},
	{name='ATM', id=277, x=24.45, y=-946.01, z=29.36},
	{name='ATM', id=277, x=-258.77, y=-723.38, z=33.47},
	{name='ATM', id=277, x=-611.87, y=-704.81, z=31.24},
	{name='ATM', id=277, x=-614.58, y=-704.84, z=31.24},
	{name='ATM', id=277, x=-866.65, y=-187.74, z=37.85},
	{name='ATM', id=277, x=-867.61, y=-186.1, z=37.85},
	{name='ATM', id=277, x=-567.89, y=-234.35, z=34.25},
	{name='ATM', id=277, x=-301.68, y=-830.05, z=32.42},
	{name='ATM', id=277, x=-37.81, y=-1115.22, z=26.44},
	{name='ATM', id=277, x=-200.63, y=-1309.54, z=31.3},
	{name='ATM', id=277, x=903.81, y=-164.08, z=74.17},
	{name='ATM', id=277, x=437.13, y=-628.34, z=28.71},
	{name='ATM', id=277, x=230.92, y=367.57, z=106.12},
	{name='ATM', id=277, x=356.97, y=173.55, z=103.08},
	{name='ATM', id=277, x=-45.18, y=-1665.89, z=29.5},
	{name='ATM', id=277, x=315.14, y=-593.7, z=43.29}, -- Hospital;

	{name='ATM', id=277, x=130.13, y=-1292.68, z=29.27},
	{name='ATM', id=277, x=129.68, y=-1291.9, z=29.27},
	{name='ATM', id=277, x=129.27, y=-1291.19, z=29.27},

	{name='ATM', id=277, x=1171.56, y=2702.54, z=38.18},
	{name='ATM', id=277, x=1172.53, y=2702.6, z=38.18},

	{name='ATM', id=277, x=942.73, y=44.57, z=80.3},
	{name='ATM', id=277, x=934.55, y=31.57, z=80.3},

	{name='ATM', id=277, x=-446.69, y=-328.79, z=34.51}, -- Hospital novo
	{name='ATM', id=277, x=-353.74, y=-125.74, z=39.44}, -- Ls Customs
	{name='ATM', id=277, x=-1025.96, y=-764.06, z=19.85},
	{name='ATM', id=277, x=-1024.31, y=-764.1, z=19.85},


}

--[ CALCULAR TEMPO ]---------------------------------------------------------------------------------------------------------------------

function CalculateTimeToDisplay()
	hora = GetClockHours()
	if hora <= 9 then
		hora = "0" .. hora
	end
end

--[ ACESSAR BANCO ]----------------------------------------------------------------------------------------------------------------------

if BancoMenu then
	Citizen.CreateThread(function()
		while true do
			local idle = 1000
			if nearBanco() then
				idle = 5
				if IsControlJustPressed(1, 38) then
					CalculateTimeToDisplay()
					if parseInt(hora) >= 07 and parseInt(hora) <= 21 then
						inMenu = true
						SetNuiFocus(true, true)
						SendNUIMessage({type = 'openGeneral'})
						TriggerServerEvent('banco:balance')
						local ped = GetPlayerPed(-1)
					else
						TriggerEvent("Notify","negado","O funcionamento é das <b>07:00</b> às <b>21:00</b>.") 
					end
				end

				if IsControlJustPressed(1, 47) then
					CalculateTimeToDisplay()
					if parseInt(hora) >= 07 and parseInt(hora) <= 17 then
						banK.giveDebitCard()
					else
						TriggerEvent("Notify","negado","O funcionamento dos bancos é das <b>07:00</b> às <b>18:00</b>.") 
					end
				end
			end

			if nearATM() then
				idle = 5
				if IsControlJustPressed(1, 38) then
					local ped = GetPlayerPed(-1)
					local playerPed = GetPlayerPed(-1)
					TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_ATM", 0, true)
					Wait(3000)
					inMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'openGeneral'})
					TriggerServerEvent('banco:balance')
					ClearPedTasksImmediately(ped)
				end
			end
		
			if IsControlJustPressed(1, 322) then
			
				inMenu = false
				SetNuiFocus(false, false)
				SendNUIMessage({type = 'close'})
			end
			Citizen.Wait(idle)
		end
	end)
end

--[ NUI BANCO ]--------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance,multas)
	
	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		multas = multas
	})
end)

RegisterNetEvent('currentbalance2')
AddEventHandler('currentbalance2', function()
	TriggerServerEvent('banco:balance')
end)

RegisterNUICallback('depositar', function(data)
	if nearBanco() then
		TriggerServerEvent('banco:depositar', tonumber(data.amount))
		TriggerServerEvent('banco:balance')
	else
		TriggerEvent("Notify","negado","Depósitos só podem ser feitos em agências bancárias.") 
	end
end)

RegisterNUICallback('sacar', function(data)
	TriggerServerEvent('banco:sacar', tonumber(data.amounts))
	TriggerServerEvent('banco:balance')
	TriggerEvent('balance')
end)

RegisterNUICallback('pagar', function(data)
	TriggerServerEvent('banco:pagar', tonumber(data.amountp))
	TriggerServerEvent('banco:balance')
end)

RegisterNUICallback('balance', function()
	TriggerServerEvent('banco:balance')
end)

RegisterNetEvent('balance:back48')
AddEventHandler('balance:back48', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

RegisterNUICallback('transferir', function(data)
	TriggerServerEvent('banco:transferir', data.to, data.amountt)
	TriggerServerEvent('banco:balance')
end)

RegisterNetEvent('banco:result')
AddEventHandler('banco:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)

function nearBanco()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(Bancos) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 1 then
			DrawText3D(search.x, search.y, search.z, "Pressione [~g~E~w~] para acessar o ~g~BANCO~w~  &  [~g~G~w~] para adquirir um ~g~CARTÃO DE DÉBITO~w~.")
			DrawMarker(23, search.x, search.y, search.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 120, 222, 93, 180, 0, 0, 0, 0)
			return true
		end
	end
end

function nearATM()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(atms) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 1 and not andamento then
			if search.assaltavel == true then 
				DrawText3D(search.x, search.y, search.z, "Pressione [~g~E~w~] para acessar o ~g~CAIXA ELETRÔNICO~w~  &  [~r~G~w~] para iniciar o ~r~ROUBO~w~.")
				DrawMarker(23, search.x, search.y, search.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 120, 222, 93, 180, 0, 0, 0, 0)
				return true
			else
				DrawText3D(search.x, search.y, search.z, "Pressione [~g~E~w~] para acessar o ~g~CAIXA ELETRÔNICO~w~.")
				DrawMarker(23, search.x, search.y, search.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 120, 222, 93, 180, 0, 0, 0, 0)
				return true
			end
		end
	end
end

--[ INICIO/CANCELAR ]--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = GetEntityCoords(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(locais) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and not andamento then
					idle = 5
					if IsControlJustPressed(0,47) and banK.checkPermission() then
						banK.checkRobbery(v.id,v.x,v.y,v.z,v.h)
					end
				end
			end
			if andamento then
				drawTxt("APERTE ~r~M~w~ PARA CANCELAR O ROUBO EM ANDAMENTO",4,0.5,0.90,0.35,255,255,255,150)
				drawTxt("RESTAM ~r~"..segundos.." SEGUNDOS ~w~PARA TERMINAR",4,0.5,0.92,0.35,255,255,255,200)
				if IsControlJustPressed(0,244) or GetEntityHealth(ped) <= 100 or IsPedBeingStunned(ped) then
					andamento = false
					ClearPedTasks(ped)
					banK.cancelRobbery()
					TriggerEvent('cancelando',false)
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ INICIADO ]---------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("iniciandocaixaeletronico")
AddEventHandler("iniciandocaixaeletronico",function(x,y,z,secs,head)
	segundos = secs
	andamento = true
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	TriggerEvent('cancelando',true)
end)

--[ CONTAGEM ]---------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
			end
		end
	end
end)

--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

RegisterNetEvent('blip:criar:caixaeletronico')
AddEventHandler('blip:criar:caixaeletronico',function(x,y,z)
	if not DoesBlipExist(blip) then
		blip = AddBlipForCoord(x,y,z)
		SetBlipScale(blip,0.5)
		SetBlipSprite(blip,1)
		SetBlipColour(blip,59)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Roubo: Caixa Eletrônico")
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,false)
		SetBlipRoute(blip,true)
	end
end)

RegisterNetEvent('blip:remover:caixaeletronico')
AddEventHandler('blip:remover:caixaeletronico',function()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end