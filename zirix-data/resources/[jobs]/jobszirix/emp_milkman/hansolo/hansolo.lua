local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp2 = Tunnel.getInterface("emp_milkman")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local process = false
local seconds = 0
local hour = 0

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function CalculateTimeToDisplay1()
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
			for _,func in pairs(config.cows) do
				local x2,y2,z2 = table.unpack(func)
				local distancia = Vdist(x,y,z,x2,y2,z2)
				local lastVehicle = GetEntityModel(GetPlayersLastVehicle())
				if distancia < 1.3 then
					idle = 5
					drawTxt("PRESSIONE  ~b~E~w~  PARA ORDENHAR A VACA",4,0.5,0.92,0.35,255,255,255,180)
					if IsControlJustPressed(0,38) and emp2.checkCrimeRecord() then
						if not process then
							if lastVehicle == 1026149675 and emp2.checkPlate(lastVehicle) then
								CalculateTimeToDisplay1()
								if parseInt(hour) >= 06 and parseInt(hour) <= 20 then
									if emp2.checkPayment() then	
										TriggerEvent('cancelando',true)
										vRP._playAnim(false,{{configmilkman.anim,configmilkman.animname}},true)	
										process = true
										seconds = 10
										SetTimeout(10000,function()
											vRP._stopAnim(false)
										end)
									end
								else
									TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
								end
							else
								TriggerEvent("Notify","negado","Você precisa utilizar o <b>veículo de serviço</b>.",10000)
							end
						end
					end
				end
			end
		end
		if process then
			drawTxt("AGUARDE ~b~"..seconds.."~w~ SEGUNDOS ATÉ FINALIZAR A EXTRAÇÃO DO LEITE",4,0.5,0.94,0.35,255,255,255,180)
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if seconds > 0 and process then
			seconds = seconds - 1
			if seconds == 0 then
				process = false
				TriggerEvent('cancelando',false)
			end
		end
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