local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
farm_ammo = Tunnel.getInterface("farm_ammo")

local blipsfammo = true
local servico = false
local selecionado = 0
local quantidade = 0
local porcentagem = 0
local criado = false
local selec = false

Citizen.CreateThread(function()
	while true do
		idle = 1000
		if not servico then			
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(config1.start[1],config1.start[2],config1.start[3])
			local distance = GetDistanceBetweenCoords(config1.start[1],config1.start[2],cdz,x,y,z,true)

			if distance <= 3 then
				idle = 5
				DrawMarker(23,config1.start[1],config1.start[2],config1.start[3]-0.97,0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and farm_ammo.checkPermission() then						
						servico = true						
						porcentagem = math.random(100)					
						
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
						TriggerEvent("Notify","importante","Vá até o próximo local e colete o pacote</b>.")
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		idle = 1000
		if servico then
			local ped = PlayerPedId()
			if selec == false then
				selecionado = math.random(#config1.locs)
				selec = true
			end
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(config1.locs[selecionado].x,config1.locs[selecionado].y,config1.locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(config1.locs[selecionado].x,config1.locs[selecionado].y,cdz,x,y,z,true)			
			if criado == false then
				CriandoBlip(config1.locs,selecionado)
				criado = true
			end
			if distance <= 15 then
				idle = 5
				DrawMarker(23,config1.locs[selecionado].x,config1.locs[selecionado].y,config1.locs[selecionado].z-0.90,0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
				if distance <= 1.5 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR O PACOTE",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if farm_ammo.checkPayment() then
							
							porcentagem = math.random(1,100)

							if porcentagem >= config1.percentage[1] and porcentagem <= config1.percentage[2] then
								farm_ammo.MarcarOcorrencia()
							end
							RemoveBlip(blipsfammo)
							
							backentrega = selecionado
							while true do
								if backentrega == selecionado then
									selecionado = math.random(#config1.locs)
								else
									break
								end
							end							
							CriandoBlip(config1.locs,selecionado)
							TriggerEvent("Notify","importante","Vá até o próximo local e colete o <b>Pacote</b>.")
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
		idle = 1000
		if servico then
			idle = 5
			if IsControlJustPressed(1,121) then
			TriggerEvent("Notify","importante","Vá até o próximo local e colete o <b>Pacote</b>.")
			elseif IsControlJustPressed(1,168) then
				servico = false
				RemoveBlip(blipsfammo)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
		Citizen.Wait(idle)
	end
end)

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

function CriandoBlip(locs,selecionado)
	blipsfammo = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blipsfammo,1)
	SetBlipColour(blipsfammo,5)
	SetBlipScale(blipsfammo,0.4)
	SetBlipAsShortRange(blipsfammo,false)
	SetBlipRoute(blipsfammo,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Pacote")
	EndTextCommandSetBlipName(blipsfammo)
end
