RegisterNetEvent("progress")
AddEventHandler("progress",function(time,text)
	SendNUIMessage({ type = "ui", display = true, time = time, text = text })
end)