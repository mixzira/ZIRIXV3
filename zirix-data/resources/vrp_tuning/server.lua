local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_tuning",vRPN)
Proxy.addInterface("vrp_tuning",vRPN)

local idgens = Tools.newIDGenerator()


function vRPN.checkPayment(value)

	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.tryPayment(user_id,parseInt(value)) then
		TriggerClientEvent("Notify",source,"sucesso","Modificação aplicada",8000)
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente",8000)
		return false
	end
end
