local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("vrp_homes")

RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify",function(mode,mensagem,item,quantidade,peso)
	local ip = config.imageServer
	if ip == '' then
        if vSERVER.checkStreaming() then
            ip = '192.99.251.232:3501'
        end
    end
    if vSERVER.checkAuth() then
        SendNUIMessage({ mode = mode, mensagem = mensagem, item = item, quantidade = quantidade, peso = peso, ip = ip })
    else
        TriggerEvent('chatMessage',"[ ZIRAFLIX: "..GetCurrentResourceName().." - Script não autenticado/vazado ]",{255,0,0},"Adquira já o seu em http://www.ziraflix.com")
    end
end)

