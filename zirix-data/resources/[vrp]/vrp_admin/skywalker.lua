local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPidd = {}
Tunnel.bindInterface("vrp_admin",vRPidd)
Proxy.addInterface("vrp_admin",vRPidd)
IDDclient = Tunnel.getInterface("vrp_admin")


local logAdminEstoque = "https://discordapp.com/api/webhooks/762555672033230858/LB_QDLQhfNCUSCNou1WW5FBiCpwU9KO0i3vgNfw2LQJAYcVC455TwefCfsvb6xVccvBQ"
local logAdminWhitelist = "https://discordapp.com/api/webhooks/762554515714867232/23GZxyxiWBtuyf7DipsOkrP6q8_yYGDuJcb1p59k0VhFF8f5ii2UnheAuDcUF3suLiL_"
local logAdminUnWhitelist = "https://discordapp.com/api/webhooks/762554689618837514/AFtptXD_befrUulyjeWgJd9TKXuAkVm24_0Ekg8GLZg8FTnwNGMgHklEZazpZDxni4qX"
local logAdminBan = "https://discordapp.com/api/webhooks/762554255004925963/a9jE99jV9ZzF4YT6EiLyCg--yz4m8CWBORF-RQr6aRgsMo6rCT28i6DpRGV86QDhgRk6"
local logAdminUnBan = "https://discordapp.com/api/webhooks/762554405132042240/AqPO_6bHxy4BcWTRMwu30aumHzIK9B515VbQBGgnq1f1DYO4g1cvbj9nBaSXu5M4ahG-"
local logAdminRenomear = "https://discordapp.com/api/webhooks/762555480773885964/fe7oRx9h5YNVigO2KNJ5B4lWr-rHT3EVc6GBIyG2C30ZvwBhibfrIy8Q50picvYdODRR"
local logAdminAnuncio = "https://discordapp.com/api/webhooks/762556537042108426/m3HgUVSQaBY_CVhxJ21d-_21k-qq9DIwho4DY-AwQAo2r2jjDzyJ8WCwG-mZ1RrwUSKL"
local logAdminAddcar = "https://discordapp.com/api/webhooks/762556674678063115/JyU18FJLY06xljzNDj9pslJDfnPxkxWaNn-ytgpR66sbVQSkLNrJcOXyUsn5HH04LOGz"
local logAdminRemcar = "https://discordapp.com/api/webhooks/762555827633782805/JY8rxRrARUTtacvf04eeRb_dTNJDH1VuRbq4VUuyIXBpwMnXwPsYWLQXgUrtVzBYgHIq"
local logAdminGroup = "https://discordapp.com/api/webhooks/762556111949660183/ZzZ2DrsVT495B8X3cnErx_UxGdIrXDp6115L-0wKd7O2KxlsfffpnJDyx0gbNUebRkOi"
local logAdminUnGroup = "https://discordapp.com/api/webhooks/792849847300522014/Va1zP-AzQ3rvpuEQ_5J8c90Ln_vI5a4PWbWaM0qRtBh5NADGQAIjQtj9npXJ6WOCHT8x"
local logAdminReviver = "https://discordapp.com/api/webhooks/762556783243690051/XhWqRHss1Rvz9HxQFsr7-PWwT4csGfuxeZ_x-sLmYj2tT-5oyqq9NL5FbdiWSiNgQq2c"
local logAdminKick = "https://discordapp.com/api/webhooks/762556262021726209/WODOaaVYl3tnFOijR3Gd_PtBBpyk-aEmxiye9tsdsEgMewFDeY2cWrvVIX7QUtUUHqtd"
local logAdminFix = "https://discordapp.com/api/webhooks/762557436930031616/MWcoTnEFRBurJ0WdXflVY5dReJWhcaF7H3NZ4AVJmgv6dZa2MfZqNuvtvI2or8O9VBEv"
local logAdminNc = "https://discordapp.com/api/webhooks/762557544102625292/55kNmfE0CCANwzrMka__VRjBuiX9Ta97UmfYoS-Wv4fRO2A-aJTYKwOK-qoPPTNHb2Me"
local logAdminTps = "https://discordapp.com/api/webhooks/762557744351281165/BjV5zyQDugzkdJcacorIMtvwX-bZWVv2XjdS0I-B5eEV_on_EBeFPx8GGNbMpl31-Kom"
local logAdminOrg = "https://discordapp.com/api/webhooks/762556417701183490/ShVX6PPb3pGvsKxoFg5ARVvHqYeZJVWRpya3UYz3Ofc44A7hMseyfT6ruyjsZeIRFFSk"
local logAdmCorno = "https://discordapp.com/api/webhooks/762557852719775774/F5SGySSrV_4qBVjNNbNDUNPnrfVKGaQoCKiDlNAwBz3IoqE0UOn0hMUrU9CaR39oOph3"
local logAdmStatus = "https://discordapp.com/api/webhooks/763897002646962217/zNjezEN5f_fNvddMYvHMXf2IeuGSJ75zOgaF-jz42Xuvpr74JuBpGIc6G7rcDRWYQ8y5"

