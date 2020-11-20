--[ VARIÁVEIS ]-----------------------------------------------------------------------------------------------------------------------------------------------------------------

local beds = {
	'v_med_bed1',
	'v_med_bed2',
	'v_med_emptybed',
}

local nearObjectM, isLocal

--[ THREAD ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		local pedCoords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(beds) do
			local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey(v), false)
			if DoesEntityExist(closestObject) then
				nearObjectM = closestObject
				isLocal = not NetworkGetEntityIsNetworked(closestObject)
				break
			else
				nearObjectM = nil
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if nearObjectM then
			idle = 5
			local macaCoords = GetEntityCoords(nearObjectM)

			if IsControlJustPressed(0,38) and not isLocal then
				if isLocal then

				else
					Pickup(nearObjectM)
				end
			elseif IsControlJustPressed(0,74) then
				if isLocal then

				else
					GoToBed(nearObjectM)
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ EVENTOS ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('vrp_for_medic:stretcher:spawn')
AddEventHandler('vrp_for_medic:stretcher:spawn', function()
	LoadModel('v_med_bed1')
	local maca = CreateObject(GetHashKey('v_med_bed1'), GetEntityCoords(PlayerPedId())-1, true, true, true)
end)

RegisterNetEvent('vrp_for_medic:stretcher:delete')
AddEventHandler('vrp_for_medic:stretcher:delete', function()
	local maca = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey('v_med_bed1'))
	if DoesEntityExist(maca) then
		DeleteEntity(maca)
	end
end)

--[ FUNÇÕES ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------

function LoadModel(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Citizen.Wait(10)
	end
end

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end

function GoToBed(macaObject)
	local ped = PlayerPedId()
	LoadAnim("anim@gangops@morgue@table@")
	AttachEntityToEntity(ped, macaObject, 0, -0.06, 0.1, 1.3, 0.0, 0.0, 179.0, 0.0, false, false, false, false, 2, true)
	while IsEntityAttachedToEntity(ped, macaObject) do
		Citizen.Wait(5)
		if not IsEntityPlayingAnim(ped, 'anim@gangops@morgue@table@', 'ko_front', 3) then
			TaskPlayAnim(ped, 'anim@gangops@morgue@table@', 'ko_front', 8.0, 8.0, -1, 69, 1, false, false, false)
		end
		if IsControlJustPressed(0, 73) then
			DetachEntity(macaObject, true, true)
			ClearPedTasks(ped)
		end
	end
end

function Pickup(macaObject)
	local ped = PlayerPedId()
	NetworkRequestControlOfEntity(macaObject)
	LoadAnim("anim@mp_ferris_wheel")
	AttachEntityToEntity(macaObject, ped, ped, 0.0, 1.8, -0.40 , 180.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
	while IsEntityAttachedToEntity(macaObject, ped) do
		Citizen.Wait(5)
		if not IsEntityPlayingAnim(ped, 'anim@mp_ferris_wheel', 'idle_a_player_one', 3) then
			TaskPlayAnim(ped, 'anim@mp_ferris_wheel', 'idle_a_player_one', 8.0, 8.0, -1, 50, 0, false, false, false)
		end
		if IsControlJustPressed(0, 73) then
			DetachEntity(macaObject, true, true)
			ClearPedTasks(ped)
		end
	end
end