RegisterNetEvent("gcPhone:instagram_getPics")
AddEventHandler("gcPhone:instagram_getPics", function(pics)
  SendNUIMessage({event = 'instagram_pics', pics = pics})
end)

RegisterNetEvent("gcPhone:instagram_newPics")
AddEventHandler("gcPhone:instagram_newPics", function(pic)
  SendNUIMessage({event = 'instagram_newPic', pic = pic})
end)

RegisterNetEvent("gcPhone:instagram_updatePicLikes")
AddEventHandler("gcPhone:instagram_updatePicLikes", function(picId, likes)
  SendNUIMessage({event = 'instagram_updatePicLikes', picId = picId, likes = likes})
end)

RegisterNetEvent("gcPhone:instagram_setAccount")
AddEventHandler("gcPhone:instagram_setAccount", function(username, avatarUrl)
  local url = exports["mugshot"]:getMugshotUrl(GetPlayerPed(-1))
  SendNUIMessage({event = 'instagram_setAccount', username = username, avatarUrl = url})
end)

RegisterNetEvent("gcPhone:instagram_createAccount")
AddEventHandler("gcPhone:instagram_createAccount", function(account)
  SendNUIMessage({event = 'instagram_createAccount', account = account})
end)

RegisterNetEvent("gcPhone:instagram_showError")
AddEventHandler("gcPhone:instagram_showError", function(title, message)
  SendNUIMessage({event = 'instagram_showError', message = message, title = title})
end)

RegisterNetEvent("gcPhone:instagram_showSuccess")
AddEventHandler("gcPhone:instagram_showSuccess", function(title, message)
  SendNUIMessage({event = 'instagram_showSuccess', message = message, title = title})
end)

RegisterNetEvent("gcPhone:instagram_setPicLikes")
AddEventHandler("gcPhone:instagram_setPicLikes", function(picId, isLikes)
  SendNUIMessage({event = 'instagram_setPicLikes', picId = picId, isLikes = isLikes})
end)

RegisterNUICallback('instagram_login', function(data, cb)
  TriggerServerEvent('gcPhone:instagram_login', data.username)
end)

RegisterNUICallback('instagram_createAccount', function(data, cb)
  local url = exports["mugshot"]:getMugshotUrl(GetPlayerPed(-1))
  TriggerServerEvent('gcPhone:instagram_createAccount', data.username, url)
end)

RegisterNUICallback('instagram_getPics', function(data, cb)
  TriggerServerEvent('gcPhone:instagram_getPics', data.username)
end)

RegisterNUICallback('instagram_postPic', function(data, cb)
  TriggerServerEvent('gcPhone:instagram_postPics', data.username or '', data.message, data.pic)
end)

RegisterNUICallback('instagram_toggleLikePic', function(data, cb)
  TriggerServerEvent('gcPhone:instagram_toogleLikePic', data.username or '', data.picId)
end)

RegisterNUICallback('instagram_comment', function(data, cb)
  TriggerServerEvent('gcPhone:instagram_comment', data.username or '', data.picId)
end)

RegisterNUICallback('instagram_setAvatarUrl', function(data, cb)
  local url = exports["mugshot"]:getMugshotUrl(GetPlayerPed(-1))
  TriggerServerEvent('gcPhone:instagram_setAvatarUrl', data.username or '', url)
end)
