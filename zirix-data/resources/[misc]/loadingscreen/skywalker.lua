local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("loadingscreen",src)
vCLIENT = Tunnel.getInterface("loadingscreen")

function src.useScript()
	local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
        PerformHttpRequest("https://api.ipify.org/",function(errorCode, resultData, resultHeaders)
            return resultData
        end)
	end
	return false
end