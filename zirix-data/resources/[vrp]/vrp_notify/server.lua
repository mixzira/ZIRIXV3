local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
local webhookadmin = ""

RegisterCommand('anunciar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem == "" then
            return
        end
        TriggerClientEvent("NotifyAdm",-1,identity.name,mensagem)
    end
end)

RegisterCommand('anuncio',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if vRP.tryPayment(user_id,5000) then
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem == "" then
            return
        end
        TriggerClientEvent("NotifyPol",-1,identity.name,mensagem)
    end
end)

RegisterCommand('callback',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"chat.permissao") then
        if args[1] then
        	local id = vRP.getUserSource(parseInt(args[1]))
            local mensagem = vRP.prompt(source,"Mensagem:","")
            if mensagem == "" then
                return
            end
            TriggerClientEvent("NotifyAdmCallback",id,identity.name,mensagem)
        end
    end
end)