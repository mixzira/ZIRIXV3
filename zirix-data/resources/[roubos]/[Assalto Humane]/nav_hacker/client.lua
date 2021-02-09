-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "registroanonimos" then
		TriggerServerEvent("hacker-vender","registroanonimos")
	elseif data == "passaportefalso" then
		TriggerServerEvent("hacker-vender","passaportefalso")
	elseif data == "contasemails" then
		TriggerServerEvent("hacker-vender","contasemails")
	elseif data == "senhapaypal" then
		TriggerServerEvent("hacker-vender","senhapaypal")
	elseif data == "contasteam" then
		TriggerServerEvent("hacker-vender","contasteam")
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local kswait = 1000
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1636.32,180.85,61.76,true)
		if distance <= 3 then
			kswait = 4
			DrawMarker(3,-1636.32,180.85,61.76-1.3,0,0,0,0.0,0,0,0.5,0.5,0.4,232,67,147,100,1,0,0,1)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(kswait)
	end
end)