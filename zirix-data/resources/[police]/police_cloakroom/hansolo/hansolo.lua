local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRPex = Tunnel.getInterface("police_cloakroom")

local system = {
	{ ['x'] = 452.03, ['y'] = -982.65, ['z'] = 30.69 },
}

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
	if data == "mk2" then
		TriggerServerEvent("recruta")

	elseif data == "pdw" then
		TriggerServerEvent("investigador")

	elseif data == "shotmk1" then
		TriggerServerEvent("tatico")

	elseif data == "pistmk1" then
		TriggerServerEvent("alta")

	elseif data == "close" then
		ToggleActionMenu()
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000
		for k,v in pairs(system) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local system = system[k]
			
			if distance <= 5 then
				idle = 5
				DrawMarker(23, system.x, system.y, system.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5, 66, 236, 134, 150,0,0,0,0)
				if distance <= 1.2 then
					idle = 5
					if IsControlJustPressed(0,38) and vRPex.checkOfficer() then
						if vRPex.checkAuth() then
							ToggleActionMenu()
						else
							TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
