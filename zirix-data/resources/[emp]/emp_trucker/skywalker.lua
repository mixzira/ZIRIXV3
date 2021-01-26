local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp15 = {}
Tunnel.bindInterface("emp_trucker",emp15)

--[ PAYMENT | FUNCTION ]---------------------------------------------------------------------------------------------------
function emp15.checkPaymentGas(pay)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveDinheirama(user_id,pay)
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(pay).." dólares</b>.")
	end
end

function emp15.checkPaymentWood(pay)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveDinheirama(user_id,pay)
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(pay).." dólares</b>.")
	end
end
