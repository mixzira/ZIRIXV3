local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered',function(author,color,message)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if not message or not author or not identity then
        return
    end
    if not WasEventCanceled() then
    	TriggerClientEvent('chatMessageProximity',-1,source,identity.name,identity.firstname,message)
    end
end)

AddEventHandler('__cfx_internal:commandFallback',function(command)
	local name = GetPlayerName(source)
    if not command or not name then
        return
    end
	if not WasEventCanceled() then
		TriggerEvent('chatMessage',source,name,'/'..command)
	end
	CancelEvent()
end)