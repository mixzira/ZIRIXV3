local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

src = {}
Tunnel.bindInterface("medical_system",src)
vSERVER = Tunnel.getInterface("medical_system")

local cab = 0
local per = 0
local mao = 0
local col = 0

RegisterCommand("diagnostico",function()
	vSERVER.checkOfficer()
	ToggleActionMenu()
	SendNUIMessage({
		cab = 1,
		per = 1,
		mao = 1,
		col = 1,
	});
end)

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "rem-kit" then
		local diagnostico =	vSERVER.raiox()
			SendNUIMessage({
			teste = diagnostico,
		});
		
	elseif data == "close" then
		ToggleActionMenu()
	end
end)

local damaged = {}
local bleeding = 0
local bleedtype = "Superficial"

function src.getDiagnostic()
	return damaged
end

function src.getBleeding()
	return bleeding
end

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 115 then
			local ped = PlayerPedId()
			local hit,bone = GetPedLastDamageBone(ped)			
			if hit and not damaged[bone] and bone ~= 0 then
				damaged[bone] = true
				print('Quebrou: '..bone)
				bleeding = bleeding + 1
			end
		end
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
 	while true do
 		local ped = PlayerPedId()

 		if GetEntityHealth(ped) > 101 then
 			if bleeding == 1 then
 				bleedtype = "superficial"
 			elseif bleeding == 2 then
 				bleedtype = "baixo"
 			elseif bleeding == 3 then
 				bleedtype = "médio"
				SetEntityHealth(ped,GetEntityHealth(ped)-3)
 			elseif bleeding == 4 then
 				bleedtype = "alto"
 				SetEntityHealth(ped,GetEntityHealth(ped)-4)
 			elseif bleeding >= 5 then
 				bleedtype = "grave"
 				SetEntityHealth(ped,GetEntityHealth(ped)-5)
 			end
 			
 			if bleeding >= 1 and GetEntityHealth(ped) > 101 then
 				TriggerEvent("Notify","negado","Sangramento <b>"..bleedtype.."</b> encontrado.",3000)
 			end

 			if bleeding >= 4 and GetEntityHealth(ped) > 101 then
 				SetFlash(0,0,500,100,500)
 			end
 		end

 		Citizen.Wait(15000)
	end
end)

RegisterNetEvent("resetDiagnostic")
AddEventHandler("resetDiagnostic",function()
	damaged = {}
end)

RegisterNetEvent("resetBleeding")
AddEventHandler("resetBleeding",function()
	bleeding = 0
end)

RegisterNetEvent("resetWarfarina")
AddEventHandler("resetWarfarina",function()
	repeat
		Citizen.Wait(15000)
		bleeding = bleeding - 1
	until bleeding <= 0
		TriggerEvent("Notify","importante","Sangramento paralisado.",8000)
end)