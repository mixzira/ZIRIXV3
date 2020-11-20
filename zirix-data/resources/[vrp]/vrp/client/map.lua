local Tools = module("vrp","lib/Tools")

function tvRP.getSkins()
    return GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01")
end

function tvRP.getModelPlayer()
    local ped = PlayerPedId()
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        return "mp_m_freemode_01"
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        return "mp_f_freemode_01"
    end
end

function tvRP.getCustomPlayer()
    local ped = PlayerPedId()
    local custom = { GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1),GetPedDrawableVariation(ped,5),GetPedTextureVariation(ped,5),GetPedDrawableVariation(ped,7),GetPedTextureVariation(ped,7),GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3),GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4),GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8),GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6),GetPedDrawableVariation(ped,11),GetPedTextureVariation(ped,11),GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9),GetPedDrawableVariation(ped,10),GetPedTextureVariation(ped,10),GetPedPropIndex(ped,0),GetPedPropTextureIndex(ped,0),GetPedPropIndex(ped,1),GetPedPropTextureIndex(ped,1),GetPedPropIndex(ped,2),GetPedPropTextureIndex(ped,2),GetPedPropIndex(ped,6),GetPedPropTextureIndex(ped,6),GetPedPropIndex(ped,7),GetPedPropTextureIndex(ped,7) }
    return custom
end

function tvRP.addBlip(x,y,z,idtype,idcolor,text,scale,route)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,idtype)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,idcolor)
	SetBlipScale(blip,scale)

	if route then
		SetBlipRoute(blip,true)
	end

	if text then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end
	return blip
end

function tvRP.removeBlip(id)
	RemoveBlip(id)
end

function tvRP.setGPS(x,y)
	SetNewWaypoint(x+0.0001,y+0.0001)
end

function tvRP.getWaypoint()
    local waypoint = GetFirstBlipInfoId(8)
    if DoesBlipExist(waypoint) then
        return true,waypoint
    else
        return false
    end
end

local areas = {}
function tvRP.setArea(name,x,y,z,radius,height)
	local area = { x = x+0.001, y = y+0.001, z = z+0.001, radius = radius, height = height }
	if area.height == nil then area.height = 6 end
	areas[name] = area
end

function tvRP.removeArea(name)
	if areas[name] then
		areas[name] = nil
	end
end

Citizen.CreateThread(function() 
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
	SetAudioFlag("PoliceScannerDisabled",true); 
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local px,py,pz = tvRP.getPosition()

		for k,v in pairs(areas) do
			local player_in = (GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= v.radius and math.abs(pz-v.z) <= v.height)

			if player_in then
				idle = 5
			end

			if v.player_in and not player_in then
				vRPserver._leaveArea(k)
				v.player_in = false
			end

			if IsControlJustPressed(0,38) then
				if not v.player_in and player_in then
					vRPserver._enterArea(k)
					v.player_in = player_in
				end
			end

			if IsControlJustPressed(0,194) or IsControlJustPressed(0,25) or IsControlJustPressed(0,200) then
				if v.player_in and player_in then
					vRPserver._leaveArea(k)
					v.player_in = false
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

function tvRP.getTimeFunction(seconds)
    local days = math.floor(seconds/86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds/3600)
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds/60)
    seconds = seconds - minutes * 60

    if days > 0 then
        return string.format("<b>%d Dias</b>, <b>%d Horas</b>, <b>%d Minutos</b> e <b>%d Segundos</b>",days,hours,minutes,seconds)
    elseif hours > 0 then
        return string.format("<b>%d Horas</b>, <b>%d Minutos</b> e <b>%d Segundos</b>",hours,minutes,seconds)
    elseif minutes > 0 then
        return string.format("<b>%d Minutos</b> e <b>%d Segundos</b>",minutes,seconds)
    elseif seconds > 0 then
        return string.format("<b>%d Segundos</b>",seconds)
    end
end