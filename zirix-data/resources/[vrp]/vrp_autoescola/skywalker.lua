local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

dmv = {}
Tunnel.bindInterface("vrp_autoescola",dmv)

vRP._prepare("vRP/update_driverlicense","UPDATE vrp_user_identities SET driverlicense = @driverlicense WHERE user_id = @user_id")
vRP._prepare("vRP/get_driverlicense","SELECT user_id FROM vrp_user_identities WHERE driverlicense = @driverlicense")

local timers = {}

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

function dmv.checkTime()
    local source = source
    local user_id = vRP.getUserId(source)

    if timers[user_id] == 0 or not timers[user_id] then
        timers[user_id] = 600
        return true
    else
        TriggerClientEvent("Notify",source,"negado","Você poderá fazer o teste novamente em <b>"..timers[user_id].." segundos</b>.",8000)
        return false
    end
end

function dmv.pagamento()
    local source = source
    local user_id = vRP.getUserId(source)
    local price = 600
    if vRP.tryPayment(user_id,parseInt(price)) then
        TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$"..vRP.format(parseInt(price)).." dólares</b> no seu teste de habilitação.")
        return true
    else
        TriggerClientEvent("Notify",source,"negado","Dinheiro & saldo insuficientes.")
        return false
    end
end

function dmv.checkcarlicense()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if identity.driverlicense == 0 or identity.driverlicense == 3 then
        return true
    end
end

function dmv.givelicense()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("cnh") <= vRP.getInventoryMaxWeight(user_id) then
		if vRP.getInventoryItemAmount(user_id,"cnh") > 0 then
			TriggerClientEvent("Notify",source,"negado","Você já possui uma CNH em sua mochila.")
		else
			if vRP.tryPayment(user_id,90) then
				vRP.giveInventoryItem(user_id,"cnh",1)
				TriggerClientEvent("Notify",source,"sucesso","Sucesso, você adquiriu a segunda via da sua CNH por <b>$90 dólares</b>.")
			else
				TriggerClientEvent("Notify",source,"negado","Saldo insuficiente.")
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Sua mochila está cheia.")
	end
end

function dmv.sucesso()
    local source = source
    local user_id = vRP.getUserId(source)

    TriggerEvent("carteira",1,user_id)

    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("cnh") <= vRP.getInventoryMaxWeight(user_id) then
		if vRP.getInventoryItemAmount(user_id,"cnh") > 0 then
			TriggerClientEvent("Notify",source,"negado","Você já possui uma CNH em sua mochila.")
		else
			vRP.giveInventoryItem(user_id,"cnh",1)
		end
	else
		TriggerClientEvent("Notify",source,"negado","Mochila <b>cheia</b>.")
	end
end

RegisterCommand('aprender',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"policia.permissao") then
        if args[1] == "cnh" then
            local nplayer = vRPclient.getNearestPlayer(source,2)
            local nuser_id = vRP.getUserId(nplayer)
            local identitynu = vRP.getUserIdentity(nuser_id)

            if nplayer then
                TriggerEvent("carteira",3,nuser_id)
                TriggerClientEvent("Notify",source,"sucesso","Você apreendeu a carteira de motorista de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.")
                TriggerClientEvent("Notify",nplayer,"negado","O oficial <b>"..identity.name.." "..identity.firstname.."</b> apreendeu sua carteira de motorista.")
            else
                TriggerClientEvent("Notify",source,"negado","Não há players por perto.")
            end
        end
    end
end)

RegisterServerEvent("carteira")
AddEventHandler("carteira",function(driverlicense,user_id)
    vRP.execute("vRP/update_driverlicense", {driverlicense = driverlicense, user_id = user_id})
end)