RegisterCommand('renomear',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or vRP.hasPermission(user_id, "manager.permissao") then
        local idjogador = vRP.prompt(source, "Qual id do jogador?", "")
        local nome = vRP.prompt(source, "Novo nome", "")
        local firstname = vRP.prompt(source, "Novo sobrenome", "")
        local idade = vRP.prompt(source, "Nova idade", "")
		local nuidentity = vRP.getUserIdentity(parseInt(idjogador))
		
        vRP.execute("vRP/update_user_identity",{
            user_id = idjogador,
            firstname = firstname,
            name = nome,
            age = idade,
            registration = nuidentity.registration,
            phone = nuidentity.phone
		})
		
		PerformHttpRequest(logAdminRenomear, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	------------------------------------------------------------
					title = "REGISTRO DE ALTERAÇÃO IDENTIDADE⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
					thumbnail = {
						url = "https://i.imgur.com/CtQB816.png"
					}, 
					fields = {
						{ 
							name = "**COLABORADOR DA EQUIPE:**",
							value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
						},
						{
							name = "**NOVOS DADOS DO RG:**",
							value = "**["..vRP.format(parseInt(idjogador)).."][ Nome: "..nome.." ][ Sobrenome: "..firstname.." ][ Idade: "..idade.." ]**\n⠀"
						}
					}, 
					footer = { 
						text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
						icon_url = "https://i.imgur.com/CtQB816.png"
					},
					color = 4402032 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
    end
end)

local player_customs = {}
RegisterCommand('vroupas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local custom = vRPclient.getCustomization(source)
	
    if vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
        if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source,"customization")
        else 
			local content = ""
			
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br/>" 
            end

            player_customs[source] = true
            vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 4px; width: 250px; margin-top: 200px; margin-right: 50px; background: rgba(15,15,15,0.7); color: #ffff; font-weight: bold; }",content)
        end
    end
end)

