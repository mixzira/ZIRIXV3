RegisterNetEvent("gcPhone:market_getItem")
AddEventHandler("gcPhone:market_getItem", function(markets)
  SendNUIMessage({event = 'market_Itemm', markets = markets})
end)

RegisterNUICallback('market_getItem', function(data, cb)
  TriggerServerEvent('gcPhone:market_getItem', data.store, data.item, data.price, data.label)
end)

RegisterNUICallback('buyMarket', function(data)
  TriggerServerEvent('gcPhone:buyMarket', data.item, 1, data.price, data.label)
end)



