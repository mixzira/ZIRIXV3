local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRPts = {}
Tunnel.bindInterface("vrp_tattoos",vRPts)
Proxy.addInterface("vrp_tattoos",vRPts)

custom = {}
function vRPts.setTattoos(data)
	ClearPedDecorations(PlayerPedId())
	if data then
		custom = data
	end
end

function vRPts.addTattoo(tattoo,store)
	ClearPedDecorations(PlayerPedId())
	if tattoo and store then
		custom[tattoo] = { store }
	end
end

function vRPts.delTattoo(tattoo)
	ClearPedDecorations(PlayerPedId())
	if tattoo then
		custom[tattoo] = nil
	end
end

function vRPts.getTattoos()
	return custom
end

function vRPts.cleanPlayer()
	ClearPedDecorations(PlayerPedId())
	custom = {}
end

RegisterNetEvent('reloadtattos')
AddEventHandler('reloadtattos',function()
	if custom then
		ClearPedDecorations(PlayerPedId())
		for k,v in pairs(custom) do
			SetPedDecoration(PlayerPedId(),GetHashKey(v[1]),GetHashKey(k))
		end
	end
end)