----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-armas",oC)

-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-arma")
AddEventHandler("produzir-arma",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        if item == config.weapons[1] then
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbodyWEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.getInventoryItemAmount(user_id,config.weapon1[1]) >= config.weapon1[2] then
                    if vRP.getInventoryItemAmount(user_id,config.weapon1[3]) >= config.weapon1[4] then
                        if vRP.getInventoryItemAmount(user_id,config.weapon1[5]) >= config.weapon1[6] then
                            if vRP.getInventoryItemAmount(user_id,config.weapon1[7]) >= config.weapon1[8] then
                                if vRP.tryGetInventoryItem(user_id,config.weapon1[1],config.weapon1[2]) and vRP.tryGetInventoryItem(user_id,config.weapon1[3],config.weapon1[4]) and vRP.tryGetInventoryItem(user_id,config.weapon1[5],config.weapon1[6]) and vRP.tryGetInventoryItem(user_id,config.weapon1[7],config.weapon1[8]) then
                                    TriggerClientEvent("fechar-nui",source)
                                    TriggerClientEvent("progress",source,10000,"Montando AK47")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wbodyWEAPON_ASSAULTRIFLE_MK2",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>AK47</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>"..config.weapon1[7].."</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..config.weapon1[5].."</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..config.weapon1[3].."</b>.")
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>"..config.weapon1[1].."</b> na mochila.")
                end
            else
                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
            end
        elseif item == "ak74u" then
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbodyWEAPON_COMPACTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.getInventoryItemAmount(user_id,config.weapon2[1]) >= config.weapon2[2] then
                    if vRP.getInventoryItemAmount(user_id,config.weapon2[3]) >= config.weapon2[4] then
                        if vRP.getInventoryItemAmount(user_id,config.weapon2[5]) >= config.weapon2[6] then
                            if vRP.getInventoryItemAmount(user_id,config.weapon2[7]) >= config.weapon2[8] then
                                if vRP.tryGetInventoryItem(user_id,config.weapon2[1],config.weapon2[2]) and vRP.tryGetInventoryItem(user_id,config.weapon2[3],config.weapon2[4]) and vRP.tryGetInventoryItem(user_id,config.weapon2[5],config.weapon2[6]) and vRP.tryGetInventoryItem(user_id,config.weapon2[7],config.weapon2[8]) then
                                    TriggerClientEvent("fechar-nui",source)

                                    TriggerClientEvent("progress",source,10000,"Montando AKS-74U")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wbodyWEAPON_COMPACTRIFLE",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>AKS-74U</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>2x pacotes de mola</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x placas de metal</b>.")
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de AKS-74U</b> na mochila.")
                end
            else
                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
            end
        elseif item == "uzi" then
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbodyWEAPON_MICROSMG") <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.getInventoryItemAmount(user_id,config.weapon3[1]) >= config.weapon3[2] then
                    if vRP.getInventoryItemAmount(user_id,config.weapon3[3]) >= config.weapon3[4] then
                        if vRP.getInventoryItemAmount(user_id,config.weapon3[5]) >= config.weapon3[6] then
                            if vRP.getInventoryItemAmount(user_id,config.weapon3[7]) >= config.weapon3[8] then
                                if vRP.tryGetInventoryItem(user_id,config.weapon3[1],config.weapon3[2]) and vRP.tryGetInventoryItem(user_id,config.weapon3[3],config.weapon3[4]) and vRP.tryGetInventoryItem(user_id,config.weapon3[5],config.weapon3[6]) and vRP.tryGetInventoryItem(user_id,config.weapon3[7],config.weapon3[8]) then
                                    TriggerClientEvent("fechar-nui",source)

                                    TriggerClientEvent("progress",source,10000,"Montando MICRO-UZI")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wbodyWEAPON_MICROSMG",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>UZI</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>2x pacotes de mola</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>3x placas de metal</b>.")
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de UZI</b> na mochila.")
                end
            else
                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
            end
        elseif item == "magnum44" then
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbodyWEAPON_REVOLVER_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.getInventoryItemAmount(user_id,config.weapon4[1]) >= config.weapon4[2] then
                    if vRP.getInventoryItemAmount(user_id,config.weapon4[3]) >= config.weapon4[4] then
                        if vRP.getInventoryItemAmount(user_id,config.weapon4[5]) >= config.weapon4[6] then
                            if vRP.getInventoryItemAmount(user_id,config.weapon4[7]) >= config.weapon4[8] then
                                if vRP.tryGetInventoryItem(user_id,config.weapon4[1],config.weapon4[2]) and vRP.tryGetInventoryItem(user_id,config.weapon4[3],config.weapon4[4]) and vRP.tryGetInventoryItem(user_id,config.weapon4[5],config.weapon4[6]) and vRP.tryGetInventoryItem(user_id,config.weapon4[7],config.weapon4[8]) then
                                    TriggerClientEvent("fechar-nui",source)

                                    TriggerClientEvent("progress",source,10000,"Montando Revolver Magnum 44")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wbodyWEAPON_REVOLVER_MK2",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Revolver Magnum 44</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>2x pacotes de mola</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>placa de metal</b> na mochila.")
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de Magnum 44</b> na mochila.")
                end
            else
                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
            end
        elseif item == "glock" then
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbodyWEAPON_COMBATPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.getInventoryItemAmount(user_id,config.weapon5[1]) >= config.weapon5[2] then
                    if vRP.getInventoryItemAmount(user_id,config.weapon5[3]) >= config.weapon5[4] then
                        if vRP.getInventoryItemAmount(user_id,config.weapon5[5]) >= config.weapon5[6] then
                            if vRP.getInventoryItemAmount(user_id,config.weapon5[7]) >= config.weapon5[8] then
                                if vRP.tryGetInventoryItem(user_id,config.weapon5[1],config.weapon5[2]) and vRP.tryGetInventoryItem(user_id,config.weapon5[3],config.weapon5[4]) and vRP.tryGetInventoryItem(user_id,config.weapon5[5],config.weapon5[6]) and vRP.tryGetInventoryItem(user_id,config.weapon5[7],config.weapon5[8]) then
                                    TriggerClientEvent("fechar-nui",source)

                                    TriggerClientEvent("progress",source,10000,"Montando Glock")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wbodyWEAPON_COMBATPISTOL",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Glock</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>pacote de molas</b> na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>placa de metal</b> na mochila.")
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de Glock</b> na mochila.")
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