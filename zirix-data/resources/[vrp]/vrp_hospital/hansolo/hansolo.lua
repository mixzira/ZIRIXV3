local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Resg = Tunnel.getInterface("vrp_hospital")

local tratamento = false
local segundos = 0
local medicalTratamento = false

RegisterNetEvent('reanimar')
AddEventHandler('reanimar',function()
	local handle,ped = FindFirstPed()
	local finished = false
	local reviver = nil
	repeat
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(ped),true)
		if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) and distance <= 1.5 and reviver == nil then
			reviver = ped
			TriggerEvent("cancelando",true)
			vRP._playAnim(false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
			TriggerEvent("progress",15000,"reanimando")
			SetTimeout(15000,function()
				SetEntityHealth(reviver,110)
				local newped = ClonePed(reviver,GetEntityHeading(reviver),true,true)
				TaskWanderStandard(newped,10.0,10)
				local model = GetEntityModel(reviver)
				SetModelAsNoLongerNeeded(model)
				Citizen.InvokeNative(0xAD738C3085FE7E11,reviver,true,true)
				TriggerServerEvent("trydeleteped",PedToNet(reviver))
				vRP._stopAnim(false)
				TriggerEvent("cancelando",false)
			end)
			finished = true
		end
		finished,ped = FindNextPed(handle)
	until not finished
	EndFindPed(handle)
end)

