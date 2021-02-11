local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp3 = {}
Tunnel.bindInterface("vrp_farmer-delivery",emp3)

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local amount = {}

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function emp3.startPayments()
	local source = source

	if amount[source] == nil then
		amount[source] = parseInt(math.random(configfarmerd.deliveryss[1],configfarmerd.deliveryss[2]))
	end

	local user_id = vRP.getUserId(source)
	if user_id then
	
		local data = vRP.getUserAptitudes(user_id)
		if data then
			if vRP.tryGetInventoryItem(user_id,configfarmerd.farmer1,amount[source]) then
				local pagamento = parseInt(math.random(configfarmerd.farmer2[1],configfarmerd.farmer2[2]))
				vRP.giveDinheirama(user_id,parseInt(pagamento+amount[source]))
				TriggerClientEvent("vrp_sound:source",source,'coin',0.2)
				TriggerClientEvent("Notify",source,"sucesso","Entrega concluída, recebido <b>$"..vRP.format(parseInt(pagamento+amount[source])).." dólares</b>.",8000)

				amount[source] = nil
				return true
			else
				TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..amount[source].."x Grãos</b>.",8000)
			end
		end
		return false
	end
end

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function emp3.checkPlate(modelo)
	local source = source
	local user_id = vRP.getUserId(source)
	local veh,vhash,vplaca,vname = vRPclient.vehListHash(source,4)
	if veh and vhash == modelo then
		local placa_user_id = vRP.getUserByRegistration(vplaca)
		if user_id == placa_user_id then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você <b>precisa usar o carro</b> de serviço.",10000)
			return false
		end
	end
end

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function emp3.checkCrimeRecord()
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