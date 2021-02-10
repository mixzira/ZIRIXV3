local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

mW = {}
Tunnel.bindInterface("vrp_lavagem",mW)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------

local armas = {
	{ item = "25k" },
	{ item = "50k" },
	{ item = "100k" },
	{ item = "500k" },
	{ item = "1kk" },
    { item = "terceirizada" }
}

-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("dirty-money-clean")
AddEventHandler("dirty-money-clean",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(armas) do
			if item == v.item then
				if item == "25k" then
					if vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"alvejante") >= 7 then
                            if vRP.getInventoryItemAmount(user_id,"borrifador") >= 3 then
                                if vRP.getInventoryItemAmount(user_id,"caixa-vazia") >= 5 then
                                    if vRP.getInventoryItemAmount(user_id,"dinheiro-sujo") >= 25000 then
                                        if vRP.tryGetInventoryItem(user_id,"alvejante",7) and vRP.tryGetInventoryItem(user_id,"borrifador",3) and vRP.tryGetInventoryItem(user_id,"caixa-vazia",5) and vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",25000) then
                                            TriggerClientEvent("close-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Lavando (25 mil)")
                                            --TriggerClientEvent("bancada-armas:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveDinheirama(user_id,parseInt("25000"))
                                                TriggerClientEvent("Notify",source,"sucesso","Você lavou uma quantia de <b>$25000</b> dólares-sujos.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>$25000</b> dólares-sujos na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>5x caixa(s)-vazia(s)</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>3x borrifador(es)</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>7x alvejante(s)</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço <b>insuficiente</b> na mochila.")
                    end 
                elseif item == "50k" then
                    if vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"alvejante") >= 14 then
                            if vRP.getInventoryItemAmount(user_id,"borrifador") >= 6 then
                                if vRP.getInventoryItemAmount(user_id,"caixa-vazia") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"dinheiro-sujo") >= 50000 then
                                        if vRP.tryGetInventoryItem(user_id,"alvejante",14) and vRP.tryGetInventoryItem(user_id,"borrifador",6) and vRP.tryGetInventoryItem(user_id,"caixa-vazia",10) and vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",50000) then
                                            TriggerClientEvent("close-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Lavando (50 mil)")
                                            --TriggerClientEvent("bancada-armas:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveDinheirama(user_id,parseInt("50000"))
                                                TriggerClientEvent("Notify",source,"sucesso","Você lavou uma quantia de <b>$50000</b> dólares-sujos.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>$50000</b> dólares-sujos na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x caixa(s)-vazia(s)</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x borrifador(es)</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>14x alvejante(s)</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço <b>insuficiente</b> na mochila.")
                    end
                elseif item == "100k" then
                    if vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"alvejante") >= 21 then
                            if vRP.getInventoryItemAmount(user_id,"borrifador") >= 9 then
                                if vRP.getInventoryItemAmount(user_id,"caixa-vazia") >= 15 then
                                    if vRP.getInventoryItemAmount(user_id,"dinheiro-sujo") >= 100000 then
                                        if vRP.tryGetInventoryItem(user_id,"alvejante",21) and vRP.tryGetInventoryItem(user_id,"borrifador",9) and vRP.tryGetInventoryItem(user_id,"caixa-vazia",15) and vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",100000) then
                                            TriggerClientEvent("close-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Lavando (100 mil)")
                                            --TriggerClientEvent("bancada-armas:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveDinheirama(user_id,parseInt("100000"))
                                                TriggerClientEvent("Notify",source,"sucesso","Você lavou uma quantia de <b>$100000</b> dólares-sujos.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>$100000</b> dólares-sujos na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x caixa(s)-vazia(s)</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>9x borrifador(es)</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>21x alvejante(s)</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço <b>insuficiente</b> na mochila.")
                    end
                elseif item == "500k" then
                    if vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"alvejante") >= 28 then
                            if vRP.getInventoryItemAmount(user_id,"borrifador") >= 12 then
                                if vRP.getInventoryItemAmount(user_id,"caixa-vazia") >= 20 then
                                    if vRP.getInventoryItemAmount(user_id,"dinheiro-sujo") >= 500000 then
                                        if vRP.tryGetInventoryItem(user_id,"alvejante",28) and vRP.tryGetInventoryItem(user_id,"borrifador",12) and vRP.tryGetInventoryItem(user_id,"caixa-vazia",20) and vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",500000) then
                                            TriggerClientEvent("close-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Lavando (500 mil)")
                                            --TriggerClientEvent("bancada-armas:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveDinheirama(user_id,parseInt("500000"))
                                                TriggerClientEvent("Notify",source,"sucesso","Você lavou uma quantia de <b>$500000</b> dólares-sujos.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>$500000</b> dólares-sujos na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x caixa(s)-vazia(s)</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>12x borrifador(es)</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>28x alvejante(s)</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço <b>insuficiente</b> na mochila.")
                    end
                elseif item == "1kk" then
                    if vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"alvejante") >= 35 then
                            if vRP.getInventoryItemAmount(user_id,"borrifador") >= 15 then
                                if vRP.getInventoryItemAmount(user_id,"caixa-vazia") >= 25 then
                                    if vRP.getInventoryItemAmount(user_id,"dinheiro-sujo") >= 1000000 then
                                        if vRP.tryGetInventoryItem(user_id,"alvejante",35) and vRP.tryGetInventoryItem(user_id,"borrifador",15) and vRP.tryGetInventoryItem(user_id,"caixa-vazia",25) and vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",1000000) then
                                            TriggerClientEvent("close-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Lavando (1 milhão)")
                                            --TriggerClientEvent("bancada-armas:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveDinheirama(user_id,parseInt("1000000"))
                                                TriggerClientEvent("Notify",source,"sucesso","Você lavou uma quantia de <b>$1000000</b> dólares-sujos.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>$1000000</b> dólares-sujos na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>25x caixa(s)-vazia(s)</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x borrifador(es)</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>35x alvejante(s)</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço <b>insuficiente</b> na mochila.")
                    end
				elseif item == "terceirizada" then
                    if vRP.getInventoryMaxWeight(user_id) then
                        local amount = vRP.getInventoryItemAmount(user_id,"dinheiro-sujo")
                        if vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",amount) then
                            local limpo = amount - amount*config.percent
                            TriggerClientEvent("close-nui",source)

                            TriggerClientEvent("progress",source,10000,"Lavando ("..amount..")")
                            --TriggerClientEvent("bancada-armas:posicao",source)
                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                            SetTimeout(10000,function()
                                vRPclient._stopAnim(source,false)
                                vRP.giveInventoryItem(user_id,'dinheiro',limpo)
                                TriggerClientEvent("Notify",source,"sucesso","Você todos seus dólares-sujos.")
                            end)
                        else
                            TriggerClientEvent("Notify",source,"negado","Dinheiro <b>insuficiente</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço <b>insuficiente</b> na mochila.")
                    end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

function mW.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,config.permission) then
        return true
    end
end