local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("vrp_control_people")

funcClient = {}
Tunnel.bindInterface("vrp_control_people", funcClient)

open = false

isPolice = true

local npcsHealth = true

local listaCarros = {
    "policiataurus", "pbus", "policiabearcat", "policiabmwr1200", "policiacharger2018", "policiaexplorer",
    "policiasilverado", "policiatahoe"
}

local listaPcs = {
    {x=-1095.43, y=-814.38, z=5.49, h=54.65},
}

local teste = 1
Citizen.CreateThread(function()
    if func.isPolice() then
		isPolice = true
        SetNuiFocus(false, false)
        init()
    else
        isPolice = false
    end
end)

RegisterNetEvent("global:loadJob")
AddEventHandler("global:loadJob",function()
    if func.isPolice() then
        isPolice = true
        init()
    else
        isPolice = false
    end
end)
--emP.checkPermission()
function init()
    while isPolice do
		Citizen.Wait(1)
        if IsControlJustPressed(1, 288) then
            local vehicle = vRP.getNearestVehicle(4)
            for v, k in pairs(listaCarros) do

                local vehicletow = IsVehicleModel(vehicle, GetHashKey(k))
                if vehicletow and IsPedInAnyVehicle(PlayerPedId()) then
                    open = true
                    SetNuiFocus(true, true)
                    SendNUIMessage({type = 'abrirTablet'})
                end

            end
        end
        if IsControlJustPressed(1, 38) then
            local ped = PlayerPedId()
            
            for v,locais in pairs(listaPcs) do
                
                local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),locais.x,locais.y,locais.z, true)
                if distance < 1.5 then
                    SetEntityHeading(ped,locais.h)
                    SetEntityCoords(ped,locais.x,locais.y,locais.z-1,false,false,false,false)
                    vRP._playAnim(false,{{"anim@heists@prison_heistig1_p1_guard_checks_bus","loop"}},true)

                    open = true
                    SetNuiFocus(true, true)
                    SendNUIMessage({type = 'abrirTablet'})
                end
            end
        end
    end
end

RegisterCommand("teste",function()
	open = true
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'abrirTablet'})
end)

RegisterNUICallback("ButtonClick", function(data, cb)
    if data.action == "fecharTablet" then
        open = false
        SetNuiFocus(false, false)
        SendNUIMessage({type = 'fecharTablet'})
        ClearPedTasks(PlayerPedId())
    end

    if data.action == "getPassaporte" then
        local identity, multas, emprego = func.Identidade(data.passaporte)
        SendNUIMessage({
            type = 'setPassaporte',
            identity = identity,
            multas = multas,
            emprego = emprego
        })
    end

    if data.action == "getMultas" then
        local multas = func.getDatasUser(data.passaporte, "multa")
        SendNUIMessage({type = 'setListaMultas', multas = multas})
    end

    if data.action == "getPrisoes" then
        local prisoes = func.getDatasUser(data.passaporte, "prisao")
        SendNUIMessage({type = 'setListaPrisoes', prisoes = prisoes})
    end

    if data.action == "getListaForagidos" then
        local lista = func.getForagidos("foragido")
        SendNUIMessage({type = 'getListaForagidos', lista = lista})
    end

    if data.action == "getListaOcorrencias" then
        local lista = func.getDatasUser(data.passaporte, "ocorrencia")
        SendNUIMessage({type = 'getListaOcorrencias', lista = lista})
    end

    if data.action == "updateFoto" then
        func.updateFoto(data.foto, data.user_id)
        SendNUIMessage({type = 'reloadPassaporte'})
    end

    if data.action == "setMulta" then
        func.setRegistro(data.passaporte, "multa", data.descricao, data.img,
                         data.valor)
        SendNUIMessage({type = 'reloadPassaporte'})
    end

    if data.action == "setOcorrencia" then
        func.setRegistro(data.passaporte, "ocorrencia", data.descricao,
                         data.img, data.valor)
        SendNUIMessage({type = 'reloadPassaporte'})
    end

    if data.action == "setForagido" then
        func.setRegistro(data.passaporte, "foragido", data.descricao, data.img,
                         data.valor)
        SendNUIMessage({type = 'reloadPassaporte'})
    end

    if data.action == "setPrisao" then
        func.setRegistro(data.passaporte, "prisao", data.descricao, data.img,
                         data.pena)
        if data.multa and data.multa > 0 then
            func.setRegistro(data.passaporte, "multa", data.descricao, data.img,
                             data.multa)
        end
        SendNUIMessage({type = 'reloadPassaporte'})
    end
end)




