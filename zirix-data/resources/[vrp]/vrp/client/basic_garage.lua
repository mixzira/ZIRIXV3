function tvRP.getNearestVehicles(radius)
	local r = {}
	local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId()))

	local vehs = {}
	local it,veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end
	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok
	EndFindVehicle(it)

	for _,veh in pairs(vehs) do
		local x,y,z = table.unpack(GetEntityCoords(veh))
		local distance = Vdist(x,y,z,px,py,pz)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end

function tvRP.getNearestVehicle(radius)
	local veh
	local vehs = tvRP.getNearestVehicles(radius)
	local min = radius+0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh 
end

function tvRP.ejectVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
	end
end

function tvRP.isInVehicle()
	return IsPedSittingInAnyVehicle(PlayerPedId())
end

function tvRP.InVehicle()
	local ped = GetPlayerPed(i)
	if IsPedInAnyVehicle(ped) then
		return true
	end
	return false
end

function tvRP.GetVehicleSeat()
    return GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()),-1) == PlayerPedId()
end

function tvRP.vehListHash()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)

	if not IsPedInAnyVehicle(ped) then
		veh = GetPlayersLastVehicle()
	end

	if IsEntityAVehicle(veh) then
		for k,v in pairs(vehs.vehList) do
			if v.hash == GetEntityModel(veh) then
				if v.name then
					return veh,v.hash,GetVehicleNumberPlateText(veh),v.name
				end
			end
		end
	end
end

function tvRP.vehList(radius)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)

	if not IsPedInAnyVehicle(ped) then
		veh = tvRP.getNearestVehicle(radius)
	end

	if IsEntityAVehicle(veh) then
		local trunk = GetVehicleDoorAngleRatio(v,5)
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(vehs.vehList) do
			if v.hash == GetEntityModel(veh) then
				if v.name then
					local tuning = { GetNumVehicleMods(veh,13),GetNumVehicleMods(veh,12),GetNumVehicleMods(veh,15),GetNumVehicleMods(veh,11),GetNumVehicleMods(veh,16) }
					return veh,VehToNet(veh),GetVehicleNumberPlateText(veh),v.name,GetVehicleDoorsLockedForPlayer(veh,PlayerId()),v.banned,trunk,GetDisplayNameFromVehicleModel(v.name),GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z)),tuning
				end
			end
		end
	end
end