local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local hour = 0
local minute = 0
local started = true
local displayValue = false
local sBuffer = {}
local vBuffer = {}
local gasolina = 0
local cintoseg = false
local thirst, hunger = 0, 0
local zones = { ['AIRP'] = "Aeroporto Internacional", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local segundos = 0

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(1000)
    local pos = GetEntityCoords(PlayerPedId())
    local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
    local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]

    if(GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z)) then
      if(zones[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1))) then
        ruas = tostring(GetStreetNameFromHashKey(var1))..", "..zones[GetNameOfZone(pos.x, pos.y, pos.z)]
      end
    end

		UpdateOverlay()
	end
end)

function UpdateOverlay()
  CalculateTimeToDisplay()
end

local menu_celular = false
RegisterNetEvent("status:celular")
AddEventHandler("status:celular",function(status)
	menu_celular = status
end)

local on_gps = false
RegisterNetEvent("status:gps")
AddEventHandler("status:gps",function(status)
	on_gps = status
end)


RegisterNetEvent("vrp_hud:update")
AddEventHandler("vrp_hud:update", function(rHunger, rThirst)
  hunger, thirst = rHunger, rThirst
end)

Citizen.CreateThread(function()
  local seatbeltIsOn = false
	while true do
    local idle = 2500
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),false))

		health = (GetEntityHealth(PlayerPedId())-100)/300*100
    armor = GetPedArmour(PlayerPedId())

    if started then 
      if IsPauseMenuActive() or menu_celular then
        displayValue = false
      else
        displayValue = true
      end
    end

    if IsPedInAnyVehicle(PlayerPedId()) then
      idle = 250
      speed = math.ceil(GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId()))*3.605936)
      nsei,baixo,alto = GetVehicleLightsState(GetVehiclePedIsIn(PlayerPedId()))
      inCar = true
			pedcar = GetVehiclePedIsIn(PlayerPedId())
      gasolina = GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId()))
      if baixo == 1 and alto == 0 then
				farol = 1
			elseif  alto == 1 then
				farol = 2
			else
				farol = 0
      end
      DisplayRadar(true)
    else
			if on_gps then
			  DisplayRadar(true)
      else
        DisplayRadar(false)
      end
			inCar  = false
      speed = nil
      gasolina = nil
      cintoseg = nil
      farol = nil
    end
		SendNUIMessage({
			show = show,
      incar = inCar,
      speed = speed,
			heal = health,
      armor = armor,
      thirst = thirst,
      hunger = hunger,
      hora = hour,
      minuto = minute,
      rua = ruas,
      gas = gasolina,
      cinto = cintoseg,
      farol = farol,
		 	display = displayValue
    });
    Citizen.Wait(idle)
	end
end)

IsCar = function(veh)
  local vc = GetVehicleClass(veh)
  return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end

Fwv = function (entity)
  local hr = GetEntityHeading(entity) + 90.0
  if hr < 0.0 then
    hr = 360.0 + hr
  end
  hr = hr * 0.0174533
  return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end


RegisterNetEvent("vrp_hud:belt")
AddEventHandler("vrp_hud:belt",function()
  local ped = PlayerPedId()
  local car = GetVehiclePedIsIn(ped)
  if car ~= 0 and (ExNoCarro or IsCar(car)) then
    TriggerEvent("cancelando",true)
    if cintoseg then
      TriggerEvent("vrp_sound:source",'unbelt',0.5)
      SetTimeout(2000,function()
        cintoseg = false
        TriggerEvent("cancelando",false)
      end)
    else
      TriggerEvent("vrp_sound:source",'belt',0.5)
      SetTimeout(3000,function()
        cintoseg = true
        TriggerEvent("cancelando",false)
      end)
    end
  end
end, false)

Citizen.CreateThread(function()
  while true do
    local idle = 10000
    if inCar then
      idle = 10
      local ped = PlayerPedId()
      local car = GetVehiclePedIsIn(ped)
      if car ~= 0 and (ExNoCarro or IsCar(car)) then
        ExNoCarro = true
        if cintoseg then
          DisableControlAction(0,75)
        end
        sBuffer[2] = sBuffer[1]
        sBuffer[1] = GetEntitySpeed(car)
        if sBuffer[2] ~= nil and not cintoseg and GetEntitySpeedVector(car,true).y > 1.0 and sBuffer[1] > 10.25 and (sBuffer[2] - sBuffer[1]) > (sBuffer[1] * 0.255) then
          local co = GetEntityCoords(ped)
          local fw = Fwv(ped)
          SetEntityHealth(ped,GetEntityHealth(ped)-150)
          SetEntityCoords(ped,co.x+fw.x,co.y+fw.y,co.z-0.47,true,true,true)
          SetEntityVelocity(ped,vBuffer[2].x,vBuffer[2].y,vBuffer[2].z)
          segundos = 20
        end
        vBuffer[2] = vBuffer[1]
        vBuffer[1] = GetEntityVelocity(car)
      elseif ExNoCarro then
        ExNoCarro = false
        cintoseg = false
        sBuffer[1],sBuffer[2] = 0.0,0.0
      end
    end
    Citizen.Wait(idle)
  end
end)

RegisterCommand('hud',function(source, args, rawCommand)
  if started then
    if not menu_celular then
      menu_celular = true
    else
      menu_celular = false
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if segundos > 0 then
      segundos = segundos - 1
    end
  end
end)