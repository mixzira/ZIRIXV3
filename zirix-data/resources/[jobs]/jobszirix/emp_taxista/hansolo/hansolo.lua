local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp9 = Tunnel.getInterface("emp_taxista")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local blips = nil
local selecionado = 0
local emservico = false
local passageiro = nil
local lastpassageiro = nil
local checkped = true
local timers = 0
local payment = 1

--[ TAXIMETRO | VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local TaxiGuiAtivo = true -- Ativa o GUIzin (Default: true)
local Custobandeira = 3.0 --(1.00 = R$60 por minuto) Custo por minuto
local custoporKm = 50.0 -- Custo por Km
local CustoBase = 10.0 -- Custo Inicial

DecorRegister("bandeiras", 1)
DecorRegister("kilometros", 1)
DecorRegister("meteractive", 2)
DecorRegister("CustoBase", 1)
DecorRegister("custoporKm", 1)
DecorRegister("Custobandeira", 1)

local inTaxi = false
local meterOpen = false
local meterActive = false

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function CalculateTimeToDisplay8()
	hour = GetClockHours()
	if hour <= 9 then
		hour = "0" .. hour
	end
end

--[ THREAD ]----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		if not emservico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(configtaxi.taxiloc.x,configtaxi.taxiloc.y,configtaxi.taxiloc.z)
			local distance = GetDistanceBetweenCoords(configtaxi.taxiloc.x,configtaxi.taxiloc.y,configtaxi.taxiloc.z,x,y,z,true)

			if distance <= 3 then
				sleep = 5
				DrawMarker(23,configtaxi.taxiloc.x,configtaxi.taxiloc.y,configtaxi.taxiloc.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 240, 0, 0, 0, 0)
				if distance <= 1.2 then
					sleep = 5
					drawTexts("PRESSIONE  ~p~E~w~  PARA INICIAR O SERVIÇO",4,0.5,0.92,0.35,255,255,255,180)
					if IsControlJustPressed(0,38) then
						CalculateTimeToDisplay8()
						if parseInt(hour) >= 06 and parseInt(hour) <= 20 then
							emp9.addGroup()
							emservico = true
							selecionado = math.random(#configtaxi.taxi)
							CriandoBlip(taxi,selecionado)
							TriggerEvent("Notify","sucesso","Você entrou em serviço.")
						else
							TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

--[ PASSENGER ]----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000

		if emservico then
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
			local vehiclespeed = GetEntitySpeed(vehicle)*3.6
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(configtaxi.taxi[selecionado].x,configtaxi.taxi[selecionado].y,configtaxi.taxi[selecionado].z)
			local distance = GetDistanceBetweenCoords(configtaxi.taxi[selecionado].x,configtaxi.taxi[selecionado].y,configtaxi.taxi[selecionado].z,x,y,z,true)

			if distance <= 50.0 and IsVehicleModel(vehicle,GetHashKey("taxi")) then
				idle = 5
				DrawMarker(21,configtaxi.taxi[selecionado].x,configtaxi.taxi[selecionado].y,configtaxi.taxi[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,0,0,50,1,0,0,1)
				if distance <= 2.5 then
					if IsControlJustPressed(0,38) and emp9.checkPermission() then
						RemoveBlip(blips)
						FreezeEntityPosition(vehicle,true)
						if DoesEntityExist(passageiro) then
							emp9.checkPayment(payment)
							Citizen.Wait(3000)
							TaskLeaveVehicle(passageiro,vehicle,262144)
							TaskWanderStandard(passageiro,10.0,10)
							Citizen.Wait(1100)
							SetVehicleDoorShut(vehicle,3,0)
							Citizen.Wait(1000)
						end

						if checkped then
							local pmodel = math.random(#configtaxi.pedlist)
							modelRequest(configtaxi.pedlist[pmodel].model)

							passageiro = CreatePed(4,configtaxi.pedlist[pmodel].hash,configtaxi.taxi[selecionado].xp,configtaxi.taxi[selecionado].yp,configtaxi.taxi[selecionado].zp,3374176,true,false)
							SetEntityInvincible(passageiro,true)
							TaskEnterVehicle(passageiro,vehicle,-1,2,1.0,1,0)
							checkped = false
							payment = 1
							lastpassageiro = passageiro
						else
							passageiro = nil
							checkped = true
							FreezeEntityPosition(vehicle,false)
						end

						lselecionado = selecionado
						while true do
							if lselecionado == selecionado then
								selecionado = math.random(#configtaxi.taxi)
							else
								break
							end
							Citizen.Wait(1)
						end

						CriandoBlip(configtaxi.taxi,selecionado)

						if DoesEntityExist(passageiro) then
							while true do
								Citizen.Wait(1)
								local x2,y2,z2 = table.unpack(GetEntityCoords(passageiro))
								if not IsPedSittingInVehicle(passageiro,vehicle) then
									DrawMarker(21,x2,y2,z2+1.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,50,1,0,0,1)
								end
								if IsPedSittingInVehicle(passageiro,vehicle) then
									FreezeEntityPosition(vehicle,false)
									break
								end
							end
						end
					end
				end
			end

			if IsEntityAVehicle(vehicle) and DoesEntityExist(passageiro) then
				if math.ceil(vehiclespeed) >= configtaxi.maxvel and timers <= 0 and payment > 0 then
					print("entrei aqui")
					timers = 5
					payment = payment - 1
				end
			end

		end
		Citizen.Wait(idle)
	end
end)

--[ TIMERS ]----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if emservico then
			if timers > 0 then
				timers = timers - 1
			end
		end
	end
end)

--[ REMOVENPCS ]----------------------------------------------------------------------------------------------------

function removePeds()
	SetTimeout(20000,function()
		if emservico and lastpassageiro and passageiro == nil then
			TriggerServerEvent("trydeleteped",PedToNet(lastpassageiro))
		end
	end)
end

--[ CANCEL ]----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if emservico then
			idle = 1
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if IsControlJustPressed(0,168) then
				RemoveBlip(blips)
				if DoesEntityExist(passageiro) then
					TaskLeaveVehicle(passageiro,vehicle,262144)
					TaskWanderStandard(passageiro,10.0,10)
					Citizen.Wait(1100)
					SetVehicleDoorShut(vehicle,3,0)
					FreezeEntityPosition(vehicle,false)					
				end
				blips = nil
				selecionado = 0
				passageiro = nil
				checkped = true
				emservico = false
				emp9.removeGroup()
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ TAXIMETRO ]----------------------------------------------------------------------------------------------------

function openGui()
  SendNUIMessage({openMeter = true})
end

function closeGui()
  SendNUIMessage({openMeter = false})
  meterOpen = false
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if NoTaxi() and GetPedInVehicleSeat(veh, -1) ~= ped then
      local ped = PlayerPedId()
      local veh = GetVehiclePedIsIn(ped, false)
      TriggerEvent('taxi:updatebandeira', veh)
      openGui()
      meterOpen = true
    end
    if meterActive and GetPedInVehicleSeat(veh, -1) == ped then
      local _bandeira = DecorGetFloat(veh, "bandeiras")
      local _kilometros = DecorGetFloat(veh, "kilometros")
      local _Custobandeira = DecorGetFloat(veh, "Custobandeira")

      if _Custobandeira ~= 0 then
        DecorSetFloat(veh, "bandeiras", _bandeira + _Custobandeira)
      else
        DecorSetFloat(veh, "bandeiras", _bandeira + Custobandeira)
      end
      DecorSetFloat(veh, "kilometros", _kilometros + round(GetEntitySpeed(veh) * 0.000621371, 5))
      TriggerEvent('taxi:updatebandeira', veh)
    end
    if NoTaxi() and not GetPedInVehicleSeat(veh, -1) == ped then
      TriggerEvent('taxi:updatebandeira', veh)
    end
  end
end)

if TaxiGuiAtivo then
  Citizen.CreateThread(function()
    while true do
      local idle = 1000
	  if(NoTaxi()) then
		idle = 5
        inTaxi = true
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if(NoTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
          if IsControlJustReleased(0,170) and emp9.checkPermission() then -- F3
            TriggerEvent('taxi:toggleDisplay')
            Citizen.Wait(100)
          end
          if IsControlJustReleased(0,288) and emp9.checkPermission() then -- F1
            TriggerEvent('taxi:toggleHire')
            Citizen.Wait(100)
          end
          if IsControlJustReleased(0,289) and emp9.checkPermission() then -- F2
            TriggerEvent('taxi:resetMeter')
            Citizen.Wait(100)
          end
        end
      else
        if(meterOpen) then
          closeGui()
        end
        meterOpen = false
	  end
	  Citizen.Wait(idle)
    end
  end)
end

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

--Métodos de retorno de chamada NUI
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNetEvent('taxi:toggleDisplay')
AddEventHandler('taxi:toggleDisplay', function()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  if(NoTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
    if meterOpen then
      closeGui()
      meterOpen = false
    else
      local _bandeira = DecorGetFloat(veh, "bandeiras")
      if _bandeira < CustoBase then
        DecorSetFloat(veh, "bandeiras", CustoBase)
      end
      TriggerEvent('taxi:updatebandeira', veh)
      openGui()
      meterOpen = true
    end
  end
end)

RegisterNetEvent('taxi:toggleHire')
AddEventHandler('taxi:toggleHire', function()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  if(NoTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
    if meterActive then
      SendNUIMessage({meterActive = false})
      meterActive = false
      DecorSetBool(veh, "meteractive", false)
    else
      SendNUIMessage({meterActive = true})
      meterActive = true
      DecorSetBool(veh, "meteractive", true)
    end
  end
end)

RegisterNetEvent('taxi:resetMeter')
AddEventHandler('taxi:resetMeter', function()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  if(NoTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
    local _bandeira = DecorGetFloat(veh, "bandeiras")
    local _kilometros = DecorGetFloat(veh, "kilometros")
    DecorSetFloat(veh, "CustoBase", CustoBase)
    DecorSetFloat(veh, "custoporKm", custoporKm)
    DecorSetFloat(veh, "Custobandeira", Custobandeira)
    DecorSetFloat(veh, "bandeiras", DecorGetFloat(veh, "CustoBase"))
    DecorSetFloat(veh, "kilometros", 0.0)
    TriggerEvent('taxi:updatebandeira', veh)
  end
end)

function IsInVehicle()
  local ply = PlayerPedId()
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

function NoTaxi()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  local model = GetEntityModel(veh)
  local displaytext = GetDisplayNameFromVehicleModel(model)
  local name = GetLabelText(displaytext)
  if (name == "Táxi") then
    return true
  else
    return false
  end
end

function ReturnVehicle()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  local model = GetEntityModel(veh)
  local displaytext = GetDisplayNameFromVehicleModel(model)
  local name = GetLabelText(displaytext)
end

function IsNearPlayer(player)
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
  local ply2Coords = GetEntityCoords(ply2, 0)
  local distance = GetDistanceBetweenCoords(ply2Coords["x"], ply2Coords["y"], ply2Coords["z"],  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
  if(distance <= 5) then
    return true
  end
end

RegisterNetEvent('taxi:updatebandeira')
AddEventHandler('taxi:updatebandeira', function(veh)
  local id = PlayerId()
  local playerName = GetPlayerName(id)
  local _bandeira = DecorGetFloat(veh, "bandeiras")
  local _kilometros = DecorGetFloat(veh, "kilometros")
  local Custobandeira = _bandeira + (_kilometros * DecorGetFloat(veh, "custoporKm"))


  SendNUIMessage({
    updateBalance = true,
    balance = string.format("%.2f", Custobandeira),
    player = string.format("%.2f", _kilometros),
    meterActive = DecorGetBool(veh, "meteractive")
  })
end)

--[ FUNCTION ]----------------------------------------------------------------------------------------------------

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

function modelRequest(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(10)
	end
end

function drawTexts(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end


function CriandoBlip(taxi,selecionado)
	blips = AddBlipForCoord(configtaxi.taxi[selecionado].x,configtaxi.taxi[selecionado].y,configtaxi.taxi[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,27)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Corrida de Taxista")
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