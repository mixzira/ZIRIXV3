----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-lsd",oC)

-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-lsd")
AddEventHandler("produzir-lsd",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        if item == config.lsd[1] then
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(config.glowquant[1])*config.glowquant[2] <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.getInventoryItemAmount(user_id,config.lowquant[1]) >= config.lowquant[2] then
                    if vRP.getInventoryItemAmount(user_id,config.lowquant[3]) >= config.lowquant[4] then
                        if vRP.getInventoryItemAmount(user_id,config.lowquant[5]) >= config.lowquant[6] then
                            if vRP.tryGetInventoryItem(user_id,config.lowquant[1],config.lowquant[2]) and vRP.tryGetInventoryItem(user_id,config.lowquant[3],config.lowquant[4]) and vRP.tryGetInventoryItem(user_id,config.lowquant[5],config.lowquant[6]) and vRP.tryGetInventoryItem(user_id,config.lowquant[7],config.lowquant[8]) then
                                TriggerClientEvent("fechar-nui",source)
                                TriggerClientEvent("progress",source,config.time,"Fazendo "..config.lsd[1].."")
                                vRPclient._playAnim(source,false,{{config.anim[1],config.anim[2]}},true)

                                SetTimeout(config.time,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,config.glowquant[1],config.glowquant[2])
                                    TriggerClientEvent("Notify",source,"sucesso","Você fez <b>"..config.lsd[1].."</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..config.lowquant[6].."x "..config.lowquant[5].."</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..config.lowquant[4].."x "..config.lowquant[3].."</b>.")
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>"..config.lowquant[1].."</b> na mochila.")
                end
            else
                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
            end
        elseif item == config.lsd[2] then
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(config.gmedquant[1])*config.gmedquant[2] <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.getInventoryItemAmount(user_id,config.medquant[1]) >= config.medquant[2] then
                    if vRP.getInventoryItemAmount(user_id,config.medquant[3]) >= config.medquant[4] then
                        if vRP.getInventoryItemAmount(user_id,config.medquant[5]) >= config.medquant[6] then
                            if vRP.getInventoryItemAmount(user_id,config.medquant[7]) >= config.medquant[8] then
                                if vRP.tryGetInventoryItem(user_id,config.medquant[1],config.medquant[2]) and vRP.tryGetInventoryItem(user_id,config.medquant[3],config.medquant[4]) and vRP.tryGetInventoryItem(user_id,config.medquant[5],config.medquant[6]) and vRP.tryGetInventoryItem(user_id,config.medquant[7],config.medquant[8]) then
                                    TriggerClientEvent("fechar-nui",source)

                                    TriggerClientEvent("progress",source,config.time,"Fazendo "..config.lsd[2].."")
                                    vRPclient._playAnim(source,false,{{config.anim[1],config.anim[2]}},true)

                                    SetTimeout(config.time,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,config.gmedquant[1],config.gmedquant[2])
                                        TriggerClientEvent("Notify",source,"sucesso","Você fez <b>"..config.lsd[2].."</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>"..config.medquant[7].."</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..config.medquant[6].."x "..config.lowquant[5].."</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..config.medquant[4].."x "..config.lowquant[3].."</b>.")
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>"..config.medquant[1].."</b> na mochila.")
                end
            else
                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
            end
        elseif item == config.lsd[3] then
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(config.ghighquant[1])*config.ghighquant[2] <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.getInventoryItemAmount(user_id,config.highquant[1]) >= config.highquant[2] then
                    if vRP.getInventoryItemAmount(user_id,config.highquant[3]) >= config.highquant[4] then
                        if vRP.getInventoryItemAmount(user_id,config.highquant[5]) >= config.highquant[6] then
                            if vRP.getInventoryItemAmount(user_id,config.highquant[7]) >= config.highquant[8] then
                                if vRP.tryGetInventoryItem(user_id,config.highquant[1],config.highquant[2]) and vRP.tryGetInventoryItem(user_id,config.highquant[3],config.highquant[4]) and vRP.tryGetInventoryItem(user_id,config.highquant[5],config.highquant[6]) and vRP.tryGetInventoryItem(user_id,config.highquant[7],config.highquant[8]) then
                                    TriggerClientEvent("fechar-nui",source)

                                    TriggerClientEvent("progress",source,config.time,"Fazendo "..config.lsd[3].."")
                                    vRPclient._playAnim(source,false,{{config.anim[1],config.anim[2]}},true)

                                    SetTimeout(config.time,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,config.ghighquant[1],config.ghighquant[2])
                                        TriggerClientEvent("Notify",source,"sucesso","Você fez <b>"..config.lsd[3].."</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>"..config.highquant[7].."</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..config.highquant[6].."x "..config.highquant[5].."</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..config.highquant[4].."x "..config.highquant[3].."</b>.")
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>"..config.highquant[1].."</b> na mochila.")
                end
            else
                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,config.permissionMachine[1]) or vRP.hasPermission(user_id,config.permissionMachine[2]) or vRP.hasPermission(user_id,config.permissionMachine[3]) or vRP.hasPermission(user_id,config.permissionMachine[4]) or vRP.hasPermission(user_id,config.permissionMachine[5]) then
        return true
    end
end