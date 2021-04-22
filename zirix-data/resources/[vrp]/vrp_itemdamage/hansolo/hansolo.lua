local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("vrp_itemdamage")

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		
		if IsEntityInWater(ped) then
			idle = 100
			if IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
				vSERVER.damageItem()
			end
			if IsPedSwimming(ped) and IsPedSwimmingUnderWater(ped) then
				vSERVER.damageItem()
			end
		end
		Citizen.Wait(idle)
	end
end)
