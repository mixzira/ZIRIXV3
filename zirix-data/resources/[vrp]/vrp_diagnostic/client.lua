local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_diagnostic",src)
vSERVER = Tunnel.getInterface("vrp_diagnostic")

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
			local hit,bone = GetPedLastDamageBone(ped)
			if hit and not damaged[bone] and bone ~= 0 then
				damaged[bone] = true
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