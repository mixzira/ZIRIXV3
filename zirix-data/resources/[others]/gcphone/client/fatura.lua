RegisterNetEvent("gcPhone:fatura_getBilling")
AddEventHandler("gcPhone:fatura_getBilling", function(billingg)
  SendNUIMessage({event = 'fatura_billingg', billingg = billingg})
end)

RegisterNUICallback('fatura_getBilling', function(data, cb)
  TriggerServerEvent('gcPhone:fatura_getBilling', data.label, data.amount, data.sender)
end)

RegisterNUICallback('faturapayBill', function(data)
  TriggerServerEvent('gcPhone:faturapayBill', data.id, data.sender, data.amount, data.target)
end)