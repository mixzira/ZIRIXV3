local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Policia = {}
Tunnel.bindInterface("police_change",Policia)

RegisterServerEvent("entrar-servico-policia")
AddEventHandler("entrar-servico-policia",function()
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"policia.permissao") then
        TriggerClientEvent("Notify",source,"negado","Você já está em serviço.")
    else
        vRP.addUserGroup(user_id,"policia")
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
    end
end)

RegisterServerEvent("sair-servico-policia")
AddEventHandler("sair-servico-policia",function()
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"paisana-policia.permissao") then
        TriggerClientEvent("Notify",source,"negado","Você já está fora de serviço.")
    else
        vRP.addUserGroup(user_id,"paisana-policia")
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
    end
end)

function Policia.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paisana-policia.permissao") then
        return true
	end
end