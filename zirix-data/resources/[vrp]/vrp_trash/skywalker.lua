local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

--[ CONNECTION ]------------------------------------------------------------------------------------

misc = {}
Tunnel.bindInterface('vrp_trash',misc)

--[ VARIABLES ]-------------------------------------------------------------------------------------

local timers = {}
local amount = {}
local amountMoney = {}
local payment = ''

--[ SEARCH TRASH | THREAD ]-------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
	end
end)

--[ SEARCH TRASH | FUNCTION ]-----------------------------------------------------------------------

function misc.amount()
	local source = source
	if amount[source] == nil then
		amount[source] = math.random(config.itemTrashPayment[1],config.itemTrashPayment[2])
	end
end

function misc.amountMoney()
	local source = source
	if amountMoney[source] == nil then
		amountMoney[source] = math.random(config.moneyTrashPayment[1],config.moneyTrashPayment[2])
	end
end

function misc.searchTrash(id)
	misc.amount()
	misc.amountMoney()

	local source = source
	local user_id = vRP.getUserId(source)
	local chance = math.random(1,1000)

	if user_id then
		if timers[id] == 0 or not timers[id] then
			if chance >= 985 then
				if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(payment)*amountMoney[source] <= vRP.getInventoryMaxWeight(user_id) then
					TriggerClientEvent('vrp_trash:trashAnim',source)
					payment = 'dinheiro'
					timers[id] = config.timeTrashCooldown
					return true
				else
					TriggerClientEvent('Notify',source,'negado','Sua mochila está <b>cheia</b>.')
					return false
				end
			elseif chance >= 930 and chance <= 984 then
				if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(payment)*amount[source] <= vRP.getInventoryMaxWeight(user_id) then
					TriggerClientEvent('vrp_trash:trashAnim',source)
					payment = config.eletricTrashPayment[math.random(3)].item
					timers[id] = config.timeTrashCooldown
					return true
				else
					TriggerClientEvent('Notify',source,'negado','Sua mochila está <b>cheia</b>.')
					return false
				end
			elseif chance >= 850 and chance <= 929 then
				if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(payment)*amount[source] <= vRP.getInventoryMaxWeight(user_id) then
					TriggerClientEvent('vrp_trash:trashAnim',source)
					payment = config.clothesTrashPayment[math.random(2)].item
					timers[id] = config.timeTrashCooldown
					return true
				else
					TriggerClientEvent('Notify',source,'negado','Sua mochila está <b>cheia</b>.')
					return false
				end
			elseif chance >= 700 and chance <= 849 then
				if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(payment)*amount[source] <= vRP.getInventoryMaxWeight(user_id) then
					TriggerClientEvent('vrp_trash:trashAnim',source)
					payment = config.foodTrashPayment[math.random(2)].item
					timers[id] = config.timeTrashCooldown
					return true
				else
					TriggerClientEvent('Notify',source,'negado','Sua mochila está <b>cheia</b>.')
					return false
				end
			elseif chance >= 500 and chance <= 699 then
				TriggerClientEvent('vrp_trash:trashAnim',source)
				payment = 'rato'
				timers[id] = config.timeTrashCooldown
				return true
			else
				TriggerClientEvent('vrp_trash:trashAnim',source)
				payment = ''
				timers[id] = config.timeTrashCooldown
				return true
			end
		else
			TriggerClientEvent('Notify',source,'negado','Lixeira está <b>vazia</b>.')
		end
	end
end

function misc.trashPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if payment ~= '' and payment ~= 'rato' then
			if payment == 'dinheiro' then
				vRP.giveInventoryItem(user_id,payment,amountMoney[source])
				TriggerClientEvent('itensNotify',source,'sucesso','Encontrou',''..vRP.itemIndexList(payment)..'',''..vRP.format(parseInt(amountMoney[source]))..'',''..vRP.format(vRP.getItemWeight(payment)*parseInt(amountMoney[source]))..'')
			else
				vRP.giveInventoryItem(user_id,payment,amount[source])
				TriggerClientEvent('itensNotify',source,'sucesso','Encontrou',''..vRP.itemIndexList(payment)..'',''..vRP.format(parseInt(amount[source]))..'',''..vRP.format(vRP.getItemWeight(payment)*parseInt(amount[source]))..'')
			end
			amount[source] = nil
			amountMoney[source] = nil
			return true
		elseif payment == 'rato' then
			TriggerClientEvent('Notify',source,'negado','Não havia nada na lixeira, além de ratos que te morderam.')
			TriggerClientEvent('vrp_misc:RagdollTime',source,6000)
			vRPclient.varyHealth(user_id,-50)
			amount[source] = nil
			amountMoney[source] = nil
			return true
		else
			TriggerClientEvent('Notify',source,'negado','Não havia nada na lixeira.')
			amount[source] = nil
			amountMoney[source] = nil
			return true
		end
	end
end