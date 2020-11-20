local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]------------------------------------------------------------------------------------

misc = {}
Tunnel.bindInterface("vrp_misc",misc)

--[ VARIABLES ]-------------------------------------------------------------------------------------

local cooldown = {}

--[ WATHER ITEM DAMAGE | EVENT ]--------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(cooldown) do
			if v > 0 then
				cooldown[k] = v - 1
			end
		end
	end
end)

function misc.damageItem()
	local source = source
	local user_id = vRP.getUserId(source)

	for k,v in pairs(config.itemList) do
		local item = v.item
		local damageItem = v.damageItem
		local percentage = 0

		if vRP.getInventoryItemAmount(user_id,item) > 0 then
			local itemAmmount = parseInt(vRP.getInventoryItemAmount(user_id,item))
			local itemName = vRP.itemNameList(item)

			if damageItem == nil then
				if cooldown[user_id] == 0 or not cooldown[user_id] then
					cooldown[user_id] = 5
					percentage = math.random(100)
					if percentage >= 60 then
						if vRP.tryGetInventoryItem(user_id,item,itemAmmount) then
							if percentage >= 70 then
								TriggerClientEvent("Notify",source,"negado","<b>Sua mochila está aberta!</b> Você perdeu <b>"..itemName.."</b>.",3000)
							else
								TriggerClientEvent("Notify",source,"negado","<b>Sua mochila está rasgada!</b> Você perdeu <b>"..itemName.."</b>.",3000)
							end
							percentage = 0
							return true
						end
					end
				else
					return false
				end
			else
				if vRP.tryGetInventoryItem(user_id,item,itemAmmount) then
					vRP.giveInventoryItem(user_id,damageItem,itemAmmount)
					TriggerClientEvent("Notify",source,"negado","Seu <b>"..itemName.." queimou</b> quando você entrou na água.",3000)
					return true
				end
			end
		end
	end
end