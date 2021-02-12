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
src = {}
Tunnel.bindInterface("vrp_yellow",src)
vCLIENT = Tunnel.getInterface("vrp_yellow")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local timedown = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookyellow = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbers = {
	[1] = { "Yellow Jack",180,50000,220000 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 4 then
			TriggerClientEvent("Notify",source,"aviso","Sistema indisponível no momento.",8000)
			return false
		elseif (parseInt(os.time())-timedown) <= 1200 then
			TriggerClientEvent("Notify",source,"importante","Aguarde "..vRP.getMinSecs(parseInt(1200-(os.time()-timedown)))..".",8000)
			return false
		end
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobbery(id,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		robbery = true
		timedown = parseInt(os.time())
		vCLIENT.startRobbery(source,robbers[id][2],x,y,z)

		local policia = vRP.getUsersByPermission("policia.permissao")
		for k,v in pairs(policia) do
			local policial = vRP.getUserSource(v)
			if policial then
				async(function()
					vCLIENT.startRobberyPolice(policial,x,y,z,robbers[id][1])
					SendWebhookMessage(webhookyellow,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n [VANILLA]: "..robbers[id][1].."\n "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					vRPclient.playSound(policial,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
					TriggerClientEvent('chatMessage',policial,"Dispatch",{65,130,255},"O roubo começou no ^1"..robbers[id][1].."^0, dirija-se até o local e intercepte os assaltantes.")
				end)
			end
		end

		SetTimeout(robbers[id][2]*1000,function()
			if robbery then
				robbery = false
				vRP.searchTimer(user_id,1800)
				vRP.giveDinheirama( user_id,"dinheirosujo",parseInt(math.random(robbers[id][3],robbers[id][4])))

				for k,v in pairs(policia) do
					local policial = vRP.getUserSource(v)
					if policial then
						async(function()
							vCLIENT.stopRobberyPolice(policial)
							TriggerClientEvent('chatMessage',policial,"Dispatch",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
						end)
					end
				end
			end
		end)

	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.stopRobbery()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robbery then
			robbery = false
			local policia = vRP.getUsersByPermission("policia.permissao")
			for k,v in pairs(policia) do
				local policial = vRP.getUserSource(v)
				if policial then
					async(function()
						vCLIENT.stopRobberyPolice(policial)
						TriggerClientEvent('chatMessage',policial,"Dispatch",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
					end)
				end
			end
		end
	end
end