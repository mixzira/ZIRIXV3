local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

banK = Tunnel.getInterface("vrp_bank")

inMenu = true
local andamento = false
local segundos = 0
local showblips	= true
local atbank = false
local bankMenu	= true
local blip = nil
local hora = 0	

function CalculateTimeToDisplay()
	hora = GetClockHours()
	if hora <= 9 then
		hora = "0" .. hora
	end
end

if bankMenu then
	Citizen.CreateThread(function()
		while true do
			local idle = 1000
			if nearbank() then
				idle = 5
				if IsControlJustPressed(1, 38) then
					CalculateTimeToDisplay()
					if parseInt(hora) >= 07 and parseInt(hora) <= 21 then
						inMenu = true
						SetNuiFocus(true, true)
						SendNUIMessage({type = 'openGeneral'})
						TriggerServerEvent('bank:balance')
						local ped = GetPlayerPed(-1)
					else
						TriggerEvent("Notify","negado","O funcionamento é das <b>07:00</b> às <b>21:00</b>.") 
					end
				end

				if IsControlJustPressed(1, 47) then
					CalculateTimeToDisplay()
					if parseInt(hora) >= 07 and parseInt(hora) <= 17 then
						bank.giveDebitCard()
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
					TriggerServerEvent('bank:balance')
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
	TriggerServerEvent('bank:balance')
end)

RegisterNUICallback('depositar', function(data)
	if nearbank() then
		TriggerServerEvent('bank:depositar', tonumber(data.amount))
		TriggerServerEvent('bank:balance')
	else
		TriggerEvent("Notify","negado","Depósitos só podem ser feitos em agências bancárias.") 
	end
end)

RegisterNUICallback('sacar', function(data)
	TriggerServerEvent('bank:sacar', tonumber(data.amounts))
	TriggerServerEvent('bank:balance')
	TriggerEvent('balance')
end)

RegisterNUICallback('pagar', function(data)
	TriggerServerEvent('bank:pagar', tonumber(data.amountp))
	TriggerServerEvent('bank:balance')
end)

RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back48')
AddEventHandler('balance:back48', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

RegisterNUICallback('transferir', function(data)
	TriggerServerEvent('bank:transferir', data.to, data.amountt)
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)

function nearbank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(config.banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 1 then
			DrawText3D(search.x, search.y, search.z, "Pressione [~g~E~w~] para acessar o ~g~Banco~w~  &  [~g~G~w~] para adquirir um ~g~CARTÃO DE DÉBITO~w~.")
			DrawMarker(23, search.x, search.y, search.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 120, 222, 93, 180, 0, 0, 0, 0)
			return true
		end
	end
end

function nearATM()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(config.atms) do
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

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = GetEntityCoords(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(config.atmrobbery) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and not andamento then
					idle = 5
					if IsControlJustPressed(0,47) and banK.checkPermission() then
						bank.checkRobbery(v.id,v.x,v.y,v.z,v.h)
					end
				end
			end
			if andamento then
				idle = 5
				drawTxt("APERTE ~r~M~w~ PARA CANCELAR O ROUBO EM ANDAMENTO",4,0.5,0.90,0.35,255,255,255,150)
				drawTxt("RESTAM ~r~"..segundos.." SEGUNDOS ~w~PARA TERMINAR",4,0.5,0.92,0.35,255,255,255,200)
				if IsControlJustPressed(0,244) or GetEntityHealth(ped) <= 100 or IsPedBeingStunned(ped) then
					andamento = false
					ClearPedTasks(ped)
					bank.cancelRobbery()
					bank.robberywebwook()
					TriggerEvent('cancelando',false)
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

RegisterNetEvent("iniciandocaixaeletronico")
AddEventHandler("iniciandocaixaeletronico",function(x,y,z,secs,head)
	segundos = secs
	andamento = true
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	TriggerEvent('cancelando',true)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				bank.robberywebwook()
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
			end
		end
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