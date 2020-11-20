local ativando = false
local system = {}

RegisterNetEvent("eblips:toggle")
AddEventHandler("eblips:toggle",function(status)
	ativando = status
	if not ativando then
		RemoveAnyExistingEmergencyBlips()
	end
end)

RegisterNetEvent("eblips:updateAll")
AddEventHandler("eblips:updateAll",function(personnel)
	system = personnel
end)

RegisterNetEvent("eblips:update")
AddEventHandler("eblips:update",function(person)
	system[person.src] = person
end)

RegisterNetEvent("eblips:remove")
AddEventHandler("eblips:remove",function(src)
	RemoveAnyExistingEmergencyBlipsById(src)
end)

function RemoveAnyExistingEmergencyBlips()
	for src,info in pairs(system) do
		local possible_blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(src)))
		if possible_blip ~= 0 then
			RemoveBlip(possible_blip)
			system[src] = nil
		end
	end
end

function RemoveAnyExistingEmergencyBlipsById(id)
	local possible_blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(id)))
	if possible_blip ~= 0 then
		RemoveBlip(possible_blip)
		system[id] = nil
	end
end

Citizen.CreateThread(function()
	while true do
		if ativando then
			for src,info in pairs(system) do
				local player = GetPlayerFromServerId(src)
				local ped = GetPlayerPed(player)
				if GetBlipFromEntity(ped) == 0 then
					local blip = AddBlipForEntity(ped)
					SetBlipSprite(blip,1)
					SetBlipColour(blip,info.color)
					SetBlipAsShortRange(blip,false)
					SetBlipScale(blip,0.5)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(info.name)
					EndTextCommandSetBlipName(blip)
				end
			end
		end
		Citizen.Wait(200)
	end
end)