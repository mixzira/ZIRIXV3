local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_rouboarmas",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookrouboarmas = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMASLIST
-----------------------------------------------------------------------------------------------------------------------------------------

local armalist = {
	[1] = { ['index'] = "wbody|WEAPON_ASSAULTSMG", ['qtd'] = 1, ['name'] = "MTAR-21" },
	[2] = { ['index'] = "wbody|WEAPON_ASSAULTRIFLE", ['qtd'] = 1, ['name'] = "AK-103" },
	[3] = { ['index'] = "wbody|WEAPON_GUSENBERG", ['qtd'] = 1, ['name'] = "THOMPSON" },
	[4] = { ['index'] = "wbody|WEAPON_PISTOL_MK2", ['qtd'] = 1, ['name'] = "FN FIVE SEVEN" },
	[5] = { ['index'] = "wammo|WEAPON_ASSAULTSMG", ['qtd'] = 35, ['name'] = "MUNIÇÃO DE MTAR-21" },
	[6] = { ['index'] = "wammo|WEAPON_ASSAULTRIFLE", ['qtd'] = 50, ['name'] = "MUNIÇÃO DE AK-103" },
	[7] = { ['index'] = "wammo|WEAPON_GUSENBERG", ['qtd'] = 10, ['name'] = "MUNIÇÃO DE THOMPSON" },
	[8] = { ['index'] = "wammo|WEAPON_PISTOL_MK2", ['qtd'] = 50, ['name'] = "MUNIÇÃO DE FN FIVE SEVEN" }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkRobbery(id,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 0 then
			if timers[id] == 0 or not timers[id] then
				timers[id] = 900
				TriggerClientEvent('iniciandolojadearmas',source,x,y,z)
				vRPclient._playAnim(source,false,{{"oddjobs@shop_robbery@rob_till","loop"}},true)
                TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.",8000)
                TriggerClientEvent("vrp_sound:source",source,'alarm',0.7)
                vRPclient.setStandBY(source,parseInt(60))
                for l,w in pairs(policia) do
                    local player = vRP.getUserSource(parseInt(w))
                    if player then
                        async(function()
                            local ids = idgens:gen()
                            vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
                            blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
                            TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo começou na ^1Loja de armas^0, dirija-se até o local e intercepte o assaltante.")
                            SetTimeout(20000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
                        end)
                    end
                end
				SetTimeout(50000,function()
					local randlist = math.random(100)
						if randlist >= 40 and randlist <= 100 then
							local randitem = math.random(#armalist)
							vRP.giveInventoryItem(user_id,armalist[randitem].index,armalist[randitem].qtd)
							TriggerClientEvent("Notify",source,"sucesso","Você recebeu "..armalist[randitem].qtd.."x <b>"..armalist[randitem].name.."</b>.",8000)
							SendWebhookMessage(webhookrouboarmas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n [ROUBOU]: "..armalist[randitem].qtd.." "..armalist[randitem].name.."  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
						else
							local quantidade = math.random(300,5500)
							vRP.giveInventoryItem(user_id,"dinheirosujo",quantidade)
							TriggerClientEvent("Notify",source,"sucesso","Você recebeu"..quantidade.." de DInheiro Sujo.",8000)
							SendWebhookMessage(webhookrouboarmas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n [ROUBOU]: "..quantidade.." Dinheiro sujo  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
						end
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","O seguro ainda não cobriu o ultimo assalto, aguarde <b>"..timers[id].." segundos</b> até a cobertura.",8000)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao"))
end