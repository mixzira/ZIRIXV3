local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

cftv = Tunnel.getInterface("vrp_cftv")

local menuactive = false

local hour = 0
local minute = 0
local dayOfMonth = 0
local month = ""

local fov_max = 80.0
local fov_min = 10.0
local zoomspeed = 2.0
local fov = (fov_max+fov_min)*0.5

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["HOME"] = 212, ["INSERT"] = 121
}

CFTVCamLocations = {
	[1] =  { ['x'] = 151.96, ['y'] = -986.37, ['z'] = 34.88,['h'] = 248.92, ['info'] = "Praça Central", ['nCam'] = "001" },
	[2] =  { ['x'] = 213.10, ['y'] = 175.87, ['z'] = 110.34,['h'] = 342.17, ['info'] = "Banco Central", ['nCam'] = "002" },
	[3] =  { ['x'] = 52.86, ['y'] = -876.07, ['z'] = 35.22,['h'] = 70.25, ['info'] = "Estacionamento 01", ['nCam'] = "003" },
	[4] =  { ['x'] = -1029.09, ['y'] = -2721.44, ['z'] = 24.98,['h'] = 151.59, ['info'] = "Aeroporto", ['nCam'] = "004" },
	[5] =  { ['x'] = -107.44, ['y'] = -1126.39, ['z'] = 30.61,['h'] = 354, ['info'] = "Concessionária", ['nCam'] = "005" },
	[6] =  { ['x'] = -922.76, ['y'] = -2066.30, ['z'] = 14.22,['h'] = 222.11, ['info'] = "Centro de Licenças", ['nCam'] = "006" }
}

local monitoramento = {
	{ ['x'] = -1089.69, ['y'] = -834.95, ['z'] = 30.76, ['h'] = 263.55 },
	{ ['x'] = -1093.51, ['y'] = -837.78, ['z'] = 30.76, ['h'] = 185.39 }
}

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

function CalculateDateToDisplay()
	month = GetClockMonth()
	dayOfMonth = GetClockDayOfMonth()
	if month == 0 then
		month = "01"
	elseif month == 1 then
		month = "02"
	elseif month == 2 then
		month = "03"
	elseif month == 3 then
		month = "04"
	elseif month == 4 then
		month = "05"
	elseif month == 5 then
		month = "06"
	elseif month == 6 then
		month = "07"
	elseif month == 7 then
		month = "08"
	elseif month == 8 then
		month = "09"
	elseif month == 9 then
		month = "10"
	elseif month == 10 then
		month = "11"
	elseif month == 11 then
		month = "12"
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		UpdateOverlay()
	end
end)

function UpdateOverlay()
	CalculateTimeToDisplay()
	CalculateDateToDisplay()
end

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "camera1" then
		TriggerEvent("cftv:camera",1)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false

	elseif data == "camera2" then
		TriggerEvent("cftv:camera",2)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false

	elseif data == "camera3" then
		TriggerEvent("cftv:camera",3)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false

	elseif data == "camera4" then
		TriggerEvent("cftv:camera",4)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false

	elseif data == "camera5" then
		TriggerEvent("cftv:camera",5)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false

	elseif data == "camera6" then
		TriggerEvent("cftv:camera",6)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

inCam = false
cftvCam = 0

RegisterNetEvent("cftv:camera")
AddEventHandler("cftv:camera", function(camNumber)
	camNumber = tonumber(camNumber)
	if inCam then
		inCam = false
		PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
		Wait(250)
		TriggerEvent("status:celular",false)
		TriggerEvent("status:chat",false)
		ClearPedTasks(GetPlayerPed(-1))
	else
		if camNumber > 0 and camNumber < #CFTVCamLocations + 1 or camNumber ~= nil then
			PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
			TriggerEvent("cftv:startcamera",camNumber)
			TriggerEvent("status:celular",true)
			TriggerEvent("status:chat",true)
		end
	end
end)

RegisterNetEvent("cftv:startcamera")
AddEventHandler("cftv:startcamera", function(camNumber)
	local camNumber = tonumber(camNumber)
	local x = CFTVCamLocations[camNumber]["x"]
	local y = CFTVCamLocations[camNumber]["y"]
	local z = CFTVCamLocations[camNumber]["z"]
	local h = CFTVCamLocations[camNumber]["h"]
	local info = CFTVCamLocations[camNumber]["info"]
	local nCam = CFTVCamLocations[camNumber]["nCam"]

	inCam = true

	SetTimecycleModifier("heliGunCam")
	SetTimecycleModifierStrength(1.0)

	local lPed = GetPlayerPed(-1)
	cftvCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(cftvCam,x,y,z)						
	SetCamRot(cftvCam, -15.0,0.0,h)
	SetCamFov(cftvCam, 110.0)
	RenderScriptCams(true, false, 0, 1, 0)
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)

	while inCam do
		SetCamCoord(cftvCam,x,y,z+1.2)
		Citizen.Wait(1)
		drawTxt("[ CFTV - Departamento de Polícia ][ IP: ~r~192.57.111.10 ~w~]",4,0.091,0.90,0.35,255,255,255,180)
		drawTxt("[ Nº: ~r~"..nCam.." ~w~][ ~r~"..dayOfMonth.."~w~-~r~"..month.."~w~-~r~2020 ~w~][ ~r~"..hour.."~w~:~r~"..minute.." ~w~]",4,0.092,0.92,0.35,255,255,255,180)
	end

	fov = (fov_max+fov_min)*0.5

	ClearFocus()
	ClearTimecycleModifier()
	RenderScriptCams(false, false, 0, 1, 0)
	DestroyCam(cftvCam, false)
	SetNightvision(false)
	SetSeethrough(false)
end)

Citizen.CreateThread(function(camNumber)
	while true do
		Citizen.Wait(0)
		if inCam then
			local rota = GetCamRot(cftvCam, 2)

			if IsControlPressed(1, Keys['BACKSPACE']) and inCam then
				TriggerEvent("status:celular",false)
				TriggerEvent("status:chat",false)
				inCam = false
			end

			if IsControlPressed(1, Keys['N4']) then
				SetCamRot(cftvCam, rota.x, 0.0, rota.z + 0.7, 2)
			end

			if IsControlPressed(1, Keys['N6']) then
				SetCamRot(cftvCam, rota.x, 0.0, rota.z - 0.7, 2)
			end

			if IsControlPressed(1, Keys['N8']) then
				SetCamRot(cftvCam, rota.x + 0.7, 0.0, rota.z, 2)
			end

			if IsControlPressed(1, Keys['N5']) then
				SetCamRot(cftvCam, rota.x - 0.7, 0.0, rota.z, 2)
			end

			if IsControlJustPressed(1, Keys['N7']) then
				fov = math.max(fov-zoomspeed,fov_min)
			end

			if IsControlJustPressed(1, Keys['N9']) then
				fov = math.min(fov+zoomspeed,fov_max)
			end

			local current_fov = GetCamFov(cftvCam)

			if math.abs(fov-current_fov) < 0.1 then
				fov = current_fov
			end

			SetCamFov(cftvCam,current_fov+(fov-current_fov)*0.05)
		end
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000

		for k,v in pairs(monitoramento) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local moni = monitoramento[k]
			
			if distance < 2.5 then
				DrawMarker(23, moni.x, moni.y, moni.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
				if distance < 2.5 then
					idle = 5
					if IsControlJustPressed(0,38) and cftv.permission() then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(idle)
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