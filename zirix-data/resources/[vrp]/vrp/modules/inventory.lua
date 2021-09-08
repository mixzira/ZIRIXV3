function vRP.save_idle_custom(player, custom)
	local r_idle = {}
	local user_id = vRP.getUserId(player)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			if data.cloakroom_idle == nil then
				data.cloakroom_idle = custom
			end

			for k, v in pairs(data.cloakroom_idle) do
				r_idle[k] = v
			end
		end
	end
	return r_idle
end

function vRP.removeCloak(player)
	local user_id = vRP.getUserId(player)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			if data.cloakroom_idle ~= nil then
				vRPclient._setCustomization(player, data.cloakroom_idle)
				data.cloakroom_idle = nil
			end
		end
	end
end

function vRP.itemNameList(item)
	if items.list[item] ~= nil then
		return items.list[item].name
	end
end

function vRP.itemIndexList(item)
	if items.list[item] ~= nil then
		return items.list[item].index
	end
end

function vRP.itemTypeList(item)
	if items.list[item] ~= nil then
		return items.list[item].type
	end
end

function vRP.itemBodyList(item)
	if items.list[item] ~= nil then
		return items.list[item]
	end
end

vRP.items = {}

function vRP.defInventoryItem(idname, name, weight)
	if weight == nil then
		weight = 0
	end
	local item = { name = name, weight = weight }
	vRP.items[idname] = item
end

function vRP.computeItemName(item, args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item, args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname, "|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item, args), vRP.computeItemWeight(item, args)
	end
	return nil, nil
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item, args)
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k, v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

