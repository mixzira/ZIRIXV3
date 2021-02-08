local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_tuning")

-- VARIABLES --
local categories = {}
local pieces = {}
local Category = 0
local Piece = 0
local sessionController = 0
local cam = nil
local currentpos = nil
local gameplaycam = nil
local vehlist = {}
local veh = nil

-- METHODS --
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

local function SetupInsideCam()
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
	SetCamActive(cam,true)
	RenderScriptCams(1,0,cam,0,0)
end

local function f(n)
	return (n+0.00001)
end

local function MoveVehCam(pos,x,y,z)
    
	SetCamActive(cam,true)
	local vx,vy,vz = table.unpack(GetEntityCoords(veh))
	local d = GetModelDimensions(GetEntityModel(veh))
	local length,width,height = d.y*-2,d.x*-2,d.z*-2
	local ox,oy,oz
	if pos == 'front' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),(length/2)+f(y),f(z)))
	elseif pos == "front-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),(length/2)+f(y),(height)+f(z)))
	elseif pos == "back" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),-(length/2)+f(y),f(z)))
	elseif pos == "back-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),-(length/2)+f(y),(height/2)+f(z)))
	elseif pos == "left" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,-(width/2)+f(x),f(y),f(z)))
	elseif pos == "right" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,(width/2)+f(x),f(y),f(z)))
	elseif pos == "middle" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),f(y),(height/2)+f(z)))
	end
	SetCamCoord(cam,ox,oy,oz)
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh,0,0,f(0)))
	RenderScriptCams(1,1,1000,0,0)
end

function empty(list)
    for k in pairs (list) do
        list [k] = nil
    end
end

function applyMod(id1, id2)
    SetVehicleModKit(veh, 0)
    SetVehicleMod(veh,id1,id2,false)
end

function setCurrentCategory()
    for k,v in pairs(vehlist) do
        if v.category == Category then applyMod(Category, v.piece) end
    end
end

function getPieceByCategory(category)
    for k,v in pairs(vehlist) do
        if v.category == category then return v end
    end
end

function getCategoryAmount(category)

    for k,v in pairs (categories) do
        if v.index == category then return v.amount end
    end
end

-- CALLBACKS --
RegisterNUICallback("close",function(data)
	StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })

    SetCamCoord(cam,GetGameplayCamCoords())
    SetCamRot(cam, GetGameplayCamRot(2),2)
    RenderScriptCams(1,1,0,0,0)
    RenderScriptCams(0,1,1000,0,0)
    SetCamActive(gameplaycam,true)
    EnableGameplayCam(true)
    SetCamActive(cam,false)

    for k,v in pairs(vehlist) do
            applyMod(v.category, v.piece)
    end
    empty(vehlist)
    empty(categories)
    sessionController = 0
end)

RegisterNUICallback("back",function(data)

    if sessionController ~= 0 then
        if Config.sound then TriggerEvent("vrp_sound:source",'back',0.5) end
        SendNUIMessage({ action = "update" })
        setCurrentCategory()
        sessionController = 0
    end
end)

RegisterNUICallback("selectObject",function(data)
    
    if Config.sound then TriggerEvent("vrp_sound:source",'select',0.5) end
  
    Category = parseInt(data.item)
    Piece = parseInt(data.peca)

    if sessionController == 2 then applyMod(Category, Piece) end
    SendNUIMessage({ action = "update" })

end)

RegisterNUICallback("buttonClick",function(data,cb)

    if data == "equip" then
        if sessionController ~= 1 then
       
            local v = getPieceByCategory(Category)
            if v.piece ~= Piece then
                if vRPNserver.checkPayment(Config.piece[Category][Piece].price) then
                    v.piece = Piece
                    if Config.sound then TriggerEvent("vrp_sound:source",'apply',0.5) end
                end
            else
                TriggerEvent("Notify","negado","O veículo já possui essa peça.",8000)
            end
  
        else
            TriggerEvent("Notify","negado","Selecione a categoria que deseja modificar.",8000)
        end
	end
end)

RegisterNUICallback("requestData",function(data,cb)
	
        if sessionController == 0 then
            cb({ objects = categories})
            sessionController = 1
        else
            empty(pieces)
            if Config.piece[Category] then

                local n = getCategoryAmount(Category)
                for j=-1,n-2 do
                    if Config.piece[Category][j] then
                     table.insert(pieces,{ prefix = "R$ ",amount = Config.piece[Category][j].price, name = Config.piece[Category][j].model, index = j, key = Category })
                    end
                end
                 
            end
  
            if Config.cam[Category] then
                MoveVehCam(Config.cam[Category].type,Config.cam[Category].x,Config.cam[Category].y,Config.cam[Category].z)
            end
        
            cb({ objects = pieces })
            sessionController = 2
        end
end)

-- COMMANDS -- 
RegisterCommand('tunar',function(source,args,rawCommand)
    
    local ped = PlayerPedId()
    veh = GetVehiclePedIsUsing(ped)

    if veh ~= 0 then

        SetVehicleModKit(veh, 0)
        for i=0,50 do
            n_mods = GetNumVehicleMods(veh, i)
            if  n_mods > 0 then
                if Config.category[i] then
                    table.insert(categories,{ prefix = "",amount = n_mods+1, name = Config.category[i].nome, index = i, key = i })
                    table.insert(vehlist, {category = i, piece = GetVehicleMod(veh, i)})
                end
            end
        end

        if Config.sound then TriggerEvent("vrp_sound:source",'intro',0.5) end

        SetNuiFocus(true,true)
        SendNUIMessage({ action = "showMenu" })

        gameplaycam = GetRenderingCam()
        SetupInsideCam()
        MoveVehCam('front', -0.6,1.5,0.4)
    else
        TriggerEvent("Notify","negado","Você precisa estar dentro de um veículo.",8000)
    end

end)