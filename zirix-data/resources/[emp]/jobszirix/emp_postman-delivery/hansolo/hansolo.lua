local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp5 = Tunnel.getInterface("emp_postman-delivery")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local check = 0
local blips = false
local inService = false
local time = 0

--[ TIME | FUNCTION ]-----------------------------------------------------------------------------------------------------------

function CalculateTimeToDisplay()
	time = GetClockHours()
	if time <= 9 then
		time = "0" .. time
	end
end

--[ START DELIVERY | THREAD ]---------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(config.postmanloc.x,config.postmanloc.y,config.postmanloc.z,x,y,z)
			local lastVehicle = GetEntityModel(GetPlayersLastVehicle())
			if distance < 10.1 then
				idle = 5
				DrawMarker(23,config.postmanloc.x,config.postmanloc.y,config.postmanloc.z-0.98,0,0,0,0,0,0,1.0,1.0,0.5,136, 96, 240, 180,0,0,0,0)
				if distance < 1.2 then
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), config.postmanloc.x,config.postmanloc.y,config.postmanloc.z, true ) <= 1.1  then
						DrawText3D(config.postmanloc.x,config.postmanloc.y,config.postmanloc.z, "Pressione [~p~E~w~] para iniciar a entrega das ~p~ENCOMENDAS~w~.")
					end
					if IsControlJustPressed(1,38) and emp5.checkCrimeRecord() and not inService then
						if lastVehicle == config.postmanveh and emp5.checkPlate(lastVehicle) then
							CalculateTimeToDisplay()
							if parseInt(time) >= 06 and parseInt(time) <= 22 then
								inService = true
								check = math.random(#config.postmandeliverys)
								makeBlipsServices()
								TriggerEvent("Notify","sucesso","<b>Rota</b> iniciada.",8000)
							else
								TriggerEvent("Notify","negado","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
							end
						else
							TriggerEvent("Notify","negado","Você precisa do <b>veículo de entregas</b> para fazer isso.")
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ DELIVER ORDER | THREAD ]----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if inService then
			if not IsPedInAnyVehicle(ped) then
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local distance = Vdist(config.postmandeliverys[check][1],config.postmandeliverys[check][2],config.postmandeliverys[check][3],x,y,z)
				local lastVehicle = GetEntityModel(GetPlayersLastVehicle())
				if distance < 10.1 then
					idle = 5
					DrawMarker(21, config.postmandeliverys[check][1],config.postmandeliverys[check][2],config.postmandeliverys[check][3]-0.3, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
					if distance < 1.2 then
						if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),config.postmandeliverys[check][1],config.postmandeliverys[check][2],config.postmandeliverys[check][3], true ) <= 1.1  then
							DrawText3D(config.postmandeliverys[check][1],config.postmandeliverys[check][2],config.postmandeliverys[check][3], "Pressione [~p~E~w~] para entregar as ~p~ENCOMENDAS~w~.")
						end
						if IsControlJustPressed(1,38) then
							if lastVehicle == -233098306 and emp5.checkPlate(lastVehicle) then
								CalculateTimeToDisplay()
								if parseInt(time) >= 06 and parseInt(time) <= 20 then
									if emp5.startPayments() then
										RemoveBlip(blips)
										check = math.random(#config.postmandeliverys)
										makeBlipsServices()
									end
								else
									TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
								end
							else
								TriggerEvent("Notify","negado","Você precisa do <b>veículo de entregas</b> para fazer isso.")
							end
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ CANCEL SERVICE | THREAD ]---------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if inService and IsControlJustPressed(1,168) then
			inService = false
			RemoveBlip(blips)
			TriggerEvent("Notify","importante","Você saiu de serviço",8000)
		end
	end
end)

--[ TEXT | FUNCTION ]-----------------------------------------------------------------------------------------------------------

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

--[ BLIP | FUNCTION ]-----------------------------------------------------------------------------------------------------------

function makeBlipsServices()
	blips = AddBlipForCoord(config.postmandeliverys[check][1],config.postmandeliverys[check][2],config.postmandeliverys[check][3])
	SetBlipSprite(blips,1)
	SetBlipColour(blips,27)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Encomendas")
	EndTextCommandSetBlipName(blips)
end