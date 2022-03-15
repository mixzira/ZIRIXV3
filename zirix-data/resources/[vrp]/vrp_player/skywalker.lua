local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

svPLAYER = {}
Tunnel.bindInterface("vrp_player",svPLAYER)
clPLAYER = Tunnel.getInterface("vrp_player")
local idgens = Tools.newIDGenerator()

function svPLAYER.checkChapeu()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRPclient.checkAcao(source) then
			if vRP.getInventoryItemAmount(user_id,"chapeu") >= 1 or vRP.hasPermission(user_id,"gold.permissao") or vRP.hasPermission(user_id,"platinum.permissao") or vRP.hasPermission(user_id,"ultimate.permissao") then
				return true 
			else
				TriggerClientEvent("Notify",source,"negado","Você não possui uma <b>mascara</b> em sua mochila.") 
				return false
			end
		end
	end
end

function svPLAYER.checkMascara()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRPclient.checkAcao(source) then
			if vRP.getInventoryItemAmount(user_id,"mascara") >= 1 or vRP.hasPermission(user_id,"gold.permissao") or vRP.hasPermission(user_id,"platinum.permissao") or vRP.hasPermission(user_id,"ultimate.permissao") then
				return true 
			else
				TriggerClientEvent("Notify",source,"negado","Você não possui uma <b>mascara</b> em sua mochila.") 
				return false
			end
		end
	end
end

function svPLAYER.checkOculos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRPclient.checkAcao(source) then
			if vRP.getInventoryItemAmount(user_id,"oculos") >= 1 or vRP.hasPermission(user_id,"gold.permissao") or vRP.hasPermission(user_id,"platinum.permissao") or vRP.hasPermission(user_id,"ultimate.permissao") then
				return true 
			else
				TriggerClientEvent("Notify",source,"negado","Você não possui uma <b>óculos</b> em sua mochila.") 
				return false
			end
		end
	end
end

RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"manager.permissao") then
		if args[1] and args[2] then
			local itemIndex = vRP.itemIndexList(args[1])

			if itemIndex then
				local itemName = vRP.itemNameList(args[1])
				vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))

				PerformHttpRequest(config.Item, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	------------------------------------------------------------
							title = "REGISTRO DE ITEM GERADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
							thumbnail = {
							url = config.webhookIcon
							}, 
							fields = {
								{ 
									name = "**COLABORADOR DA EQUIPE:**", 
									value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"
								},
								{
									name = "**ITEM GERADO**",
									value = "[ **Item: "..itemName.."** ][ **Quantidade: "..tonumber(args[2]).."** ]\n⠀⠀"
								}
							}, 
							footer = { 
								text = config.webhookBottomText..os.date("%d/%m/%Y |: %H:%M:%S"), 
								icon_url = config.webhookIcon 
							},
							color = config.webhookColor 
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				TriggerClientEvent("itensNotify",source,"usar","Pegou",""..itemIndex.."")
			else
				TriggerClientEvent("Notify",source,"negado","Item <b>inválido ou inexistente</b>.")
			end
		end
	end
end)

RegisterCommand('uservehs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local vehicle = vRP.query("losanjos/get_vehicle",{ user_id = parseInt(nuser_id) })
                local car_names = {}
                for k,v in pairs(vehicle) do
                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>")
                end
                car_names = table.concat(car_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Veículos de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..car_names,10000)
            end
        end
    end
end)

RegisterCommand('reskin',function(source,rawCommand)
	local user_id = vRP.getUserId(source)		
	vRPclient._setCustomization(vRPclient.getCustomization(source))		
end)

RegisterCommand('id',function(source,rawCommand)	
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(nuser_id)
		vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #d1257d; }","<div class=\"local\"><b>Passaporte:</b> ( "..vRP.format(identity.user_id).." )</div>")
		vRP.request(source,"Você deseja fechar o registro geral?",1000)
		vRPclient.removeDiv(source,"completerg")
	end
end)

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


