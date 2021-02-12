local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("vrp_garages")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp15 = Tunnel.getInterface("emp_trucker")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local emservico = false
local menuactive = false
local wood = false
local gas = false
local criado = false
local servehicle = nil

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function CalculateTimeToDisplay6()
	hour = GetClockHours()
	if hour <= 9 then
		hour = "0" .. hour
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------

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

-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("ButtonClick",function(data,cb)	
	if data == "gas-01" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configtrucker.trailer) do
				if k == 1 then
				TriggerEvent("Notify","sucesso","Carga de <b>Combustível</b> liberada.")
				spawnVehicle("tanker2",v.x,v.y,v.z)
				servehicle = 1956216962
				emservico = true
				gas = true
				end
			end
		end
	elseif data == "gas-02" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configtrucker.trailer) do
				if k == 2 then
					TriggerEvent("Notify","sucesso","Carga de <b>Combustível</b> liberada.")
					spawnVehicle("tanker2",v.x,v.y,v.z)
					servehicle = 1956216962
					emservico = true
					gas = true
				end
			end
		end
	elseif data == "gas-03" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configtrucker.trailer) do
				if k == 3 then
					spawnVehicle("tanker2",v.x,v.y,v.z)
					TriggerEvent("Notify","sucesso","Carga de <b>Combustível</b> liberada.")
					servehicle = 1956216962
					emservico = true
					gas = true
				end
			end
		end
	elseif data == "woods-01" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configtrucker.trailer) do
				if k == 4 then
					spawnVehicle("trailerlogs",v.x,v.y,v.z)
					servehicle = 2016027501
					emservico = true
					TriggerEvent("Notify","sucesso","Carga de <b>Madeiras</b> liberada.")
					wood = true
				end
			end
		end
	elseif data == "woods-02" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configtrucker.trailer) do
				if k == 5 then
					spawnVehicle("trailerlogs",v.x,v.y,v.z)
					servehicle = 2016027501
					emservico = true
					TriggerEvent("Notify","sucesso","Carga de <b>Madeiras</b> liberada.")
					wood = true
				end
			end
		end
	elseif data == "woods-03" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configtrucker.trailer) do
				if k == 6 then
					spawnVehicle("trailerlogs",v.x,v.y,v.z)
					servehicle = 2016027501
					emservico = true
					TriggerEvent("Notify","sucesso","Carga de <b>Madeiras</b> liberada.")
					wood = true
				end
			end
		end
	end
	if data == "fechar" then
		ToggleActionMenu()	
	end
end)

--[ THREAD ]-----------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not emservico then
			for _,v in pairs(configtrucker.start) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				local lastVehicle = GetEntityModel(GetPlayersLastVehicle())
					if distance <= 3 then
						idle = 5
						DrawMarker(23,v.x,v.y,v.z-0.99,0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
						if distance <= 1.2 then
							drawTxt("PRESSIONE  ~p~E~w~  PARA INICIAR O SERVIÇO",4,0.5,0.92,0.35,255,255,255,180)
							if IsControlJustPressed(1,38) then
								CalculateTimeToDisplay6()
                                --if parseInt(hour) >= 06 and parseInt(hour) <= 20 then
                                    if lastVehicle == GetHashKey(configtrucker.truck) or lastVehicle == GetHashKey(configtrucker.truck1) then
										ToggleActionMenu()
									else
                                        TriggerEvent("Notify","importante","Necessario um caminhao para iniciar.",8000)
                                    end
								--else
									--TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
								--end
							end
						end
					end
				end
			end
		Citizen.Wait(idle)
	end
end)

