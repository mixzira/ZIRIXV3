local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local Ran = false

--[ CONNECTION ]-------------------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("loadingscreen",src)
vSERVER = Tunnel.getInterface("loadingscreen")

RegisterNUICallback('requestIP',function(data,cb)
	local ip = vSERVER.useScript()
	if ip then
		cb({ ip = ip })
	end
end)

AddEventHandler("playerSpawned", function ()
	if not Ran then
		ShutdownLoadingScreenNui()
		Ran = true
	end
end)