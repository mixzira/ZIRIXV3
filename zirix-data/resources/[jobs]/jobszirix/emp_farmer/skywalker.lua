local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emp17 = {}
Tunnel.bindInterface("emp_farmer",emp17)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS COLHEITA
-----------------------------------------------------------------------------------------------------------------------------------------
function emp17.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        randgraos = math.random(configfarmer.grain[1],configfarmer.grain[2])
        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(configfarmer.igrain) <= vRP.getInventoryMaxWeight(user_id) then
            vRP.giveInventoryItem(user_id,configfarmer.igrain,parseInt(randgraos))
            TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>"..randgraos.."</b> Grãos.")
        else
            TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS SEPARAR GRAOS
-----------------------------------------------------------------------------------------------------------------------------------------
function emp17.checkGraos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,configfarmer.igrain) >= 5 then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","<b>Grãos</b> insuficientes.") 
			return false
		end
	end
end

function emp17.separarGraos()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.tryGetInventoryItem(user_id,configfarmer.igrain,configfarmer.ugrain) then
            rgraos = math.random(configfarmer.qgrain[1],configfarmer.qgrain[2])
            vRP.giveInventoryItem(user_id,configfarmer.cgrain,parseInt(rgraos))
            TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>"..rgraos.."</b> Grãos.")
        end
    end
end