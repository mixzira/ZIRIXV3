local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_shops",src)

vRP._prepare("vRP/get_points","SELECT * FROM vrp_stock_exchange WHERE name = @name")
vRP._prepare("vRP/set_points","UPDATE vrp_stock_exchange SET points = @points WHERE name = @name")

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
                                            local rows = vRP.query("vRP/get_points",{ name = shopName })
                                            local resultado = 0
                                            if #rows > 0 then
                                                resultado = json.encode(rows[1].points)
                                            end
                                            local newPoints = resultado + amount

                                            vRP.execute("vRP/set_points", { name = shopName, points = newPoints })
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
                                                local rows = vRP.query("vRP/get_points",{ name = shopName })
                                                local resultado = 0
                                                if #rows > 0 then
                                                    resultado = json.encode(rows[1].points)
                                                end
    
                                                local newPoints = resultado + amount
    
                                                vRP.execute("vRP/set_points", { name = shopName, points = newPoints })
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
                                            local rows = vRP.query("vRP/get_points",{ name = shopName })
                                            local resultado = 0
                                            if #rows > 0 then
                                                resultado = json.encode(rows[1].points)
                                            end

                                            local newPoints = resultado + amount

                                            vRP.execute("vRP/set_points", { name = shopName, points = newPoints })

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

function src.sellItem(itemName,amount,shopName)
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
                            if v.gunlicense ~= nil and v.gunlicense or v.itemRequire ~= nil and v.itemRequire then
                                TriggerClientEvent("Notify",source,"negado","Você <b>não</b> pode vender isso.")
                            else
                                if vRP.getInventoryItemAmount(user_id,v.itemName) >= amount then
                                    vRP.tryGetInventoryItem(user_id,v.itemName,amount)
                                    vRP.giveInventoryItem(user_id, "dinheiro", parseInt(v.saleValue*amount))
                                    TriggerClientEvent("itensNotify",source,"sucesso","Vendeu",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(amount)).."")
                                    TriggerClientEvent("itensNotify",source,"sucesso","Recebeu",""..vRP.itemIndexList("dinheiro").."",""..vRP.format(parseInt(v.saleValue*amount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(amount)).."")
                                    TriggerClientEvent('vrp_shops:Update',source,'updateShop')
                                    PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE LOJA:\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM VENDEU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM VENDIDO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ][ **Valor: " ..parseInt(v.saleValue)"** ]\n⠀⠀"}, {name = "**LOJA:**", value = "[ **"..nShop.."** ]\n⠀⠀"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..amount.."x "..v.itemName.."</b>.")
                                end
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