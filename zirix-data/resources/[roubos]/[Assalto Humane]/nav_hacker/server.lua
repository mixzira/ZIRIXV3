local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
    { item = "registroanonimos", venda = 1500 },
    { item = "passaportefalso", venda = 1600 },
    { item = "contasemails", venda = 1300 },
    { item = "senhapaypal", venda = 1400 },
    { item = "contasteam", venda = 1350 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("hacker-vender")
AddEventHandler("hacker-vender",function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    local data = vRP.getUserDataTable(user_id)
    local quantidade = 0
    if data and data.inventory then
        for k,v in pairs(valores) do
            if item == v.item then
                for i,o in pairs(data.inventory) do
                    if i == item then
                        quantidade = o.amount
                    end
                end
                if parseInt(quantidade) > 0 then
                    if vRP.tryGetInventoryItem(user_id,v.item,quantidade) then
                        vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(v.venda*quantidade))
                        TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..quantidade.."x "..vRP.itemNameList(v.item).."</b> por <b>R$"..vRP.format(parseInt(v.venda*quantidade)).." reais</b>.")
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Não possui <b>"..vRP.itemNameList(v.item).."</b> em sua mochila.")
                end
            end
        end
    end
end)
