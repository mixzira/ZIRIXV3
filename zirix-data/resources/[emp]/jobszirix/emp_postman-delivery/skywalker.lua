local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp5 = {}
Tunnel.bindInterface("emp_postman-delivery",emp5)

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local ammount = {}

--[ DELIVERY ORDER | FUNCTION ]-------------------------------------------------------------------------------------------------

function emp5.startPayments()
	local source = source
	local user_id = vRP.getUserId(source)
	if ammount[source] == nil then
		ammount[source] = parseInt(math.random(config.postmandelivery[1],config.postmandelivery[2]))
	end
	if user_id then
		if vRP.tryGetInventoryItem(user_id,config.postmanitem,ammount[source]) then
			local price = parseInt(math.random(config.postmanpayment[1],config.postmanpayment[2]))
			vRP.giveDinheirama(user_id,parseInt(price+ammount[source]))
			TriggerClientEvent("Notify",source,"sucesso","Você entregou <b>x"..ammount[source].." encomendas</b>, recebendo <b>$"..vRP.format(parseInt(price+ammount[source])).." dólares</b>.",8000)
			ammount[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..ammount[source].."x Encomendas</b>.",8000)
		end
	end
end

--[ DELIVERY ORDER | FUNCTION ]-------------------------------------------------------------------------------------------------

function emp5.checkCrimeRecord()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.checkCrimeRecord(user_id) < 1 then
		return true
	else
		TriggerClientEvent("Notify",source,"importante","Não contratamos pessoas com <b>Ficha Criminal</b>.",10000)
		return false	
	end
end

--[ CHECK PLATE | FUNCTION ]----------------------------------------------------------------------------------------------------

function emp5.checkPlate(modelo)
	local source = source
	local user_id = vRP.getUserId(source)
	local veh,vhash,vplaca,vname = vRPclient.vehListHash(source,4)
	if veh and vhash == modelo then
		local placa_user_id = vRP.getUserByRegistration(vplaca)
		if user_id == placa_user_id then
			return true
		end
	end
end