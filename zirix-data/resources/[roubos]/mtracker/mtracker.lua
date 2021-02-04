targetsEntitys = {}
mTrackerRunning = false
timer = 0

AddEventHandler('mtracker:start', function()
  mTrackerRunning = true
  nuiMsg = {}
	nuiMsg.run = mTrackerRunning
  nuiMsg.show = mTrackerRunning
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('mtracker:stop', function()
  mTrackerRunning = false
  nuiMsg = {}
	nuiMsg.run = mTrackerRunning
  nuiMsg.show = mTrackerRunning
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('mtracker:settargets', function(targets)
  targetsEntitys = targets
  polartargets = transformTargets()
  nuiMsg = {}
	nuiMsg.settargets = polartargets
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('mtracker:updatetargets', function()
  polartargets = transformTargets()
  nuiMsg = {}
	nuiMsg.updatetargets = polartargets
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('mtracker:removealltargets', function()
  nuiMsg = {}
	nuiMsg.removealltargets = true
	SendNUIMessage(nuiMsg)
end)

function isrunning()
  return mTrackerRunning
end

function atan2(x, y)
	local res = 0
	if x > 0 then
		res = math.atan(y/x)
	elseif x < 0 and y > 0 then
		res = math.atan(y/x) + math.pi
	elseif x < 0 and y < 0 then
		res = math.atan(y/x) - math.pi
	elseif x == 0 and y > 0 then
		res = 0.5 * math.pi
	elseif x == 0 and y < 0 then
		res = -0.5 * math.pi
	elseif y == 0 and x > 0 then
		res = math.pi
	end
	return res
end

function radToDeg(f)
	res = 180.0/math.pi * f
	if res >= 360 then
		res = res - 360.0
	end
	return res
end

function calculateRelativePolarCoordinates(playerPos, targetPos)
  local v = {x = targetPos.x - playerPos.x, y = targetPos.y - playerPos.y}
  local phi = radToDeg(atan2(v.y, v.x)) + GetEntityHeading(PlayerPedId())
  if phi > 360.0 then phi = phi - 360.0 end
  if phi < 0.0 then phi = phi + 360.0 end
  local r = scalingFunction( math.sqrt( v.x*v.x + v.y*v.y ) )
  return {['r'] = r, ['phi'] = phi}
end

function transformTargets()
  if not IsEntityDead(PlayerPedId()) then
    local t = {}
    local v = GetEntityCoords(PlayerPedId(), true)
    for _,ent in pairs(targetsEntitys) do
      if not IsEntityDead(ent) then
        table.insert(t, calculateRelativePolarCoordinates(v, GetEntityCoords(ent, true)))
      end
    end
    return t
  else
    TriggerEvent("mtracker:stop")
  end
end

function setTimer()
  timer = GetGameTimer()
end

function getTimer()
  return GetGameTimer() - timer
end

function scalingFunction(r)
  res = 0
  if mtracker_ScalingType == "LOG" then
    if r > 0 then
      res = mtracker_MaxRings * math.log(r)/math.log(mtracker_MaxDistance)
    else
      res = 0
    end
  elseif mtracker_ScalingType == "SQRT" then
    res = mtracker_MaxRings * math.sqrt(r/mtracker_MaxDistance)
  elseif mtracker_ScalingType == "LIN" then
    res = mtracker_MaxRings * r/mtracker_MaxDistance
  end
  return res
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if mTrackerRunning then
      if getTimer() > 15 then
        TriggerEvent('mtracker:updatetargets')
        setTimer()
      end
      if IsControlJustPressed(1, mtracker_StoppingKey) then
        TriggerEvent("mtracker:stop")
      end
    end
  end
end)
