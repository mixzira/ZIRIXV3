local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
local Tools = module('vrp','lib/Tools')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

src = {}
Tunnel.bindInterface('vrp_advanced_shops',src)

local timers = {}
local idgens = Tools.newIDGenerator()
local blips = {}

vRP.prepare('vRP/insert_shops','INSERT INTO vrp_shops(owner, name, security, price, forsale, stock, maxstock, vault, maxvault,fantasy) VALUES(@owner, @name, @security, @price, @forsale, @stock, @maxstock, @vault, @maxvault, @fantasy)')
vRP.prepare('vRP/get_stock_shop','SELECT stock FROM vrp_shops WHERE name = @name')
vRP.prepare('vRP/set_stock_shop','UPDATE vrp_shops SET stock = @stock WHERE name = @name')
vRP.prepare('vRP/get_maxstock_shop','SELECT * FROM vrp_shops WHERE name = @name')
vRP.prepare('vRP/set_maxstock_shop','UPDATE vrp_shops SET maxstock = @maxstock WHERE name = @name')
vRP.prepare('vRP/get_vault_shop','SELECT * FROM vrp_shops WHERE name = @name')
vRP.prepare('vRP/set_vault_shop','UPDATE vrp_shops SET vault = @vault WHERE name = @name')
vRP.prepare('vRP/purchase_shop','UPDATE vrp_shops SET owner = @owner, forsale = @forsale WHERE name = @name')

vRP.prepare('vRP/select_shop_name','SELECT * FROM vrp_shops WHERE name = @name')
vRP.prepare('vRP/get_security_shop','SELECT * FROM vrp_shops WHERE name = @name')
vRP.prepare('vRP/set_security_shop','UPDATE vrp_shops SET security = @security WHERE name = @name')
vRP.prepare('vRP/get_owner_shop','SELECT * FROM vrp_shops WHERE name = @name')
vRP.prepare('vRP/update_product','UPDATE vrp_shops SET stock = @stock WHERE name = @name')
vRP.prepare('vRP/set_fantasy_shop','UPDATE vrp_shops SET fantasy = @fantasy WHERE name = @name')
vRP.prepare('vRP/get_owner','SELECT * FROM vrp_shops WHERE owner = @owner')

vRP.prepare('vRP/select_shop','SELECT * FROM vrp_shops')

function dist ( x1, y1, z1, x2, y2, z2 )
	local dx = x1 - x2
	local dy = y1 - y2
	local dz = z1 - z2
	return math.sqrt ( dx * dx + dy * dy + dz*dz )
end

function createShop()
    local rows = vRP.query('vRP/select_shop',{})
    
    for k,v in pairs(config.shops) do
        local create = false
        for x,y in pairs(rows) do
            if rows[x].name == k then
                create = true
                break
            end
        end
        if not create then
            vRP.execute('vRP/insert_shops', {
                ['owner'] = 0,
                ['name'] = k,
                ['security'] = v.security,
                ['price'] = v.price,
                ['forsale'] = v.forsale,
                ['stock'] = json.encode(v.stock),
                ['maxstock'] = v.maxstock,
                ['vault'] = 0,
                ['maxvault'] = v.vault.limit,
                ['fantasy'] = "Loja"
            })
        end
    end
    return false
end

function src.getFantasy(name)
    local rows = vRP.query('vRP/get_maxstock_shop', { name = name })
    if #rows > 0 then
        return rows[1].fantasy
    else
        return {}
    end
end

function setFantasy(name,fantasy)
    vRP.execute('vRP/set_fantasy_shop', { name = name, fantasy = fantasy })
end

function getStock(name)
    local rows = vRP.query('vRP/get_stock_shop', { name = name })
    if #rows > 0 then
        return json.decode(rows[1].stock)
    else
        return {}
    end
end

function setStock(name,stock)
    vRP.execute('vRP/set_stock_shop', { name = name, stock = json.encode(stock) })
end

function getMaxStock(name)
    local rows = vRP.query('vRP/get_maxstock_shop', { name = name })
    if #rows > 0 then
        return rows[1].maxstock
    else
        return {}
    end
end

function setMaxStock(name,maxstock,source)
    vRP.execute('vRP/set_maxstock_shop', { name = name, maxstock = maxstock })
