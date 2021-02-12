local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
delivery_lsd = {}

Tunnel.bindInterface("delivery_lsd",delivery_lsd)

local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function delivery_lsd.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return (vRP.hasPermission(user_id,config4.permission))
end

function delivery_lsd.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local qtd = math.random(config4.qtd[1],config4.qtd[2])
	local eqtd = math.random(config4.eqtd[1],config4.eqtd[2])
	local payment = eqtd*qtd
	if user_id then
		if vRP.getInventoryItemAmount(user_id,config4.item[1]) >= eqtd then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(config4.itens[1])*qtd <= vRP.getInventoryMaxWeight(user_id) then
				vRP.tryGetInventoryItem(user_id, config4.item[1], eqtd)
				vRP.giveInventoryItem(user_id, config4.itens[1], payment)
				TriggerClientEvent("Notify",source,"sucesso","Você recebeu "..payment.." de <b>"..config4.itens[1].."</b>.")	
				TriggerClientEvent("Notify",source,"sucesso","Você entregou "..eqtd.." de <b>"..config4.item[1].."</b>.")									
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você está sem espaço na sua mochila para receber o dinheiro.")
				return false
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem <b>"..eqtd.." "..config4.item[1].."</b>.")
		end
	end
end

local blips = {}
function delivery_lsd.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local soldado = vRP.getUsersByPermission(config4.ppermission)
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Recebemos uma denuncia de entrega de drogas, verifique o ocorrido.")
					SetTimeout(20000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end
