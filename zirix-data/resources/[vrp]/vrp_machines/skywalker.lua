local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]------------------------------------------------------------------------------------

misc = {}
Tunnel.bindInterface("vrp_machines",misc)

function misc.buyMachine(item)
	local source = source
	local user_id = vRP.getUserId(source)
	for k,v in pairs(config.productsMachine) do
		if item == v.item then
			if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(v.item) <= vRP.getInventoryMaxWeight(user_id) then
				local price = parseInt(v.price)
				
				if vRP.tryPayment(user_id,parseInt(price)) then
					vRPclient._playAnim(source,false,{{'amb@prop_human_parking_meter@female@idle_a','idle_a_female'}},true)
					SetTimeout(6000,function()
						vRPclient._stopAnim(source,false)
					end)
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					return false
				end
			else
				TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
				return false
			end
		end
	end
end

function misc.machinePayment(item)
	local source = source
	local user_id = vRP.getUserId(source)

	TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(item).."",1,""..vRP.format(vRP.getItemWeight(item)).."")
	return vRP.giveInventoryItem(user_id,item,1)
end