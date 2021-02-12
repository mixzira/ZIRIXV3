local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp7 = {}
Tunnel.bindInterface("emp_lumberjack",emp7)

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

local quantidade = {}
function emp7.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(3)
	end
end

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function emp7.checkPayment()
	emp7.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("tora")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"tora",quantidade[source])
			quantidade[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
			return false
		end
	end
end