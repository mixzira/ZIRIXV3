local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp8 = {}
Tunnel.bindInterface("emp_lumberjack-delivery",emp8)

--[ FUNCTION ]-----------------------------------------------------------------------------------------------------------------

local quantidade = {}
function emp8.Quantidade()
	local source = source
	if quantidade[source] == nil then
	   quantidade[source] = parseInt(math.random(configlumberjackdelivery.delivery[1],configlumberjackdelivery.delivery[2]))
	end
	   TriggerClientEvent("quantidade-tora",source,parseInt(quantidade[source]))
end

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

local tora = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k,v in pairs(tora) do
            if v > 0 then
                tora[k] = v - 1
            end
        end
    end
end)

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function emp8.checkPayment()
	emp8.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if tora[user_id] == 0 or not tora[user_id] then
			if vRP.tryGetInventoryItem(user_id,configlumberjackdelivery.tora,quantidade[source]) then
				local pagamento = math.random(configlumberjackdelivery.money[1],configlumberjackdelivery.money[2])
				vRP.giveDinheirama(user_id,parseInt(pagamento))
		        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(pagamento)).." dólares</b>.")
				quantidade[source] = nil
				emp8.Quantidade()
				tora[user_id] = 15
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..quantidade[source].."x Toras de Madeira</b>.")
			end
		else
			TriggerClientEvent("Notify",source,"importante","Você precisa aguardar <b>"..tora[user_id].." segundos</b> para realizar outra entrega.")
		end
	end
	return false
end