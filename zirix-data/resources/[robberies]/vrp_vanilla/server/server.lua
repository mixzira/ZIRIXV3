local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_vanilla",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookvanilla = ""
local webhookalertoupolicia = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if timers > 0 then
			timers = timers - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkRobbery(id,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 6 and not vRPclient.changingClothes(source) then
			if timers == 0 or not timers then
				timers = 1200
				TriggerClientEvent('iniciandovanilla',source,id,x,y,z)
				local random = math.random(100)
				if random >= 5 then
					SendWebhookMessage(webhookalertoupolicia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[ALERTA]: Polícia acionada"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.",8000)
					TriggerClientEvent("vrp_sound:source",source,'alarm',0.7)
					vRP.searchTimer(user_id, 900)
					for l,w in pairs(policia) do
						local player = vRP.getUserSource(parseInt(w))
						if player then
							async(function()
								local ids = idgens:gen()
								vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
								blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
								TriggerClientEvent('chatMessage',player,"190",{64,64,255},"O roubo começou no ^1Vanilla^0, dirija-se até o local e intercepte o assaltante.")
								SetTimeout(20000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
							end)
						end
					end
				else
					SendWebhookMessage(webhookalertoupolicia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[ALERTA]: Polícia NÃO foi acionada."..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			else
				TriggerClientEvent("Notify",source,"aviso","O seguro ainda não cobriu o último assalto, aguarde <b>"..timers.." segundos</b> até a cobertura.",8000)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
		end
	end
end

function func.giveAward()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		local randmoney = math.random(150000,175000)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu "..randmoney.."x <b>Dinheiro Sujo</b>.",8000)
		SendWebhookMessage(webhookvanilla,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n [ROUBOU]: "..randmoney.." dinheiro sujo"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		vRP.giveInventoryItem(user_id, "dinheirosujo", randmoney)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"medico.permissao") or vRP.hasPermission(user_id,"paisanapolicia.permissao") or vRP.hasPermission(user_id,"paisanamedico.permissao"))
end