end

function getVault(name)
    local rows = vRP.query('vRP/get_vault_shop', { name = name })
    if #rows > 0 then
        return json.decode(rows[1].vault), rows[1].maxvault
    else
        return {}
    end
end

function setVault(name,vault,source)
    vRP.execute('vRP/set_vault_shop', { name = name, vault = vault })
end

function getSecurity(name)
    local rows = vRP.query('vRP/get_security_shop', { name = name })
    if #rows > 0 then
        return json.decode(rows[1].security)
    else
        return {}
    end
end

function setSecurity(name,security)
    vRP.execute('vRP/set_security_shop', { name = name, security = security })
end

function src.getOwnerName(name)
    local rows = vRP.query('vRP/get_owner_shop', { name = name })
    if #rows > 0 then
        local user_id = rows[1].owner
        local identity = vRP.getUserIdentity(user_id)
        if identity then
            return identity.name
        end
    else
        return {}
    end
end

function getOwner(name)
    local rows = vRP.query('vRP/get_owner_shop', { name = name })
    if #rows > 0 then
        return rows[1].owner
    else
        return {}
    end
end

function getStatus(name)
    local rows = vRP.query('vRP/get_owner_shop', { name = name })
    if #rows > 0 then
        return rows[1].forsale
    else
        return {}
    end
end

function purchaseShop(name,owner,forsale)
    vRP.execute('vRP/purchase_shop', { name = name, owner = owner, forsale = forsale })
end

function src.checkOwner(name)
    local source = source
    local user_id = vRP.getUserId(source)
    local rows = vRP.query('vRP/get_owner_shop', { name = name })
    if #rows > 0 then
        local owner = json.decode(rows[1].owner)
        if owner == user_id then
            return true
        end
    else
        return false
    end
end

function src.modifyItem(item, shop)
    local source = source
    local user_id = vRP.getUserId(source)
    local stock = getStock(shop)
    local products = stringsplit(item, ',')
    local owner = getOwner(shop)
    if user_id then
        TriggerClientEvent('vrp_advanced_shops:close',source,'hideMenu')
        local number = vRP.prompt(source,'Qual é o novo valor do produto?', '')
        if number ~= '' then
            for k,v in pairs(products) do
                local newprice = parseInt(number)
                local percent = parseInt(tonumber(stock[v].price)*0.3)
                local max = parseInt(tonumber(stock[v].price)+percent)
                local min = parseInt(tonumber(stock[v].price)-percent)
                if newprice < min or newprice > max then
                    TriggerClientEvent('Notify',source,'negado','Você <b>não pode</b> ultrapassar o limite fiscal.')
                    return false
                else
                    if owner == user_id then
                        stock[v].price = newprice
                        setStock(shop,stock)
                        TriggerClientEvent('itensNotify',source,'usar','Alterou preço',''..vRP.itemIndexList(v)..'',''..vRP.format(newprice)..'')
                        return true
                    else
                        TriggerClientEvent('Notify',source,'negado','Você <b>não pode</b> fazer isso.')
                        return false
                    end
                end
            end
        else
            TriggerClientEvent('Notify',source,'negado','Valor <b>inválido</b>.')
            return false
        end
    end
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = '%s'
    end
    local t = {} ; i = 1
    for str in string.gmatch(inputstr, '([^'..sep..']+)') do
        t[i] = str
        i = i + 1
    end
    return t
end

