-----------------------------------------------------------------------------------------------------------------------------------------
--[ vRP ]--------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÕES ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Resg = {}
Tunnel.bindInterface("vrp_hospital",Resg)
vDIAGNOSTIC = Tunnel.getInterface("vrp_diagnostic")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEL ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESGATE ]----------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('resgate', function(source,args,rawCommand)
 	local user_id = vRP.getUserId(source)
 	local player = vRP.getUserSource(user_id)
 	local colaboradordmla = vRP.getUsersByPermission("dmla.permissao")
 	local paramedicos = 0
	
	for k,v in ipairs(colaboradordmla) do
		paramedicos = paramedicos + 1
	end

	if parseInt(#colaboradordmla) == 0 then
		TriggerClientEvent("Notify",source,"importante", "Não há <b>colaboradores do departamento médico</b> em serviço no momento.")
	elseif parseInt(#colaboradordmla) == 1 then
		TriggerClientEvent("Notify",source,"importante", "Atualmente, <b>"..paramedicos.." colaborador do departamento médico</b> está em serviço.")
	elseif  parseInt(#colaboradordmla) >= 1 then
		TriggerClientEvent("Notify",source,"importante", "Atualmente, <b>"..paramedicos.." colaboradores do departamento médico</b> estão em serviço.")
	end

	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ 112 ]--------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('112',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"dmla.permissao") then
			if user_id then
				TriggerClientEvent('chatMessage',-1,"[ Departamento Médico ] "..identity.name.." "..identity.firstname,{255,109,80},rawCommand:sub(4))
				SendWebhookMessage(webhooksresgatechat,"**[ Departamento Médico ] "..identity.name.." "..identity.firstname..":** "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- [ PR ] -------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "dmla.permissao"
		if vRP.hasPermission(user_id,permission) then
			local colaboradordmla = vRP.getUsersByPermission(permission)
			for l,w in pairs(colaboradordmla) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,"[ DMLA Interno ] "..identity.name.." "..identity.firstname,{255,109,80},rawCommand:sub(3))
						SendWebhookMessage(webhooksresgatechat,"**[ DMLA Interno ] "..identity.name.." "..identity.firstname..":** "..rawCommand:sub(3)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- [ REANIMAR ] -------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reanimar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"ems.permissao") then
		TriggerClientEvent('reanimar',source)
	end
end)

RegisterServerEvent("reanimar:pagamento")
AddEventHandler("reanimar:pagamento",function()
	local user_id = vRP.getUserId(source)
	if user_id then
		pagamento = math.random(50,80)
		vRP.giveMoney(user_id,pagamento)
		TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..pagamento.." dólares</b> de gorjeta do americano.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- [ RE ] -------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('re',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"dmla.permissao") then
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
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent('cancelando',source,false)
				end)

			else
				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
		else
			TriggerClientEvent("Notify",source,"importante","Chegue mais perto do paciente.")
		end
	elseif vRP.hasPermission(user_id,"dpla.permissao") then
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
						TriggerClientEvent("resetBleeding",nplayer)
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
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRATAMENTO ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tratamento',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"dmla.permissao") then
        local nplayer = vRPclient.getNearestPlayer(source,3)
        if nplayer then
			if not vRPclient.isComa(nplayer) then
				TriggerClientEvent("tratamento",nplayer)
				TriggerClientEvent("Notify",source,"sucesso","Tentando tratar o paciente.",10000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function Resg.checkServices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dmla = vRP.getUsersByPermission("dmla.permissao")
		if parseInt(#dmla) == 0 then
			return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LAUDO MÉDICO ]-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('laudo',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id,"dmla.permissao") then
		local source = source
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		
		local nomep = vRP.prompt(source, "Nome completo do paciente:", "")
		local idadep = vRP.prompt(source, "Idade do paciente:", "")
		local rgp = vRP.prompt(source, "RG do paciente:", "")
		local generop = vRP.prompt(source, "Gênero do paciente:", "")
		local anamnese = vRP.prompt(source, "Anamnese:", "")
		local laudo = vRP.prompt(source, "Laudo Médico:", "")
		local retorno = vRP.prompt(source, "Data de retorno:", "")
		local data = vRP.prompt(source, "Data de atendimento:", "")
		local receutuario = vRP.prompt(source, "Medicamento receitado:", "")
		local crm = vRP.prompt(source, "CRM do médico:", "")

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

		PerformHttpRequest(webhookslaudomedico, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 
					title = "LAUDO MÉDICO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					thumbnail = {
					url = "https://i.imgur.com/Hd8OAAV.png"
					}, 
					fields = {
						{ 
							name = "**NOME DO PACIENTE:**", 
							value = nomep.." ",
							inline = true
						},
						{ 
							name = "**IDADE DO PACIENTE:**",
							value = idadep.." \n⠀",
							inline = true
						},
						{ 
							name = "**ANAMNESE:**",
							value = anamnese.." \n⠀"
						},
						{ 
							name = "**RG DO PACIENTE:**",
							value = rgp,
							inline = true
						},
						{ 
							name = "**SEXO DO PACIENTE:**",
							value = generop.." \n⠀",
							inline = true
						},
						{ 
							name = "**LAUDO MÉDICO:**",
							value = laudo.." \n⠀"
						},
						{ 
							name = "**DATA E HORA DO ATENDIMENTO:**",
							value = data,
							inline = true
						},
						{ 
							name = "**DATA DE RETORNO:**",
							value = retorno.." \n⠀",
							inline = true
						},
						{ 
							name = "**RECEITUÁRIO:**",
							value = receutuario.." \n⠀"
						},
						{ 
							name = "**NOME DO MÉDICO:**",
							value = identity.name.." "..identity.firstname,
							inline = true
						},
						{ 
							name = "**CRM:**",
							value = crm.."\n⠀",
							inline = true
						},

					}, 
					footer = { 
						text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
						icon_url = "https://i.imgur.com/Hd8OAAV.png" 
					},
					color = 16384038 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
	end
end)