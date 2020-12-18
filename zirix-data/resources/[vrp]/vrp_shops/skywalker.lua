local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

shop = {}
Tunnel.bindInterface("vrp_shops",shop)

local auth = false
local customer = 'N/A'
local customerid = 'N/A'
local customeremail = 'N/A'
local customerdiscord = '<@N/A>'
local customerip = 'N/A'
local webhook = 'https://discord.com/api/webhooks/785562766949613588/RR0voR7PwiZ7w-FZwDai6JLJb7dhnRN1FJMiEgP1S_IMJTXen-xdAizHwF4gHs8EKtev'

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function shop.openNav()
	local source = source
    local user_id = vRP.getUserId(source)
    local data = vRP.getUserDataTable(user_id)

	local inventory = {}
    local accessories = {}
    local ammunation = {}
    local pub = {}
    local coffeeshop = {}
    local convenienceshop = {}
    local digitalshop = {}
    local drugshop = {}
    local toolshop = {}

    if user_id then
        if data and data.inventory then
            for k,v in pairs(data.inventory) do
                if vRP.itemBodyList(k) then
                    table.insert(inventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
                end
            end
        end

        for k,v in pairs(config.accessoriesList) do
            table.insert(accessories, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(config.ammunationList) do
            table.insert(ammunation, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(config.pubList) do
            table.insert(pub, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(config.coffeeshopList) do
            table.insert(coffeeshop, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(config.convenienceshopList) do
            table.insert(convenienceshop, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(config.digitalshopList) do
            table.insert(digitalshop, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(config.drugshopList) do
            table.insert(drugshop, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(config.toolshopList) do
            table.insert(toolshop, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        return inventory, vRP.getInventoryWeight(user_id), vRP.getInventoryMaxWeight(user_id), accessories, ammunation, pub, coffeeshop, convenienceshop, digitalshop, drugshop, toolshop
	end
end

function shop.buyItem(itemName,itemAmount)
    local source = source
    local user_id = vRP.getUserId(source)
    if itemAmount and itemAmount >= 1 then
        for k,v in pairs(accessoriesList) do
            if itemName == v.itemName then
                if itemAmount then
                    if user_id then
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.itemName)*v.itemAmount*itemAmount <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.tryPayment(user_id,parseInt(v.itemPrice*itemAmount)) then
                                vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*itemAmount))
                                TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(itemAmount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(itemAmount)).."")
                            else
                                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.")
                end
            end
        end

        for k,v in pairs(ammunationList) do
            if itemName == v.itemName then
                if itemAmount then
                    if user_id then
                        if itemName == 'wbody|WEAPON_PISTOL' or itemName == 'wammo|WEAPON_PISTOL' then
                            local identity = vRP.getUserIdentity(user_id)
                            if identity.gunlicense == 1 and vRP.getInventoryItemAmount(user_id,"portearmas") >= 1 then
                                if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.itemName)*v.itemAmount*itemAmount <= vRP.getInventoryMaxWeight(user_id) then
                                    if vRP.tryPayment(user_id,parseInt(v.itemPrice*itemAmount)) then
                                        vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*itemAmount))
                                        TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(itemAmount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(itemAmount)).."")
                                        TriggerClientEvent("Shops:UpdateInventory",source,"updateShop")
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisar ter <b>porte de armas</b>.")
                            end
                        else
                            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.itemName)*v.itemAmount*itemAmount <= vRP.getInventoryMaxWeight(user_id) then
                                if vRP.tryPayment(user_id,parseInt(v.itemPrice*itemAmount)) then
                                    vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*itemAmount))
                                    TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(itemAmount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(itemAmount)).."")
                                    TriggerClientEvent("Shops:UpdateInventory",source,"updateShop")
                                else
                                    TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
                            end
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.")
                end
            end
        end

        for k,v in pairs(pubList) do
            if itemName == v.itemName then
                if itemAmount then
                    if user_id then
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.itemName)*v.itemAmount*itemAmount <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.tryPayment(user_id,parseInt(v.itemPrice*itemAmount)) then
                                vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*itemAmount))
                                TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(itemAmount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(itemAmount)).."")
                                TriggerClientEvent("Shops:UpdateInventory",source,"updateShop")
                            else
                                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.")
                end
            end
        end

        for k,v in pairs(coffeeshopList) do
            if itemName == v.itemName then
                if itemAmount then
                    if user_id then
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.itemName)*v.itemAmount*itemAmount <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.tryPayment(user_id,parseInt(v.itemPrice*itemAmount)) then
                                vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*itemAmount))
                                TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(itemAmount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(itemAmount)).."")
                                TriggerClientEvent("Shops:UpdateInventory",source,"updateShop")
                            else
                                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.")
                end
            end
        end

        for k,v in pairs(convenienceshopList) do
            if itemName == v.itemName then
                if itemAmount then
                    if user_id then
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.itemName)*v.itemAmount*itemAmount <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.tryPayment(user_id,parseInt(v.itemPrice*itemAmount)) then
                                vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*itemAmount))
                                TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(itemAmount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(itemAmount)).."")
                                TriggerClientEvent("Shops:UpdateInventory",source,"updateShop")
                            else
                                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.")
                end
            end
        end

        for k,v in pairs(digitalshopList) do
            if itemName == v.itemName then
                if itemAmount then
                    if user_id then
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.itemName)*v.itemAmount*itemAmount <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.tryPayment(user_id,parseInt(v.itemPrice*itemAmount)) then
                                vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*itemAmount))
                                TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(itemAmount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(itemAmount)).."")
                                TriggerClientEvent("Shops:UpdateInventory",source,"updateShop")
                            else
                                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.")
                end
            end
        end

        for k,v in pairs(drugshopList) do
            if itemName == v.itemName then
                if itemAmount then
                    if user_id then
                        if vRP.tryGetInventoryItem(user_id,v.itemRequire,itemAmount) then
                            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.itemName)*v.itemAmount*itemAmount <= vRP.getInventoryMaxWeight(user_id) then
                                if vRP.tryPayment(user_id,parseInt(v.itemPrice*itemAmount)) then
                                    vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*itemAmount))
                                    TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(itemAmount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(itemAmount)).."")
                                    TriggerClientEvent("Shops:UpdateInventory",source,"updateShop")
                                else
                                    TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..itemAmount.."x "..vRP.itemNameList(v.itemRequire).."</b>.")
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.")
                end
            end
        end

        for k,v in pairs(toolshopList) do
            if itemName == v.itemName then
                if itemAmount then
                    if user_id then
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.itemName)*v.itemAmount*itemAmount <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.tryPayment(user_id,parseInt(v.itemPrice*itemAmount)) then
                                vRP.giveInventoryItem(user_id,v.itemName,parseInt(v.itemAmount*itemAmount))
                                TriggerClientEvent("itensNotify",source,"sucesso","Comprou",""..vRP.itemIndexList(v.itemName).."",""..vRP.format(parseInt(itemAmount)).."",""..vRP.format(vRP.getItemWeight(v.itemName)*parseInt(itemAmount)).."")
                                TriggerClientEvent("Shops:UpdateInventory",source,"updateShop")
                            else
                                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.")
                end
            end
        end
    else
        TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.")
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

function shop.checkAuth()
	if auth then
		return true
    end
end