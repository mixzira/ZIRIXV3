local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_rouboarmas")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 253.92, ['y'] = -51.98, ['z'] = 69.95 },
	{ ['id'] = 2, ['x'] = -1304.31, ['y'] = -396.54, ['z'] = 36.7 },
	{ ['id'] = 3, ['x'] = -660.64, ['y'] = -933.08, ['z'] = 21.83 },
	{ ['id'] = 4, ['x'] = 24.61, ['y'] = -1105.61, ['z'] = 29.8 },
	{ ['id'] = 5, ['x'] = 840.5, ['y'] = -1035.58, ['z'] = 28.2 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTEIRO DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		local x,y,z = GetEntityCoords(ped)
        if not andamento then 
            for k,v in pairs(locais) do
                if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and not andamento then
                    DrawMarker(21,v.x,v.y,v.z-0.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,50,1,0,0,1)
                    drawText("~g~E~w~  PARA INICIAR O ROUBO",4,0.5,0.93,0.50,255,255,255,180)
                    if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
                        if IsControlJustPressed(0,38) and func.checkPermission() then
                            func.checkRobbery(v.id,v.x,v.y,v.z)
                        end
                    end
                end
            end
        else
            drawText("~g~"..segundos.." SEGUNDOS~w~ ATÉ QUE TERMINE O ROUBO",4,0.5,0.9,0.46,255,255,255,150)
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO O ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandolojadearmas")
AddEventHandler("iniciandolojadearmas",function(x,y,z)
	segundos = 50
	andamento = true
	SetEntityHeading(PlayerPedId())
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	TriggerEvent('cancelando',true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTXT
-----------------------------------------------------------------------------------------------------------------------------------------

function drawText(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