RegisterCommand('estoque',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"manager.permissao") then
		if args[1] and args[2] then
			
			PerformHttpRequest(logAdminEstoque, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	------------------------------------------------------------
						title = "REGISTRO DE ALTERAÇÃO DE ESTOQUE⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							},
							{
								name = "**MODIFICAÇÃO DE ESTOQUE:**",
								value = "**[ Modelo: "..args[1].." ][ Quantidade: "..vRP.format(parseInt(args[2])).." ]**\n⠀"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

            vRP.execute("losanjos/set_estoque",{ vehicle = args[1], quantidade = args[2] })
            TriggerClientEvent("Notify",source,"sucesso","Voce colocou mais <b>"..args[2].."</b> no estoque, para o carro <b>"..args[1].."</b>.") 
        end
    end
end)

RegisterCommand('addcar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserId(parseInt(args[2]))
	
    if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
			local identitynu = vRP.getUserIdentity(nuser_id)
			
			PerformHttpRequest(logAdminAddcar, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	------------------------------------------------------------
						title = "REGISTRO DE CARRO ADICIONADO A PLAYER⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							},
							{
								name = "**INFORMAÇÕES:**",
								value = "**[ Modelo: "..args[1].." ][ Player ID: "..args[2].." ]**\n⠀"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

            vRP.execute("losanjos/add_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) })
            TriggerClientEvent("Notify",source,"sucesso","Voce adicionou o veículo <b>"..args[1].."</b> para o Passaporte: <b>"..parseInt(args[2]).."</b>.")
        end
    end
end)

RegisterCommand('remcar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserId(parseInt(args[2]))
	
    if vRP.hasPermission(user_id,"manager.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
			local identitynu = vRP.getUserIdentity(nuser_id)
			
			PerformHttpRequest(logAdminRemcar, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	------------------------------------------------------------
						title = "REGISTRO DE CARRO REMOVIDO DE PLAYER⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							},
							{
								name = "**INFORMAÇÕES:**",
								value = "**[ Modelo: "..args[1].." ][ Player ID: "..args[2].." ]**\n⠀"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

            vRP.execute("losanjos/rem_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time())  }) 
            TriggerClientEvent("Notify",source,"sucesso","Voce removeu o veículo <b>"..args[1].."</b> do Passaporte: <b>"..parseInt(args[2]).."</b>.")
        end
    end
end)

RegisterCommand('uncuff',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
			TriggerClientEvent("admcuff",source)
		end
	end
end)

RegisterCommand('limpararea',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
        TriggerClientEvent("syncarea",-1,x,y,z)
    end
end)

RegisterCommand('apagao',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") and args[1] ~= nil then
            local cond = tonumber(args[1])
            --TriggerEvent("cloud:setApagao",cond)
            TriggerClientEvent("cloud:setApagao",-1,cond)                    
        end
    end
end)

RegisterCommand('raios', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") and args[1] ~= nil then
            local vezes = tonumber(args[1])
            TriggerClientEvent("cloud:raios",-1,vezes)           
        end
    end
end)

RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("skinmenu",nplayer,args[2])
                TriggerClientEvent("Notify",source,"sucesso","Voce setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.")
            end
        end
    end
end)

RegisterCommand('debug',function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
			TriggerClientEvent("ToggleDebug",player)
		end
	end
end)

RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
    TriggerClientEvent("syncdeleteobj",-1,index)
end)

RegisterCommand('fix',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local vehicle = vRPclient.getNearestVehicle(source,11)
	if vehicle then
		if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
			
			PerformHttpRequest(logAdminFix, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	------------------------------------------------------------
						title = "REGISTRO DE FIX⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032
					}
				}
			}), { ['Content-Type'] = 'application/json' })
			
			TriggerClientEvent('reparar',source)
		end
	end
end)

RegisterCommand('reviver',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
        if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				local identitynu = vRP.getUserIdentity(nuser_id)

				PerformHttpRequest(logAdminReviver, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	
							title = "REGISTRO DE REVIVER⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
							thumbnail = {
								url = "https://i.imgur.com/CtQB816.png"
							}, 
							fields = {
								{ 
									name = "**COLABORADOR DA EQUIPE:**",
									value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
								},
								{
									name = "**INFORMAÇÕES DO PLAYER REVIVIDO:**",
									value = "**"..identitynu.name.." "..identitynu.firstname.."** [**"..nuser_id.."**]\n⠀"
								}
							}, 
							footer = { 
								text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
								icon_url = "https://i.imgur.com/CtQB816.png"
							},
							color = 4402032 
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				TriggerClientEvent("resetBleeding",nplayer)
                TriggerClientEvent("resetDiagnostic",nplayer)

                vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,400)
				vRP.varyThirst(nplayer,-15)
				vRP.varyHunger(nplayer,-15)
            end
		else
			PerformHttpRequest(logAdminReviver, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	
						title = "REGISTRO DE REVIVER⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			TriggerClientEvent("resetBleeding",source)
            TriggerClientEvent("resetDiagnostic",source)

            vRPclient.killGod(source)
			vRPclient.setHealth(source,400)
			vRP.varyThirst(source,-100)
			vRP.varyHunger(source,-100)
        end
    end
end)

RegisterCommand('reviverall',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
    	local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
            	TriggerClientEvent("resetBleeding",id)
            	TriggerClientEvent("resetDiagnostic",id)
            	vRPclient.killGod(id)
				vRPclient.setHealth(id,400)
            end
		end
		
		PerformHttpRequest(logAdminReviver, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	
					title = "REGISTRO DE REVIVER TODOS⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
					thumbnail = {
						url = "https://i.imgur.com/CtQB816.png"
					}, 
					fields = {
						{ 
							name = "**COLABORADOR DA EQUIPE:**",
							value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
						}
					}, 
					footer = { 
						text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
						icon_url = "https://i.imgur.com/CtQB816.png"
					},
					color = 4402032 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterCommand('hash',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"manager.permissao") then
		TriggerClientEvent('vehash',source)
	end
end)

RegisterCommand('tuning',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		TriggerClientEvent('vehtuning',source)
	end
end)

RegisterCommand('wl',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id) 
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"aprovador-wl.permissao") then
		if args[1] then
			
			PerformHttpRequest(logAdminWhitelist, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	
						title = "NOVO ID ADICIONADO A WHITELIST⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							},
							{
								name = "**ID ADICIONADO: **"..vRP.format(parseInt(args[1])),
								value = "⠀"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

            vRP.setWhitelisted(parseInt(args[1]),true)
            TriggerClientEvent("Notify",source,"sucesso","Você aprovou o passaporte <b>"..args[1].."</b> na whitelist.")
        end
    end
end)

RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		if args[1] then

			PerformHttpRequest(logAdminUnWhitelist, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "ID REMOVIDO DA WHITELIST⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							},
							{
								name = "**ID REMOVIDO: **"..vRP.format(parseInt(args[1])),
								value = "⠀"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			vRP.setWhitelisted(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Você retirou o passaporte <b>"..args[1].."</b> da whitelist.")
		end
	end
end)

RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then

				PerformHttpRequest(logAdminKick, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	
							title = "REGISTRO DE KICK⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
							thumbnail = {
								url = "https://i.imgur.com/CtQB816.png"
							}, 
							fields = {
								{ 
									name = "**COLABORADOR DA EQUIPE:**",
									value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
								},
								{
									name = "**ID KIKADO: **"..vRP.format(parseInt(args[1])),
									value = "⠀"
								}
							}, 
							footer = { 
								text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
								icon_url = "https://i.imgur.com/CtQB816.png"
							},
							color = 4402032 
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				vRP.kick(id,"Você foi expulso da cidade.")
				TriggerClientEvent("Notify",source,"sucesso","Voce kickou o passaporte <b>"..args[1].."</b> da cidade.")
			end
		end
	end
end)

RegisterCommand('kickall',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
        local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
                vRP.kick(id,"Você foi vitima do terremoto.")
            end
		end
		
		PerformHttpRequest(logAdminKick, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	
					title = "REGISTRO DE KICKAR TODOS⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
					thumbnail = {
						url = "https://i.imgur.com/CtQB816.png"
					}, 
					fields = {
						{ 
							name = "**COLABORADOR DA EQUIPE:**",
							value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
						}
					}, 
					footer = { 
						text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
						icon_url = "https://i.imgur.com/CtQB816.png"
					},
					color = 4402032 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterCommand('ban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		if args[1] then
			local nuser_id = vRP.getUserSource(parseInt(args[1]))

			PerformHttpRequest(logAdminBan, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE BANIMENTO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							},
							{
								name = "**ID BANIDO: **"..vRP.format(parseInt(args[1])),
								value = "⠀"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			vRP.setBanned(parseInt(args[1]),true)
			vRP.kick(nuser_id,"Você foi banido! [ Mais informações em: discord.gg/diamondcity ]")

			TriggerClientEvent("Notify",source,"sucesso","Voce baniu o passaporte <b>"..args[1].."</b> da cidade.")
		end
	end
end)

RegisterCommand('unban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		if args[1] then

			PerformHttpRequest(logAdminUnBan, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE DESBANIMENTO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							},
							{
								name = "**ID DESBANIDO: **"..vRP.format(parseInt(args[1])),
								value = "⠀"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			vRP.setBanned(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Voce desbaniu o passaporte <b>"..args[1].."</b> da cidade.")
		end
	end
end)

RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if vRP.hasPermission(user_id, "lider-corretor.permissao") or vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		
		PerformHttpRequest(logAdminNc, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	
					title = "REGISTRO DE NC⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
					thumbnail = {
						url = "https://i.imgur.com/CtQB816.png"
					}, 
					fields = {
						{ 
							name = "**COLABORADOR DA EQUIPE:**",
							value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
						}
					}, 
					footer = { 
						text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
						icon_url = "https://i.imgur.com/CtQB816.png"
					},
					color = 4402032
				}
			}
		}), { ['Content-Type'] = 'application/json' })
		
		vRPclient.toggleNoclip(source)
	end
end)

RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)

RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		heading = GetEntityHeading(GetPlayerPed(-1))
		vRP.prompt(source,"Cordenadas:","['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
	end
end)

RegisterCommand('cds2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:",tD(x)..", "..tD(y)..", "..tD(z))
	end
end)

RegisterCommand('cds3',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:","{name='ATM', id=277, x="..tD(x)..", y="..tD(y)..", z="..tD(z).."},")
	end
end)

RegisterCommand('cds4',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:","x = "..tD(x)..", y = "..tD(y)..", z = "..tD(z))
	end
end)

RegisterCommand('group',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		if args[1] and args[2] then
			vRP.addUserGroup(parseInt(args[1]),args[2])
			
			TriggerClientEvent("Notify",source,"sucesso","Voce setou o passaporte <b>"..parseInt(args[1]).."</b> no grupo <b>"..args[2].."</b>.")

			PerformHttpRequest(logAdminGroup, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE GROUP:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							},
							{
								name = "**ID & GROUP: **",
								value = "**"..args[1].." no grupo: "..args[2].."**"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			TriggerClientEvent("oc_gps:coords", nplayer)
		end
	end
end)

RegisterCommand('ungroup',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		if args[1] and args[2] then
			vRP.removeUserGroup(parseInt(args[1]),args[2])

			TriggerClientEvent("Notify",source,"sucesso","Voce removeu o passaporte <b>"..parseInt(args[1]).."</b> do grupo <b>"..args[2].."</b>.")

			PerformHttpRequest(logAdminUnGroup, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE UNGROUP:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
						thumbnail = {
							url = "https://i.imgur.com/CtQB816.png"
						}, 
						fields = {
							{ 
								name = "**COLABORADOR DA EQUIPE:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
							},
							{
								name = "**ID & GROUP: **",
								value = "**"..args[1].." retirou o grupo: "..args[2].."**"
							}
						}, 
						footer = { 
							text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
							icon_url = "https://i.imgur.com/CtQB816.png"
						},
						color = 4402032 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			TriggerClientEvent("oc_gps:coords", nplayer)
		end
	end
end)

RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then

				PerformHttpRequest(logAdminTps, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	------------------------------------------------------------
							title = "REGISTRO DE TPTOME⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
							thumbnail = {
								url = "https://i.imgur.com/CtQB816.png"
							}, 
							fields = {
								{ 
									name = "**COLABORADOR:**",
									value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
								},
								{ 
									name = "**ID DO PLAYER PUXADO: **"..args[1],
									value = "⠀"
								}
							}, 
							footer = { 
								text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
								icon_url = "https://i.imgur.com/CtQB816.png"
							},
							color = 4402032
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				vRPclient.teleport(tplayer,x,y,z)
			end
		end
	end
end)

RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				PerformHttpRequest(logAdminTps, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	------------------------------------------------------------
							title = "REGISTRO DE TPTO⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
							thumbnail = {
								url = "https://i.imgur.com/CtQB816.png"
							}, 
							fields = {
								{ 
									name = "**COLABORADOR:**",
									value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
								},
								{ 
									name = "**ID DO PLAYER: **"..args[1],
									value = "⠀"
								}
							}, 
							footer = { 
								text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
								icon_url = "https://i.imgur.com/CtQB816.png"
							},
							color = 4402032
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
			end
		end
	end
end)

RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		
		PerformHttpRequest(logAdminTps, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	------------------------------------------------------------
					title = "REGISTRO DE TPWAY⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
					thumbnail = {
						url = "https://i.imgur.com/CtQB816.png"
					}, 
					fields = {
						{ 
							name = "**COLABORADOR:**",
							value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
						}
					}, 
					footer = { 
						text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
						icon_url = "https://i.imgur.com/CtQB816.png"
					},
					color = 4402032
				}
			}
		}), { ['Content-Type'] = 'application/json' })

		TriggerClientEvent('tptoway',source)
	end
end)

RegisterCommand('delnpcs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		TriggerClientEvent('delnpcs',source)
	end
end)

RegisterCommand('pon',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        local users = vRP.getUsers()
        local players = ""
		local quantidade = 0
		
        for k,v in pairs(users) do
            if k ~= #users then
                players = players
			end
			
            players = players.." "..k
            quantidade = quantidade + 1
		end
		
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{255,160,0},quantidade)
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{255,160,0},players)
    end
end)

