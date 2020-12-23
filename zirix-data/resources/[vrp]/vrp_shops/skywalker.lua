local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("vrp_shops",src)

local auth = false
local imageStreaming = false

local customer = 'N/A'
local customerid = 'N/A'
local customeremail = 'N/A'
local customerdiscord = '<@N/A>'
local customerip = 'N/A'
local webhook = 'https://discord.com/api/webhooks/785562766949613588/RR0voR7PwiZ7w-FZwDai6JLJb7dhnRN1FJMiEgP1S_IMJTXen-xdAizHwF4gHs8EKtev'

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function src.openNav(shopName)
	local source = source
    local user_id = vRP.getUserId(source)
    local data = vRP.getUserDataTable(user_id)

    local tSlot = vRP.verifySlots(user_id)
    local tcSlot = 0

	local inventory = {}
    local shop = {}

    if user_id then
        local fSlot = 9
        local fcSlot = 9

        if tSlot ~= nil then
            tSlot = tSlot
        else
            tSlot = 6
        end

        if tSlot < fSlot then
            fSlot = fSlot - tSlot
        elseif tSlot >= fSlot then
            fSlot = 0
        end

        if data and data.inventory then
            for k,v in pairs(data.inventory) do
                if vRP.itemBodyList(k) then
                    tSlot = tSlot - 1
                    table.insert(inventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
                end
            end
        end

        for k,v in pairs(config.shops) do
            if k == shopName then
                for k,v in pairs(v.itens) do
                    tcSlot = tcSlot + 1
                    table.insert(shop, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
                end
            end
        end

        if tcSlot < fcSlot then
            fcSlot = fcSlot - tcSlot
        elseif tcSlot >= fcSlot then
            fcSlot = 0
        end

        return inventory, vRP.getInventoryWeight(user_id), vRP.getInventoryMaxWeight(user_id), parseInt(tSlot), parseInt(fSlot), parseInt(fcSlot), shop
	end
end

function src.buyItem(itemName,amount,shopName)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if amount and amount >= 1  then
            for k,v in pairs(config.shops) do
                local nShop = k
                for k,v in pairs(v.itens) do
                    if itemName == v.itemName then
                        if shopName == nShop then
                            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.itemName)*v.itemAmount*amount <= vRP.getInventoryMaxWeight(user_id) and vRP.getRemaingSlots(user_id) >= 1 then
                                if v.gunlicense ~= nil and v.gunlicense then
                                    if identity.gunlicense == 1 and vRP.getInventoryItemAmount(user_id,"portearmas") >= 1 then
                                        if vRP.tryPayment(user_id,parseInt(v.itemPrice*amount)) then
                                            vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*amount))
                                            TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(amount)).."")
                                            TriggerClientEvent('vrp_shops:Update',source,'updateShop')
                                            PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE LOJA:\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM COMPROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM COMPRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}, {name = "**LOJA:**", value = "[ **"..nShop.."** ]\n⠀⠀"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisar ter <b>porte de armas</b>.")
                                    end
                                else
                                    if v.itemRequire ~= nil then
                                        if vRP.getInventoryItemAmount(user_id,v.itemRequire) >= amount then
                                            if vRP.tryPayment(user_id,parseInt(v.itemPrice*amount)) then
                                                vRP.tryGetInventoryItem(user_id,v.itemRequire,amount)
                                                vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*amount))
                                                TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(amount)).."")
                                                TriggerClientEvent('vrp_shops:Update',source,'updateShop')
                                                PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE LOJA:\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM COMPROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM COMPRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}, {name = "**LOJA:**", value = "[ **"..nShop.."** ]\n⠀⠀"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                            else
                                                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                                            end
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..amount.."x "..vRP.itemNameList(v.itemRequire).."</b>.")
                                        end
                                    else
                                        if vRP.tryPayment(user_id,parseInt(v.itemPrice*amount)) then
                                            vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*amount))
                                            TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(amount)).."")
                                            TriggerClientEvent('vrp_shops:Update',source,'updateShop')
                                            PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE LOJA:\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM COMPROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM COMPRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}, {name = "**LOJA:**", value = "[ **"..nShop.."** ]\n⠀⠀"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                                        end
                                    end
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
                            end
                        end
                    end
                end
            end
        else
            TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.")
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

AddEventHandler("onResourceStart",function(resourceName)
    if GetCurrentResourceName() == resourceName then
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
    end
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