----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-coca",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local drogas = {
	{ item = "coca-baixa" },
	{ item = "coca-media" },
	{ item = "coca-alta" },
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-coca")
AddEventHandler("produzir-coca",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(drogas) do
			if item == v.item then
				if item == "coca-baixa" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("cocaina") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pasta-base") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"folhas-coca") >= 10 then
                                if vRP.getInventoryItemAmount(user_id,"plastico") >= 5 then
                                    if vRP.tryGetInventoryItem(user_id,"pasta-base",1) and vRP.tryGetInventoryItem(user_id,"folhas-coca",10) and vRP.tryGetInventoryItem(user_id,"plastico",5) then
                                        TriggerClientEvent("fechar-nui-coca",source)
                                        TriggerClientEvent("produzindo-true",source)

                                        TriggerClientEvent("progress",source,10000,"Produzindo Cocaina")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(10000,function()
                                            TriggerClientEvent("produzindo-false",source)
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"cocaina",5)
                                            TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>COCAINA</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>5x Plasticos</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Folhas de Coca</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Pasta Base</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "coca-media" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("cocaina") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pasta-base") >= 2 then
                            if vRP.getInventoryItemAmount(user_id,"folhas-coca") >= 15 then
                                if vRP.getInventoryItemAmount(user_id,"plastico") >= 10 then
                                    if vRP.tryGetInventoryItem(user_id,"pasta-base",2) and vRP.tryGetInventoryItem(user_id,"folhas-coca",15) and vRP.tryGetInventoryItem(user_id,"plastico",10) then
                                        TriggerClientEvent("fechar-nui-coca",source)
                                        TriggerClientEvent("produzindo-true",source)

                                        TriggerClientEvent("progress",source,15000,"Produzindo Cocaina")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(15000,function()
                                            TriggerClientEvent("produzindo-false",source)
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"cocaina",10)
                                            TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>COCAINA</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Plasticos</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x Folhas de Coca</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Pasta Base</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "coca-alta" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("cocaina") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pasta-base") >= 3 then
                            if vRP.getInventoryItemAmount(user_id,"folhas-coca") >= 20 then
                                if vRP.getInventoryItemAmount(user_id,"plastico") >= 15 then
                                    if vRP.tryGetInventoryItem(user_id,"pasta-base",3) and vRP.tryGetInventoryItem(user_id,"folhas-coca",20) and vRP.tryGetInventoryItem(user_id,"plastico",15) then
                                        TriggerClientEvent("fechar-nui-coca",source)
                                        TriggerClientEvent("produzindo-true",source)

                                        TriggerClientEvent("progress",source,20000,"Produzindo Cocaina")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(20000,function()
                                            TriggerClientEvent("produzindo-false",source)
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"cocaina",15)
                                            TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>COCAINA</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x Plasticos</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Folhas de Coca</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Pasta Base</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                end
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
    if vRP.hasPermission(user_id,"medellin.permissao") or vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"lider-medellin.permissao") or vRP.hasPermission(user_id,"motoclub.permissao") or vRP.hasPermission(user_id,"lider-motoclub.permissao") then
        return true
    end
end