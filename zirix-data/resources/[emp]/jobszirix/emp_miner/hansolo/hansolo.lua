local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp11 = Tunnel.getInterface("emp_miner")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local working = false
local selected = 1
local process = false

--[ IN WORKING AREA | THREAD ]--------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not working then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local distance = Vdist(x, y, z, configminer.rocks[selected].x, configminer.rocks[selected].y, configminer.rocks[selected].z)
				local lastVehicle = GetEntityModel(GetPlayersLastVehicle())
				if distance <= 100.0 then
					idle = 5
					DrawMarker(21, configminer.rocks[selected].x, configminer.rocks[selected].y, configminer.rocks[selected].z-0.3, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
					if distance <= 1.2 and IsControlJustPressed(1,38) then
						if lastVehicle == configminer.lastveh and emp11.checkPlate(lastVehicle) and emp11.checkCrimeRecord() then
							if emp11.checkWeight() then
								working = true
								vRP.DeletarObjeto()
								TriggerEvent("cancelando",true)
								SetEntityCoords(ped, configminer.rocks[selected].x+0.0001, configminer.rocks[selected].y+0.0001, configminer.rocks[selected].z+0.0001-1, 1, 0, 0, 1)
								vRP.CarregarObjeto("amb@world_human_const_drill@male@drill@base", "base","prop_tool_jackham", 15, 28422)
								
								SetTimeout(10000,function()
									working = false
									vRP.DeletarObjeto()
									vRP._stopAnim(false)
									TriggerEvent("cancelando",false)
									backentrega = selected
									while true do
										if backentrega == selected then
											selected = math.random(#configminer.rocks)
										else
											break
										end
										Citizen.Wait(10)
									end
									emp11.collectOres()
								end)
							else
								TriggerEvent("Notify","negado","<b>Ferramenta</b> ou <b>espaço na mochila</b> insuficientes.")	
							end
						else
							TriggerEvent("Notify","negado","Você precisa do <b>veículo da mineradora</b> para fazer isso.")
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)