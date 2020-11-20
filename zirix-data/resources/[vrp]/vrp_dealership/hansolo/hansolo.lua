local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("vrp_dealership",src)
vSERVER = Tunnel.getInterface("vrp_dealership")

--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------

local dealerOpen = false

--[ DEALERS ]----------------------------------------------------------------------------------------------------------------------------

local dealers = {
	{ ['x'] = -56.64, ['y'] = -1096.91, ['z'] = 26.43 }
}

--[ OPEN DEALER ]------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(dealers) do
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance < 10.5 then
					idle = 5
					DrawMarker(23,v.x,v.y,v.z-0.98,0,0,0,0,0,0,0.7,0.7,0.5, 255, 255, 255, 180,0,0,0,0)
					if distance <= 1.5 and IsControlJustPressed(0,38) then
						SetNuiFocus(true,true)
						SendNUIMessage({ action = "showMenu" })
						dealerOpen = true
						vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ STARTFOCUS ]-------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

--[ DEALERCLOSE ]------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("dealerClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	dealerOpen = false
	vRP._DeletarObjeto()
	vRP._stopAnim(false)
end)

--[ REQUESTCARROS ]----------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestCarros",function(data,cb)
	local veiculos = vSERVER.Carros()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)

--[ REQUESTMOTOS ]------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestMotos",function(data,cb)
	local veiculos = vSERVER.Motos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)

--[ REQUESTIMPORT ]----------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestImport",function(data,cb)
	local veiculos = vSERVER.Import()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)

--[ BUYDEALER ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("buyDealer",function(data)
	if data.name ~= nil then
		vSERVER.buyDealer(data.name)
	end
end)

--[ AUTO-UPDATE ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("dealership:Update")
AddEventHandler("dealership:Update",function(action)
	SendNUIMessage({ action = action })
end)