function svPLAYER.PagamentoSalario()
	local source = source
	local user_id = vRP.getUserId(source)


	if timers[user_id] == 0 or not timers[user_id] then
		timers[user_id] = 5
		if user_id then
			for k,v in pairs(config.payments) do
				if vRP.hasPermission(user_id,v.permissao) then
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					TriggerClientEvent("Notify",source,"importante","Obrigado por colaborar com a cidade, seu salario de <b>$"..vRP.format(parseInt(v.payment)).." dólares</b> foi depositado.")
					vRP.giveBankMoney(user_id,parseInt(v.payment))
				end
			end
		end
	else
		PerformHttpRequest(config.Dumb, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	
					title = "REGISTRO DE BANIMENTO POR CHEAT:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
					thumbnail = {
						url = config.webhookIcon
					}, 
					fields = {
						{
							name = "**ID BANIDO: **"..user_id,
							value = "Banido ao tentar usar o evento de salário."
						}
					}, 
					footer = { 
						text = "Los Anjos RP - "..os.date("%d/%m/%Y | %H:%M:%S"),
						icon_url = config.webhookIcon
					},
					color = 15906321 
				}
			}
		}), { ['Content-Type'] = 'application/json' })

		vRP.setBanned(user_id,true)
		vRP.kick(source,"Você foi banido, PAU NO CU!")
	end
end

local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)

RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ultimate.permissao") or vRP.hasPermission(user_id,"platinum.permissao") or vRP.hasPermission(user_id,"gold.permissao") or vRP.hasPermission(user_id,"standard.permissao") then
        DropPlayer(source,"Voce foi desconectado por ficar ausente.")
    end
end)

RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)

RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)

RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)

RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)

RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)

local blips = {}
RegisterCommand('chamar',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	vida = vRPclient.getHealth(source)
	vRPclient._CarregarObjeto(source,"cellphone@","cellphone_call_to_text","prop_amb_phone",50,28422)
	if user_id then
		local descricao = vRP.prompt(source,"Descrição:","")
		if descricao == "" then
			vRPclient._stopAnim(source,false)
			vRPclient._DeletarObjeto(source)
			return
		end

		local x,y,z = vRPclient.getPosition(source)
		local players = {}
		local playerstwo = {}
		local playersthree = {}
		vRPclient._stopAnim(source,false)
		vRPclient._DeletarObjeto(source)
		local especialidade = false

		if args[1] == "911" then
			players = vRP.getUsersByPermission("policia.permissao")
			especialidade = "agentes do <b>departamento de policia</b>"
		elseif args[1] == "112" then
			players = vRP.getUsersByPermission("ems.permissao")
			especialidade = "colaboradores do <b>departamento médico</b>"
		elseif args[1] == "mec" then
			players = vRP.getUsersByPermission("mecanico.permissao")
			especialidade = "mecânicos"
		elseif args[1] == "taxi" then
			players = vRP.getUsersByPermission("taxista.permissao")
			especialidade = "taxistas"
		elseif args[1] == "adv" then
			players = vRP.getUsersByPermission("advogado.permissao")
			especialidade = "advogados"
		elseif args[1] == "staff" then
			players = vRP.getUsersByPermission("administrador.permissao")
			playerstwo = vRP.getUsersByPermission("moderador.permissao")
			playersthree = vRP.getUsersByPermission("manager.permissao")
			playersfour = vRP.getUsersByPermission("suporte.permissao")
			especialidade = "staff"
		end

		local adm = ""

		if especialidade == "Staff" then
			adm = "[STAFF] "
		end
		
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		
		local identitys = vRP.getUserIdentity(user_id)
		TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")

		for l,w in pairs(players) do
			local player = vRP.getUserSource(parseInt(w))
			local nuser_id = vRP.getUserId(player)
			if player and player ~= uplayer then
				async(function()
					vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
					TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},adm.."Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."], "..descricao)
					local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
					if ok then
						if not answered then
							answered = true
							local identity = vRP.getUserIdentity(nuser_id)
							TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							vRPclient._setGPS(player,x,y)
						else
							TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")
							vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
						end
					end
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
					SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end

		for l,w in pairs(playerstwo) do
			local player = vRP.getUserSource(parseInt(w))
			local nuser_id = vRP.getUserId(player)
			if player and player ~= uplayer then
				async(function()
					vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
					TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},adm.."Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."], "..descricao)
					local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
					if ok then
						if not answered then
							answered = true
							local identity = vRP.getUserIdentity(nuser_id)
							TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							vRPclient._setGPS(player,x,y)
						else
							TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")
							vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
						end
					end
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
					SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end

		for l,w in pairs(playersthree) do
			local player = vRP.getUserSource(parseInt(w))
			local nuser_id = vRP.getUserId(player)
			if player and player ~= uplayer then
				async(function()
					vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
					TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},adm.."Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."], "..descricao)
					local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
					if ok then
						if not answered then
							answered = true
							local identity = vRP.getUserIdentity(nuser_id)
							TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							vRPclient._setGPS(player,x,y)
						else
							TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")
							vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
						end
					end
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
					SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end

		for l,w in pairs(playersfour) do
			local player = vRP.getUserSource(parseInt(w))
			local nuser_id = vRP.getUserId(player)
			if player and player ~= uplayer then
				async(function()
					vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
					TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},adm.."Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."], "..descricao)
					local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
					if ok then
						if not answered then
							answered = true
							local identity = vRP.getUserIdentity(nuser_id)
							TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							vRPclient._setGPS(player,x,y)
						else
							TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")
							vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
						end
					end
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
					SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end)

RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setchapeu",source,args[1],args[2])
				end
			end
		end
	end
end)

RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmascara",source,args[1],args[2])
				end
			end
		end
	end
end)

RegisterCommand('colete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setcolete",source)
				end
			end
		end
	end
end)

RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setoculos",source,args[1],args[2])
				end
			end
		end
	end
end)

function svPLAYER.checkPassGold()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"gold.permissao") or vRP.hasPermission(user_id,"platinum.permissao") or vRP.hasPermission(user_id,"ultimate.permissao") then
		return true
	end
end

function svPLAYER.checkPassPlatinum()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"ultimate.permissao") then
		return true
	end
end

RegisterCommand('servico',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerClientEvent("Notify",source,"importante","<b>[DPDC]</b> Em serviço.")

	elseif vRP.hasPermission(user_id,"paisana-policia.permissao") then
		TriggerClientEvent("Notify",source,"importante","<b>[DPDC]</b> Fora de serviço.")

	elseif vRP.hasPermission(user_id,"ems.permissao") then
		TriggerClientEvent("Notify",source,"importante","<b>[DMDC]</b> Em serviço.")

	elseif vRP.hasPermission(user_id,"paisana-ems.permissao") then
		TriggerClientEvent("Notify",source,"importante","<b>[DMDC]</b> Fora de serviço.")

	elseif vRP.hasPermission(user_id,"taxista.permissao") then
		TriggerClientEvent("Notify",source,"importante","<b>[TAXI LTDA]</b> Em serviço.")

	elseif vRP.hasPermission(user_id,"paisana-taxista.permissao") then
		TriggerClientEvent("Notify",source,"importante","<b>[TAXI LTDA]</b> Fora de serviço.")

	elseif vRP.hasPermission(user_id,"mecanico.permissao") then
		TriggerClientEvent("Notify",source,"importante","<b>[MECÂNICA]</b> Em serviço.")

	elseif vRP.hasPermission(user_id,"paisana-mecanico.permissao") then
		TriggerClientEvent("Notify",source,"importante","<b>[MECÂNICA]</b> Fora de serviço.")

	else
		TriggerClientEvent("Notify",source,"negado","<b>[SET]</b> Inválido.")

	end
end)
