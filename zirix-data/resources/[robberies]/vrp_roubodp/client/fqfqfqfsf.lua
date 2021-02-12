local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_roubodp")

client = {}
Tunnel.bindInterface("vrp_roubodp",client)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = -442.21, ['y'] = 5987.18, ['z'] = 31.72 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTEIRO DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delegacia', function(source, args, rawCmd)
	if func.checkPermission() then
	local ped = PlayerPedId()
	local x,y,z = GetEntityCoords(ped)
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
		for k,v in pairs(locais) do
			if Vdist(v.x,v.y,v.z,x,y,z) <= 2 and not andamento then
				func.checkRobbery(v.id,v.x,v.y,v.z)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO O ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandodp")
AddEventHandler("iniciandodp",function(x,y,z)
	segundos = 160
	andamento = true
	SetEntityHeading(PlayerPedId())
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	SetPedComponentVariation(GetPlayerPed(-1),5,21,0,2)
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


function client.VerificarAnim(dict, name)
	if IsEntityPlayingAnim(PlayerPedId(), dict, name, 3) then return true end return false
end