function src.openNav(shopName)
    local source = source
    local user_id = vRP.getUserId(source)
    local data = vRP.getUserDataTable(user_id)
    local dataShop = getStock(shopName)
    local tSlot = vRP.verifySlots(user_id)
    local tcSlot = 0
    local inventory = {}
    local shop = {}
    local options = {}
    local vault, maxvault = getVault(shopName)
    local maxstock = getMaxStock(shopName)
    local security = getSecurity(shopName)
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
                    table.insert(inventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), weight = vRP.getItemWeight(k) })
                end
            end
        end
        if dataShop then
            for k,v in pairs(dataShop) do
                if vRP.itemBodyList(k) then
                    tcSlot = tcSlot + 1
                    table.insert(shop, { body = k, index = vRP.itemIndexList(k), name = vRP.itemNameList(k), price = parseInt(v.price), stock = parseInt(v.amount) })
                end
            end
        end
        if tcSlot < fcSlot then
            fcSlot = fcSlot - tcSlot
        elseif tcSlot >= fcSlot then
            fcSlot = 0
        end
        for k,v in pairs(config.options) do
            table.insert(options, { body = k, name = v.name, price = parseInt(v.price), description = v.description, security = parseInt(v.security), stock = parseInt(v.stock) })
        end
        if security == 1 then
            security = '<r>Baixa</r>'
        elseif security == 2 then
            security = '<l>Média</l>'
        elseif security == 3 then
            security = '<v>Alta</v>'
        end
        return inventory, vRP.getInventoryWeight(user_id), vRP.getInventoryMaxWeight(user_id), parseInt(tSlot), parseInt(fSlot), parseInt(fcSlot), shop, vault, maxvault, options, parseInt(maxstock), security
    end
end

