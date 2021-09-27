local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("vrp_homes")

RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify",function(mode,mensagem,item,quantidade,peso)
	local imageService = config.imageService
    SendNUIMessage({ mode = mode, mensagem = mensagem, item = item, quantidade = quantidade, peso = peso, imageService = imageService })
end)

