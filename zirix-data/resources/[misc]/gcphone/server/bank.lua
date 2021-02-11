local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local logBankTransferencia = "https://discordapp.com/api/webhooks/762559610002866196/7-PjG811yekbIMM65UXMMbHNM2eVyakH3PsaCRLMjowEvTiEssHLxiQo4iDdKTbhaVCn"

RegisterServerEvent('gcPhone:allUpdate')
AddEventHandler('gcPhone:allUpdate',function()
	local source = source
	local user_id = vRP.getUserId(source)
    local num = getNumberPhone(user_id)
    local identity = vRP.getUserIdentity(user_id)
    local money = vRP.getBankMoney(user_id)

	TriggerClientEvent("gcPhone:myPhoneNumber", source, num)
	TriggerClientEvent("vRP:updateBalanceGc", source, money)
	TriggerClientEvent("gcPhone:contactList",source, getContacts(user_id))
    TriggerClientEvent("gcPhone:allMessage",source, getMessages(user_id))
    TriggerClientEvent("gcPhone:firstname",source, identity.name)
    TriggerClientEvent("gcPhone:lastname",source, identity.firstname)
    sendHistoriqueCall(source, num)
end)

RegisterNetEvent("vRP/update_gc_phone")
AddEventHandler("vRP/update_gc_phone", function()
	local source = source
    local user_id = vRP.getUserId(source)
	local bmoney = vRP.getBankMoney(user_id)
    local identity = vRP.getUserIdentity(user_id)

    TriggerClientEvent("vRP:updateBalanceGc", source, bmoney)
    TriggerClientEvent("gcPhone:firstname", source, identity.name)
    TriggerClientEvent("gcPhone:lastname", source, identity.firstname)
end)

RegisterServerEvent('gcPhone:transfer')
AddEventHandler('gcPhone:transfer', function(to,amountt)
    local _source = source
    local user_id = vRP.getUserId(_source)
    local nuser_id = vRP.getUserSource(tonumber(to))
    local amount =  tonumber(amountt)

    if amount <= 0 then
		return TriggerClientEvent('Notify',_source,'negado','Você digitou uma quantia inválida.')
	elseif amount > 5000 then
		return TriggerClientEvent('Notify',_source,'negado','O valor excede o limite de transferência por dispositivel móvel.')
	end

    local identity = vRP.getUserIdentity(user_id)
    local nuidentity = vRP.getUserIdentity(tonumber(to))   

    if nuser_id ~= nil then
        if nuser_id == user_id then
            return TriggerClientEvent('Notify',_source,'negado','Você não pode transferir para si mesmo.')
        else
            local myBank = vRP.getBankMoney(user_id)
            local tax = parseInt(7/100*amount)
            local pagtax = parseInt(amount+tax)

            if myBank >= pagtax then
                vRP.setBankMoney(user_id,myBank-pagtax)
                vRP.giveBankMoney(tonumber(to),amount)
                
                TriggerClientEvent('Notify',nuser_id,'sucesso','Você rebeu <b>$'..amount..'</b> de <b>'..identity.name..' '..identity.firstname..'</b>, passaporte: '..tostring(user_id))
                TriggerClientEvent('Notify',_source,'sucesso','Você transferiu <b>$'..amountt..'</b> para <b>'..nuidentity.name..' '..nuidentity.firstname..'</b>, passaporte: '..tostring(to))

                PerformHttpRequest(logBankTransferencia, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	------------------------------------------------------------
							title = "REGISTRO DE TRANSFERENCIAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
							thumbnail = {
								url = "https://i.imgur.com/CtQB816.png"
							}, 
							fields = {
								{ 
									name = "**IDENTIFICAÇÃO:**",
									value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
								},
								{ 
									name = "**TRANSFERIU PARA:**",
									value = "**"..nuidentity.name.." "..nuidentity.firstname.."** [**"..nuser_id.."**]\n⠀"
								},
								{ 
									name = "**VALOR: $"..tonumber(amountt).."**",
									value = "\n⠀"
								}
							},
							footer = { 
								text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
								icon_url = "https://i.imgur.com/CtQB816.png"
							},
							color = 4402032 
						}
					}
				}), { ['Content-Type'] = 'application/json' })
            else
                TriggerClientEvent('Notify',_source,'negado','<b>Saldo insuficiente</b>.') 
            end
        end
    else
        return TriggerClientEvent('Notify',_source,'negado','Usuario invalido.')
    end
end)

--[[AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local money = vRP.getBankMoney(user_id)
        local identity = vRP.getUserIdentity(user_id)
        TriggerClientEvent("vRP:updateBalanceGc",source, money)
        TriggerClientEvent("gcPhone:firstname",source, identity.name)
        TriggerClientEvent("gcPhone:lastname",source, identity.firstname)
    end
end)]]

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        local money = vRP.getBankMoney(user_id)
        local identity = vRP.getUserIdentity(user_id)
        getOrGeneratePhoneNumber(source, identifier, function(myPhoneNumber)
            TriggerClientEvent("gcPhone:myPhoneNumber",source, myPhoneNumber)
            TriggerClientEvent("vRP:updateBalanceGc", source, money)
            TriggerClientEvent("gcPhone:contactList",source, getContacts(user_id))
            TriggerClientEvent("gcPhone:allMessage",source, getMessages(user_id))
            TriggerClientEvent("gcPhone:firstname",source, identity.name)
            TriggerClientEvent("gcPhone:lastname",source, identity.firstname)
        end)
    end
end)