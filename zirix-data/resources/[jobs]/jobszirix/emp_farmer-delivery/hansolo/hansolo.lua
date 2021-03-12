local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

empfarmer = Tunnel.getInterface("vrp_farmer-delivery")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local check = 0
local blips = false
local working = false
local hour = 0

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function CalculateTimeToDisplay3()
	hour = GetClockHours()
	if hour <= 9 then
		hour = "0" .. hour
	end
end

--[ THREAD ]--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(configfarmerd.ini.x,configfarmerd.ini.y,configfarmerd.ini.z)
			local distance = Vdist(configfarmerd.ini.x,configfarmerd.ini.y,configfarmerd.ini.z,x,y,z)
			local lastVehicle = GetEntityModel(GetPlayersLastVehicle())
			if distance < 15.1 then
				idle = 5
				DrawMarker(23,configfarmerd.ini.x,configfarmerd.ini.y,configfarmerd.ini.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,136, 96, 240, 180,0,0,0,0)
				if distance <= 1.2 then
					drawTexts("PRESSIONE  ~b~E~w~  PARA INICIAR ENTREGAS",4,0.5,0.92,0.35,255,255,255,180)
					if IsControlJustPressed(1,38) then
						if lastVehicle == configfarmerd.lastve and empfarmer.checkPlate(lastVehicle) then
							if empfarmer.checkCrimeRecord() then
								if not working then
									CalculateTimeToDisplay3()
									if parseInt(hour) >= 06 and parseInt(hour) <= 20 then
										working = true
										check = math.random(#configfarmerd.deliverys)
										makeBlipsServices2()
										TriggerEvent("Notify","sucesso","Entregas iniciada com <b>sucesso</b>.",8000)
									else
										TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
									end
								end
							else
								TriggerEvent("Notify","importante","Sua ficha criminal se encontra suja.",8000)
							end
						else
							TriggerEvent("Notify","importante","Veiculo inválido.",8000)
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ THREAD ]--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if working then
			if not IsPedInAnyVehicle(ped) then
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local distance = Vdist(configfarmerd.deliverys[check][1],configfarmerd.deliverys[check][2],configfarmerd.deliverys[check][3],x,y,z)
				local lastVehicle = GetEntityModel(GetPlayersLastVehicle())local lastVehicle = GetEntityModel(GetPlayersLastVehicle())
				if distance < 15.1 then
					idle = 5
					DrawMarker(21,configfarmerd.deliverys[check][1],configfarmerd.deliverys[check][2],configfarmerd.deliverys[check][3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,136, 96, 240, 180,0,0,0,1)
					if distance <= 1.2 then
						drawTexts("PRESSIONE  ~b~E~w~  PARA ENTREGAR GRAOS",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(1,38) and lastVehicle == 1026149675 and empfarmer.checkPlate(lastVehicle) and empfarmer.checkCrimeRecord() then
							
							CalculateTimeToDisplay3()
							if parseInt(hour) >= 06 and parseInt(hour) <= 20 then
								if empfarmer.startPayments() then
									RemoveBlip(blips)
									check = math.random(#configfarmerd.deliverys)
									makeBlipsServices2()
								end
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

--[ CANCEL | THREAD ]--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if working and IsControlJustPressed(1,168) then
			working = false
			RemoveBlip(blips)
			TriggerEvent("Notify","importante","Você saiu de serviço",8000)
		end
	end
end)

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function drawTexts(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function makeBlipsServices2()
	blips = AddBlipForCoord(configfarmerd.deliverys[check][1],configfarmerd.deliverys[check][2],configfarmerd.deliverys[check][3])
	SetBlipSprite(blips,1)
	SetBlipColour(blips,27)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entregas")
	EndTextCommandSetBlipName(blips)
end