--[ DELIVERY ]-----------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if gas then
			if emservico then
				local entrega = math.random(#configtrucker.routegas)
				local pay = configtrucker.routegas[entrega].pay
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(configtrucker.routegas[entrega].x, configtrucker.routegas[entrega].y, configtrucker.routegas[entrega].z)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),configtrucker.routegas[entrega].x,configtrucker.routegas[entrega].y,configtrucker.routegas[entrega].z,true)
				if criado == false then
					criandoblip(configtrucker.routegas[entrega].x, configtrucker.routegas[entrega].y, configtrucker.routegas[entrega].z)
					criado = true
				end
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), configtrucker.routegas[entrega].x,configtrucker.routegas[entrega].y,configtrucker.routegas[entrega].z, true ) < 50 then
					idle = 5
					DrawMarker(23,configtrucker.routegas[entrega].x, configtrucker.routegas[entrega].y, configtrucker.routegas[entrega].z-0.96,0, 0, 0, 0, 0, 0, 10.0, 10.0, 1.0, 136, 96, 240, 180, 0, 0, 0, 0)
					if distance <= 10.0 then
						if IsControlJustPressed(0,38) then
							if not IsPedInAnyVehicle(ped) then
								local vehicle = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
								if GetEntityModel(vehicle) == servehicle then
									vSERVER.deleteVehicles(vehicle)
									emp15.checkPaymentGas(pay)
									RemoveBlip(blip)
									emservico = false
									criado = false	
								end
							else	
								TriggerEvent("Notify","importante","Saia do caminhao e vá ao lado da carga para entregar.",8000)					
							end
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if wood then
			if emservico then
				local entrega = math.random(#configtrucker.routewood)
				local pay = configtrucker.routewood[entrega].pay
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(configtrucker.routewood[entrega].x, configtrucker.routewood[entrega].y, configtrucker.routewood[entrega].z)
				local distance = GetDistanceBetweenCoords(configtrucker.routewood[entrega].x, configtrucker.routewood[entrega].y, configtrucker.routewood[entrega].z,cdz,x,y,z,true)
				if criado == false then
					criandoblip(configtrucker.routewood[entrega].x, configtrucker.routewood[entrega].y, configtrucker.routewood[entrega].z)
					criado = true
				end
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), configtrucker.routewood[entrega].x,configtrucker.routewood[entrega].y,configtrucker.routewood[entrega].z, true ) < 50 then
					idle = 5
					DrawMarker(23,configtrucker.routewood[entrega].x, configtrucker.routewood[entrega].y, configtrucker.routewood[entrega].z-0.96,0, 0, 0, 0, 0, 0, 10.0, 10.0, 1.0, 136, 96, 240, 180, 0, 0, 0, 0)
					if IsControlJustPressed(0,38) then
						if not IsPedInAnyVehicle(ped) then
							local vehicle = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
							if GetEntityModel(vehicle) == servehicle then
								vSERVER.deleteVehicles(vehicle)
								emp15.checkPaymentWood(pay)
								RemoveBlip(blip)
								emservico = false
								criado = false	
							end
						else	
							TriggerEvent("Notify","importante","Saia do caminhao e vá ao lado da carga para entregar.",8000)					
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
		if IsControlJustPressed(0,168) then
			if emservico then
				emservico = false
				RemoveBlip(blip)
				TriggerEvent("Notify","importante","Você cancelou o serviço.",8000)
				wood = false
				gas = false
				criado = false
			end
		end
	end
end)

--[ FUNCTION ]--------------------------------------------------------------------------------------------------------

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

function criandoblip(x,y,z)
	blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,27)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Caminhoneiro")
	EndTextCommandSetBlipName(blip)
	criado = true
end

function spawnVehicle(name,x,y,z)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end
	
	if HasModelLoaded(mhash) then
		local nveh = CreateVehicle(mhash,x,y,z,267.54,true,false)
		local netveh = VehToNet(nveh)
		local id = NetworkGetNetworkIdFromEntity(nveh)

		NetworkRegisterEntityAsNetworked(nveh)
		while not NetworkGetEntityIsNetworked(nveh) do
			NetworkRegisterEntityAsNetworked(nveh)
			Citizen.Wait(1)
		end

		if NetworkDoesNetworkIdExist(netveh) then
			SetEntitySomething(nveh,true)
			if NetworkGetEntityIsNetworked(nveh) then
				SetNetworkIdExistsOnAllMachines(netveh,true)
			end
		end

		SetNetworkIdCanMigrate(id,true)
		SetVehicleNumberPlateText(NetToVeh(netveh),"CAMINHAO")
		Citizen.InvokeNative(0xAD738C3085FE7E11,NetToVeh(netveh),true,true)
		SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
		SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
		SetModelAsNoLongerNeeded(mhash)
	end
end

function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end
