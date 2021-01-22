local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp4 = Tunnel.getInterface("emp_postman")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local process = false

--[ TIME | FUNCTION ]-----------------------------------------------------------------------------------------------------------

local time = 0
function CalculateTimeToDisplay5()
	time = GetClockHours()
	if time <= 9 then
		time = "0" .. time
	end
end

--[ PROCESS | THREAD ]----------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			if Vdist(configpostman.startpostman.x,configpostman.startpostman.y,configpostman.startpostman.z,x,y,z) < 5.1 then
				idle = 5
				DrawMarker(23, configpostman.startpostman.x, configpostman.startpostman.y, configpostman.startpostman.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
				if Vdist(configpostman.startpostman.x,configpostman.startpostman.y,configpostman.startpostman.z,x,y,z) <= 1.2 then
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), configpostman.startpostman.x,configpostman.startpostman.y,configpostman.startpostman.z, true ) <= 1.1  then
						DrawText3D(configpostman.startpostman.x,configpostman.startpostman.y,configpostman.startpostman.z, "Pressione [~p~E~w~] para empacotar as ~p~ENCOMENDAS~w~.")
					end
					if IsControlJustPressed(1,38) then
						if not process then
							CalculateTimeToDisplay5()
							if parseInt(time) >= 06 and parseInt(time) <= 20 then
								if emp4.checkCrimeRecord() and emp4.checkWeight() then
									process = true
									TriggerEvent('cancelando',true)
									TriggerEvent("progress",8000,"Coletando")
									FreezeEntityPosition(ped,true)
									vRP._playAnim(false,{{configpostman.animpostman,configpostman.animname}},true)
									SetTimeout(8000,function()
										process = false
										TriggerEvent('cancelando',false)
										emp4.giveOrders()
										FreezeEntityPosition(ped,false)
										vRP._stopAnim(false)
									end)
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