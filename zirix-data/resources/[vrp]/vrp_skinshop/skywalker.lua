local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_skinshop")
vRPloja = Tunnel.getInterface("vrp_skinshop")

RegisterServerEvent("vrp_skinshop:Comprar")
AddEventHandler("vrp_skinshop:Comprar", function(preco)
    local source = source
    local user_id = vRP.getUserId(source)
    if preco then   
        if vRP.tryPayment(user_id,parseInt(preco)) then
            TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$"..vRP.format(parseInt(preco)).." dólares</b> em roupas e acessórios.")
            TriggerClientEvent('vrp_skinshop:ReceberCompra', source, true)
        else
            TriggerClientEvent("Notify",source,"negado","Dinheiro & saldo insuficientes.")
            TriggerClientEvent('vrp_skinshop:ReceberCompra', source, false)	
        end
    end
end)

