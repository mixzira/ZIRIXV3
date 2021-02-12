local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_vanilla")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local roubando = false
local segundos = 0
local id_loja = 0
local pegando = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 95.23, ['y'] = -1293.24, ['z'] = 29.27 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTEIRO DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vanilla', function(source, args, rawCmd)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
		for k,v in pairs(locais) do
			if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and not andamento then
				if func.checkPermission() then
					func.checkRobbery(v.id,v.x,v.y,v.z)
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO O ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandovanilla")
AddEventHandler("iniciandovanilla",function(id,x,y,z)
	andamento = true
	segundos = 160
	id_loja = id
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 500
		if andamento then
			sleep = 5
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(x,y,z,locais[id_loja].x,locais[id_loja].y,locais[id_loja].z)
			if distance >= 6.5 then
				andamento = false
				TriggerEvent("Notify","negado","Seu roubo foi cancelado.")
			end
			if distance <= 6.5 then
				slee = 5
				drawTxt("AGUARDE  ~r~"..segundos.."~w~  PARA FINALIZAR O ROUBO, NÃO SAIA DA SALA",4,0.5,0.93,0.50,255,255,255,180)
				if segundos == 0 then
					andamento = false
					func.giveAward()
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		if andamento then
			if segundos > 0 then
				segundos = segundos - 1
			end
		end
		Citizen.Wait(1000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end