function vRP.giveInventoryItem(user_id, idname, amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry then
			entry.amount = entry.amount + amount
		else
			data.inventory[idname] = { amount = amount }
		end
	end
end

function vRP.tryGetInventoryItem(user_id, idname, amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry and entry.amount >= amount then
			entry.amount = entry.amount - amount

			if entry.amount <= 0 then
				data.inventory[idname] = nil
			end
			return true
		end
	end
	return false
end

function vRP.getInventoryItemAmount(user_id, idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	return math.floor(vRP.expToLevel(vRP.getExp(user_id, "physical", "strength")))*3
end

RegisterServerEvent("clearInventoryTwo")
AddEventHandler("clearInventoryTwo", function(id)
    if id then
		local data = vRP.getUserDataTable(id)
		if data then
			data.inventory = {}
		end

		vRPclient._clearWeapons(id)
	end
end)

RegisterServerEvent("clearInventory")
AddEventHandler("clearInventory", function()
    local source = source
	local user_id = vRP.getUserId(source)
	
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        if data then
            data.inventory = {}
        end

        vRP.varyThirst(user_id, -50)
		vRP.varyHunger(user_id, -50)
        vRPclient._clearWeapons(source)
        vRPclient._setHandcuffed(source, false)

        vRP.setExp(user_id, "physical", "strength", 20)
    end
end)

AddEventHandler("vRP:playerJoin", function(user_id, source, name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)

--[ VEHICLEGLOBAL ]-------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleGlobal()
	return vehs.vehglobal
end

--[ VEHICLENAME ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleName(vname)
	return vehs.vehglobal[vname].name
end

--[ VEHICLERENTALPRICE ]--------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleRentalPrice(vname)
	return vehs.vehglobal[vname].rentalPrice
end

--[ VEHICLECHEST ]--------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleChest(vname)
	return vehs.vehglobal[vname].mala
end

--[ VEHICLESLOT ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleSlot(vname)
	if vehs.vehglobal[vname].slots == nil then
		return 5
	end
	return vehs.vehglobal[vname].slots
end

--[ VEHICLEPRICE ]--------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehiclePrice(vname)
	return vehs.vehglobal[vname].price
end

--[ VEHICLETYPE ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.vehicleType(vname)
	return vehs.vehglobal[vname].tipo
end

--[ ACTIVED ]-------------------------------------------------------------------------------------------------------------------------------------------

local actived = {}
local activedAmount = {}
Citizen.CreateThread(function()
	while true do
		for k, v in pairs(actived) do
			if actived[k] > 0 then
				actived[k] = v - 1
				if actived[k] <= 0 then
					actived[k] = nil
					activedAmount[k] = nil
				end
			end
		end
		Citizen.Wait(100)
	end
end)

--[ SLOT INVENTORY ]------------------------------------------------------------------------------------------------------------------------------------

function vRP.verifySlots(user_id)
	if vRP.getExp(user_id, "physical", "strength") == 1900 then -- 90Kg
		return 24
	elseif vRP.getExp(user_id, "physical", "strength") == 1320 then -- 75Kg
		return 18
	elseif vRP.getExp(user_id, "physical", "strength") == 670 then -- 51Kg
		return 12
	elseif vRP.getExp(user_id, "physical", "strength") == 20 then -- 6Kg
		return 6
	end
end

function vRP.getRemaingSlots(user_id)
	local tSlot = vRP.verifySlots(user_id)

	if tSlot ~= nil then
		tSlot = tSlot
	else
		tSlot = 11
	end

	for k, v in pairs(vRP.getInventory(user_id)) do
		tSlot = tSlot - 1
	end

	return tSlot
end

function vRP.haveMoreSlots(user_id)
	if vRP.getRemaingSlots(user_id) > 0 then
		return true
	else
		return false
	end
end

--[ SLOT CHEST ]----------------------------------------------------------------------------------------------------------------------------------------

function vRP.getRemaingChestSlots(chestData, chestSlots)
	local tcSlot = chestSlots

	if tcSlot ~= nil then
		tcSlot = tcSlot
	else
		tcSlot = 11
	end

	local data = vRP.getSData(chestData)
	local result = json.decode(data) or {}

	for k, v in pairs(result) do
		tcSlot = tcSlot - 1
	end

	return tcSlot
end

--[ STORE CHEST ]---------------------------------------------------------------------------------------------------------------------------------------

function vRP.storeChestItem(user_id, chestData, itemName, amount, chestWeight, chestSlots)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then

			if parseInt(amount) > 0 then
				activedAmount[user_id] = parseInt(amount)
			else
				return false
			end

			local new_weight = vRP.computeItemsWeight(items) + vRP.getItemWeight(itemName) * parseInt(activedAmount[user_id])

			if new_weight <= parseInt(chestWeight) and vRP.getRemaingChestSlots(chestData, chestSlots) >= 1 then
				if vRP.tryGetInventoryItem(parseInt(user_id), itemName, parseInt(activedAmount[user_id])) then
					if items[itemName] ~= nil then
						items[itemName].amount = parseInt(items[itemName].amount) + parseInt(activedAmount[user_id])
					else
						items[itemName] = { amount = parseInt(activedAmount[user_id]) }
					end

					vRP.setSData(chestData, json.encode(items))
					return true
				end
			end
		end
	end
	return false
end

--[ TAKE CHEST ]----------------------------------------------------------------------------------------------------------------------------------------

function vRP.tryChestItem(user_id, chestData, itemName, amount)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then
			if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then

				if parseInt(amount) > 0 then
					activedAmount[user_id] = parseInt(amount)
				else
					return false
				end

				local new_weight = vRP.getInventoryWeight(parseInt(user_id)) + vRP.getItemWeight(itemName) * parseInt(activedAmount[user_id])
				if new_weight <= vRP.getInventoryMaxWeight(parseInt(user_id)) and vRP.getRemaingSlots(parseInt(user_id)) >= 1 then
					vRP.giveInventoryItem(parseInt(user_id), itemName, parseInt(activedAmount[user_id]))

					items[itemName].amount = parseInt(items[itemName].amount) - parseInt(activedAmount[user_id])

					if parseInt(items[itemName].amount) <= 0 then
						items[itemName] = nil
					end

					vRP.setSData(chestData, json.encode(items))
					return true
				end
			end
		end
	end
	return false
end