function src.buyItem(item,amount,shop)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local stock = getStock(shop)
    local products = stringsplit(item, ',')
    local vault, maxvault = getVault(shop)
    local owner = getOwner(shop)
    if user_id then
        if amount and amount >= 1  then
            for k,v in pairs(products) do
                if stock[v].amount >= amount then
                    if owner == user_id then
                        if vRP.checkExistentItem(user_id, item) then
                            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v)*amount <= vRP.getInventoryMaxWeight(user_id) then
                                stock[v].amount = stock[v].amount - amount
                                setStock(shop,stock)
                                vRP.giveInventoryItem(user_id,v,amount)
                                TriggerClientEvent('itensNotify',source,'sucesso','- estoque',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM RETIROU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, {name = '**ITEM RETIRADO:**', value = '[ **Item: '..vRP.itemNameList(item)..'** ][ **Quantidade: '..parseInt(amount)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                            else 
                                TriggerClientEvent('Notify',source,'negado','Mochila <b>cheia</b>.')
                            end
                        else
                            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v)*amount <= vRP.getInventoryMaxWeight(user_id) and vRP.getRemaingSlots(user_id) >= 1 then
                                stock[v].amount = stock[v].amount - amount
                                setStock(shop,stock)
                                vRP.giveInventoryItem(user_id,v,amount)
                                TriggerClientEvent('itensNotify',source,'sucesso','- estoque',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM RETIROU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, {name = '**ITEM RETIRADO:**', value = '[ **Item: '..vRP.itemNameList(item)..'** ][ **Quantidade: '..parseInt(amount)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                            else 
                                TriggerClientEvent('Notify',source,'negado','Mochila <b>cheia</b>.')
                            end
                        end
                    else
                        local newvault = vault + tonumber(stock[v].price) * amount
                        if vault < maxvault and newvault <= maxvault then
                            if vRP.checkExistentItem(user_id, item) then
                                if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(v)*amount <= vRP.getInventoryMaxWeight(user_id) then
                                    if stock[v].gunlicense ~= nil and stock[v].gunlicense then
                                        if identity.gunlicense == 1 and vRP.getInventoryItemAmount(user_id,'portearmas') >= 1 then              
                                            if vRP.tryPayment(user_id,parseInt(tonumber(stock[v].price)*amount)) then
                                                stock[v].amount = stock[v].amount - amount
                                                vRP.giveInventoryItem(user_id,v,amount)
                                                setVault(shop,newvault,source)
                                                setStock(shop,stock)
                                                TriggerClientEvent('itensNotify',source,'sucesso','Comprou',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                                PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM COMPROU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, {name = '**ITEM COMPRADO:**', value = '[ **Item: '..vRP.itemNameList(item)..'** ][ **Quantidade: '..parseInt(amount)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                            else
                                                TriggerClientEvent('Notify',source,'negado','Dinheiro insuficiente.')
                                            end
                                        else
                                            TriggerClientEvent('Notify',source,'negado','Você precisar ter <b>porte de armas</b>.')
                                        end 
                                    else
                                        if stock[v].require ~= nil and stock[v].require then
                                            if vRP.getInventoryItemAmount(user_id,stock[v].require) >= amount then
                                                if vRP.tryPayment(user_id,parseInt(tonumber(stock[v].price)*amount)) then
                                                    stock[v].amount = stock[v].amount - amount
                                                    vRP.tryGetInventoryItem(user_id,stock[v].require,amount)
                                                    vRP.giveInventoryItem(user_id,v,amount)
                                                    setVault(shop,newvault,source)
                                                    setStock(shop,stock)
                                                    TriggerClientEvent('itensNotify',source,'sucesso','Comprou',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                                    TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                                    PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM COMPROU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, {name = '**ITEM COMPRADO:**', value = '[ **Item: '..vRP.itemNameList(item)..'** ][ **Quantidade: '..parseInt(amount)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                                else
                                                    TriggerClientEvent('Notify',source,'negado','Dinheiro insuficiente.')
                                                end
                                            else
                                                TriggerClientEvent('Notify',source,'negado','Você precisa de <b>'..amount..'x '..vRP.itemNameList(stock[v].require)..'</b>.')
                                            end
                                        else
                                            if vRP.tryPayment(user_id,parseInt(tonumber(stock[v].price)*amount)) then
                                                stock[v].amount = stock[v].amount - amount
                                                vRP.giveInventoryItem(user_id,v,amount)
                                                setVault(shop,newvault,source)
                                                setStock(shop,stock)
                                                TriggerClientEvent('itensNotify',source,'sucesso','Comprou',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                                PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM COMPROU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, { name = '**ITEM COMPRADO:**', value = '[ **Item: '..vRP.itemNameList(item)..'** ][ **Quantidade: '..parseInt(amount)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                            else
                                                TriggerClientEvent('Notify',source,'negado','Dinheiro insuficiente.')
                                            end
                                        end
                                    end
                                else
                                    TriggerClientEvent('Notify',source,'negado','Mochila <b>cheia</b>.')
                                end
                            else
                                if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v)*amount <= vRP.getInventoryMaxWeight(user_id) and vRP.getRemaingSlots(user_id) >= 1 then
                                    if stock[v].gunlicense ~= nil and stock[v].gunlicense then
                                        if identity.gunlicense == 1 and vRP.getInventoryItemAmount(user_id,'portearmas') >= 1 then              
                                            if vRP.tryPayment(user_id,parseInt(tonumber(stock[v].price)*amount)) then
                                                stock[v].amount = stock[v].amount - amount
                                                vRP.giveInventoryItem(user_id,v,amount)
                                                setVault(shop,newvault,source)
                                                setStock(shop,stock)
                                                TriggerClientEvent('itensNotify',source,'sucesso','Comprou',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                                PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM COMPROU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, {name = '**ITEM COMPRADO:**', value = '[ **Item: '..vRP.itemNameList(item)..'** ][ **Quantidade: '..parseInt(amount)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                            else
                                                TriggerClientEvent('Notify',source,'negado','Dinheiro insuficiente.')
                                            end
                                        else
                                            TriggerClientEvent('Notify',source,'negado','Você precisar ter <b>porte de armas</b>.')
                                        end 
                                    else
                                        if stock[v].require ~= nil and stock[v].require then
                                            if vRP.getInventoryItemAmount(user_id,stock[v].require) >= amount then
                                                if vRP.tryPayment(user_id,parseInt(tonumber(stock[v].price)*amount)) then
                                                    stock[v].amount = stock[v].amount - amount
                                                    vRP.tryGetInventoryItem(user_id,stock[v].require,amount)
                                                    vRP.giveInventoryItem(user_id,v,amount)
                                                    setVault(shop,newvault,source)
                                                    setStock(shop,stock)
                                                    TriggerClientEvent('itensNotify',source,'sucesso','Comprou',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                                    TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                                    PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM COMPROU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, {name = '**ITEM COMPRADO:**', value = '[ **Item: '..vRP.itemNameList(item)..'** ][ **Quantidade: '..parseInt(amount)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                                else
                                                    TriggerClientEvent('Notify',source,'negado','Dinheiro insuficiente.')
                                                end
                                            else
                                                TriggerClientEvent('Notify',source,'negado','Você precisa de <b>'..amount..'x '..vRP.itemNameList(stock[v].require)..'</b>.')
                                            end
                                        else
                                            if vRP.tryPayment(user_id,parseInt(tonumber(stock[v].price)*amount)) then
                                                stock[v].amount = stock[v].amount - amount
                                                vRP.giveInventoryItem(user_id,v,amount)
                                                setVault(shop,newvault,source)
                                                setStock(shop,stock)
                                                TriggerClientEvent('itensNotify',source,'sucesso','Comprou',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                                PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM COMPROU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, { name = '**ITEM COMPRADO:**', value = '[ **Item: '..vRP.itemNameList(item)..'** ][ **Quantidade: '..parseInt(amount)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                            else
                                                TriggerClientEvent('Notify',source,'negado','Dinheiro insuficiente.')
                                            end
                                        end
                                    end
                                else
                                    TriggerClientEvent('Notify',source,'negado','Mochila <b>cheia</b>.')
                                end
                            end
                        else
                            TriggerClientEvent('Notify',source,'negado','Venda <b>indisponível</b> no momento. Estamos aguardando o cofre ser esvaziado.')
                        end
                    end
                else
                    TriggerClientEvent('Notify',source,'negado','Estoque <b>insuficiente</b>.')
                end
            end
        else
            TriggerClientEvent('Notify',source,'negado','Quantidade <b>inválida</b>.')
        end
    end
end

function src.sellItem(item,amount,shop)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local stock = getStock(shop)
    local maxstock = getMaxStock(shop)
    local products = stringsplit(item, ',')
    local vault, maxvault = getVault(shop)
    local owner = getOwner(shop)
    if user_id then
        if amount and amount >= 1  then
            for k,v in pairs(products) do
                if stock[v] ~= nil then
                    if stock[v].amount + amount <= maxstock then
                        if owner == user_id then
                            if vRP.getInventoryItemAmount(user_id,v) >= amount then
                                stock[v].amount = stock[v].amount + amount
                                vRP.tryGetInventoryItem(user_id,v,amount)
                                setStock(shop,stock)
                                TriggerClientEvent('itensNotify',source,'sucesso','+ estoque',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                            end
                        else
                            local sale = parseInt(tonumber(stock[v].price*0.6)) * amount
                            if vault >= sale then
                                if stock[v].gunlicense ~= nil and stock[v].gunlicense or stock[v].itemRequire ~= nil and stock[v].itemRequire then
                                    TriggerClientEvent('Notify',source,'negado','Você <b>não pode</b> vender esse produto.')
                                else
                                    if vRP.checkExistentItem(user_id, 'dinheiro') then
                                        if vRP.getInventoryWeight(user_id) + vRP.getItemWeight('dinheiro') * sale <= vRP.getInventoryMaxWeight(user_id) then
                                            if vRP.getInventoryItemAmount(user_id,v) >= amount then
                                                local newvault = vault - sale
                                                stock[v].amount = stock[v].amount + amount
                                                vRP.tryGetInventoryItem(user_id,v,amount)
                                                vRP.giveInventoryItem(user_id, 'dinheiro', sale)
                                                setVault(shop,newvault,source)
                                                setStock(shop,stock)
                                                TriggerClientEvent('itensNotify',source,'sucesso','Vendeu',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                                TriggerClientEvent('itensNotify',source,'sucesso','Recebeu',''..vRP.itemIndexList('dinheiro')..'',''..vRP.format(sale)..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                                PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM VENDEU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, {name = '**ITEM VENDIDO:**', value = '[ **Item: '..vRP.itemNameList(v)..'** ][ **Quantidade: '..parseInt(amount)..'** ][ **Valor: ' ..vRP.format(sale)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                            else
                                                TriggerClientEvent('Notify',source,'negado','Você <b>não possuí</b> a quantidade informada do produto.') 
                                            end
                                        else
                                            TriggerClientEvent('Notify',source,'negado','Você <b>não pode</b> vender esse produto, porque não tem espaço na mochila para receber o pagamento.') 
                                        end
                                    else
                                        if vRP.getInventoryWeight(user_id) + vRP.getItemWeight('dinheiro') * sale <= vRP.getInventoryMaxWeight(user_id) and vRP.getRemaingSlots(user_id) >= 1 then
                                            if vRP.getInventoryItemAmount(user_id,v) >= amount then
                                                local newvault = vault - sale
                                                stock[v].amount = stock[v].amount + amount
                                                vRP.tryGetInventoryItem(user_id,v,amount)
                                                vRP.giveInventoryItem(user_id, 'dinheiro', sale)
                                                setVault(shop,newvault,source)
                                                setStock(shop,stock)
                                                TriggerClientEvent('itensNotify',source,'sucesso','Vendeu',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                                TriggerClientEvent('itensNotify',source,'sucesso','Recebeu',''..vRP.itemIndexList('dinheiro')..'',''..vRP.format(sale)..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                                PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM VENDEU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, {name = '**ITEM VENDIDO:**', value = '[ **Item: '..vRP.itemNameList(v)..'** ][ **Quantidade: '..parseInt(amount)..'** ][ **Valor: ' ..vRP.format(sale)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                            else
                                                TriggerClientEvent('Notify',source,'negado','Você <b>não possuí</b> a quantidade informada do produto.') 
                                            end
                                        else
                                            TriggerClientEvent('Notify',source,'negado','Você <b>não pode</b> vender esse produto, porque não tem espaço na mochila para receber o pagamento.') 
                                        end
                                    end
                                end
                            else
                                TriggerClientEvent('Notify',source,'negado','O logista <b>não possuí</b> saldo suficiente para comprar o seu produto.')
                            end
                        end
                    else
                        TriggerClientEvent('Notify',source,'negado','O estoque deste produto está <b>cheio</b>.')
                    end
                else
                    TriggerClientEvent('Notify',source,'negado','Você <b>não pode</b> vender esse produto aqui.')
                end
            end
        else
            TriggerClientEvent('Notify',source,'negado','Quantidade <b>inválida</b>.') 
        end
    end
end

function src.upgradeShop(item,stock,security,shop)
    local source = source
    local user_id = vRP.getUserId(source)
    local astock = getMaxStock(shop)
    local asecurity = getSecurity(shop)
    if user_id then
        if stock ~= 0 then
            if astock ~= stock then
                if stock > parseInt(astock) then
                    for k,v in pairs(config.options) do
                        if k == item then
                            if vRP.tryPayment(user_id,parseInt(v.price)) then
                                setMaxStock(shop,stock)
                                TriggerClientEvent('Notify',source,'sucesso','Upgrade instalado com <b>sucesso</b>.')
                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                            else
                                TriggerClientEvent('Notify',source,'negado','Dinheiro <b>insuficiente</b>.')   
                            end
                        end
                    end
                else
                    TriggerClientEvent('Notify',source,'negado','Não é possível dar <b>downgrade</b> em suas melhorias.')
                end
            else
                TriggerClientEvent('Notify',source,'negado','Esse upgrade já está <b>instalado</b>.')    
            end
        elseif security ~= 0 then
            if asecurity ~= security then
                if security > asecurity then
                    for k,v in pairs(config.options) do
                        if k == item then
                            if vRP.tryPayment(user_id,parseInt(v.price)) then
                                setSecurity(shop,security)
                                TriggerClientEvent('Notify',source,'sucesso','Upgrade instalado com <b>sucesso</b>.')
                                TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                            else
                                TriggerClientEvent('Notify',source,'negado','Dinheiro <b>insuficiente</b>.')   
                            end
                        end
                    end
                else
                    TriggerClientEvent('Notify',source,'negado','Não é possível dar <b>downgrade</b> em suas melhorias.')
                end
            else
                TriggerClientEvent('Notify',source,'negado','Esse upgrade já está <b>instalado</b>.')   
            end
        end
    end
end

function src.upgradePrice(item,shop)
    local source = source
    local user_id = vRP.getUserId(source)
    local stock = getStock(shop)
    local products = stringsplit(item, ',')
    local owner = getOwner(shop)

    TriggerClientEvent('vrp_advanced_shops:close',source)

    local newprice = parseInt(vRP.prompt(source,'Qual é o novo valor do produto?', ''))
    if newprice == 0 or newprice == '' then
        TriggerClientEvent('Notify',source,'negado','Digite um valor para <b>o seu produto</b>.')         
    else
        for k,v in pairs(products) do
            if stock[v] ~= nil then
                if owner == user_id then
                    stock[v].price = newprice
                    setStock(shop,stock)
                    TriggerClientEvent('Notify',source,'sucesso','O preço de <b>'..vRP.itemNameList(item)..'</b> foi atualizado para <b>$'..vRP.format(parseInt(newprice))..'.</b>')
                    return true
                end
            end
        end
    end
end

function src.vaultRobbery(shop)
    local source = source
    local user_id = vRP.getUserId(source)
    local vault, maxvault = getVault(shop)
    local security = getSecurity(shop)
    local owner = getOwner(shop)
    local police = vRP.getUsersByPermission(config.policePermission)
    if user_id then
        if user_id ~= owner then
            for k,v in pairs(config.shops) do
                if k == shop then
                    local info = v.info
                    local alarm = 5000
                    if security == 1 then
                        alarm = 20000
                    elseif security == 2 then
                        alarm = 10000
                    elseif security == 3 then
                        alarm = 5000
                    end
                    if #police >= config.contingentPolice then
                        if timers[shop] == 0 or not timers[shop] then
                            if config.requireBomb then
                                if not vRP.tryGetInventoryItem(user_id, config.bombName, config.bombAmount) then
                                    TriggerClientEvent('Notify',source,'negado','Você não possui '..config.bombName..'', 8000)
                                    return
                                end
                            end
                            timers[shop] = 600
                            TriggerClientEvent('vrp_advanced_shops:startRobbery',source, shop, security)
                            for l,w in pairs(police) do
                                local player = vRP.getUserSource(parseInt(w))
                                SetTimeout(alarm,function()
                                    if player then
                                        async(function()
                                            local ids = idgens:gen()
                                            vRPclient.playSound(player,'Oneshot_Final','MP_MISSION_COUNTDOWN_SOUNDSET')
                                            blips[ids] = vRPclient.addBlip(player, info.x, info.y, info.z,1,59,'Alarme disparando',0.5,true)
                                            TriggerClientEvent('chatMessage',player,'911',{ 64, 64, 255 },'O roubo começou na ^1Caixa Registradora^0, dirija-se até o local e intercepte o assaltante.')
                                            SetTimeout(20000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
                                        end)
                                    end
                                end)
                            end
                        else
                            TriggerClientEvent('Notify',source,'negado','<b>Cofre vázio</b>. Tente novamente em <b>'..timers[shop]..' segundos</b>.')
                        end
                    else
                        TriggerClientEvent('Notify',source,'negado','Você <b>não pode</b> fazer isso no momento.',8000)
                    end
                end
            end
        end
    end
end

function src.paymentRobbery(shop)
    local source = source
    local user_id = vRP.getUserId(source)
    local vault, maxvault = getVault(shop)
    local security = getSecurity(shop)
    local owner = getOwner(shop)
    if user_id then
        if user_id ~= owner then
            for k,v in pairs(config.shops) do
                if k == shop then
                    local sPayment = math.random(5000,10000)
                    local mPayment = parseInt(v.robbery[2])
                    local payment = parseInt(vault)
                    if vault < mPayment then
                        payment = vault + sPayment
                        if payment > mPayment then
                            payment = mPayment
                        end
                    end
                    setVault(shop,0,source)
                    local vPayment = parseInt(payment/4)
                    vRP.giveInventoryItem(user_id,'dinheiro-sujo',vPayment)
                end
            end
        end
    end
end

function src.buyStore(shop)
    local source = source
    local user_id = vRP.getUserId(source)
    local forsale = getStatus(shop)
    if user_id then
        if forsale then
            for k,v in pairs(config.shops) do
                if k == shop then
                    local fantasyName = vRP.prompt(source,'Qual é o novo nome da sua loja?', '')
                    if fantasyName == '' or fantasyName == nil then
                        TriggerClientEvent('Notify',source,'negado','Informe um <b>nome</b> para sua loja.')
                    else
                        if vRP.tryPayment(user_id,parseInt(v.price)) then
                            purchaseShop(shop,user_id,0)
                            setFantasy(shop,fantasyName)
                            TriggerClientEvent('vrp_advanced_shops:updateBlip',source)
                            TriggerClientEvent('Notify',source,'sucesso','Você comprou essa loja por <b>$'..parseInt(v.price)..' dólares</b>.')
                        else
                            TriggerClientEvent('Notify',source,'negado','Dinheiro insuficiente.')
                        end
                    end
                end
            end
        else
            TriggerClientEvent('Notify',source,'negado','Essa loja já <b>possuí dono</b>.')
        end
    end
end

RegisterCommand('loja',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local rows = vRP.query('vRP/get_owner', { owner = user_id })
    local shop = ""
    if #rows > 0 then
        shop = rows[1].name
    end
    if user_id then
        if args[1] == 'renomear' then
            local fantasyName = vRP.prompt(source,'Qual é o novo nome da sua loja?', '')
            if fantasyName == '' or fantasyName == nil then
                TriggerClientEvent('Notify',source,'negado','Informe um <b>nome</b> para sua loja.')
            else
                local price = 50000
                local confirmation = vRP.request(source,"Deseja realmente alterar o nome da sua loja para <b>"..fantasyName..'</b> por <b>$'..price..'</b>.',30)
                if confirmation then
                    if vRP.tryPayment(user_id,parseInt(price)) then
                        setFantasy(shop,fantasyName)
                        TriggerClientEvent('vrp_advanced_shops:updateBlip',source)
                        TriggerClientEvent('Notify',source,'sucesso','Troca de nome realizada.')
                    else
                        TriggerClientEvent('Notify',source,'negado','Dinheiro insuficiente.')
                    end
                end
            end
        elseif args[1] == 'sacar' then
            local x,y,z = vRPclient.getPosition(source)
            local x2,y2,z2 = config.shops[shop].vault.position.x,config.shops[shop].vault.position.y,config.shops[shop].vault.position.z 
            local distance = dist(x,y,z,x2,y2,z2)
            if distance < 2 then
                local shopMoney = vRP.prompt(source,'Quanto deseja sacar?', '')
                local rows = vRP.query('vRP/get_vault_shop', { name = shop })
                local available = ""
                if #rows > 0 then
                    available = rows[1].vault
                end
                if string.len(shopMoney) >= 20 or parseInt(shopMoney) <= 0  or shopMoney == '' then
                    TriggerClientEvent('Notify',source,'negado','Valor inválido.')
                else
                    if parseInt(shopMoney) <= available then
                        if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("dinheiro")*parseInt(shopMoney) <= vRP.getInventoryMaxWeight(user_id) then
                            vRP.giveInventoryItem(user_id,"dinheiro",parseInt(shopMoney))
                            vRP.query('vRP/set_vault_shop', {vault = available - parseInt(shopMoney), name = shop})
                            TriggerClientEvent('Notify',source,'sucesso','Você sacou $'..shopMoney..".")
                        else
                            TriggerClientEvent('Notify',source,'negado','Espaço no inventário insuficiente.')
                        end
                    else
                        TriggerClientEvent('Notify',source,'negado','Você não possui esse dinheiro no cofre.')
                    end
                end
            else
                TriggerClientEvent('Notify',source,'negado','Você está longe do cofre da sua loja.')
            end
        elseif args[1] == 'vender' then
            if args[2] then
                local nuser_id = parseInt(args[2])
                if vRP.getUserSource(nuser_id) then
                    if args[3] then
                        identity = vRP.getUserIdentity(user_id)
                        if vRP.request(vRP.getUserSource(nuser_id),"Deseja comprar a loja de "..identity.name.." por: <b>$"..args[3].."</b> ?",30) then
                            if vRP.tryPayment(nuser_id,parseInt(args[3])) then
                                purchaseShop(shop,nuser_id,0)
                            else
                                TriggerClientEvent('Notify',vRP.getUserSource(nuser_id),'negado','Dinheiro insuficiente.')
                            end
                        end
                    else
                        TriggerClientEvent('Notify',source,'negado','Digite o valor que deseja vender.')
                    end

                else
                    TriggerClientEvent('Notify',source,'negado','Este jogador não está online.')
                end
            else
                TriggerClientEvent('Notify',source,'negado','Digite o ID do jogador que deseja vender.')
            end
        end
    end
end)

Citizen.CreateThread(function()
    createShop()
end)

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