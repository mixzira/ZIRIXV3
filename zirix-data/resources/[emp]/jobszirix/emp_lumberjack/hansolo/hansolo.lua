local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp7 = Tunnel.getInterface("emp_lumberjack")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local processo = false
local segundos = 0
local list = {}

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function CalculateTimeToDisplay7()
	hour = GetClockHours()
	if hour <= 9 then
		hour = "0" .. hour
	end
end

--[ THREAD ]--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not processo then
			for _,func in pairs(configlumberjack.trees) do
				local ped = PlayerPedId()
				local i,x,y,z = table.unpack(func)
				local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z)
				local vehicle = GetPlayersLastVehicle()
				if distancia <= 10 and list[i] == nil then
					idle = 5
					DrawMarker(21,x,y,z,0,0,0,0,180.0,130.0,0.5,0.5,0.5,136, 96, 240,180,1,0,0,1)
					if distancia <= 1.2 then
						if GetSelectedPedWeapon(ped) == GetHashKey(configlumberjack.axe) or GetSelectedPedWeapon(ped) == GetHashKey(configlumberjack.axe) then
							if IsControlJustPressed(0,38) and emp7.checkPayment() then
								CalculateTimeToDisplay7()
								--if parseInt(hour) >= 06 and parseInt(hour) <= 20 then
									if emp7.checkPayment() then
										list[i] = true
										processo = true
										segundos = 3
										SetEntityCoords(ped,x,y,z-1)
										SetEntityHeading(ped,100.0)
										vRP._playAnim(false,{{"melee@hatchet@streamed_core","plyr_front_takedown_b"}},true)
										TriggerEvent('cancelando',true)
									end
								--else
									--TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
								--end
							end
						end
					end
				end
			end
		end
		if processo then
			idle = 5
			drawTxt("AGUARDE ~g~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR A EXTRAÇÃO DA MADEIRA",4,0.5,0.92,0.35,255,255,255,180)
		end
		Citizen.Wait(idle)
	end
end)

--[ CANCEL | THREAD ]--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if processo then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					processo = false
					vRP._stopAnim(false)
					TriggerEvent('cancelando',false)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)

--[ FUNCTION ]--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(180000)
		list = {}
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