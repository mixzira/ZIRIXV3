local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

banK = {}
Tunnel.bindInterface("vrp_banco",banK)
Proxy.addInterface("vrp_banco",banK)

--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------

local recompensa = 0
local andamento = false
local dinheirosujo = {}


local logBankSacar = "https://discordapp.com/api/webhooks/762559292745711616/yg1i1Nstvg0knDYKWVYrPlhWdNl4FRVQMHLnF5LUaGQxMpwn6g0VbA9Jg_5uDfTohnR1"
local logBankDepositar = "https://discordapp.com/api/webhooks/762559391509250048/-TUtXDvaCXHX9sb3cIwrEODTFxsFGVJFoswh9keswtCEjD-cFva5hyOoFf9aPG5gVs_w"
local logBankTransferencia = "https://discordapp.com/api/webhooks/762559610002866196/7-PjG811yekbIMM65UXMMbHNM2eVyakH3PsaCRLMjowEvTiEssHLxiQo4iDdKTbhaVCn"

--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------

local caixas = {
	[1] = { ['seconds'] = 25 },
	[2] = { ['seconds'] = 39 },
	[3] = { ['seconds'] = 39 },
	[4] = { ['seconds'] = 35 },
	[5] = { ['seconds'] = 33 },
	[6] = { ['seconds'] = 33 },
	[7] = { ['seconds'] = 55 },
	[8] = { ['seconds'] = 39 },
	[9] = { ['seconds'] = 35 },
	[10] = { ['seconds'] = 60 },
	[11] = { ['seconds'] = 43 },
	[12] = { ['seconds'] = 27 },
	[13] = { ['seconds'] = 45 },
	[14] = { ['seconds'] = 120 }
}

--[ WEBHOOKS ]---------------------------------------------------------------------------------------------------------------------------

local webhookDepositar = ""
local webhookSacar = ""
local webhookPTrans = ""
local webhookPSacar = ""
local webhookRCaixaEletronico = ""

--[ PAGAR MULTAS ]-----------------------------------------------------------------------------------------------------------------------

RegisterCommand('multas',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)

	local value = vRP.getUData(parseInt(user_id),"vRP:multas")
	local multas = json.decode(value) or 0
	local banco = vRP.getBankMoney(user_id)
	
	if user_id then
		if args[1] == nil then
			if multas >= 1 then
				TriggerClientEvent("Notify",source,"aviso","Você possuí <b>$"..multas.." dólares em multas</b> para pagar.",8000)
			else
				TriggerClientEvent("Notify",source,"aviso","Você <b>não possuí</b> multas para pagar.",8000)
			end
		elseif args[1] == "pagar" then
			local valorpay = vRP.prompt(source,"Saldo de multas: $"..multas.." - Valor de multas a pagar:","")
			if banco >= parseInt(valorpay) then
				if parseInt(valorpay) <= parseInt(multas) then
					vRP.setBankMoney(user_id,parseInt(banco-valorpay))
					vRP.setUData(user_id,"vRP:multas",json.encode(parseInt(multas)-parseInt(valorpay)))
					TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$"..valorpay.." dólares</b> em multas.",8000)
				else
					TriggerClientEvent("Notify",source,"negado","Você não pode pagar mais multas do que deve.",8000)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Você não tem dinheiro em sua conta suficiente para isso.",8000)
			end
		end
	end
end)