RegisterCommand('org',function(source,args,rawCommand)
	if args[1] then
		local source = source
		local contratado = vRP.prompt(source, "Passaporte:", "")
		local idcontratado = parseInt(contratado)
		if contratado ~= "" then
			local org = vRP.prompt(source, "Cargo:", "")
			if org ~= "" then
				if args[1] == "add" then
					local user_id = vRP.getUserId(source)
					local identity = vRP.getUserIdentity(user_id)
					if org == "orgdone" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdone.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgdone")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgdtwo" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdtwo.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgdtwo")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgdthree" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdthree.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgdthree")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgdfour" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdfour.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgdfour")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgdfive" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdfive.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgdfive")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgdsix" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdsix.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgdsix")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orggone" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orggone.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orggone")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orggtwo" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orggtwo.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orggtwo")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgmone" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgmone.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgmone")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgmtwo" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgmtwo.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgmtwo")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgmthree" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgmthree.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgmthree")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgcone" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgcone.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgcone")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgctwo" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgctwo.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,"orgctwo")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "diretor-geral" or org == "diretor-auxiliar" or org == "medico-chefe" or org == "medico-cirurgiao" or org == "medico-aulixiar" or org == "medico" or org == "paramedico" or org == "residente" or org == "socorrista" or org == "estagiario" or org == "ems" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"diretor-geral.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "chefe-policia" or org == "sub-chefe-policia" or org == "inspetor" or org == "capitao" or org == "tenente" or org == "sub-tenente" or org == "primeiro-sargento" or org == "segundo-sargento" or org == "agente-policia" or org == "recruta-policia" or org == "policia" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"chefe-policia") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "juiz" or org == "procurador" or org == "promotor" or org == "defensor" or org == "advogado" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"juiz.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "corretor" or org == "visitante" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-corretor.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "taxista" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-taxista.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "mecanico" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-mecanico.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.addUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					end

					PerformHttpRequest(logAdminOrg, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 
								title = "REGISTRO DE CONTRATAÇÃO ORG⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
								thumbnail = {
									url = "https://i.imgur.com/CtQB816.png"
								}, 
								fields = {
									{ 
										name = "**LÍDER:**",
										value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
									},
									{ 
										name = "**INFORMAÇÕES DA CONTRATAÇÃO:**",
										value = "**[ ID Contratado: "..idcontratado.." ][ Cargo: "..org.." **]\n⠀"
									}
								}, 
								footer = { 
									text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
									icon_url = "https://i.imgur.com/CtQB816.png"
								},
								color = 4402032
							}
						}
					}), { ['Content-Type'] = 'application/json' })

				elseif args[1] == "rem" then
					local user_id = vRP.getUserId(source)
					local identity = vRP.getUserIdentity(user_id)

					if org == "orgdone" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdone.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgdone")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgdtwo" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdtwo.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgdtwo")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgdthree" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdthree.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgdthree")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgdfour" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdfour.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgdfour")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgdfive" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdfive.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgdfive")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgdsix" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgdsix.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgdsix")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orggone" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orggone.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orggone")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orggtwo" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orggtwo.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orggtwo")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgmone" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgmone.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgmone")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgmtwo" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgmtwo.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgmtwo")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgmthree" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgmthree.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgmthree")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgcone" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgcone.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgcone")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "orgctwo" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-orgctwo.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,"orgctwo")
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "diretor-geral" or org == "diretor-auxiliar" or org == "medico-chefe" or org == "medico-cirurgiao" or org == "medico-aulixiar" or org == "medico" or org == "paramedico" or org == "residente" or org == "socorrista" or org == "estagiario" or org == "ems" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"diretor-geral.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "chefe-policia" or org == "sub-chefe-policia" or org == "inspetor" or org == "capitao" or org == "tenente" or org == "sub-tenente" or org == "primeiro-sargento" or org == "segundo-sargento" or org == "agente-policia" or org == "recruta-policia" or org == "policia" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"chefe-policia") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "juiz" or org == "procurador" or org == "promotor" or org == "defensor" or org == "advogado" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"juiz.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "corretor" or org == "visitante" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-corretor.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "taxista" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-taxista.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					elseif org == "mecanico" then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id,"lider-mecanico.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
							vRP.removeUserGroup(idcontratado,org)
						else
							TriggerClientEvent("Notify",source,"negado","Permissão <b>negada</b>!")	
						end
					end

					PerformHttpRequest(logAdminOrg, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 
								title = "REGISTRO DE DEMISSÃO ORG⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
								thumbnail = {
									url = "https://i.imgur.com/CtQB816.png"
								}, 
								fields = {
									{ 
										name = "**LÍDER:**",
										value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
									},
									{ 
										name = "**INFORMAÇÕES DA DEMISSÃO:**",
										value = "**[ ID Contratado: "..idcontratado.." ][ Cargo: "..org.." **]\n⠀"
									}
								}, 
								footer = { 
									text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
									icon_url = "https://i.imgur.com/CtQB816.png"
								},
								color = 4402032
							}
						}
					}), { ['Content-Type'] = 'application/json' })
				end
			else
				TriggerClientEvent("Notify",source,"negado","Cargo <b>inválido</b> ou <b>inexistente</b>.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Passaporte <b>inválido</b> ou <b>inexistente</b>.")
		end
	end
