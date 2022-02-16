local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

porte = {}
Tunnel.bindInterface("nav_porte",porte)

--[ mySQL ]------------------------------------------------------------------------------------------------------------------------------

vRP._prepare("vRP/update_gunlicense","UPDATE vrp_user_identities SET gunlicense = @gunlicense WHERE user_id = @user_id")
vRP._prepare("vRP/get_gunlicense","SELECT user_id FROM vrp_user_identities WHERE gunlicense = @gunlicense")

--[ AÇÃO ]-------------------------------------------------------------------------------------------------------------------------------

function porte.pagamento()
    local source = source
    local user_id = vRP.getUserId(source)
    local preco = 30000

    if preco then
        if vRP.hasPermission(user_id,"bronze.permissao") then
            desconto = math.floor(preco*20/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"prata.permissao") then
            desconto = math.floor(preco*15/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"ouro.permissao") then
            desconto = math.floor(preco*10/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"platina.permissao") then
            desconto = math.floor(preco*5/100)
            pagamento = math.floor(preco-desconto)
        else
            pagamento = math.floor(preco)
        end

        if vRP.getInventoryItemAmount(user_id,"cartaodebito") >= 1 then
            if vRP.tryPayment(user_id,parseInt(pagamento)) then
                TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b>. <b>em ( Dinheiro )</b>")
                return true
            else
                if vRP.tryDebitPayment(user_id,parseInt(pagamento)) then
                    TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b> .. <b>No ( Débito )</b>")
                    return true
                else
                    TriggerClientEvent("Notify",source,"negado","Dinheiro & saldo insuficientes.")
                    return false
                end
            end
        else
            if vRP.tryPayment(user_id,parseInt(pagamento)) then
                if preco > 0 then
                    TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b>. <b>em ( Dinheiro )</b>")
                    return true
                end
            else
                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                return false
            end
        end
    end
end

function porte.checkcarlicense()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if identity.gunlicense  == 0 or identity.gunlicense  == 3 then
        return true
    end
end

function porte.sucessoArma()
    local source = source
    local user_id = vRP.getUserId(source)
    TriggerEvent("arma",1,user_id)
end

RegisterCommand('apreender',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"dpla.permissao") then
        if args[1] == "porte" then
            local nplayer = vRPclient.getNearestPlayer(source,2)
            local nuser_id = user_id
            local identitynu = vRP.getUserIdentity(nuser_id)

            if nplayer then
                TriggerEvent("arma",3,nuser_id)
                TriggerClientEvent("Notify",source,"sucesso","Apreendeu o porte de arma de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.")
                TriggerClientEvent("Notify",nplayer,"negado","O oficial <b>"..identity.name.." "..identity.firstname.."</b> apreendeu o seu porte de arma.")
            else
                TriggerClientEvent("Notify",source,"negado","Não há players por perto.")
            end
        end
    end
end)

RegisterServerEvent("arma")
AddEventHandler("arma",function(gunlicense,user_id)
    vRP.execute("vRP/update_gunlicense", {gunlicense = gunlicense, user_id = user_id})
end)
