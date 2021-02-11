RegisterServerEvent('gcPhone:finish')
AddEventHandler('gcPhone:finish', function(plate)
	local _source = source
	local xPlayer = getPlayerID(_source)
	TriggerClientEvent('esx:showNotification21', _source, _U('vale_get'))
	xPlayer.removeAccountMoney('bank', Config.ValePrice)
end)

RegisterServerEvent('gcPhone:valet-car-set-outside')
AddEventHandler('gcPhone:valet-car-set-outside', function(plate)
	local src = source
	local xPlayer = getPlayerID(src)
    if xPlayer then
        MySQL.Async.insert('UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate', {
            ['@plate'] = plate,
            ['@stored'] = 0
        })
    end
end)