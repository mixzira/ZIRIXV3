local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp16 = {}
Tunnel.bindInterface("emp_pilot",emp16)

--[ PAYMENT | FUNCTION ]---------------------------------------------------------------------------------------------------
function emp16.checkPaymentShamal(pay)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveDinheirama(user_id,pay)
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(pay).." dólares</b>.")
	end
end

function emp16.checkPaymentMiljet(pay)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveDinheirama(user_id,pay)
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(pay).." dólares</b>.")
	end
end
