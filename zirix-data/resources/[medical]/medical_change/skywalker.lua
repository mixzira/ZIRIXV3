local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

src = {}
Tunnel.bindInterface('medical_change',src)
vCLIENT = Tunnel.getInterface('medical_change')

RegisterServerEvent("entrar-servico")
AddEventHandler("entrar-servico",function()
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"ems.permissao") then
        TriggerClientEvent("Notify",source,"negado","Você já está em serviço.")
    else
        vRP.addUserGroup(user_id,"ems")
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
    end
end)

RegisterServerEvent("sair-servico")
AddEventHandler("sair-servico",function()
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"paisana-ems.permissao") then
        TriggerClientEvent("Notify",source,"negado","Você já está fora de serviço.")
    else
        vRP.addUserGroup(user_id,"paisana-ems")
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
    end
end)

function src.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ems.permissao") or vRP.hasPermission(user_id,"paisana-ems.permissao") then
        return true
	end
end