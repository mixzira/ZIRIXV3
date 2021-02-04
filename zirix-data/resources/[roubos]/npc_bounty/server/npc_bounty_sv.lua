ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local hiddencoords = vector3(1276.191, -1710.02, 54.7715)
local onDuty = 0

ESX.RegisterServerCallback('bounty:getlocation', function(source, cb)
    cb(hiddencoords)
end)

ESX.RegisterServerCallback('bounty:getCops', function(source, cb)
    cb(getCops())
end)

function getCops()
  local xPlayers = ESX.GetPlayers()
  onDuty = 0

  for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if xPlayer.job.name == Config.policeJob then
      onDuty = onDuty + 1
    end
  end
  return onDuty
end

RegisterServerEvent("bounty:GiveItem")
AddEventHandler("bounty:GiveItem", function(x,y,z)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local myPed = GetPlayerPed(_source)
	local myPos = GetEntityCoords(myPed)
	local dist = #(vector3(x,y,z) - myPos)
	if dist <= 3 then
    	xPlayer.addInventoryItem("dogtags", 1)
	elseif Config.useMythic then
		TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = _U'dist_check'})
	end
end)

RegisterNetEvent('bounty:updatetable')
AddEventHandler('bounty:updatetable', function(bool)
    TriggerClientEvent('bounty:synctable', -1, bool)
end)

RegisterServerEvent("bounty:syncMission")
AddEventHandler("bounty:syncMission", function(missionData)
	local missionData = missionData
	TriggerClientEvent('bounty:syncMissionClient', -1, missionData)
end)

RegisterServerEvent("bounty:delivery")
AddEventHandler("bounty:delivery", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local check = xPlayer.getInventoryItem('dogtags').count

    if check >= 1 then
      xPlayer.removeInventoryItem('dogtags', 1)
      if not Config.useDirtyMoney then
        xPlayer.addMoney(Config.reward)
      else
        xPlayer.addAccountMoney('black_money', Config.reward)
      end
      if Config.useMythic then
    	 TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'inform', text = _U'dollar'..Config.reward.._U'payment'})
      end
    elseif Config.useMythic then
    	TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = _U'no_tags'})
    end
end)

-- call this function if you want to print the table in server console - (debugging)
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end

