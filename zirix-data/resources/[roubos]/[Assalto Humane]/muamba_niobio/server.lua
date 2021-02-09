-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_niobio",func)
vCLIENT = Tunnel.getInterface("vrp_niobio")
local idgens = Tools.newIDGenerator()
local blips = {}
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

local item1 = false
local item2 = false
local item3 = false
local item4 = false
local item5 = false
local item6 = false
local item7 = false
local item8 = false
local item9 = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECNIOBIO
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkNiobio()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then		
		if vRP.getInventoryItemAmount(user_id,"celular") or vRP.getInventoryItemAmount(user_id,"celular")  >= 1 then	
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
		if vRP.getInventoryItemAmount(user_id,"celular") >= 1 or vRP.getInventoryItemAmount(user_id,"celular-pro") >= 1 then	
			return true							
		else
			TriggerClientEvent("Notify",source,"importante","Precisa de um <b>Celular</b> para hackear.")
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
			TriggerClientEvent("Notify",source,"aviso","O Laboratório Humane  não se recuperou do ultimo roubo, aguarde <b>"..vRP.format(parseInt((21600-(os.time()-timers)))).." segundos</b> até que o laboratório seja liberado.")
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
		--TriggerClientEvent("pNotify:SendNotification", -1, {text = "<div class='imagem-notificacao'></div>", layout = "bottomCenter", type = "warning", theme = "metroui", timeout = 15000})
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
function func.Start(id)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	for k,v in pairs(config.itens) do
		if user_id then
			if k == 1 then
				if id == k then
					if not item1 then
						vRP.giveInventoryItem(user_id,v.item,v.qtd)
						item1 = true
					else
						TriggerClientEvent("Notify",source,"negado","Armarios vazios.") 
					end
				end
			elseif k == 2 then
				if id == k then
					if not item2 then
						vRP.giveInventoryItem(user_id,v.item,v.qtd)	
						item2 = true
					else
						TriggerClientEvent("Notify",source,"negado","Armarios vazios.") 
					end
				end
			elseif k == 3 then				
				if id == k then
					if not item3 then
						vRP.giveInventoryItem(user_id,v.item,v.qtd)	
						item3 = true
					else
						TriggerClientEvent("Notify",source,"negado","Armarios vazios.") 
					end
				end
			elseif k == 4 then	
				if id == k then
					if not item4 then
						vRP.giveInventoryItem(user_id,v.item,v.qtd)
						item4 = true
					else
						TriggerClientEvent("Notify",source,"negado","Armarios vazios.") 
					end
				end
			elseif k == 5 then	
				if id == k then
					if not item5 then
						vRP.giveInventoryItem(user_id,v.item,v.qtd)	
						item5 = true
					else
						TriggerClientEvent("Notify",source,"negado","Armarios vazios.") 
					end
				end
			elseif k == 6 then	
				if id == k then
					if not item6 then
						vRP.giveInventoryItem(user_id,v.item,v.qtd)	
						item6 = true
					else
						TriggerClientEvent("Notify",source,"negado","Armarios vazios.") 
					end
				end
			elseif k == 7 then	
				if id == k then
					if not item7 then
						vRP.giveInventoryItem(user_id,v.item,v.qtd)	
						item7 = true
					else
						TriggerClientEvent("Notify",source,"negado","Armarios vazios.") 
					end
				end
			elseif k == 8 then	
				if id == k then
					if not item8 then
						vRP.giveInventoryItem(user_id,v.item,v.qtd)	
						item8 = true
					else
						TriggerClientEvent("Notify",source,"negado","Armarios vazios.") 
					end
				end
			elseif k == 9 then	
				if id == k then
					if not item9 then
						vRP.giveInventoryItem(user_id,v.item,v.qtd)	
						item9 = true
					else
						TriggerClientEvent("Notify",source,"negado","Armarios vazios.") 
					end
				end
			end
		end
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