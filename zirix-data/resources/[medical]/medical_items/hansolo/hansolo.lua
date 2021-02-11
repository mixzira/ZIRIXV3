local menuactive = false
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

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "pegar-headblock" then
		TriggerServerEvent("medical-pegar","headblock")

	elseif data == "pegar-gesso" then
		TriggerServerEvent("medical-pegar","gesso")

	elseif data == "pegar-bandagem" then
		TriggerServerEvent("medical-pegar","bandagem")

	elseif data == "pegar-cinta" then
		TriggerServerEvent("medical-pegar","cinta")
	
	elseif data == "fechar" then
		ToggleActionMenu()
	
	end
end)

local lojas = {
	{ ['x'] = 295.7, ['y'] = -591.77, ['z'] = 43.27 },
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000

		for k,v in pairs(lojas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local lojas = lojas[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), lojas.x, lojas.y, lojas.z, true ) < 1.2 then
				DrawText3D(lojas.x, lojas.y, lojas.z, "Pressione [~y~E~w~] para acessar a ~y~ESTOQUE~w~.")
			end
			
			if distance <= 10 then
				DrawMarker(23, lojas.x, lojas.y, lojas.z-0.97, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 0, 0, 300, 0, 0, 0, 0)
				DrawMarker(0, lojas.x, lojas.y, lojas.z-0.2, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.4, 255, 255, 255, 300, 1, 0, 0, 0)
				idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

function DrawText3D(x,y,z, text)
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