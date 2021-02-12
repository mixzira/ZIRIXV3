RegisterNetEvent("gcPhone:tchat_receive")
AddEventHandler("gcPhone:tchat_receive", function(message)
  SendNUIMessage({event = 'tchat_receive', message = message})
end)

RegisterNetEvent("gcPhone:tchat_channeldumpamistocazzo")
AddEventHandler("gcPhone:tchat_channeldumpamistocazzo", function(channel, messages)
  SendNUIMessage({event = 'tchat_channel', messages = messages})
end)

RegisterNUICallback('tchat_addMessage', function(data, cb)
  TriggerServerEvent('gcPhone:tchat_addMessage', data.channel, data.message)
end)

RegisterNUICallback('tchat_getChannel', function(data, cb)
  TriggerServerEvent('gcPhone:tchat_channeldumpamistocazzo', data.channel)
end)

RegisterNUICallback('tchat_receive', function(data, cb)
  TriggerServerEvent('gcPhone:tchat_receive', data.channel, data.message)
end)