local isOpen = false

RegisterCommand('div', function(source, args)
    if not isOpen then
        SetNuiFocus(true, true)
	    SendNUIMessage({action = 'showMenu'})
        isOpen = true
    else
        SetNuiFocus(false, false)
	    SendNUIMessage({action = 'hideMenu'})
        isOpen = false
    end
end)

RegisterNUICallback('close',function()
	SetNuiFocus(false, false)
	SendNUIMessage({action = 'hideMenu'})
    isOpen = false
end)

Citizen.CreateThread(function()
    SetNuiFocus(false, false)
	SendNUIMessage({action = 'hideMenu'})
end)