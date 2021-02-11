RegisterNUICallback('reddit_postChanell', function(data, cb)
  TriggerServerEvent('gcPhone:reddit_postChanell', data.redgkit)
end)

RegisterNetEvent("gcPhone:reddit_getChanells")
AddEventHandler("gcPhone:reddit_getChanells", function(channnels)
  SendNUIMessage({event = 'reddit_chanells', channnels = channnels})
end)

RegisterNUICallback('reddit_getChanells', function(data, cb)
  TriggerServerEvent('gcPhone:reddit_getChanells', data.redgkit)
end)

RegisterNetEvent("gcPhone:reddit_receive")
AddEventHandler("gcPhone:reddit_receive", function(reditsage)
  SendNUIMessage({event = 'reddit_receive', reditsage = reditsage})
end)

RegisterNetEvent("gcPhone:reddit_channel")
AddEventHandler("gcPhone:reddit_channel", function(redgkit, reditsages)
  SendNUIMessage({event = 'reddit_channel', reditsages = reditsages})
end)

RegisterNUICallback('reddit_addMessage', function(data, cb)
  TriggerServerEvent('gcPhone:reddit_addMessage', data.redgkit, data.reditsage)
end)

RegisterNUICallback('reddit_getChannel', function(data, cb)
  TriggerServerEvent('gcPhone:reddit_channel', data.redgkit)
end)