end)

function vRPidd.getPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		return true
	else
		return false
	end
end

RegisterCommand('ids',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		TriggerClientEvent("mostrarid",source)
	end
end)

function vRPidd.logID()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)

	PerformHttpRequest(logAdmCorno, function(err, text, headers) end, 'POST', json.encode({
		embeds = {
			{ 	
				title = "REGISTRO DE ID VISIVEL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
				thumbnail = {
				url = "https://i.imgur.com/CtQB816.png"
				}, 
				fields = {
					{ 
						name = "**COLABORADOR DA EQUIPE:**", 
						value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
					},
					{ 
						name = "**LOCAL: "..tD(x)..", "..tD(y)..", "..tD(z).."**",
						value = "⠀"
					}
				}, 
				footer = { 
					text = "DIAMOND"..os.date("%d/%m/%Y |: %H:%M:%S"), 
					icon_url = "https://i.imgur.com/CtQB816.png" 
				},
				color = 4402032 
			}
		}
	}), { ['Content-Type'] = 'application/json' })
end

RegisterCommand('staff',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = nil
	local status = nil

	if vRP.hasPermission(user_id,"manager.permissao") then
		cargo = "Manager"
		status = "Saiu do modo administrativo."
		vRP.addUserGroup(user_id,"off-manager")
		TriggerClientEvent("Notify",source,"negado","<b>[MANAGER]</b> OFF.")

	elseif vRP.hasPermission(user_id,"off-manager.permissao") then
		cargo = "Manager"
		status = "Entrou no modo administrativo."
		vRP.addUserGroup(user_id,"manager")
		TriggerClientEvent("Notify",source,"sucesso","<b>[MANAGER]</b> ON.")

	elseif vRP.hasPermission(user_id,"administrador.permissao") then
		cargo = "Administrador"
		status = "Saiu do modo administrativo."
		vRP.addUserGroup(user_id,"off-administrador")
		TriggerClientEvent("Notify",source,"negado","<b>[ADMINISTRADOR]</b> OFF.")

	elseif vRP.hasPermission(user_id,"off-administrador.permissao") then
		cargo = "Administrador"
		status = "Entrou no modo administrativo."
		vRP.addUserGroup(user_id,"administrador")
		TriggerClientEvent("Notify",source,"sucesso","<b>[ADMINISTRADOR]</b> ON.")

	elseif vRP.hasPermission(user_id,"moderador.permissao") then
		cargo = "Moderador"
		status = "Saiu do modo administrativo."
		vRP.addUserGroup(user_id,"off-moderador")
		TriggerClientEvent("Notify",source,"negado","<b>[MODERADOR]</b> OFF.")

	elseif vRP.hasPermission(user_id,"off-moderador.permissao") then
		cargo = "Moderador"
		status = "Entrou no modo administrativo."
		vRP.addUserGroup(user_id,"moderador")
		TriggerClientEvent("Notify",source,"sucesso","<b>[MODERADOR]</b> ON.")

	elseif vRP.hasPermission(user_id,"suporte.permissao") then
		cargo = "Suporte"
		status = "Saiu do modo administrativo."
		vRP.addUserGroup(user_id,"off-suporte")
		TriggerClientEvent("Notify",source,"negado","<b>[SUPORTE]</b> OFF.")

	elseif vRP.hasPermission(user_id,"off-suporte.permissao") then
		cargo = "Suporte"
		status = "Entrou no modo administrativo."
		vRP.addUserGroup(user_id,"suporte")
		TriggerClientEvent("Notify",source,"sucesso","<b>[SUPORTE]</b> ON.")

	end

	PerformHttpRequest(logAdmStatus, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            { 	
                title = "REGISTRO ADMINISTRATIVO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                thumbnail = {
                    url = "https://i.imgur.com/CtQB816.png"
                },
                fields = {
                    { 
                        name = "**IDENTIFICAÇÃO: "..identity.name.." "..identity.firstname.."** [**"..user_id.."**]",
                        value = "⠀"
					},
					{ 
                        name = "**CARGO: **"..cargo,
						value = "⠀",
						inline = true
					},
					{ 
                        name = "**STATUS: **"..status,
						value = "⠀",
						inline = true
                    }
                },
                footer = { 
                    text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = "https://i.imgur.com/CtQB816.png"
                },
                color = 4402032
            }
        }
    }), { ['Content-Type'] = 'application/json' })
