local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp4 = {}
Tunnel.bindInterface("emp_postman",emp4)

--[ COLLECT | FUNCTION ]--------------------------------------------------------------------------------------------------------

function emp4.checkWeight()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("encomenda")*3 <= vRP.getInventoryMaxWeight(user_id) and vRP.tryGetInventoryItem(user_id,configpostman.boxpostman,configpostman.ammountpostman) and TriggerClientEvent("itensNotify",source,"usar","Usou","caixa-vazia") then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia ou <b>itens insuficientes</b> para o trabalho.",10000)
			return false
		end
	end
end

--[ COLLECT | FUNCTION ]--------------------------------------------------------------------------------------------------------

function emp4.checkCrimeRecord()
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

--[ COLLECT | FUNCTION ]--------------------------------------------------------------------------------------------------------

function emp4.giveOrders()
	local source = source
	local user_id = vRP.getUserId(source)

	vRP.giveInventoryItem(user_id,configpostman.orderpostman,configpostman.ammoutorder)
	TriggerClientEvent("itensNotify",source,"sucesso","Empacotou","encomenda",3,vRP.format(vRP.getItemWeight("encomenda")*parseInt(3)))
end

