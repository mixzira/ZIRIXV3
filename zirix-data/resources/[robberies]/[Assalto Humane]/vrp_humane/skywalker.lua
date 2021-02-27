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
Tunnel.bindInterface("vrp_humane",func)
vCLIENT = Tunnel.getInterface("vrp_humane")

local idgens = Tools.newIDGenerator()
local blips = {}
local robbery = false
local timedown = 0

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------

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

function func.robberywebwook()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	PerformHttpRequest(config.webhookhumane, function(err, text, headers) end, 'POST', json.encode({
		embeds = {
			{ 
				title = "REGISTRO DE ASSALTO A HUMANE:",
				thumbnail = {
					url = config.image
				}, 
				fields = {
					{ 
						name = "**IDENTIFICAÇÃO DO PLAYER:**",
						value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**] \n⠀"
					},

				}, 
				footer = { 
					text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
					icon_url = config.image
				},
				color = 15906321 
			}
		}
	}), { ['Content-Type'] = 'application/json' })
end

function func.checkHacker()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then	
		if vRP.getInventoryItemAmount(user_id,config.need[1]) >= config.need[2] or vRP.getInventoryItemAmount(user_id,config.need1[1]) >= config.need[2] then	
			return true							
		else
			TriggerClientEvent("Notify",source,"importante",config.nnotify)
			return false
		end		
	end
end

function func.sendMessageAll(message)
	if message then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,config.snotify,{0, 204, 0},message)
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
	return not (vRP.hasPermission(user_id,config.permission1) or vRP.hasPermission(user_id,config.permission2) or vRP.hasPermission(user_id,config.permission3) or vRP.hasPermission(user_id,config.permission4))
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.callPolice(x,y,z)
	local source = source
	local policia = vRP.getUsersByPermission(config.permission)
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				local ids = idgens:gen()
				vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				blips[ids] = vRPclient.addBlip(player,x,y,z,161,59,"Roubo em andamento",0.5,true)
				TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo começou no ^Laboratório Humane^0, dirija-se até o local e intercepte o assaltante.")
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
		local policia = vRP.getUsersByPermission(config.permission)
		if #policia <= config.qtdpolice then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
			return false
		elseif (os.time()-timedown) <= config.time then
			TriggerClientEvent("Notify",source,"aviso","O Laboratório Humane não se recuperou do ultimo roubo, aguarde <b>"..vRP.format(parseInt((21600-(os.time()-timers)))).." segundos</b> até que o laboratório seja liberado.")
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
function func.Start(id)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	for k,v in pairs(config.itens) do
		if user_id then
			if k == 1 then
				if id == k then
					vRP.giveInventoryItem(user_id,v.item,v.qtd)
				end
			elseif k == 2 then
				if id == k then
					vRP.giveInventoryItem(user_id,v.item,v.qtd)
				end
			elseif k == 3 then				
				if id == k then
					vRP.giveInventoryItem(user_id,v.item,v.qtd)
				end
			elseif k == 4 then	
				if id == k then
					vRP.giveInventoryItem(user_id,v.item,v.qtd)
				end
			elseif k == 5 then	
				if id == k then
					vRP.giveInventoryItem(user_id,v.item,v.qtd)
				end
			elseif k == 6 then	
				if id == k then
					vRP.giveInventoryItem(user_id,v.item,v.qtd)	
				end
			elseif k == 7 then	
				if id == k then
					vRP.giveInventoryItem(user_id,v.item,v.qtd)	
				end
			elseif k == 8 then	
				if id == k then
					vRP.giveInventoryItem(user_id,v.item,v.qtd)
				end
			elseif k == 9 then	
				if id == k then
					vRP.giveInventoryItem(user_id,v.item,v.qtd)
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