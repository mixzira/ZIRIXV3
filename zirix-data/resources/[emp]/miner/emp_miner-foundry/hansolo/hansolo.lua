local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]---------------------------------------------------------------------------------

emp = Tunnel.getInterface("emp_miner-foundry")

--[ VARIABLES ]----------------------------------------------------------------------------------

local menuactive = false
local foundry = {
	{ ['x'] = 1087.83, ['y'] = -2001.85, ['z'] = 30.89 }
}

--[ MENU ]---------------------------------------------------------------------------------------

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end

--[ BUTTON ]-------------------------------------------------------------------------------------

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "fundir-diamante" then
		TriggerServerEvent("fundir","diamante")

	elseif data == "fundir-ouro" then
		TriggerServerEvent("fundir","barra-ouro")

	elseif data == "fundir-prata" then
		TriggerServerEvent("fundir","barra-prata")

	elseif data == "fundir-ferro" then
		TriggerServerEvent("fundir","barra-ferro")

	elseif data == "fechar" then
		ToggleActionMenu()
		menu = false
	end
end)


RegisterNetEvent("fechar-nui")
AddEventHandler("fechar-nui", function()
	ToggleActionMenu()
end)

--[ ACTION ]---------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		for k,v in pairs(foundry) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local foundry = foundry[k]
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), foundry.x, foundry.y, foundry.z, true ) < 1.2 and not menuactive then
				DrawText3D(foundry.x, foundry.y, foundry.z, "Pressione [~y~E~w~] para acessar a ~y~FUNDIÇÃO DE MINÉRIOS~w~.")
			end
			if distance <= 5 then
				idle = 5
				DrawMarker(23, foundry.x, foundry.y, foundry.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and emp.checkCrimeRecord() then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ FUNCTION ]-------------------------------------------------------------------------------------

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end