local nveh = nil
local pveh01 = nil
local pveh02 = nil
local inTransport = false
function funcClient.carroPrisao(id, tempo)
    local ped = PlayerPedId()
	local vhash = GetHashKey("riot")
	while not HasModelLoaded(vhash) do
		RequestModel(vhash)
		Citizen.Wait(10)
	end

	local phash = GetHashKey("s_m_y_swat_01")
	while not HasModelLoaded(phash) do
		RequestModel(phash)
		Citizen.Wait(10)
	end

	local armas = {
		"weapon_carbinerifle_mk2",
        "weapon_carbinerifle",
        }
    
    local locaisPrisao = {
        {name = "DP CENTRO", x=-1095.43, y=-814.38, z=5.49, x2=-1054.52,y2=-892.93,z2=4.75, h2=301.53},
        {name = "PRISAO", x=1812.96, y=2604.84, z=45.57}
    }

	if HasModelLoaded(vhash) then
        -- nveh = CreateVehicle(vhash,1877.59,2625.8,45.67, 356.74,true,false)
        local menorDistancia = nil
        local coordenadasSaida = nil
        for i, loc in pairs(locaisPrisao) do
            local localPrisao = GetDistanceBetweenCoords(GetEntityCoords(ped), loc.x, loc.y, loc.z,true)
            if menorDistancia == nil or menorDistancia > localPrisao then
                menorDistancia = localPrisao
                coordenadasSaida = loc
                -- print(loc.name)
            end
        end

        if coordenadasSaida.name == "PRISAO" then
            func.setPrisao2(id, tempo)
            return 
        end

		nveh = CreateVehicle(vhash,coordenadasSaida.x2,coordenadasSaida.y2,coordenadasSaida.z2,coordenadasSaida.h2,true,false)
		pveh01 = CreatePedInsideVehicle(nveh,27,GetHashKey("s_m_y_swat_01"),-1,true,false)
        pveh02 = CreatePedInsideVehicle(nveh,27,GetHashKey("s_m_y_swat_01"),0,true,false)
       

        TaskWarpPedIntoVehicle(PlayerPedId(),nveh,2)
        SetVehicleSiren(nveh, true)
        

		setPedPropertys(pveh01,armas[math.random(1,#armas)])
		setPedPropertys(pveh02,armas[math.random(1,#armas)])

		SetEntityAsMissionEntity(nveh,  true, false)
		SetEntityAsMissionEntity(pveh01,  true, false)
		SetEntityAsMissionEntity(pveh02,  true, false)

		SetVehicleOnGroundProperly(nveh)
		TaskVehicleDriveToCoordLongrange(pveh01,nveh,1830.45,2607.38,45.57,20.0,447,1.0)
        SetModelAsNoLongerNeeded(vhash)
        inTransport = true
        async(function()
            while inTransport do
                Citizen.Wait(60000)
                tempo = tempo - 1
            end
        end)
        async(function()
            while inTransport do
                Citizen.Wait(1000)
                if IsPedDeadOrDying(pveh01) and IsPedDeadOrDying(pveh02) then
                    inTransport = false
                    npcsHealth = false
                    func.teste(source)

                    SetTimeout(100,function()
                        TriggerServerEvent("DeleteEntity",PedToNet(pveh01))
                        TriggerServerEvent("DeleteEntity",PedToNet(pveh02))
                        TriggerServerEvent("DeleteVehicle",VehToNet(nveh))
                        pveh01 = nil
                        pveh02 = nil
                        nveh = nil
                    end)
                end
                
                local x,y,z = table.unpack(GetEntityCoords(ped))
                local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
                if street == "Route 68" then
                    SetEntityMaxSpeed(nveh,0.50*100)---0.45)
                end

                local distancia = GetDistanceBetweenCoords(GetEntityCoords(nveh),1830.45,2607.38,45.57,true)
                local vehspeed = GetEntitySpeed(nveh)*5.5--3.6

                if distancia < 5.0 and math.ceil(vehspeed) < 3 then
                    if IsPedSittingInAnyVehicle(ped) then
                        local veh = GetVehiclePedIsIn(ped, false)
                        TaskLeaveVehicle(ped,veh,4160)
                        SetTimeout(3000, function()
                            if tempo < 2 then
                                tempo = 2
                            end
                            
                            func.setPrisao2(id, tempo-1)

                            TriggerServerEvent("tryDeleteEntity",PedToNet(pveh01))
                            TriggerServerEvent("tryDeleteEntity",PedToNet(pveh02))
                            TriggerServerEvent("tryDeleteVehicle",VehToNet(nveh))
                            pveh01 = nil
                            pveh02 = nil
                            nveh = nil
                            vRP._DeletarObjeto()
                            SetEntityAsNoLongerNeeded(pveh01)
                            SetEntityAsNoLongerNeeded(pveh02)
                            SetEntityAsNoLongerNeeded(nveh)
                            inTransport = false
                        end)
                    end
                end
            end
        end)
    end
    return nveh
end

Citizen.CreateThread(function()
    while true do
        if IsPedDeadOrDying(pveh01) and IsPedDeadOrDying(pveh02) then
            npcsHealth = false
        end
        Citizen.Wait(5)
	end
end)

function funcClient.sendServer()
    return npcsHealth
end

RegisterCommand('liberar2',function(source,args,rawCommand)
    funcClient.teste(source)
end)

function funcClient.teste()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    print(plyCoords)
    local entityWorld = GetOffsetFromEntityInWorldCoords(ply, 0.0, 20.0, 0.0)
    print(entityWorld)

    local distancia = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ply, 0)
    print(distancia)
    return distancia
    
end

function setPedPropertys(npc,weapon)
	SetPedShootRate(npc,700)
	SetPedAlertness(npc,100)
	SetPedAccuracy(npc,100)
	SetPedCanSwitchWeapon(npc,true)
	SetPedFleeAttributes(npc,0,0)
	SetPedCombatAttributes(npc,46,true)
	SetPedCombatAbility(npc,2)
	SetPedCombatRange(npc,50)
	SetPedPathAvoidFire(npc,1)
	SetPedPathCanUseLadders(npc,1)
	SetPedPathCanDropFromHeight(npc,1)
	SetPedPathPreferToAvoidWater(npc,1)
	SetPedGeneratesDeadBodyEvents(npc,1)
	GiveWeaponToPed(npc,GetHashKey(weapon),5000,true,true)
    SetPedRelationshipGroupHash(npc,GetHashKey("security_guard"))
    
    SetEntityHealth(npc, 500)
    SetPedArmour(npc,100)
end

function draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end