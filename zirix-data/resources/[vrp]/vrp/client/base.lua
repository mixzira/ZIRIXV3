local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

tvRP = {}
local players = {}
Tunnel.bindInterface("vRP",tvRP)
vRPserver = Tunnel.getInterface("vRP")
Proxy.addInterface("vRP",tvRP)

local user_id
function tvRP.setUserId(_user_id)
	user_id = _user_id
end

function tvRP.getUserId()
	return user_id
end

function tvRP.getUserHeading()
	return GetEntityHeading(PlayerPedId())
end

function tvRP.getSpeed()
	local vx,vy,vz = table.unpack(GetEntityVelocity(GetPlayerPed(-1)))
	return math.sqrt(vx*vx+vy*vy+vz*vz)
end

function tvRP.teleport(x,y,z)
	SetEntityCoords(PlayerPedId(),x+0.0001,y+0.0001,z+0.0001,1,0,0,1)
	vRPserver._updatePos(x,y,z)
end

function tvRP.clearWeapons()
    RemoveAllPedWeapons(PlayerPedId(),true)
end

function tvRP.getPosition()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
	return x,y,z
end

function tvRP.isInside()
	local x,y,z = tvRP.getPosition()
	return not (GetInteriorAtCoords(x,y,z) == 0)
end

function tvRP.getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)
	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end
	return x,y,z
end

function tvRP.addPlayer(player)
	players[player] = true
end

function tvRP.removePlayer(player)
	players[player] = nil
end

function tvRP.getNearestPlayers(radius)
	local r = {}
	local ped = GetPlayerPed(i)
	local pid = PlayerId()
	local px,py,pz = tvRP.getPosition()

	for k,v in pairs(players) do
		local player = GetPlayerFromServerId(k)
		if player ~= pid and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local x,y,z = table.unpack(GetEntityCoords(oped,true))
			local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
			if distance <= radius then
				r[GetPlayerServerId(player)] = distance
			end
		end
	end
	return r
end

function tvRP.getNearestPlayer(radius)
	local p = nil
	local players = tvRP.getNearestPlayers(radius)
	local min = radius+0.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end

local anims = {}
local anim_ids = Tools.newIDGenerator()

function tvRP.playAnim(upper,seq,looping)
	if seq.task then
		tvRP.stopAnim(true)

		local ped = PlayerPedId()
		if seq.task == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then
			local x,y,z = tvRP.getPosition()
			TaskStartScenarioAtPosition(ped,seq.task,x,y,z-1,GetEntityHeading(ped),0,0,false)
		else
			TaskStartScenarioInPlace(ped,seq.task,0,not seq.play_exit)
		end
	else
		tvRP.stopAnim(upper)

		local flags = 0
		if upper then flags = flags+48 end
		if looping then flags = flags+1 end

		Citizen.CreateThread(function()
			local id = anim_ids:gen()
			anims[id] = true

			for k,v in pairs(seq) do
				local dict = v[1]
				local name = v[2]
				local loops = v[3] or 1

				for i=1,loops do
					if anims[id] then
						local first = (k == 1 and i == 1)
						local last = (k == #seq and i == loops)

						RequestAnimDict(dict)
						local i = 0
						while not HasAnimDictLoaded(dict) and i < 1000 do
						Citizen.Wait(10)
						RequestAnimDict(dict)
						i = i + 1
					end

					if HasAnimDictLoaded(dict) and anims[id] then
						local inspeed = 3.0
						local outspeed = -3.0
						if not first then inspeed = 2.0 end
						if not last then outspeed = 2.0 end

						TaskPlayAnim(PlayerPedId(),dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
					end
						Citizen.Wait(5)
						while GetEntityAnimCurrentTime(PlayerPedId(),dict,name) <= 0.95 and IsEntityPlayingAnim(PlayerPedId(),dict,name,3) and anims[id] do
							Citizen.Wait(5)
						end
					end
				end
			end
			anim_ids:free(id)
			anims[id] = nil
		end)
	end
end

function tvRP.stopAnim(upper)
	anims = {}
	if upper then
		ClearPedSecondaryTask(PlayerPedId())
	else
		ClearPedTasks(PlayerPedId())
	end
end

function tvRP.playSound(dict,name)
	PlaySoundFrontend(-1,dict,name,false)
end

function tvRP.playScreenEffect(name,duration)
	if duration < 0 then
		StartScreenEffect(name,0,true)
	else
		StartScreenEffect(name,0,true)

		Citizen.CreateThread(function()
			Citizen.Wait(math.floor((duration+1)*1000))
			StopScreenEffect(name)
		end)
	end
end

AddEventHandler("playerSpawned",function()
	TriggerServerEvent("vRPcli:playerSpawned")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if NetworkIsSessionStarted() then
			TriggerServerEvent("Queue:playerActivated")
			return
		end
	end
end)