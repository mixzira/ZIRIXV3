-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_stockade",src)
vCLIENT = Tunnel.getInterface("vrp_stockade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = 0
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkTimers()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"celular") >= 1 and vRP.tryGetInventoryItem(user_id,"celular",1) then -- Item necessário para hackear e pegar a loc do carro forte
			-- local policia = vRP.getUsersByPermission("policia.permissao")
			-- if #policia <= 0 then
			-- 	TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
			-- 	return false
			if parseInt(os.time()-timers) <= 1000 then
				TriggerClientEvent("Notify",source,"aviso","O sistema foi hackeado, aguarde <b>"..vRP.format(parseInt((3600-(os.time()-timers)))).." segundos</b> até que o mesmo retorne a funcionar.",8000)
				return false
			else
				timers = parseInt(os.time())
				return true
			end
		else
			TriggerClientEvent("Notify",source,"negado","Precisa de um <b>Pendrive</b> para hackear o sistema.",8000)
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkStockade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.searchTimer(user_id,900)
		vCLIENT.startStockade(source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPAR
-----------------------------------------------------------------------------------------------------------------------------------------
function src.dropSystem(x,y,z)
	TriggerEvent("DropSystem:create","dinheiro-sujo",math.random(420000,480000),x,y,z)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPAR
-----------------------------------------------------------------------------------------------------------------------------------------
function src.resetTimer()
	timers = 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARCAROCORRENCIA
-----------------------------------------------------------------------------------------------------------------------------------------
function src.markOcorrency(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(policia) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,304,3,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"Dispatch",{65,130,255},"Recebemos uma denuncia de que um ^1Carro Forte^0 está sendo interceptado.")
					SetTimeout(15000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end

function src.checkExplosive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"celular") >= 1 and vRP.tryGetInventoryItem(user_id,"celular",1) then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Precisa de uma <b>C4</b> para abrir a porta.",8000)
			return false
		end
	end
end