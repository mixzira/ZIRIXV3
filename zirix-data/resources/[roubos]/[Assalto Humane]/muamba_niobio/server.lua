-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_niobio",func)
vCLIENT = Tunnel.getInterface("vrp_niobio")
local robbery = false
local timedown = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookniobio = ""
local timers = 0
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECNIOBIO
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkNiobio()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then		
		if vRP.getInventoryItemAmount(user_id,"cocaina") >= 1 and vRP.tryGetInventoryItem(user_id,"cocaina",1) then	
			return true							
		else
			TriggerClientEvent("Notify",source,"importante","Precisa de uma <b>C4</b> para explodir as portas.")
			return false
		end		
	end
end

function func.checkHacker()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then		
		if vRP.getInventoryItemAmount(user_id,"notebook") >= 1 and vRP.tryGetInventoryItem(user_id,"notebook",1) then	
			return true							
		else
			TriggerClientEvent("Notify",source,"importante","Precisa de um <b>Telefone Descartável</b> para hackear.")
			return false
		end		
	end
end

function func.sendMessageAll(message)
	if message then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,"[KSNEWS] Laboratório Humane - Nióbio:",{0, 204, 0},message)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	SendWebhookMessage(webhookniobio,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	return not (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"paisanapolicia.permissao") or vRP.hasPermission(user_id,"paisanaparamedico.permissao"))
end

function func.checkPermission2()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	return (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paisanapolicia.permissao"))
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK TIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function func.setSearchTimer()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.searchTimer(user_id,parseInt(2000))
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.callPolice(x,y,z)
	local source = source
	local policia = vRP.getUsersByPermission("policia.permissao")
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				local ids = idgens:gen()
				vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				blips[ids] = vRPclient.addBlip(player,x,y,z,161,59,"Roubo em andamento",0.5,true)
				TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo começou no ^Laboratório Humane - Nióbio^0, dirija-se até o local e intercepte o assaltante.")
				SetTimeout(30000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
			end)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPolice(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 17 then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
			return false
		elseif (os.time()-timedown) <= 21600 then
			TriggerClientEvent("Notify",source,"aviso","O Laboratório Humane - Nióbio não se recuperou do ultimo roubo, aguarde <b>"..vRP.format(parseInt((21600-(os.time()-timers)))).." segundos</b> até que o laboratório seja liberado.")
			return false
		else
			func.callPolice(x,y,z)
			return true
		end
	end	
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.startNiobio()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then		
		TriggerClientEvent("pNotify:SendNotification", -1, {text = "<div class='imagem-notificacao'></div>", layout = "bottomCenter", type = "warning", theme = "metroui", timeout = 15000})
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbers = {
	[1] = { ['place'] = "Laboratório Humane", ['seconds'] = 600, ['rewmin'] = 3800000, ['rewmax'] = 4800000 },
	[2] = { ['place'] = "Laboratório Humane", ['seconds'] = 660, ['rewmin'] = 3400000, ['rewmax'] = 4400000 },
	[3] = { ['place'] = "Laboratório Humane", ['seconds'] = 720, ['rewmin'] = 3000000, ['rewmax'] = 4000000 },
	[4] = { ['place'] = "Laboratório Humane", ['seconds'] = 780, ['rewmin'] = 2800000, ['rewmax'] = 3800000 },
	[5] = { ['place'] = "Laboratório Humane", ['seconds'] = 840, ['rewmin'] = 2600000, ['rewmax'] = 3600000 },
	[6] = { ['place'] = "Laboratório Humane", ['seconds'] = 900, ['rewmin'] = 2400000, ['rewmax'] = 3400000 }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.Start(id,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		robbery = true
		timedown = os.time()
		vCLIENT.inicioroubo(source,robbers[id].seconds,x,y,z)		
		vRPclient.setStandBY(source,parseInt(600))		
		SetTimeout(robbers[id].seconds*1000,function()
			if robbery then				
				robbery = false
				vRP.searchTimer(user_id,1800)
				vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(math.random(robbers[id].rewmin,robbers[id].rewmax)))				
			end
		end)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.pararroubo()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robbery then
			robbery = false			
		end
	end
end