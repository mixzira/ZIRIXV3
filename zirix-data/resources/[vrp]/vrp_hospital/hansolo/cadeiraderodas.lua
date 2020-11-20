--[ VARIÁVEIS ]-----------------------------------------------------------------------------------------------------------------------------------------------------------------

local nearObjectC

--[ THREAD ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local pedCoords = GetEntityCoords(PlayerPedId())
		local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_wheelchair_01"), false)
    if DoesEntityExist(closestObject) and NetworkGetEntityIsNetworked(closestObject) then
			nearObjectC = closestObject
		else
			nearObjectC = nil
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if nearObjectC then
			idle = 5

			local wheelChairCoords = GetEntityCoords(nearObjectC)

			if IsControlJustPressed(0,38) then
				PickupCadeira(nearObjectC)
			elseif IsControlJustPressed(0,74) then
				Sit(nearObjectC)
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ EVENTOS ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('vrp_for_medic:wheelchair:spawn')
AddEventHandler('vrp_for_medic:wheelchair:spawn', function()
	LoadModel('prop_wheelchair_01')

	local wheelchair = CreateObject(GetHashKey('prop_wheelchair_01'), GetEntityCoords(PlayerPedId()), true)
end, false)

RegisterNetEvent('vrp_for_medic:wheelchair:delete')
AddEventHandler('vrp_for_medic:wheelchair:delete', function()
	local wheelchair = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey('prop_wheelchair_01'))

	if DoesEntityExist(wheelchair) then
		DeleteEntity(wheelchair)
	end
end, false)

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

function Sit(wheelchairObject)
	local ped = PlayerPedId()
	LoadAnim("missfinale_c2leadinoutfin_c_int")
	AttachEntityToEntity(ped, wheelchairObject, 0, 0, 0.0, 0.4, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
	while IsEntityAttachedToEntity(ped, wheelchairObject) do
		Citizen.Wait(5)
		if not IsEntityPlayingAnim(ped, 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
			TaskPlayAnim(ped, 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 8.0, 8.0, -1, 69, 1, false, false, false)
		end
		if IsControlJustPressed(0, 73) then
			DetachEntity(wheelchairObject, true, true)
			ClearPedTasks(ped)
		end
	end
end

function PickupCadeira(wheelchairObject)
	local ped = PlayerPedId()
	NetworkRequestControlOfEntity(wheelchairObject)
	LoadAnim("anim@heists@box_carry@")
	AttachEntityToEntity(wheelchairObject, ped, GetPedBoneIndex(ped,  28422), -0.00, -0.3, -0.73, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
	while IsEntityAttachedToEntity(wheelchairObject, ped) do
		Citizen.Wait(5)
		if not IsEntityPlayingAnim(ped, 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end
		if IsControlJustPressed(0, 73) then
			DetachEntity(wheelchairObject, true, true)
			ClearPedTasks(ped)
		end
	end
end
