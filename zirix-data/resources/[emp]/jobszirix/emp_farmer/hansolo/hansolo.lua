local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emp17 = Tunnel.getInterface("emp_farmer")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local processo = false
local segundos = 0
local selecionadocolheita = 0

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function CalculateTimeToDisplay6()
	hour = GetClockHours()
	if hour <= 9 then
		hour = "0" .. hour
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not servico then
			for _,v in pairs(configfarmer.start) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				if distance <= 10 then
					idle = 5
					DrawMarker(23,v.x,v.y,v.z-0.99,0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
					if distance <= 2.0 then
						drawTxt("PRESSIONE  ~p~E~w~  PARA INICIAR O SERVIÇO",4,0.5,0.92,0.35,255,255,255,180)
						if IsControlJustPressed(0,38) then
							CalculateTimeToDisplay6()
							if parseInt(hour) >= 06 and parseInt(hour) <= 20 then
								TriggerEvent("Notify","sucesso","Você entrou em serviço.")
								servico = true
								selecionadocolheita = 1
								CriandoBlipC(configfarmer.locsfarm,selecionadocolheita)	
							else
								TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
							end												
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		idle = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(configfarmer.locsfarm[selecionadocolheita].x,configfarmer.locsfarm[selecionadocolheita].y,configfarmer.locsfarm[selecionadocolheita].z)
			local distance = GetDistanceBetweenCoords(configfarmer.locsfarm[selecionadocolheita].x,configfarmer.locsfarm[selecionadocolheita].y,cdz,x,y,z,true)
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)

			if distance <= 25.0 then
				idle = 5
				DrawMarker(23,configfarmer.locsfarm[selecionadocolheita].x,configfarmer.locsfarm[selecionadocolheita].y,configfarmer.locsfarm[selecionadocolheita].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,0,0,50,1,0,0,1)
				if distance <= 2.5 then
					if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey(configfarmer.vehicle)) then
						SetEntityMaxSpeed(veh,0.75*10-0.45)
						RemoveBlip(blips)
						if selecionadocolheita == 32 then
							selecionadocolheita = 1
						else
							selecionadocolheita = selecionadocolheita + 1
						end
						emp17.checkPayment()
						CriandoBlipC(configfarmer.locsfarm,selecionadocolheita)
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		idle = 1000
		if servico then
			idle = 5
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
		Citizen.Wait(idle)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO --
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		idle = 1000
		if not processo then
			for _,v in pairs(configfarmer.grainclean) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance2 = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				if distance2 <= 10 then
					idle = 5
					DrawMarker(23,v.x,v.y,v.z-0.99,0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
					if distance2 <= 2 and not andamento then
						drawTxt("PRESSIONE  ~p~E~w~  PARA INICIAR A SEPARAÇÃO DOS GRAOS",4,0.5,0.92,0.35,255,255,255,180)
						if IsControlJustPressed(0,38) and emp17.checkGraos() and not IsPedInAnyVehicle(ped) then
							CalculateTimeToDisplay6()
							--if parseInt(hour) >= 06 and parseInt(hour) <= 20 then
								processo = true
								segundos = 3
								SetTimeout(4000,function()
									emp17.separarGraos()
								end)
							--else
								--TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
							--end							
						end
					end
				end
			end
		end
		if processo then
			idle = 1
			drawTxt("AGUARDE ~g~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR A SEPARAÇÃO DOS GRÃOS",4,0.5,0.93,0.50,255,255,255,180)
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				processo = false
				TriggerEvent('cancelando',false)
				ClearPedTasks(PlayerPedId())
				vRP._DeletarObjeto()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function CriandoBlipC(locsfarm,selecionadocolheita)
	blips = AddBlipForCoord(configfarmer.locsfarm[selecionadocolheita].x,configfarmer.locsfarm[selecionadocolheita].y,configfarmer.locsfarm[selecionadocolheita].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Colheita")
	EndTextCommandSetBlipName(blips)
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