--[ DEPOSITAR ]--------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('banco:depositar')
AddEventHandler('banco:depositar', function(amount)
	local _source = source
	local user_id = vRP.getUserId(_source)
	local identity = vRP.getUserIdentity(user_id)

	if amount == nil or amount <= 0 or amount > vRP.getMoney(user_id) then
		TriggerClientEvent("Notify",_source,"negado","Valor inválido")
	else
		vRP.tryDeposit(user_id, tonumber(amount))

		PerformHttpRequest(logBankDepositar, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	------------------------------------------------------------
					title = "REGISTRO DE DEPOSITOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
					thumbnail = {
						url = "https://i.imgur.com/CtQB816.png"
					}, 
					fields = {
						{ 
							name = "**IDENTIFICAÇÃO:**",
							value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
						},
						{ 
							name = "**VALOR: $"..tonumber(amount).."**",
							value = "\n⠀"
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

		TriggerClientEvent("Notify",_source,"sucesso","Você depositou <b>$"..amount.." dólares</b>.")
	end
end)

--[ SACAR ]------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('banco:sacar')
AddEventHandler('banco:sacar', function(amount)
	local _source = source
	local user_id = vRP.getUserId(_source)
	local identity = vRP.getUserIdentity(user_id)

	amount = tonumber(amount)
	local getbankmoney = vRP.getBankMoney(user_id)

	if amount == nil or amount <= 0 or amount > getbankmoney then
		TriggerClientEvent("Notify",_source,"negado","Valor inválido")
	else
		vRP.tryWithdraw(user_id,amount)

		PerformHttpRequest(logBankSacar, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	------------------------------------------------------------
					title = "REGISTRO DE SAQUES:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
					thumbnail = {
						url = "https://i.imgur.com/CtQB816.png"
					}, 
					fields = {
						{ 
							name = "**IDENTIFICAÇÃO:**",
							value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
						},
						{ 
							name = "**VALOR: $"..amount.."**",
							value = "\n⠀"
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

		TriggerClientEvent("Notify",_source,"sucesso","Você sacou <b>$"..amount.." dólares</b>.")
	end
end)

--[ PAGAR ]------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('banco:pagar')
AddEventHandler('banco:pagar', function(amount)
	local _source = source
	local user_id = vRP.getUserId(_source)
	local banco = vRP.getBankMoney(user_id)

	local valor = tonumber(amount)

	if banco >= tonumber(amount) then
		local multas = vRP.getUData(user_id,"vRP:multas")
		local int = parseInt(multas)
		if int >= valor then
			if valor > 999 then
				local rounded = math.ceil(valor)
				local novamulta = int - rounded
				vRP.setUData(user_id,"vRP:multas",json.encode(novamulta))
				vRP.setBankMoney(user_id,banco-tonumber(valor))
				TriggerClientEvent("Notify",_source,"sucesso","Você pagou $"..valor.." em multas.")
				TriggerClientEvent("currentbalance2",_source)
			else
				TriggerClientEvent("Notify",_source,"negado","Você só pode pagar multas acima de <b>$1.000</b> dólares")
			end
		else
			TriggerClientEvent("Notify",_source,"negado","Você não pode pagar mais multas do que possuí.")
		end
	else
		TriggerClientEvent("Notify",_source,"negado","Saldo inválido.")
	end
end)

--[ SALDO ]------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('banco:balance')
AddEventHandler('banco:balance', function()
	local _source = source
	local user_id = vRP.getUserId(_source)
	local getbankmoney = vRP.getBankMoney(user_id)
	local multasbalance = vRP.getUData(user_id,"vRP:multas")

	TriggerClientEvent("currentbalance1",_source,addComma(math.floor(getbankmoney)),multasbalance)
	TriggerClientEvent("currentbalance2",_source)
end)

--[ TRANSFERENCIAS ]---------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('banco:transferir')
AddEventHandler('banco:transferir', function(to,amountt)
	local _source = source
	local user_id = vRP.getUserId(_source)
	local identity = vRP.getUserIdentity(user_id)

	local _nplayer = vRP.getUserSource(parseInt(to))
	local nuser_id = vRP.getUserId(_nplayer)
	local identitynu = vRP.getUserIdentity(nuser_id)
	local banco = 0

	if nuser_id == nil then
		TriggerClientEvent("Notify",_source,"negado","Passaporte inválido ou indisponível.")
	else
		if nuser_id == user_id then
			TriggerClientEvent("Notify",_source,"negado","Você não pode transferir dinheiro para sí mesmo.")	
		else
			local banco = vRP.getBankMoney(user_id)
			local banconu = vRP.getBankMoney(nuser_id)
			
			if banco <= 0 or banco < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent("Notify",_source,"negado","Dinheiro Insuficiente")
			else
				vRP.setBankMoney(user_id,banco-tonumber(amountt))
				vRP.setBankMoney(nuser_id,banconu+tonumber(amountt))

				PerformHttpRequest(logBankTransferencia, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	------------------------------------------------------------
							title = "REGISTRO DE TRANSFERENCIAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
							thumbnail = {
								url = "https://i.imgur.com/CtQB816.png"
							}, 
							fields = {
								{ 
									name = "**IDENTIFICAÇÃO:**",
									value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
								},
								{ 
									name = "**TRANSFERIU PARA:**",
									value = "**"..identitynu.name.." "..identitynu.firstname.."** [**"..nuser_id.."**]\n⠀"
								},
								{ 
									name = "**VALOR: $"..tonumber(amountt).."**",
									value = "\n⠀"
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

				TriggerClientEvent("Notify",_nplayer,"sucesso","<b>"..identity.name.." "..identity.firstname.."</b> depositou <b>$"..amountt.." dólares</b> na sua conta.")
				TriggerClientEvent("Notify",_source,"sucesso","Você transferiu <b>$"..amountt.." dólares</b> para conta de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.")
			end
		end
	end
end)

--[ TEMPO ]------------------------------------------------------------------------------------------------------------------------------

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

--[ CHECKROBBERY ]-----------------------------------------------------------------------------------------------------------------------

function banK.checkRobbery(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("policia-ptr.permissao")
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if #policia <= 2 then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais em patrulha no momento.",8000)
		else
			if timers[id] == 0 or not timers[id] then
				timers[id] = 600
				andamento = true
				dinheirosujo = {}
				dinheirosujo[user_id] = caixas[id].seconds
				vRPclient.setStandBY(source,parseInt(800))
				recompensa = parseInt(math.random(2000,8000)/caixas[id].seconds)
				TriggerClientEvent('iniciandocaixaeletronico',source,x,y,z,caixas[id].seconds,head)
				vRPclient._playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
				for l,w in pairs(policia) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('blip:criar:caixaeletronico',player,x,y,z)
							vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
							TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo começou no ^1Caixa Eletrônico^0, dirija-se até o local e intercepte os assaltantes.")
						end)
					end
				end
				
				PerformHttpRequest(webhookRCaixaEletronico, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 
							title = "REGISTRO DE ASSALTO:",
							thumbnail = {
								url = "https://i.imgur.com/CtQB816.png"
							}, 
							fields = {
								{ 
									name = "**IDENTIFICAÇÃO DO PLAYER:**",
									value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**] \n⠀"
								},
								{ 
									name = "**LUCRO DO ASSALTO:**",
									value = "**$"..parseInt(recompensa).." dólares**\n⠀"
								},

							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
								icon_url = "https://i.imgur.com/CtQB816.png"
							},
							color = 15906321 
						}
					}
				}), { ['Content-Type'] = 'application/json' })
				
				SetTimeout(caixas[id].seconds*1000,function()
					if andamento then
						andamento = false
						for l,w in pairs(policia) do
							local player = vRP.getUserSource(parseInt(w))
							if player then
								async(function()
									TriggerClientEvent('blip:remover:caixaeletronico',player)
									TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
								end)
							end
						end
					end
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","O caixa eletrônico está vazio, aguarde <b>"..timers[id].." segundos</b> até que tenha dinheiro novamente.",8000)
			end
		end
	end
end

--[ CANCELROBBERY ]----------------------------------------------------------------------------------------------------------------------

function banK.cancelRobbery()
	if andamento then
		andamento = false
		local policia = vRP.getUsersByPermission("dpla-ptr.permissao")
		for l,w in pairs(policia) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent('blip:remover:caixaeletronico',player)
					TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
	end
end

--[ PAYMENTROBBERY ]---------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			for k,v in pairs(dinheirosujo) do
				if v > 0 then
					dinheirosujo[k] = v - 1
					vRP._giveInventoryItem(k,"dinheiro-sujo",recompensa)
				end
			end
		end
	end
end)

--[ CHECK PERMISSIONS ]------------------------------------------------------------------------------------------------------------------

function banK.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"policia-ptr.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"ems.permissao") or vRP.hasPermission(user_id,"paisana-ems.permissao"))
end


function banK.giveDebitCard()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("cartao-debito") <= vRP.getInventoryMaxWeight(user_id) then
		if vRP.getInventoryItemAmount(user_id,"cartao-debito") > 0 then
			TriggerClientEvent("Notify",source,"negado","Você já possui um cartão de débito em sua mochila.")
		else
			local bank = vRP.getBankMoney(user_id)
			if bank >= 170 then
				vRP.setBankMoney(user_id,bank-170)
				vRP.giveInventoryItem(user_id,"cartao-debito",1)
				TriggerClientEvent("Notify",source,"sucesso","Sucesso, você adquiriu o seu cartão de débito por <b>$170 dólares</b>.")
			else
				TriggerClientEvent("Notify",source,"negado","Saldo insuficiente para contratar o seu cartão de débito.")
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Sua mochila está cheia.")
	end
end

--[ TESTE ]------------------------------------------------------------------------------------------------------------------------------

function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	if num and type(num) == "number" then
	  return math.floor(num * mult + 0.5) / mult
	end
end
  
function addComma(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
		if (k==0) then
		break
		end
	end
	return formatted
end