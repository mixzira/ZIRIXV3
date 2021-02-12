local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp6 = {}
Tunnel.bindInterface("emp_driver",emp6)

--[ PAYMENT | FUNCTION ]---------------------------------------------------------------------------------------------------

function emp6.checkPayment(bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	local pagamento = parseInt(math.random(configdriver.rpagamento[1],configdriver.rpagamento[2]))
	if user_id then
		vRP.giveDinheirama(user_id,parseInt(pagamento))
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(pagamento)).." dólares</b>.")
	end
end

