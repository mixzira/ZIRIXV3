   local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

vRPN = {}
Tunnel.bindInterface('vrp_identity',vRPN)
Proxy.addInterface('vrp_identity',vRPN)

local identidade = false

function vRPN.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.getInventoryItemAmount(user_id,"identidade") >= 1 or vRP.getInventoryItemAmount(user_id,"passaporte") >= 1 then
		return true 
	else
		TriggerClientEvent("Notify",source,"negado","Você não possui um documento de identidade em sua mochila.") 
		return false
	end
end

function vRPN.Identidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)

		local groupv = vRP.getUserGroupByType(user_id,'primario')
		local groups = vRP.getUserGroupByType(user_id,'secundario')
		local cargo = vRP.getUserGroupByType(user_id,'hie')

		if groupv == '' and groups == '' and cargo == '' then
			groupv = 'Desempregado'
		end

		if groups ~= '' then
			groupv = groups
		end

		if cargo ~= '' then
			groupv = cargo
		end

		local cnh = 'Inválido'
		if identity.driverlicense == 0 then
			cnh = 'Não habilitado'
		elseif identity.driverlicense == 1 then
			cnh = 'Habilitado'
		elseif identity.driverlicense == 3 then
			cnh = 'Cassada'
		end

		if identity then
			return identity.foto,identity.name,identity.firstname,identity.user_id,identity.registration,identity.age,identity.phone,groupv,cnh
		end
	end
end

function vRPN.checkPlayer2()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)

	if nplayer then
		if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
			return true
		end
	else
		TriggerClientEvent('Notify',source,'negado','Não há pessoas por perto.',8000)
		return false
	end
end

function vRPN.checkPlayer()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)

	if nplayer then
		if vRP.getInventoryItemAmount(nuser_id,'identidade') >= 1 then
			local confirmacao = vRP.request(nplayer,"<b>"..identity.name.." "..identity.firstname.."</b> está pedindo a sua identidade.",30)
			if confirmacao then
				return true
			else
				TriggerClientEvent('Notify',source,'negado','Solicitação negada.',8000)
			end
		else
			TriggerClientEvent('Notify',source,'negado','Essa pessoa não possui um documento de identidade no inventário.',8000)
		end
	else
		TriggerClientEvent('Notify',source,'negado','Não há pessoas por perto.',8000)
		return false
	end
end

function vRPN.nuIdentidade2()
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nplayer then
		local identitynu = vRP.getUserIdentity(nuser_id)

		local cnh = 'Inválido'
		if identitynu.driverlicense == 0 then
			cnh = 'Não habilitado'
		elseif identitynu.driverlicense == 1 then
			cnh = 'Habilitado'
		elseif identitynu.driverlicense == 3 then
			cnh = 'Cassada'
		end

		if identitynu then
			return identitynu.foto,identitynu.name,identitynu.firstname,identitynu.registration,nuser_id,identitynu.age,cnh
		end
	end
end

function vRPN.nuIdentidade()
	local source = source
	local user_id = vRP.getUserId(source)
	
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)

	if nplayer then
		if vRP.getInventoryItemAmount(nuser_id,'identidade') >= 1 then
			local identitynu = vRP.getUserIdentity(nuser_id)

			local cnh = 'Inválido'
			if identitynu.driverlicense == 0 then
				cnh = 'Não habilitado'
			elseif identitynu.driverlicense == 1 then
				cnh = 'Habilitado'
			elseif identitynu.driverlicense == 3 then
				cnh = 'Cassada'
			end

			if identitynu then
				return identitynu.foto,identitynu.name,identitynu.firstname,identitynu.registration,nuser_id,identitynu.age,cnh
			end
		else
			TriggerClientEvent('Notify',source,'negado','Essa pessoa não possui um documento de identidade no inventário.',8000)
		end
	end
end

function vRPN.modifyIdentidade()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	
	if user_id then
		if vRP.getInventoryItemAmount(user_id,'passaporte') >= 1 then
			local nome = vRP.prompt(source,'Qual é o nome? ( Preencha com atençao! )', '')
			if nome ~= '' then
				local sobrenome = vRP.prompt(source,'Qual é o sobrenome? ( Preencha com atençao! )', '')
				if sobrenome ~= '' then
					local idade = vRP.prompt(source,'Qual é a sua idade? ( Preencha com atençao! )', '')
					if idade ~= '' then
						local checkIdade = idade
						if idade >= '18' and idade <= '90' then

							vRP.execute('vRP/update_user_identity',{
								user_id = user_id,
								firstname = sobrenome,
								name = nome,
								age = idade,
								registration = identity.registration,
								phone = identity.phone
							})

							vRP.tryGetInventoryItem(user_id,'passaporte',1)

							if vRP.getInventoryItemAmount(user_id,"identidade") <= 0  then
								vRP.giveInventoryItem(user_id,"identidade",1)
							end

							TriggerClientEvent('Notify',source,'sucesso','Você foi cadastrado no sistema do governo com sucesso!.',8000)
							return true
						else
							TriggerClientEvent('Notify',source,'negado','Sua idade não pode ser menor que 18 ou maior que 90.',8000)
							return false
						end
					else
						TriggerClientEvent('Notify',source,'negado','Você precisa dizer a sua idade!',8000)
						return false
					end
				else
					TriggerClientEvent('Notify',source,'negado','Você precisa dizer o seu sobrenome!',8000)
					return false
				end
			else
				TriggerClientEvent('Notify',source,'negado','Você precisa dizer o seu nome!',8000)
				return false
			end
		else
			TriggerClientEvent('Notify',source,'negado','Você precisa de um passaporte para iniciar o cadastro na cidade.',8000)
			return false
		end
	end
end

function vRPN.giveIdentidade()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("identidade") <= vRP.getInventoryMaxWeight(user_id) then
		if vRP.getInventoryItemAmount(user_id,"identidade") > 0 then
			TriggerClientEvent("Notify",source,"negado","Você já possui uma identidade em sua mochila.")
		else
			if vRP.tryPayment(user_id,90) then
				vRP.giveInventoryItem(user_id,"identidade",1)
				TriggerClientEvent("Notify",source,"sucesso","Sucesso, você adquiriu a segunda via da sua identidade por <b>$90 dólares</b>.")
			else
				TriggerClientEvent("Notify",source,"negado","Saldo insuficiente.")
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Sua mochila está cheia.")
	end
end