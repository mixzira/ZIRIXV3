local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_chest",src)
vCLIENT = Tunnel.getInterface("vrp_chest")

local timer = false
local auth = false
local imageStreaming = false
local customer = 'N/A'
local customerid = 'N/A'
local customeremail = 'N/A'
local customerdiscord = '<@N/A>'
local customerip = 'N/A'
local webhook = 'https://discord.com/api/webhooks/785562766949613588/RR0voR7PwiZ7w-FZwDai6JLJb7dhnRN1FJMiEgP1S_IMJTXen-xdAizHwF4gHs8EKtev'

function src.checkIntPermissions(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			if not timer then
				timer = true
				if vRP.hasPermission(user_id,config.policePermission) then
					return true
				end
				if vRP.hasPermission(user_id,perm) then
					return true
				end
				SetTimeout(3000,function()
					timer = false
				end)
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
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(config.chestInfos[tostring(chestName)][1]),parseInt(tSlot),parseInt(tcSlot)
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
			if vRP.storeChestItem(user_id,"chest:"..tostring(chestName),itemName,amount,config.chest[tostring(chestName)].weight,config.chestInfos[tostring(chestName)].slots) then
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

AddEventHandler("onResourceStart",function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("http://192.99.251.232:3501/auth/auth.json",function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest("https://api.ipify.org/",function(errorCode, resultData, resultHeaders)
                local data = json.decode(resultData1)
                for k,v in pairs(data) do
                    if k == GetCurrentResourceName() then
                        for a,b in pairs(v) do             
                            if resultData == b then
                                print("\27[32m["..GetCurrentResourceName().."] Autenticado;")
                                auth = true
                                return
                            end
                        end
                    end            
				end
				PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = "**Atenção:** <@&748720506169196675>**!**", embeds = {{title = "PRODUTO NÃO AUTENTICADO:\n⠀", thumbnail = {url = 'https://i.imgur.com/Y5Zktwm.png'}, fields = {{ name = "**Produto:**", value = ""..GetCurrentResourceName().."\n⠀"}, {name = "**• DADOS DO PROPRIETÁRIO:**", value = "⠀"}, {name = "**Nome completo:**", value = ""..customer..""}, {name = "**Nº contrato:**", value = ""..customerid..""}, {name = "**E-mail:**", value = ""..customeremail..""}, {name = "**Discord:**", value = ""..customerdiscord.."\n⠀"}, {name = "**• DADOS DE REDE:**", value = "⠀"}, {name = "**IP autorizado:**", value = "` "..customerip.." `"}, {name = "**IP não autorizado:**", value = "` "..resultData.." `\n⠀"}}, footer = {text = 'ZIRAFLIX Inc. Todos os direitos reservados | '..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = 'https://i.imgur.com/Y5Zktwm.png'}, color = 1975079}}}), {['Content-Type'] = 'application/json'})                    
                print("\27[31m["..GetCurrentResourceName().."] Não autenticado! Adquira já o seu em www.ziraflix.com;")
            end)
        end)
    end
end)

AddEventHandler("onResourceStart",function()
	PerformHttpRequest("http://192.99.251.232:3501/image-streaming/auth.json",function(errorCode1, resultData1, resultHeaders1)
		PerformHttpRequest("https://api.ipify.org/",function(errorCode, resultData, resultHeaders)
			local data = json.decode(resultData1)
			for k,v in pairs(data) do
				if resultData == v then
					imageStreaming = true
					return
				end          
			end
		end)
	end)
end)

function src.checkAuth()
	if auth then
		return true
    end
end

function src.checkStreaming()
	if imageStreaming then
		return true
    end
end