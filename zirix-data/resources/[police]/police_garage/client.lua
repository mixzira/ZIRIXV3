local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("police_garage")

local open = false
local categoriaSelecionada = nil
local carroSelecionado = nil

RegisterCommand("conce",function()
	open = true
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openGeneral'})
end)

Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        Wait(5)

        local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1078.81,-856.44,5.05 - 0.97, true)
			if distance <= 50 then
				DrawMarker(23,-1078.81,-856.44,5.05-0.97,0,0,0,0.0,0,0,0.8,0.8,0.8,0,0,0,300,0,0,0,1)
				DrawMarker(36,-1078.81,-856.44,5.05-0.50,0,0,0,0.0,0,0,0.8,0.8,0.8,255,255,255,200,1,0,0,1)
				if distance <= 2 then
					if not open then
						if IsControlJustPressed(1, 38) then
							open = true
							SetNuiFocus(true, true)
							SendNUIMessage({type = 'openGeneral'})
						end
					end
				end
			end
		end
	end)

-- TIRAR CARRO
carros = {}
Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        Wait(5)
        local ped = PlayerPedId()
        local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), -1112.1318359375,-1690.7235107422,4.5645732879639 - 0.97, true)

        if distance <= 100 then

            DrawMarker(23, -1112.1318359375,-1690.7235107422,4.5645732879639 - 0.97, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.5,
                       0, 95, 140, 80, 0, 0, 0, 0)

            if distance <= 2 then
                if not open then
                    if IsControlJustPressed(1, 38) and func.getPermissao() then
                        local name = func.getNomeVeiculo()
                        if name ~= "" then
                            if not carros[name] or carros[name] == nil then
                                local mhash = GetHashKey(name)

                                TriggerEvent("Notify", "aviso",
                                             "Buscando veículo!")

                                local tentativas = 0
                                while tentativas < 350 and
                                    not HasModelLoaded(mhash) do
                                    RequestModel(mhash)
                                    Citizen.Wait(10)
                                    tentativas = tentativas + 1
                                end
                                if not HasModelLoaded(mhash) then
                                    TriggerEvent("Notify", "negado",
                                                 "Veículo inválido!")

                                else
                                    local nveh =
                                        CreateVehicle(mhash,
                                                      GetEntityCoords(ped),
                                                      GetEntityHeading(ped),
                                                      true, false)

                                    local placa = vRP.getRegistrationNumber()
                                    SetVehicleOnGroundProperly(nveh)
                                    SetVehicleNumberPlateText(nveh, placa)
                                    SetEntityAsMissionEntity(nveh, true, false) -- Torna a entidade especificada (ped, veículo ou objeto) persistente. Entidades persistentes não serão removidas automaticamente pelo mecanismo.
                                    TaskWarpPedIntoVehicle(ped, nveh, -1)

                                    SetModelAsNoLongerNeeded(mhash)
                                    carros[name] = placa
                                end

                            else
                                TriggerEvent("Notify", "negado",
                                             "Veículo já foi retirado!")
                            end
                        end
                    end
                end
            end
        end

    end
end)

RegisterNUICallback("CarregarDados", function(data, cb)
    SendNUIMessage({
        type = 'loadData',
        veiculos = json.encode(Config.Veiculos),
        meusVeiculos = func.getVeiculos(),
        totalTipo = func.getTotalVeiculorTipo(),
        aberto = func.abertoTodos(),
        isVendedor = func.getPermissao()
    })
end)

RegisterNUICallback("ButtonClick", function(data, cb)
    if data.action == "close" then
        open = false
        SetNuiFocus(false, false)
        SendNUIMessage({type = 'closeAll'})
    end

    if data.action == "confirmarCompra" then
        if func.comprarVeiculo(data.categoria, data.model) then
            SendNUIMessage({
                type = 'openGeneral',
                veiculos = json.encode(Config.Veiculos),
                meusVeiculos = func.getVeiculos(),
                totalTipo = func.getTotalVeiculorTipo(),
                aberto = Config.AbertoAll,
                isVendedor = func.getPermissao()
            })
        end
    end

    if data.action == "confirmarVenda" then
        if func.venderVeiculo(data.categoria, data.model) then
            SendNUIMessage({
                type = 'openGeneral',
                veiculos = json.encode(Config.Veiculos),
                meusVeiculos = func.getVeiculos(),
                totalTipo = func.getTotalVeiculorTipo(),
                aberto = Config.AbertoAll,
                isVendedor = func.getPermissao()
            })
        end
    end
end)

RegisterNetEvent('vrp_concessionaria:closeAll')
AddEventHandler('vrp_concessionaria:closeAll', function()
    open = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
end)

RegisterNetEvent("vrp_concessionaria:deletarveiculo")
AddEventHandler('vrp_concessionaria:deletarveiculo', function(distance)
    local vehicle = vRP.getNearestVehicle(distance)
    if IsEntityAVehicle(vehicle) then
        -- local veh = VehToNet(vehicle)

        local vehicleLabel = GetDisplayNameFromVehicleModel(
                                 GetEntityModel(vehicle))
        local placa = GetVehicleNumberPlateText(vehicle)
        if carros[string.lower(vehicleLabel)] == placa then
            carros[string.lower(vehicleLabel)] = nil
        end
        TriggerServerEvent("vrp_adv_garages_id", veh,
                           GetVehicleEngineHealth(vehicle),
                           GetVehicleBodyHealth(vehicle),
                           GetVehicleFuelLevel(vehicle))
        TriggerServerEvent("trydeleteentity", VehToNet(vehicle))
    end
end)

RegisterNetEvent("vrp_concessionaria:notify")
AddEventHandler('vrp_concessionaria:notify', function(title, msg, type)
    SendNUIMessage({type = 'alert', title = title, msg = msg, typeMsg = type})
end)
