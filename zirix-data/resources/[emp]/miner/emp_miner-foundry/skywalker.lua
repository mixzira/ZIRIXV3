local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]-------------------------------------------------------------------------------------------------------------------------

emp = {}
Tunnel.bindInterface("emp_miner-foundry",emp)

--[ VARIABLES ]--------------------------------------------------------------------------------------------------------------------------

local ores = {
    { bar = "diamante", barAmmount = 1, ore = "minerio-diamante", oreAmmount = 8 },
    { bar = "barra-ouro", barAmmount = 1, ore = "minerio-ouro", oreAmmount = 6 },
    { bar = "barra-prata", barAmmount = 1, ore = "minerio-prata", oreAmmount = 4 },
    { bar = "barra-ferro", barAmmount = 1, ore = "minerio-ferro", oreAmmount = 2 }
}

--[ EVENT ]----------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("fundir")
AddEventHandler("fundir",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
    
    if user_id then
        for k,v in pairs(ores) do
			if item == v.bar then
                if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(item) <= vRP.getInventoryMaxWeight(user_id) then
                    if vRP.tryGetInventoryItem(user_id,v.ore,v.oreAmmount) then
                        TriggerClientEvent("fechar-nui",source)

                        TriggerClientEvent("progress",source,10000,"Fundindo")
                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                        SetTimeout(10000,function()
                            vRPclient._stopAnim(source,false)
                            vRP.giveInventoryItem(user_id,item,v.barAmmount)
                            TriggerClientEvent("itensNotify",source,"sucesso","Fundiu",""..v.bar.."",""..v.barAmmount.."",""..vRP.format(vRP.getItemWeight(item)*parseInt(v.barAmmount)).."")
                        end)
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                end
            end
		end
	end
end)

--[ FUNCTION ]-------------------------------------------------------------------------------------------------------------------

function emp.checkCrimeRecord()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.checkCrimeRecord(user_id) > 0 then
			TriggerClientEvent("Notify",source,"negado","Não contratamos pessoas com <b>Ficha Criminal</b>.",10000)
			return false
		else
			return true
		end
	end
end