local macas = {
	{ ['x'] = -459.46, ['y'] = -287.97, ['z'] = 34.92, ['x2'] = -460.17, ['y2'] = -288.72, ['z2'] = 35.84, ['h'] = 200.98, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." }, -- Enfermaria;  sim
	{ ['x'] = -462.8, ['y'] = -289.62, ['z'] = 34.92, ['x2'] = -463.64, ['y2'] = -290.0, ['z2'] = 35.84, ['h'] = 199.36, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." },
	{ ['x'] = -466.05, ['y'] = -291.03, ['z'] = 34.92, ['x2'] = -466.98, ['y2'] = -291.44, ['z2'] = 35.84, ['h'] = 203.01, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." },
	{ ['x'] = -468.99, ['y'] = -283.94, ['z'] = 34.92, ['x2'] = -469.99, ['y2'] = -284.19, ['z2'] = 35.84, ['h'] = 16.91, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." },
	{ ['x'] = -467.37, ['y'] = -283.17, ['z'] = 34.92, ['x2'] = -466.55, ['y2'] = -282.71, ['z2'] = 35.84, ['h'] = 17.15, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." },
	{ ['x'] = -463.64, ['y'] = -281.64, ['z'] = 34.92, ['x2'] = -462.75, ['y2'] = -281.3, ['z2'] = 35.84, ['h'] = 25.28, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." },
	{ ['x'] = -459.86, ['y'] = -280.1, ['z'] = 34.92, ['x2'] = -459.04, ['y2'] = -279.61, ['z2'] = 35.85, ['h'] = 21.62, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." },
	{ ['x'] = -455.82, ['y'] = -278.75, ['z'] = 34.92, ['x2'] = -455.2, ['y2'] = -278.05, ['z2'] = 35.84, ['h'] = 22.17, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." },
	{ ['x'] = -449.29, ['y'] = -283.94, ['z'] = 34.92, ['x2'] = -448.28, ['y2'] = -283.84, ['z2'] = 35.84, ['h'] = 201.34, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." },
	{ ['x'] = -452.39, ['y'] = -285.33, ['z'] = 34.92, ['x2'] = -451.57, ['y2'] = -284.99, ['z2'] = 35.84, ['h'] = 210.98, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." },
	{ ['x'] = -455.66, ['y'] = -286.86, ['z'] = 34.92, ['x2'] = -454.91, ['y2'] = -286.51, ['z2'] = 35.84, ['h'] = 202.63, ['name'] = "Pressione [~p~E~w~] para deitar   ~p~&~w~    [~p~G~w~] para se tratar." },

	{ ['x'] = -465.02, ['y'] = -294.74, ['z'] = 34.91, ['x2'] = -464.9, ['y2'] = -295.37, ['z2'] = 35.68, ['h'] = 294.32, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -456.2, ['y'] = -314.99, ['z'] = 34.92, ['x2'] = -456.12, ['y2'] = -315.49, ['z2'] = 35.69, ['h'] = 287.9, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -441.46, ['y'] = -302.68, ['z'] = 34.92, ['x2'] = -441.17, ['y2'] = -303.31, ['z2'] = 35.78, ['h'] = 291.05, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -444.77, ['y'] = -307.15, ['z'] = 34.92, ['x2'] = -445.45, ['y2'] = -307.43, ['z2'] = 35.84, ['h'] = 199.8, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -446.71, ['y'] = -291.74, ['z'] = 34.92, ['x2'] = -447.01, ['y2'] = -291.14, ['z2'] = 35.82, ['h'] = 288.39, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -460.4, ['y'] = -306.08, ['z'] = 34.92, ['x2'] = -460.35, ['y2'] = -306.58, ['z2'] = 35.69, ['h'] = 293.73, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -483.72, ['y'] = -330.39, ['z'] = 69.53, ['x2'] = -483.0, ['y2'] = -330.52, ['z2'] = 70.44, ['h'] = 359.57, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -484.52, ['y'] = -340.31, ['z'] = 69.53, ['x2'] = -485.25, ['y2'] = -340.16, ['z2'] = 70.45, ['h'] = 168.26, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -477.7, ['y'] = -332.82, ['z'] = 69.53, ['x2'] = -477.55, ['y2'] = -332.09, ['z2'] = 70.44, ['h'] = 88.12, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -475.56, ['y'] = -339.58, ['z'] = 69.53, ['x2'] = -475.54, ['y2'] = -340.33, ['z2'] = 70.45, ['h'] = 267.77, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -470.38, ['y'] = -333.77, ['z'] = 69.53, ['x2'] = -470.25, ['y2'] = -333.06, ['z2'] = 70.44, ['h'] = 74.19, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -468.17, ['y'] = -340.86, ['z'] = 69.53, ['x2'] = -468.25, ['y2'] = -341.6, ['z2'] = 70.45, ['h'] = 258.31, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -461.44, ['y'] = -333.3, ['z'] = 69.53, ['x2'] = -460.7, ['y2'] = -333.45, ['z2'] = 70.44, ['h'] = 348.81, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -462.22, ['y'] = -343.17, ['z'] = 69.53, ['x2'] = -462.96, ['y2'] = -343.07, ['z2'] = 70.45, ['h'] = 166.14, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -446.96, ['y'] = -345.25, ['z'] = 69.53, ['x2'] = -447.69, ['y2'] = -345.15, ['z2'] = 70.46, ['h'] = 172.38, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -444.28, ['y'] = -345.82, ['z'] = 69.53, ['x2'] = -443.52, ['y2'] = -345.91, ['z2'] = 70.46, ['h'] = 159.87, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -456.42, ['y'] = -310.68, ['z'] = -130.87, ['x2'] = -456.7, ['y2'] = -309.93, ['z2'] = -129.93, ['h'] = 283.46, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -443.28, ['y'] = -303.45, ['z'] = -130.87, ['x2'] = -443.05, ['y2'] = -304.1, ['z2'] = -129.93, ['h'] = 288.64, ['name'] = "Pressione [~p~E~w~] para deitar." },

	{ ['x'] = -446.46, ['y'] = -290.87, ['z'] = -130.87, ['x2'] = -446.09, ['y2'] = -291.7, ['z2'] = -129.93, ['h'] = 295.79, ['name'] = "Pressione [~p~E~w~] para deitar." },

}

local emMaca = false
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		
		for k,v in pairs(macas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local cod = macas[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cod.x, cod.y, cod.z, true ) < 1.2 then
				DrawText3D(cod.x, cod.y, cod.z, cod.name)
			end

			if distance < 1.5 then
				idle = 5
				if IsControlJustPressed(0,38) then
					SetEntityCoords(ped,v.x2,v.y2,v.z2)
					SetEntityHeading(ped,v.h)
					vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
					emMaca = true
				end
				if IsControlJustPressed(0,47) then
					if Resg.checkServices() then
						TriggerEvent('tratamento')
						SetEntityCoords(ped,v.x2,v.y2,v.z2)
						SetEntityHeading(ped,v.h)
						vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
						TriggerEvent('cancelando',true)
					else
						TriggerEvent("Notify","aviso","Existem paramédicos em serviço.")
					end
				end
			end

			if tratamento then
				idle = 5
				drawTxt("RESTAM ~p~"..segundos.." SEGUNDOS ~w~PARA TERMINAR O TRATAMENTO.",4,0.5,0.92,0.35,255,255,255,200)
				DisableControlAction(0,167,true)
				DisableControlAction(0,75,true)
				DisableControlAction(0,245,true)
			end

			if IsControlJustPressed(0,167) then
				ClearPedTasks(GetPlayerPed(-1))
				emMaca = false
			end
		end

		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if tratamento then
			segundos = segundos - 1
			if segundos <= 0 then
				tratamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
				TriggerEvent('final-tratamento')
			end
		end
	end
end)

RegisterNetEvent("tratamento")
AddEventHandler("tratamento",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

	TriggerEvent("resetBleeding")
    TriggerEvent("resetDiagnostic")
    SetEntityHealth(ped,health)
	TriggerEvent("rainda",armour)
	
	if tratamento then
		return
	end
	vRP.blockAcao()
	segundos = 300
	tratamento = true
	TriggerEvent("Notify","sucesso","Tratamento iniciado, aguarde a liberação do <b>profissional médico.</b>.",8000)
end)

RegisterNetEvent("final-tratamento")
AddEventHandler("final-tratamento",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped,health)
	--SetPedArmour(ped,armour)
	TriggerEvent("rainda",armour)
	
	SetEntityHealth(ped,400)
	vRP.desblockAcao()
end)

local medicalTratamento = false

RegisterNetEvent("medical-tratamento")
AddEventHandler("medical-tratamento",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

	TriggerEvent("resetBleeding")
    TriggerEvent("resetDiagnostic")
    SetEntityHealth(ped,health)
	TriggerEvent("rainda",armour)
	
	if emMaca then
		if medicalTratamento then
			return
		end

		medicalTratamento = true
		TriggerEvent("Notify","sucesso","Tratamento iniciado, aguarde a liberação do <b>profissional médico.</b>.",8000)
		TriggerEvent('resetWarfarina')
		TriggerEvent('resetDiagnostic')
		

		if medicalTratamento then
			repeat
				Citizen.Wait(600)
				if GetEntityHealth(ped) > 101 then
					SetEntityHealth(ped,GetEntityHealth(ped)+1)
				end
			until GetEntityHealth(ped) >= 320 or GetEntityHealth(ped) <= 101
				TriggerEvent("Notify","sucesso","Tratamento concluido.",8000)
				medicalTratamento = false
		end
	else
		TriggerEvent("Notify","negado","Você precisa estar deitado em uma maca para ser tratado.",8000)
	end
end)

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