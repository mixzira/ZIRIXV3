local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Api = {}
Tunnel.bindInterface(GetCurrentResourceName(), Api)




function Api.punish()
    if Config.punish == 1 then
        SetBan()
    elseif Config.punish == 2 then
        SetKick()
    elseif Config.punish == 3 then
        SetJail()
    end
end

SetBan = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({
            embeds = {
                { 
                    title = "ACESSANDO O DEVTOOLS:⠀  \n⠀",
                    thumbnail = {
                        url = Config.webhookIcon
                    }, 
                    fields = {
                        { 
                            name = "**[PUNIÇÃO:]**",
                            value = "Banido\n⠀"
                        },
                        {
                            name = "**[INFORMAÇÕES]**",
                            value = "[ ID: **"..user_id.."** ][ IP: **"..vRP.getPlayerEndpoint(source).."** ]"
                        }
                    }, 
                    footer = { 
                        text = Config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = Config.webhookIcon
                    },
                    color = Config.webhookColor 
                }
            }
        }), { ['Content-Type'] = 'application/json' })


        vRP.setBanned(source,true)
    end
end

SetKick = function()

    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({
            embeds = {
                { 
                    title = "ACESSANDO O DEVTOOLS:⠀  \n⠀",
                    thumbnail = {
                        url = Config.webhookIcon
                    }, 
                    fields = {
                        { 
                            name = "**[PUNIÇÃO:]**",
                            value = "Expulso da cidade\n⠀"
                        },
                        {
                            name = "**[INFORMAÇÕES]**",
                            value = "[ ID: **"..user_id.."** ][ IP: **"..vRP.getPlayerEndpoint(source).."** ]"
                        }
                    }, 
                    footer = { 
                        text = Config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = Config.webhookIcon
                    },
                    color = Config.webhookColor 
                }
            }
        }), { ['Content-Type'] = 'application/json' })

        vRP.kick(source,'Você foi expulso por estar utilizando o Dev Tools, não mexa nisso!')

    end

end
SetJail = function()

    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.setUData(parseInt(user_id),Config.datatableName,json.encode(parseInt(Config.timeJail)))

        PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({
            embeds = {
                { 
                    title = "ACESSANDO O DEVTOOLS:⠀  \n⠀",
                    thumbnail = {
                        url = Config.webhookIcon
                    }, 
                    fields = {
                        { 
                            name = "**[PUNIÇÃO:]**",
                            value = "Expulso da cidade e voltará direto para cadeia com "..Config.timeJail.." minutos para cumprir de pena\n⠀"
                        },
                        {
                            name = "**[INFORMAÇÕES]**",
                            value = "[ ID: **"..user_id.."** ][ IP: **"..vRP.getPlayerEndpoint(source).."** ]"
                        }
                    }, 
                    footer = { 
                        text = Config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = Config.webhookIcon
                    },
                    color = Config.webhookColor 
                }
            }
        }), { ['Content-Type'] = 'application/json' })

        vRP.kick(source,'Você foi expulso por estar utilizando o Dev Tools, não mexa nisso!')
        
    end

end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local player = vRP.getUserSource(parseInt(user_id))
	if player then
		SetTimeout(60000,function()
			local value = vRP.getUData(parseInt(user_id),Config.datatableName)
			local tempo = json.decode(value) or -1

			if tempo == -1 then
				return
			end

			if tempo > 0 then
				TriggerClientEvent('abuserjail',player,true)
				vRPclient.teleport(player,1680.1,2513.0,46.5)
				applyJail(parseInt(user_id))
			end
		end)
	end
end)

applyJail = function(jailId)
	local player = vRP.getUserSource(parseInt(jailId))
	if player then
		SetTimeout(1,function()
			local value = vRP.getUData(parseInt(jailId),Config.datatableName)
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 1 then
				TriggerClientEvent("Notify",player,"importante","Ainda vai passar <b>"..parseInt(tempo).." meses</b> preso.")
				vRP.setUData(parseInt(jailId),Config.datatableName,json.encode(parseInt(tempo)-1))
				applyJail(parseInt(jailId))
			elseif parseInt(tempo) == 0 then
				TriggerClientEvent('abuserjail',player,false)
				vRPclient.teleport(player,1850.5,2604.0,45.5)
				vRP.setUData(parseInt(jailId),Config.datatableName,json.encode(-1))
				TriggerClientEvent("Notify",player,"importante","Sua sentença terminou, esperamos não ve-lo novamente.")
			end
		end)
	end
end