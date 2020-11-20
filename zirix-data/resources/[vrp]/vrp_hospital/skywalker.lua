local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONEXÕES ]------------------------------------------------------------------------------------------------------------------------------------------------------------------

Resg = {}
Tunnel.bindInterface("vrp_hospital",Resg)

--[ VARIÁVEL ]------------------------------------------------------------------------------------------------------------------------------------------------------------------

local idgens = Tools.newIDGenerator()

--[ WEBHOOK ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------

local logSistemaLaudo = "https://discordapp.com/api/webhooks/764957969972330517/MRFjuO6Mepz9_4N2OfuuttRFUdlDPjMAjIvH_uSaPeZOBlXoL5y0tln9VRxGhu7chrRi"

--[ RESGATE ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('ems', function(source,args,rawCommand)
	local source = source
 	local user_id = vRP.getUserId(source)
	 local identity = vRP.getUserIdentity(user_id)
	
	if args[1] == "info" then
		if args[2] ~= '' then
			if vRP.hasPermission(user_id,"ems.permissao") then
				if user_id then
					TriggerClientEvent('chatMessage',-1,"EMS - Informativo",{235,109,114},rawCommand:sub(9))
				end
			end
		end
	elseif args[1] == 'int' then
		if args[2] ~= '' then
			local permission = "ems.permissao"
			if vRP.hasPermission(user_id,permission) then
				local colaborador = vRP.getUsersByPermission(permission)
				for l,w in pairs(colaborador) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('chatMessage',player,"EMS - Interno | "..identity.name.." "..identity.firstname,{235,109,114},rawCommand:sub(8))
						end)
					end
				end
			end
		end
	elseif args[1] == 'pulsar' then
		local pulso = math.random(99)
		if pulso <= 33 then
			TriggerClientEvent('chatMessageProximity2',-1,source,"💙 EMS - PULSAR | Dr(a). "..identity.name.." "..identity.firstname,{69,115,235}," Pulsação forte. 👍")
		elseif pulso >= 34 and pulso <= 66 then
			TriggerClientEvent('chatMessageProximity2',-1,source,"💙 EMS - PULSAR | Dr(a). "..identity.name.." "..identity.firstname,{69,115,235}," Sem pulsação. ☠️")
		elseif pulso >= 67 then
			TriggerClientEvent('chatMessageProximity2',-1,source,"💙 EMS - PULSAR | Dr(a). "..identity.name.." "..identity.firstname,{69,115,235}," Pulsação fraca. 🩸")
		end
	elseif args [1] == nil then
		local colaboradordmla = vRP.getUsersByPermission("ems.permissao")
		local colaboradores = 0
		
		for k,v in ipairs(colaboradordmla) do
			colaboradores = colaboradores + 1
		end

		if parseInt(#colaboradordmla) == 0 then
			TriggerClientEvent("Notify",source,"importante", "Não há <b>colaboradores do departamento médico</b> em serviço no momento.")
		elseif parseInt(#colaboradordmla) == 1 then
			TriggerClientEvent("Notify",source,"importante", "Atualmente, <b>"..colaboradores.." colaborador do departamento médico</b> está em serviço.")
		elseif  parseInt(#colaboradordmla) >= 1 then
			TriggerClientEvent("Notify",source,"importante", "Atualmente, <b>"..colaboradores.." colaboradores do departamento médico</b> estão em serviço.")
		end
	end
end)

-- [ REANIMAR ] ----------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('reanimar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"ems.permissao") then
		TriggerClientEvent('reanimar',source)
	end
end)

-- [ RE ] ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('re',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"ems.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		
		if nplayer then
			if vRPclient.isInComa(nplayer) then
				local identity_user = vRP.getUserIdentity(user_id)
				local nuser_id = vRP.getUserId(nplayer)
				local identity_coma = vRP.getUserIdentity(nuser_id)
				
				local set_user = "Departamento Médico"

				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
				TriggerClientEvent("progress",source,30000,"reanimando")

				SetTimeout(30000,function()	
					vRPclient.killGod(nplayer)
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
				end)

			else
				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
		else
			TriggerClientEvent("Notify",source,"importante","Chegue mais perto do paciente.")
		end
	elseif vRP.hasPermission(user_id,"policia.permissao") then
		if Resg.checkServices() then
			if nplayer then
				if vRPclient.isInComa(nplayer) then
					local identity_user = vRP.getUserIdentity(user_id)
					local nuser_id = vRP.getUserId(nplayer)
					local identity_coma = vRP.getUserIdentity(nuser_id)
					
					local set_user = "Departmanto de Polícia"
	
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
					TriggerClientEvent("progress",source,30000,"reanimando")
					
					SetTimeout(30000,function()
						vRPclient.killGod(nplayer)
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
					end)
				else
					TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Existem membros do Departamento Médico em serviço!")
		end 
	end
end)

--[ TRATAMENTO ]----------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('tratamento',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ems.permissao") then
        local nplayer = vRPclient.getNearestPlayer(source,3)
        if nplayer then
			if not vRPclient.isComa(nplayer) then
				TriggerClientEvent("medical-tratamento",nplayer)
				TriggerClientEvent("Notify",source,"sucesso","Tentando tratar o paciente.",10000)
            end
        end
    end
end)

--[ FUNÇÕES ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------

function Resg.checkServices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dmla = vRP.getUsersByPermission("ems.permissao")
		if parseInt(#dmla) == 0 then
			return true
		end
	end
end

--[ LAUDO MÉDICO ]--------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('laudo',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id,"ems.permissao") then
		local source = source
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		
		local nomep = vRP.prompt(source, "Nome completo do paciente:", "")
		if nomep ~= "" then
			local rgp = vRP.prompt(source, "RG do paciente:", "")
			if rgp ~= "" then
				local anamnese = vRP.prompt(source, "Anamnese:", "")
				if anamnese ~= "" then
					local laudo = vRP.prompt(source, "Laudo Médico:", "")
					if laudo ~= "" then
						local receutuario = vRP.prompt(source, "Medicamento receitado:", "")

						if receutuario == "paracetamil" or receutuario == "Paracetamil"  then
							vRP.giveInventoryItem(user_id,"r-paracetamil",1)
				
						elseif receutuario == "voltarom" or receutuario == "Voltarom" then
							vRP.giveInventoryItem(user_id,"r-voltarom",1)
				
						elseif receutuario == "trandrylux" or receutuario == "Trandrylux" then
							vRP.giveInventoryItem(user_id,"r-trandrylux",1)
				
						elseif receutuario == "dorfrex" or receutuario == "Dorfrex" then
							vRP.giveInventoryItem(user_id,"r-dorfrex",1)
				
						elseif receutuario == "buscopom" or receutuario == "Buscopom"  then
							vRP.giveInventoryItem(user_id,"r-buscopom",1)
				
						end

						PerformHttpRequest(logSistemaLaudo, function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{ 	------------------------------------------------------------
									title = "LAUDO MÉDICO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
									thumbnail = {
									url = "https://i.imgur.com/CtQB816.png"
									}, 
									fields = {
										{ 
											name = "**NOME DO PACIENTE:**", 
											value = nomep.." \n⠀",
										},
										{ 
											name = "**ANAMNESE:**",
											value = anamnese.." \n⠀"
										},
										{ 
											name = "**RG DO PACIENTE:**",
											value = rgp
										},
										{ 
											name = "**LAUDO MÉDICO:**",
											value = laudo.." \n⠀"
										},
										{ 
											name = "**RECEITUÁRIO:**",
											value = receutuario.." \n⠀"
										},
										{ 
											name = "**NOME DO MÉDICO:**",
											value = identity.name.." "..identity.firstname.." \n⠀"
										}
				
									}, 
									footer = { 
										text = "DIAMOND - "..os.date("%d/%m/%Y | %H:%M:%S"), 
										icon_url = "https://i.imgur.com/CtQB816.png"
									},
									color = 15906321 
								}
							}
						}), { ['Content-Type'] = 'application/json' })
					else
						TriggerClientEvent("Notify",source,"negado","É <b>obrigatório</b> informar o laúdo médico.",10000)
					end
				else
					TriggerClientEvent("Notify",source,"negado","É <b>obrigatório</b> informar a anamnese informada pelo paciente.",10000)
				end
			else
				TriggerClientEvent("Notify",source,"negado","É <b>obrigatório</b> informar o rg do paciente.",10000)
			end
		else
			TriggerClientEvent("Notify",source,"negado","É <b>obrigatório</b> informar o nome do paciente.",10000)
		end
	end
end)

--[ LAUDO MÉDICO ]--------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('sme',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"ems.permissao") then
			if args[1] == "cadeira" then
				if args[2] == "add" then
					TriggerClientEvent("vrp_for_medic:wheelchair:spawn", source)
				elseif args[2] == "rem" then
					TriggerClientEvent("vrp_for_medic:wheelchair:delete", source)
				end
			elseif args[1] == "maca" then
				if args[2] == "add" then
					TriggerClientEvent("vrp_for_medic:stretcher:spawn", source)
				elseif args[2] == "rem" then
					TriggerClientEvent("vrp_for_medic:stretcher:delete", source)
				end
			end
		end
	end
end)

--[ RESGATE ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------