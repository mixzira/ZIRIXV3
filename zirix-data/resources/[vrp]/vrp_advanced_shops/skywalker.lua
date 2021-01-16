local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

src = {}
Tunnel.bindInterface('vrp_advanced_shops',src)

local auth = false
local imageStreaming = false
local customer = 'N/A'
local customerid = 'N/A'
local customeremail = 'N/A'
local customerdiscord = '<@N/A>'
local customerip = 'N/A'
local webhook = 'https://discord.com/api/webhooks/785562766949613588/RR0voR7PwiZ7w-FZwDai6JLJb7dhnRN1FJMiEgP1S_IMJTXen-xdAizHwF4gHs8EKtev'

vRP._prepare('vRP/insert_shops','INSERT INTO vrp_shops(owner, name, security, price, forsale, stock, maxstock, vault, maxvault) VALUES(@owner, @name, @security, @price, @forsale, @stock, @maxstock, @vault, @maxvault)')
vRP._prepare('vRP/get_stock_shop','SELECT stock FROM vrp_shops WHERE name = @name')
vRP._prepare('vRP/set_stock_shop','UPDATE vrp_shops SET stock = @stock WHERE name = @name')
vRP._prepare('vRP/get_maxstock_shop','SELECT * FROM vrp_shops WHERE name = @name')
vRP._prepare('vRP/set_maxstock_shop','UPDATE vrp_shops SET maxstock = @maxstock WHERE name = @name')
vRP._prepare('vRP/get_vault_shop','SELECT * FROM vrp_shops WHERE name = @name')
vRP._prepare('vRP/set_vault_shop','UPDATE vrp_shops SET vault = @vault WHERE name = @name')
vRP._prepare('vRP/purchase_shop','UPDATE vrp_shops SET owner = @owner, forsale = @forsale WHERE name = @name')
vRP._prepare('vRP/select_shop','SELECT * FROM vrp_shops')
vRP._prepare('vRP/select_shop_name','SELECT * FROM vrp_shops WHERE name = @name')
vRP._prepare('vRP/get_security_shop','SELECT * FROM vrp_shops WHERE name = @name')
vRP._prepare('vRP/set_security_shop','UPDATE vrp_shops SET security = @security WHERE name = @name')
vRP._prepare('vRP/get_owner_shop','SELECT * FROM vrp_shops WHERE name = @name')
vRP._prepare('vRP/update_product','UPDATE vrp_shops SET stock = @stock WHERE name = @name')

function createShop()
    local rows = vRP.query('vRP/select_shop')
    for k,v in pairs(config.shops) do
      if #rows == 0 then
        vRP.execute('vRP/insert_shops', {
          ['owner'] = 0,
          ['name'] = k,
          ['security'] = v.security,
          ['price'] = v.price,
          ['forsale'] = v.forsale,
          ['stock'] = json.encode(v.stock),
          ['maxstock'] = v.maxstock,
          ['vault'] = 0,
          ['maxvault'] = v.vault.limit
        })
      end
    end
    return false
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

function getOwner(name)
    local rows = vRP.query('vRP/get_owner_shop', { name = name })
    if #rows > 0 then
        return rows[1].owner
    else
        return {}
    end
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
                        stock[v].amount = stock[v].amount - amount
                        setStock(shop,stock)
                        vRP.giveInventoryItem(user_id,v,amount)
                        TriggerClientEvent('itensNotify',source,'sucesso','- estoque',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                        TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                        PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM RETIROU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, {name = '**ITEM RETIRADO:**', value = '[ **Item: '..vRP.itemNameList(item)..'** ][ **Quantidade: '..parseInt(amount)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                    else
                        local newvault = vault + tonumber(stock[v].price) * amount
                        if vault < maxvault and newvault <= maxvault then
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
                                    if vRP.getInventoryItemAmount(user_id,v) >= amount then
                                        local newvault = vault - sale
                                        stock[v].amount = stock[v].amount + amount
                                        vRP.tryGetInventoryItem(user_id,v,amount)
                                        vRP.giveInventoryItem(user_id, 'dinheiro',sale)
                                        setVault(shop,newvault,source)
                                        setStock(shop,stock)
                                        TriggerClientEvent('itensNotify',source,'sucesso','Vendeu',''..vRP.itemIndexList(v)..'',''..vRP.format(parseInt(amount))..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                        TriggerClientEvent('itensNotify',source,'sucesso','Recebeu',''..vRP.itemIndexList('dinheiro')..'',''..vRP.format(sale)..'',''..vRP.format(vRP.getItemWeight(v)*parseInt(amount))..'')
                                        TriggerClientEvent('vrp_advanced_shops:Update',source,'updateShop')
                                        PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = 'REGISTRO DE LOJA:\n⠀', thumbnail = {url = config.webhookIcon}, fields = {{name = '**QUEM VENDEU:**', value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]'}, {name = '**ITEM VENDIDO:**', value = '[ **Item: '..vRP.itemNameList(v)..'** ][ **Quantidade: '..parseInt(amount)..'** ][ **Valor: ' ..vRP.format(sale)..'** ]\n⠀⠀'}, {name = '**LOJA:**', value = '[ **'..shop..'** ]\n⠀⠀'}}, footer = {text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
                                    else
                                        TriggerClientEvent('Notify',source,'negado','Você <b>não possuí</b> a quantidade informada do produto.') 
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
                if stock > astock then
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

    local newprice = parseInt(vRP.prompt(source,"Qual é o novo valor do produto?", ""))
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

AddEventHandler('onResourceStart',function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest('http://192.99.251.232:3501/auth/auth.json',function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest('https://api.ipify.org/',function(errorCode, resultData, resultHeaders)
                local data = json.decode(resultData1)
                for k,v in pairs(data) do
                    if k == GetCurrentResourceName() then
                        for a,b in pairs(v) do             
                            if resultData == b then
                                print('\27[32m['..GetCurrentResourceName()..'] Autenticado;')
                                auth = true
                                return
                            end
                        end
                    end            
                end
				PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = '**Atenção:** <@&748720506169196675>**!**', embeds = {{title = 'PRODUTO NÃO AUTENTICADO:\n⠀', thumbnail = {url = 'https://i.imgur.com/Y5Zktwm.png'}, fields = {{ name = '**Produto:**', value = ''..GetCurrentResourceName()..'\n⠀'}, {name = '**• DADOS DO PROPRIETÁRIO:**', value = '⠀'}, {name = '**Nome completo:**', value = ''..customer..''}, {name = '**Nº contrato:**', value = ''..customerid..''}, {name = '**E-mail:**', value = ''..customeremail..''}, {name = '**Discord:**', value = ''..customerdiscord..'\n⠀'}, {name = '**• DADOS DE REDE:**', value = '⠀'}, {name = '**IP autorizado:**', value = '` '..customerip..' `'}, {name = '**IP não autorizado:**', value = '` '..resultData..' `\n⠀'}}, footer = {text = 'ZIRAFLIX Inc. Todos os direitos reservados | '..os.date('%d/%m/%Y | %H:%M:%S'), icon_url = 'https://i.imgur.com/Y5Zktwm.png'}, color = 1975079}}}), {['Content-Type'] = 'application/json'})                    
                print('\27[31m['..GetCurrentResourceName()..'] Não autenticado! Adquira já o seu em www.ziraflix.com;')
            end)
        end)
    end
end)

AddEventHandler('onResourceStart',function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest('http://192.99.251.232:3501/image-streaming/auth.json',function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest('https://api.ipify.org/',function(errorCode, resultData, resultHeaders)
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

Citizen.CreateThread(function()
    createShop()
end)