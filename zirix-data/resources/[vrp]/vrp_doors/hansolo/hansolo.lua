local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPNserver = Tunnel.getInterface("vrp_doors")

local doors = {}
local hour = 0

RegisterNetEvent('vrpdoorsystem:load')
AddEventHandler('vrpdoorsystem:load',function(list)
	doors = list
end)

RegisterNetEvent('vrpdoorsystem:statusSend')
AddEventHandler('vrpdoorsystem:statusSend',function(i,status)
	if i ~= nil and status ~= nil then
		doors[i].lock = status
	end
end)

function searchIdDoor()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	for k,v in pairs(doors) do
		if not v.public and GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) <= 1.5 then
			return k
		end
	end
	return 0
end

function searchPublicIdDoor()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	for k,v in pairs(doors) do
		if v.public then
			if GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) < 5.1 then
				return k
			end
		end
	end
	return 0
end

function CalculateTimeToDisplay()
	hour = GetClockHours()
	if hour <= 9 then
		hour = "0" .. hour
	end
end

RegisterNetEvent('vrpdoorsystem:forceOpen')
AddEventHandler('vrpdoorsystem:forceOpen',function(name)
	local publicId = searchPublicIdDoor()
	if publicId ~= 0 then
		vRP._playAnim(true,{{"veh@mower@base","start_engine"}},true)
		TriggerEvent("progress",15000,"Destrancando")
		TriggerEvent("itensNotify","usar","Usou",""..name.."")
		SetTimeout(15000,function()
			vRPNserver.forceOpen(publicId)
			vRP._stopAnim(false)
		end)
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 500
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		CalculateTimeToDisplay()

		local publicId = searchPublicIdDoor()
		if publicId ~= 0 then
			if parseInt(hour) >= 07 and parseInt(hour) <= 21 then
				vRPNserver.timeOpen(publicId)
			else
				vRPNserver.timeClose(publicId)
			end
		end
		
		local id = searchIdDoor()
		if id ~= 0 then
			if IsControlJustPressed(0,38) then
				vRP._playAnim(true,{{"veh@mower@base","start_engine"}},false)
				Citizen.Wait(2200)
				TriggerServerEvent("vrpdoorsystem:open",id)
			end
		end
		
		for k,v in pairs(doors) do
			if GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) <= 3.5 then
				idle = 5

				local door = GetClosestObjectOfType(v.x,v.y,v.z,1.0,v.hash,false,false,false)
				
				if door ~= 0 then
					SetEntityCanBeDamaged(door,false)
					if v.lock == false then
						if v.text then
							if not v.public and GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) <= 1.5 then
								DrawText3Ds(v.x,v.y,v.z+0.2,"[~p~E~w~] Porta ~p~destrancada~w~.")
							end
						end
						NetworkRequestControlOfEntity(door)
						FreezeEntityPosition(door,false)
					else
						local lock,heading = GetStateOfClosestDoorOfType(v.hash,v.x,v.y,v.z,lock,heading)
						if heading > -0.02 and heading < 0.02 then
							if v.text then
								if not v.public and GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) <= 1.5 then
									DrawText3Ds(v.x,v.y,v.z+0.2,"[~p~E~w~] Porta ~p~trancada~w~.")
								end
							end
							NetworkRequestControlOfEntity(door)
							FreezeEntityPosition(door,true)
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.25,0.25)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)

	DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0115, 0.001+factor, 0.03, 0, 0, 0,80)
end