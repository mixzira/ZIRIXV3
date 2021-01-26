local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("vrp_garages")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp16 = Tunnel.getInterface("emp_pilot")

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
	if data == "airport-1" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configpilot.spawn) do
				if k == 1 then
				TriggerEvent("Notify","sucesso","Avião liberado para decolagem.")
				spawnVehicle(configpilot.plane,v.x,v.y,v.z)
				emservico = true
				gas = true
				end
			end
		end
	elseif data == "airport-2" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configpilot.spawn) do
				if k == 2 then
					TriggerEvent("Notify","sucesso","Avião liberado para decolagem.")
					spawnVehicle(configpilot.plane,v.x,v.y,v.z)
					emservico = true
					gas = true
				end
			end
		end
	elseif data == "airport-3" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configpilot.spawn) do
				if k == 3 then
					spawnVehicle(configpilot.plane,v.x,v.y,v.z)
					TriggerEvent("Notify","sucesso","Avião liberado para decolagem.")
					emservico = true
					gas = true
				end
			end
		end
	elseif data == "airport-01" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configpilot.spawn) do
				if k == 4 then
					spawnVehicle(configpilot.plane1,v.x,v.y,v.z)
					emservico = true
					TriggerEvent("Notify","sucesso","Avião liberado para decolagem.")
					wood = true
				end
			end
		end
	elseif data == "airport-02" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configpilot.spawn) do
				if k == 5 then
					spawnVehicle(configpilot.plane1,v.x,v.y,v.z)
					emservico = true
					TriggerEvent("Notify","sucesso","Avião liberado para decolagem.")
					wood = true
				end
			end
		end
	elseif data == "airport-03" then
		if emservico == true then
			TriggerEvent("Notify","importante","Voce ja esta em serviço.",8000)
		else
			for k,v in pairs(configpilot.spawn) do
				if k == 6 then
					spawnVehicle(configpilot.plane1,v.x,v.y,v.z)
					emservico = true
					TriggerEvent("Notify","sucesso","Avião liberado para decolagem.")
					wood = true
				end
			end
		end
	end
	if data == "fechar" then
		ToggleActionMenu()	
	end
end)

RegisterCommand("fechar",function()
	ToggleActionMenu()
end)


--[ THREAD ]-----------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not emservico then
			for _,v in pairs(configpilot.start) do
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
                                if parseInt(hour) >= 00 and parseInt(hour) <= 23 then
                                    if lastVehicle == GetHashKey(configpilot.truck) or lastVehicle == GetHashKey(configpilot.truck1) then
										ToggleActionMenu()
									else
                                        TriggerEvent("Notify","importante","Necessario um caminhao para iniciar.",8000)
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

--[ DELIVERY ]-----------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if gas then
			if emservico then
				local entrega = math.random(#configpilot.routegas)
				local pay = configpilot.routegas[entrega].pay
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(configpilot.routegas[entrega].x, configpilot.routegas[entrega].y, configpilot.routegas[entrega].z)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),configpilot.routegas[entrega].x,configpilot.routegas[entrega].y,configpilot.routegas[entrega].z,true)
				if criado == false then
					criandoblip(configpilot.routegas[entrega].x, configpilot.routegas[entrega].y, configpilot.routegas[entrega].z)
					criado = true
				end
				if distance <= 50.0 then
					idle = 5
					DrawMarker(23,configpilot.routegas[entrega].x, configpilot.routegas[entrega].y, configpilot.routegas[entrega].z-0.96,0, 0, 0, 0, 0, 0, 10.0, 10.0, 1.0, 136, 96, 240, 180, 0, 0, 0, 0)
					if distance <= 10.0 then
						if IsControlJustPressed(0,38) then
							if not IsPedInAnyVehicle(ped) then
								local vehicle = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
								if GetEntityModel(vehicle) == servehicle then
									vSERVER.deleteVehicles(vehicle)
									emp16.checkPaymentGas(pay)
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
				local entrega = math.random(#configpilot.routewood)
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(configpilot.routewood[entrega].x, configpilot.routewood[entrega].y, configpilot.routewood[entrega].z)
				local distance = GetDistanceBetweenCoords(configpilot.routewood[entrega].x, configpilot.routewood[entrega].y, configpilot.routewood[entrega].z,cdz,x,y,z,true)
				if criado == false then
					criandoblip(configpilot.routewood[entrega].x, configpilot.routewood[entrega].y, configpilot.routewood[entrega].z)
					criado = true
				end
				if distance <= 10.0 then
					if IsControlJustPressed(0,38) then
						if not IsPedInAnyVehicle(ped) then
							local vehicle = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
							if GetEntityModel(vehicle) == servehicle then
								vSERVER.deleteVehicles(vehicle)
								emp16.checkPaymentWood(pay)
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
	AddTextComponentString("Plano de Voo")
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
		local nveh = CreateVehicle(mhash,x,y,z,147.22,true,false)
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
