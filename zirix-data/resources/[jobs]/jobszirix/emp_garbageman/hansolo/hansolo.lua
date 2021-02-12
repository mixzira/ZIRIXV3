local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp1 = Tunnel.getInterface("emp_garbageman")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local blips = false
local working = false
local onTrash = false
local trashHand = false
local trashSpawn = false
local onRota = false
local onLocal = false
local trashOn = false
local selected = 0
local hour = 0

--[ EVENTS ]--------------------------------------------------------------------------------------------------------------------

function CalculateTimeToDisplay4()
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
			local bowz,cdz = GetGroundZFor_3dCoord(configgarbageman.coleta.x,configgarbageman.coleta.y,configgarbageman.coleta.z)
			local distance = GetDistanceBetweenCoords(configgarbageman.coleta.x,configgarbageman.coleta.y,cdz,x,y,z,true)
			if distance <= 3 then
				idle = 5
				DrawMarker(23, configgarbageman.coleta.x, configgarbageman.coleta.y, configgarbageman.coleta.z-0.99,0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
				drawTxt("PRESSIONE  ~p~E~w~  PARA INICIAR A ROTA",4,0.5,0.92,0.35,255,255,255,180)
				if distance < 1.1 then
					if IsControlJustPressed(1,38) then
						CalculateTimeToDisplay4()
						if parseInt(hour) >= 06 and parseInt(hour) <= 20 then
							if not working then
								working = true
							  	selected = 1
							  	createBlip(configgarbageman.locs,selected)
						  	end
						else
							TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ DELIVERY ]------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if working then
			idle = 5
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(configgarbageman.locs[selected].x,configgarbageman.locs[selected].y,configgarbageman.locs[selected].z)
			local distance = GetDistanceBetweenCoords(configgarbageman.locs[selected].x,configgarbageman.locs[selected].y,cdz,x,y,z,true)
			local ped = PlayerPedId()

			local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)

			if distance >= 20.0 then
				onRota = true
				onLocal = false
				trashOn = false
			else
				onRota = false
				onLocal = true
				onTrash = true
			end

			if IsPedInAnyVehicle(ped) then
				drawTxt("PRESSIONE ~r~F7~w~ PARA ENCERRAR O SERVIÇO",4,0.218,0.963,0.35,255,255,255,120)
			else
				drawTxt("PRESSIONE ~r~F7~w~ PARA ENCERRAR O SERVIÇO",4,0.068,0.963,0.35,255,255,255,120)
			end

			if onRota then
				if IsPedInAnyVehicle(ped) then
					drawTxt("VÁ ATÉ O LOCAL DE COLETA DE LIXO",4,0.220,0.938,0.45,255,255,255,200)
				else
					drawTxt("VÁ ATÉ O LOCAL DE COLETA DE LIXO",4,0.070,0.938,0.45,255,255,255,200)
				end
			end

			if onLocal then
				if IsPedInAnyVehicle(ped) then
					drawTxt("PEGUE O SACO DE LIXO E JOGUE NO CAMINHÃO",4,0.242,0.938,0.45,255,255,255,200)
				else
					drawTxt("PEGUE O SACO DE LIXO E JOGUE NO CAMINHÃO",4,0.091,0.938,0.45,255,255,255,200)
				end
			end

			if onTrash then
				if DoesObjectOfTypeExistAtCoords(configgarbageman.locs[selected].x,configgarbageman.locs[selected].y,configgarbageman.locs[selected].z-0.97,0.9,GetHashKey(configgarbageman.prop),true) then
					onTrash = false
				else
					if not trashOn then
						if nome ~= "d" then
							sacolixo = CreateObject(GetHashKey(configgarbageman.prop),configgarbageman.locs[selected].x,configgarbageman.locs[selected].y,configgarbageman.locs[selected].z-0.97,true,true,true)
							PlaceObjectOnGroundProperly(sacolixo)
							SetModelAsNoLongerNeeded(sacolixo)
							Citizen.InvokeNative(0xAD738C3085FE7E11,sacolixo,true,true)
							FreezeEntityPosition(sacolixo,true)
							SetEntityAsNoLongerNeeded(sacolixo)
						end
						onTrash = false
						trashOn = true
						trashSpawn = true
					end
				end
			end

			if distance <= 1.5 then
				if trashSpawn then
					drawTxt("PRESSIONE ~b~E~w~ PARA PEGAR O SACO DE LIXO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						sacolixo = GetClosestObjectOfType(configgarbageman.locs[selected].x,configgarbageman.locs[selected].y,configgarbageman.locs[selected].z-0.97,0.9,GetHashKey(configgarbageman.prop),false,false,false)
						Citizen.InvokeNative(0xAD738C3085FE7E11,sacolixo,true,true)
						SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(sacolixo))
						DeleteObject(sacolixo)
						vRP.CarregarObjeto("","","prop_cs_rub_binbag_01",50,57005,0.11,0,0.0,0)
						trashHand = true
						trashSpawn = false
					end
				end
			end

			local vehicle = vRP.getNearestVehicle(7)
			local portaMalas = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle,"boot"))
			local distanciaPortaMalas = GetDistanceBetweenCoords(portaMalas, coord, 2)

			if trashHand then
				if distanciaPortaMalas <= 2 then
					drawTxt("PRESSIONE ~b~E~w~ PARA JOGAR A SACOLA DE LIXO NO CAMINHAO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						vRP._DeletarObjeto()
						emp1.payment()
						RemoveBlip(blips)
						if selected == #configgarbageman.locs then
							selected = 1
						else
							selected = selected + 1
						end
						createBlip(configgarbageman.locs,selected)
						trashHand = false
						onRota = true
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ CANCEL | THREAD ]-----------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if working then
			idle = 5
			if IsControlJustPressed(0,168) then
				working = false
				RemoveBlip(blips)
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

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

function createBlip(locs,selected)
	blips = AddBlipForCoord(locs[selected].x,locs[selected].y,locs[selected].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,27)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Lixo")
	EndTextCommandSetBlipName(blips)
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