end)

local plan = {}

RegisterCommand("plano", function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if args[1] == "add" then
		if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
			if vRP.getUserSource(tonumber(args[2])) then
				if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
					local consulta = vRP.getUData(tonumber(args[2]),"vRP:plano")
					local resultado = json.decode(consulta) or {}
					resultado.tempo = (resultado.tempo or 0)+tonumber(args[3])*1440
					plan[vRP.getUserId(source)] = resultado.tempo
					vRP.setUData(tonumber(args[2]), "vRP:plano", json.encode(resultado))
				end
			end
		end
	elseif args[1] == "info" then
		local consulta = vRP.getUData(vRP.getUserId(source),"vRP:plano")
		local resultado = json.decode(consulta) or {}
		
		resultado.tempo = resultado.tempo or 0
		resultado = resultado.tempo/1440 or 0

		TriggerClientEvent("Notify",source,"importante","<b>Dias Restantes:</b> "..math.ceil(resultado))
	end
end)

function vRPidd.getId()
	local user_id = vRP.getUserId()
	return user_id
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

local run = {}

RegisterCommand("vip", function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	local nuser_id = parseInt(args[2])
	if args[1] == "add" then
		local vip = args[3]
		if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
			if vip == "ultimate" then
				vRP.addUserGroup(nuser_id,"ultimate")
				TriggerClientEvent("Notify", source, "sucesso","ID "..args[1].." setado de Ultimate pass.")
				if vRP.getUserSource(tonumber(args[2])) then
					if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
						local consulta = vRP.getUData(tonumber(args[2]),"vRP:vip")
						local resultado = json.decode(consulta) or {}
						resultado.tempo = (resultado.tempo or 0)+tonumber(args[4])*1440
						run[vRP.getUserId(source)] = resultado.tempo
						vRP.setUData(tonumber(args[2]), "vRP:vip", json.encode(resultado))
					end
				end
			elseif 	vip == "platina" then
				vRP.addUserGroup(nuser_id,"platinum")
				TriggerClientEvent("Notify", source, "sucesso","ID "..args[1].." setado de Platina pass.")
				if vRP.getUserSource(tonumber(args[2])) then
					if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
						local consulta = vRP.getUData(tonumber(args[2]),"vRP:vip")
						local resultado = json.decode(consulta) or {}
						resultado.tempo = (resultado.tempo or 0)+tonumber(args[4])*1440
						run[vRP.getUserId(source)] = resultado.tempo
						vRP.setUData(tonumber(args[2]), "vRP:vip", json.encode(resultado))
					end
				end
			elseif 	vip == "ouro" then
				vRP.addUserGroup(nuser_id,"gold")
				TriggerClientEvent("Notify", source, "sucesso","ID "..args[1].." setado de Ouro pass.")
				if vRP.getUserSource(tonumber(args[2])) then
					if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
						local consulta = vRP.getUData(tonumber(args[2]),"vRP:vip")
						local resultado = json.decode(consulta) or {}
						resultado.tempo = (resultado.tempo or 0)+tonumber(args[4])*1440
						run[vRP.getUserId(source)] = resultado.tempo
						vRP.setUData(tonumber(args[2]), "vRP:vip", json.encode(resultado))
					end
				end
			elseif 	vip == "standard" then
				vRP.addUserGroup(nuser_id,"standard")
				TriggerClientEvent("Notify", source, "sucesso","ID "..args[1].." setado de Standard pass.")
				if vRP.getUserSource(tonumber(args[2])) then
					if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
						local consulta = vRP.getUData(tonumber(args[2]),"vRP:vip")
						local resultado = json.decode(consulta) or {}
						resultado.tempo = (resultado.tempo or 0)+tonumber(args[4])*1440
						run[vRP.getUserId(source)] = resultado.tempo
						vRP.setUData(tonumber(args[2]), "vRP:vip", json.encode(resultado))
					end
				end

			end
		end
	elseif args[1] == "rem" then
		if vRP.getUserSource(tonumber(args[2])) then
			if vRP.hasPermission(vRP.getUserId(source),"manager.permissao") or vRP.hasPermission(vRP.getUserId(source),"administrador.permissao") then
				local consulta = vRP.getUData(tonumber(args[2]),"vRP:vip")
				local resultado = json.decode(consulta) or {}
				resultado.tempo = (resultado.tempo or 0)-tonumber(args[3])*1440
				if resultado.tempo < 0 then resultado.tempo = 0 end
				run[vRP.getUserId(source)] = resultado.tempo
				vRP.setUData(tonumber(args[2]), "vRP:vip", json.encode(resultado))
			end
		end
	elseif args[1] == "status" then
		local user_id = vRP.getUserId(source)
		local consulta = vRP.getUData(vRP.getUserId(source),"vRP:vip")
		local resultado = json.decode(consulta) or {}
		local pass = ""
		
		if vRP.hasPermission(user_id,"ultimate.permissao") then	
			pass = "Ultimate"
		elseif vRP.hasPermission(user_id,"platina.permissao") then	
			pass = "Platina"
		elseif vRP.hasPermission(user_id,"ouro.permissao") then	
			pass = "Ouro"
		elseif vRP.hasPermission(user_id,"standard.permissao") then
			pass = "Standard"
		end
		
		resultado.tempo = resultado.tempo or 0
		resultado = resultado.tempo/1440 or 0

		TriggerClientEvent("Notify",source,"importante","<b>Pass:</b> "..pass.." | <b>Dias Restantes:</b> "..math.ceil(resultado))
	end
end)

RegisterCommand('bvida',function(source,rawCommand)
	local user_id = vRP.getUserId(source)		
	vRPclient._setCustomization(source,vRPclient.getCustomization(source))
	vRP.removeCloak(source)			
end)
