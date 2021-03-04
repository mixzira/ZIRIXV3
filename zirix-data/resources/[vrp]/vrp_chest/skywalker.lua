local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_chest",src)
vCLIENT = Tunnel.getInterface("vrp_chest")

local timer = false

function src.checkIntPermissions(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			if not timer then
				timer = true
				if vRP.hasPermission(user_id,config.policePermission) then
					SetTimeout(3000,function()
						timer = false
					end)
					return true
				end
				if vRP.hasPermission(user_id,perm) then
					SetTimeout(3000,function()
						timer = false
					end)
					return true
				end
			end
		end
	end
	return false
end

function src.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(chestName))
		local result = json.decode(data) or {}
		local tcSlot = src.verifyChestSlots(chestName)
		local tSlot = vRP.verifySlots(user_id)
		if result then
			if tcSlot ~= nil then
				tcSlot = tcSlot
			else
				tcSlot = 11
			end
			if tSlot ~= nil then
				tSlot = tSlot
			else
				tSlot = 11
			end
			for k,v in pairs(result) do
				tcSlot = tcSlot - 1
				if vRP.itemBodyList(k) then
					if tcSlot >= 0 then
						table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
					end
				end
			end
			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				if vRP.itemBodyList(k) then
					tSlot = tSlot - 1
					table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
				end
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(config.chest[tostring(chestName)][1]),parseInt(tSlot),parseInt(tcSlot)
	end
	return false
end

function src.verifyChestSlots(chestName)
	return config.chest[tostring(chestName)].slots
end

function src.haveMoreChestSlots(chestName)
	local chestData = "chest:"..tostring(chestName)
	if vRP.getRemaingChestSlots(chestData,src.verifyChestSlots(chestName)) > 0 then
		return true
	else
		return false
	end
end

function src.storeItem(chestName,itemName,amount)
    if itemName then
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
			if vRP.storeChestItem(user_id,"chest:"..tostring(chestName),itemName,amount,config.chest[tostring(chestName)].weight,config.chest[tostring(chestName)].slots) then
				local identity = vRP.getUserIdentity(user_id)
				TriggerClientEvent("Chest:UpdateChest",source,"updateChest")
				TriggerClientEvent("itensNotify",source,"sucesso","Guardou",""..vRP.itemIndexList(itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(itemName)*parseInt(amount)).."")
				PerformHttpRequest(config.chest[tostring(chestName)].webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE BAÚ:\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
            end
        end
    end
end

function src.takeItem(chestName,itemName,amount)
    if itemName then
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
			if vRP.tryChestItem(user_id,"chest:"..tostring(chestName),itemName,amount) then
				local identity = vRP.getUserIdentity(user_id)
				TriggerClientEvent("Chest:UpdateChest",source,"updateChest")
				TriggerClientEvent("itensNotify",source,"sucesso","Pegou",""..vRP.itemIndexList(itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(itemName)*parseInt(amount)).."")
				PerformHttpRequest(config.chest[tostring(chestName)].webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE BAÚ:\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
            end
        end
    end
end