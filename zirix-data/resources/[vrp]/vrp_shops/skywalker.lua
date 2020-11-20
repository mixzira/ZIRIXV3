local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

shop = {}
Tunnel.bindInterface("vrp_shops",shop)

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local accessoriesList = {
    { itemName = 'mascara', itemPrice = 130, itemAmount = 1 },
    { itemName = 'mochila', itemPrice = 1000, itemAmount = 1 },
    { itemName = 'oculos', itemPrice = 90, itemAmount = 1 }
}

local ammunationList = {
    { itemName = 'wbody|WEAPON_SWITCHBLADE', itemPrice = 950, itemAmount = 1 },
    { itemName = 'wbody|WEAPON_KNIFE', itemPrice = 950, itemAmount = 1 },
    { itemName = 'wbody|WEAPON_PISTOL', itemPrice = 50000, itemAmount = 1 },
    { itemName = 'wammo|WEAPON_PISTOL', itemPrice = 1200, itemAmount = 30 }
}

local pubList = {
    { itemName = 'pibwassen', itemPrice = 12, itemAmount = 1 },
    { itemName = 'tequilya', itemPrice = 24, itemAmount = 1 },
    { itemName = 'patriot', itemPrice = 12, itemAmount = 1 },
    { itemName = 'blarneys', itemPrice = 25, itemAmount = 1 },
    { itemName = 'jakeys', itemPrice = 36, itemAmount = 1 },
    { itemName = 'barracho', itemPrice = 12, itemAmount = 1 },
    { itemName = 'ragga', itemPrice = 20, itemAmount = 1 },
    { itemName = 'nogo', itemPrice = 29, itemAmount = 1 },
    { itemName = 'mount', itemPrice = 29, itemAmount = 1 },
    { itemName = 'cherenkov', itemPrice = 29, itemAmount = 1 },
    { itemName = 'bourgeoix', itemPrice = 42, itemAmount = 1 },
    { itemName = 'bleuterd', itemPrice = 34, itemAmount = 1 }
}

local coffeeshopList = {
    { itemName = 'cafe', itemPrice = 8, itemAmount = 1 },
    { itemName = 'cafecleite', itemPrice = 10, itemAmount = 1 },
    { itemName = 'cafeexpresso', itemPrice = 14, itemAmount = 1 },
    { itemName = 'capuccino', itemPrice = 17, itemAmount = 1 },
    { itemName = 'frappuccino', itemPrice = 18, itemAmount = 1 },
    { itemName = 'cha', itemPrice = 9, itemAmount = 1 },
    { itemName = 'icecha', itemPrice = 9, itemAmount = 1 },
    { itemName = 'sanduiche', itemPrice = 12, itemAmount = 1 },
    { itemName = 'rosquinha', itemPrice = 9, itemAmount = 1 }
}

local convenienceshopList = {
    { itemName = 'sanduiche', itemPrice = 30, itemAmount = 1 },
    { itemName = 'rosquinha', itemPrice = 30, itemAmount = 1 },
    { itemName = 'hotdog', itemPrice = 30, itemAmount = 1 },
    { itemName = 'xburguer', itemPrice = 30, itemAmount = 1 },
    { itemName = 'chips', itemPrice = 30, itemAmount = 1 },
    { itemName = 'batataf', itemPrice = 30, itemAmount = 1 },
    { itemName = 'pizza', itemPrice = 30, itemAmount = 1 },
    { itemName = 'taco', itemPrice = 30, itemAmount = 1 },
    { itemName = 'agua', itemPrice = 30, itemAmount = 1 },
    { itemName = 'cola', itemPrice = 30, itemAmount = 1 },
    { itemName = 'sprunk', itemPrice = 30, itemAmount = 1 },
    { itemName = 'energetico', itemPrice = 30, itemAmount = 1 },
    { itemName = 'leite', itemPrice = 30, itemAmount = 1 },
    { itemName = 'barracho', itemPrice = 30, itemAmount = 1 },
    { itemName = 'patriot', itemPrice = 30, itemAmount = 1 },
    { itemName = 'pibwassen', itemPrice = 30, itemAmount = 1 }
}

local digitalshopList = {
    { itemName = 'radio', itemPrice = 300, itemAmount = 1 },
    { itemName = 'maquininha', itemPrice = 600, itemAmount = 1 },
    { itemName = 'celular', itemPrice = 800, itemAmount = 1 },
    { itemName = 'celular-pro', itemPrice = 2800, itemAmount = 1 },
    { itemName = 'plano-one', itemPrice = 150, itemAmount = 1 },
    { itemName = 'plano-three', itemPrice = 300, itemAmount = 1 },
    { itemName = 'plano-five', itemPrice = 500, itemAmount = 1 },
    { itemName = 'plano-ten', itemPrice = 1000, itemAmount = 1 }
}

local drugshopList = {
    { itemName = 'paracetamil', itemRequire = 'r-paracetamil', itemPrice = 67, itemAmount = 1 },
    { itemName = 'voltarom', itemRequire = 'r-voltarom', itemPrice = 80, itemAmount = 1 },
    { itemName = 'trandrylux', itemRequire = 'r-trandrylux', itemPrice = 95, itemAmount = 1 },
    { itemName = 'dorfrex', itemRequire = 'r-dorfrex', itemPrice = 60, itemAmount = 1 },
    { itemName = 'buscopom', itemRequire = 'r-buscopom', itemPrice = 73, itemAmount = 1 }
}

local toolshopList = {
    { itemName = 'garrafa-vazia', itemPrice = 12, itemAmount = 1 },
    { itemName = 'caixa-vazia', itemPrice = 5, itemAmount = 1 },
    { itemName = 'paninho', itemPrice = 29, itemAmount = 1 },
    { itemName = 'ponta-britadeira', itemPrice = 45, itemAmount = 1 },
    { itemName = 'repairkit', itemPrice = 45, itemAmount = 1 },
    { itemName = 'serra', itemPrice = 650, itemAmount = 1 },
    { itemName = 'pa-jardinagem', itemPrice = 100, itemAmount = 1 },
    { itemName = 'furadeira', itemPrice = 450, itemAmount = 1 },
    { itemName = 'wbody|WEAPON_HAMMER', itemPrice = 300, itemAmount = 1 },
    { itemName = 'wbody|WEAPON_CROWBAR', itemPrice = 300, itemAmount = 1 },
    { itemName = 'wbody|WEAPON_WEAPON_HATCHET', itemPrice = 300, itemAmount = 1 },
    { itemName = 'wbody|WEAPON_WHENCH', itemPrice = 300, itemAmount = 1 }
}

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

        for k,v in pairs(accessoriesList) do
            table.insert(accessories, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(ammunationList) do
            table.insert(ammunation, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(pubList) do
            table.insert(pub, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(coffeeshopList) do
            table.insert(coffeeshop, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(convenienceshopList) do
            table.insert(convenienceshop, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(digitalshopList) do
            table.insert(digitalshop, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(drugshopList) do
            table.insert(drugshop, { itemBody = v.itemName, itemIndex = vRP.itemIndexList(v.itemName), itemName = vRP.itemNameList(v.itemName), itemPrice = parseInt(v.itemPrice), itemAmount = parseInt(v.itemAmount) })
        end

        for k,v in pairs(toolshopList) do
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