local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

misc = {}
Tunnel.bindInterface('vrp_watercooler',misc)

function misc.searchCooler()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,config.temWaterRequire) >= 1 then
		if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(config.itemWaterPayment) <= vRP.getInventoryMaxWeight(user_id) then
			vRPclient._playAnim(source,false,{{'amb@prop_human_parking_meter@female@idle_a','idle_a_female'}},true)
			SetTimeout(10000,function()
				vRPclient._stopAnim(source,false)
			end)
			return true
		else
			return false
		end
	else
		return false
	end
end

function misc.coolerPayment()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.tryGetInventoryItem(user_id,config.temWaterRequire,1) then
		SetTimeout(6000,function()
			vRP.giveInventoryItem(user_id,config.itemWaterPayment,1)
		end)
	end
end