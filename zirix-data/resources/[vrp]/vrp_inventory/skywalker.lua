local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_inventory",vRPN)
Proxy.addInterface("vrp_inventory",vRPN)
vRPCclient = Tunnel.getInterface("vrp_inventory")
vGARAGE = Tunnel.getInterface("vrp_garages")

local idgens = Tools.newIDGenerator()
local actived = {}
local pick = {}
local blips = {}

function vRPN.Inventory()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local data = vRP.getUserDataTable(user_id)
		local inventory = {}

		if data and data.inventory then
			local tSlot = vRPN.verifySlots(user_id)
			
			if tSlot ~= nil then
				tSlot = tSlot
			else
				tSlot = 11
			end

			for k,v in pairs(data.inventory) do
				tSlot = tSlot - 1
				if vRP.itemBodyList(k) then
					if tSlot >= 0 then
						table.insert(inventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
					end
				end
			end

			return inventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),tSlot
		end

	end
end

function vRPN.verifySlots(user_id)
	if vRP.getExp(user_id,"physical","strength") == 1900 then -- 90Kg
		return 24
	elseif vRP.getExp(user_id,"physical","strength") == 1320 then -- 75Kg
		return 18
	elseif vRP.getExp(user_id,"physical","strength") == 670 then -- 51Kg
		return 12
	elseif vRP.getExp(user_id,"physical","strength") == 20 then -- 6Kg
		return 6
	end
end

function vRPN.getRemaingSlots(user_id)
	local tSlot = vRPN.verifySlots(user_id)

	if tSlot ~= nil then
		tSlot = tSlot
	else
		tSlot = 11
	end

	for k,v in pairs(vRP.getInventory(user_id)) do
		tSlot = tSlot - 1
	end

	return tSlot
end

function vRPN.haveMoreSlots(user_id)
	if vRPN.getRemaingSlots(user_id) > 0 then
		return true
	else
		return false
	end
end

function vRPN.sendItem(itemName,type,amount)
	local source = source

	if itemName then
		local user_id = vRP.getUserId(source)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(nplayer)
		local identity = vRP.getUserIdentity(user_id)
		local identitynu = vRP.getUserIdentity(nuser_id)
		local tnSlot = 0

		if nuser_id then
			local data = vRP.getUserDataTable(nuser_id)
			local inventory = {}
			if data and data.inventory then
				tnSlot = vRPN.verifySlots(nuser_id)
				if tnSlot ~= nil then
					tnSlot = tnSlot
				else
					tnSlot = 11
				end
				for k,v in pairs(data.inventory) do
					tnSlot = tnSlot - 1
					if vRP.itemBodyList(k) then
						if tnSlot >= 0 then
							table.insert(inventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
						end
					end
				end
			end
		end

		if nuser_id and tnSlot > 0 and vRP.itemIndexList(itemName) then
			local x,y,z = vRPclient.getPosition(source)
			if parseInt(amount) > 0 then
				if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,itemName,amount) then
						vRP.giveInventoryItem(nuser_id,itemName,amount)
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						PerformHttpRequest(config.webhookSend, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE ITEM ENVIADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM ENVIOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM ENVIADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..vRP.format(parseInt(amount)).."** ]"}, {name = "**QUEM RECEBEU:**", value = "**"..identitynu.name.." "..identitynu.firstname.."** [**"..nuser_id.."**]\n⠀⠀"}, {name = "**LOCAL: "..tD(x)..", "..tD(y)..", "..tD(z).."**", value = "⠀"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y |: %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), { ['Content-Type'] = 'application/json' })
						TriggerClientEvent("itensNotify",source,"sucesso","Enviou",""..vRP.itemIndexList(itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(itemName)*parseInt(amount)).."")
						TriggerClientEvent("itensNotify",nplayer,"sucesso","Recebeu",""..vRP.itemIndexList(itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(itemName)*parseInt(amount)).."")
						vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
						TriggerClientEvent('vrp_inventory:Update',nplayer,'updateInventory')
						return true
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.",8000)
			end
		end
	end
	return false
end

function vRPN.dropItem(itemName,type,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local x,y,z = vRPclient.getPosition(source)
		if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,itemName,amount) then
			TriggerEvent("DropSystem:create",itemName,amount,x,y,z,3600)
			vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
			PerformHttpRequest(config.webhookDrop, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE ITEM DROPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM DROPOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM DROPADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..vRP.format(parseInt(amount)).."** ]\n⠀⠀"}, {name = "**LOCAL: "..tD(x)..", "..tD(y)..", "..tD(z).."**", value = "⠀"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
			TriggerClientEvent("itensNotify",source,"sucesso","Largou",""..vRP.itemIndexList(itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(itemName)*parseInt(amount)).."")
			TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Quantidade <b>inválida</b>.",8000)
		end
	end
	return false
end

function vRPN.useItem(itemName,type,ramount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and ramount ~= nil and parseInt(ramount) >= 0 and not actived[user_id] and actived[user_id] == nil then
		if type == 'use' then
			if itemName == "mochilap" then
				if vRP.getInventoryMaxWeight(user_id) >= 51 then
					TriggerClientEvent("Notify",source,"negado","Você não pode equipar mais mochilas.",8000)
				else
					if vRP.tryGetInventoryItem(user_id,"mochilap",1) then
						TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
						vRP.varyExp(user_id,"physical","strength",650)
						TriggerClientEvent("inventory:mochilaon",source)
						TriggerClientEvent("itensNotify",source,'use',"Equipou",""..itemName.."")
					end
				end
			elseif itemName == "mochilam" then
					if vRP.getInventoryMaxWeight(user_id) >= 51 then
						TriggerClientEvent("Notify",source,"negado","Você não pode equipar mais mochilas.",8000)
					else
						if vRP.tryGetInventoryItem(user_id,"mochilam",1) then
							TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
							vRP.varyExp(user_id,"physical","strength",1300)
							TriggerClientEvent("inventory:mochilaon",source)
							TriggerClientEvent("itensNotify",source,'use',"Equipou",""..itemName.."")
						end
					end
			elseif itemName == "mochilag" then
				if vRP.getInventoryMaxWeight(user_id) >= 51 then
					TriggerClientEvent("Notify",source,"negado","Você não pode equipar mais mochilas.",8000)
				else
					if vRP.tryGetInventoryItem(user_id,"mochilag",1) then
						TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
						vRP.varyExp(user_id,"physical","strength",1900)
						TriggerClientEvent("inventory:mochilaon",source)
						TriggerClientEvent("itensNotify",source,'use',"Equipou",""..itemName.."")
					end
				end
			elseif itemName == "plano-one" then
				local dias = 1
				local consulta = vRP.getUData(user_id,"vRP:plano")
				local resultado = json.decode(consulta) or {}
				local plan = {}
				if resultado.tempo == nil then
					resultado.tempo = 0
				end
				if resultado.tempo > 0 then
					resultado = resultado.tempo/1440 or 0
					TriggerClientEvent("Notify",source,"negado","Você já tem um plano ativo no momento, com <b>"..math.ceil(resultado).." dias restantes</b>.")
				else  
						if vRP.tryGetInventoryItem(user_id,"plano-one",1) then                
							resultado.tempo = resultado.tempo or 0
							resultado.tempo = (resultado.tempo or 0)+tonumber(dias)*1440
							plan[vRP.getUserId(source)] = resultado.tempo
							vRP.setUData(user_id, "vRP:plano", json.encode(resultado))
							TriggerClientEvent("Notify",source,"sucesso","Plano contratado com sucesso! Você tem <b>"..dias.." dias restantes</b>.")
						end
				end
			elseif itemName == "plano-three" then
				local dias = 3
				local consulta = vRP.getUData(user_id,"vRP:plano")
				local resultado = json.decode(consulta) or {}
				local plan = {}
				if resultado.tempo == nil then
					resultado.tempo = 0
				end
				if resultado.tempo > 0 then
					resultado = resultado.tempo/1440 or 0
					TriggerClientEvent("Notify",source,"negado","Você já tem um plano ativo no momento, com <b>"..math.ceil(resultado).." dias restantes</b>.")
				else  
						if vRP.tryGetInventoryItem(user_id,"plano-three",1) then                
							resultado.tempo = resultado.tempo or 0
							resultado.tempo = (resultado.tempo or 0)+tonumber(dias)*1440
							plan[vRP.getUserId(source)] = resultado.tempo
							vRP.setUData(user_id, "vRP:plano", json.encode(resultado))
							TriggerClientEvent("Notify",source,"sucesso","Plano contratado com sucesso! Você tem <b>"..dias.." dias restantes</b>.")
						end
				end
			elseif itemName == "plano-five" then
				local dias = 5
				local consulta = vRP.getUData(user_id,"vRP:plano")
				local resultado = json.decode(consulta) or {}
				local plan = {}
				if resultado.tempo == nil then
					resultado.tempo = 0
				end
				if resultado.tempo > 0 then
					resultado = resultado.tempo/1440 or 0
					TriggerClientEvent("Notify",source,"negado","Você já tem um plano ativo no momento, com <b>"..math.ceil(resultado).." dias restantes</b>.")
				else  
						if vRP.tryGetInventoryItem(user_id,"plano-five",1) then                
							resultado.tempo = resultado.tempo or 0
							resultado.tempo = (resultado.tempo or 0)+tonumber(dias)*1440
							plan[vRP.getUserId(source)] = resultado.tempo
							vRP.setUData(user_id, "vRP:plano", json.encode(resultado))
							TriggerClientEvent("Notify",source,"sucesso","Plano contratado com sucesso! Você tem <b>"..dias.." dias restantes</b>.")
						end
				end
			elseif itemName == "plano-ten" then
				local dias = 10
				local consulta = vRP.getUData(user_id,"vRP:plano")
				local resultado = json.decode(consulta) or {}
				local plan = {}
				if resultado.tempo == nil then
					resultado.tempo = 0
				end
				if resultado.tempo > 0 then
					resultado = resultado.tempo/1440 or 0
					TriggerClientEvent("Notify",source,"negado","Você já tem um plano ativo no momento, com <b>"..math.ceil(resultado).." dias restantes</b>.")
				else  
						if vRP.tryGetInventoryItem(user_id,"plano-ten",1) then                
							resultado.tempo = resultado.tempo or 0
							resultado.tempo = (resultado.tempo or 0)+tonumber(dias)*1440
							plan[vRP.getUserId(source)] = resultado.tempo
							vRP.setUData(user_id, "vRP:plano", json.encode(resultado))
							TriggerClientEvent("Notify",source,"sucesso","Plano contratado com sucesso! Você tem <b>"..dias.." dias restantes</b>.")
						end
				end
			elseif itemName == "maquininha" then
				local source = source
				local user_id = vRP.getUserId(source)
				local nplayer = vRPclient.getNearestPlayer(source,2)
				local nuser_id = vRP.getUserId(nplayer)
				
				TriggerClientEvent("vrp_inventory:fechar",source)

				if nplayer then
					local identity = vRP.getUserIdentity(user_id)
					local identitynu = vRP.getUserIdentity(nuser_id)
					local banco = vRP.getBankMoney(user_id)
					local banconu = vRP.getBankMoney(nuser_id)

					if vRP.getInventoryItemAmount(user_id,"maquininha") >= 1 then
						local cobranca = vRP.prompt(source,"Quanto deseja cobrar pelos serviços prestados a "..identitynu.name.." "..identitynu.firstname.."</b>?", "")
						TriggerClientEvent("emotes",source,"anotar2")

						if cobranca ~= "" then
							local valorfatura = parseInt(cobranca)
							local fatura = vRP.request(nplayer,"<b>"..identity.name.." "..identity.firstname.."</b> está cobrando <b>$"..valorfatura.." dólares</b> pelos serviços. Deseja pagar?",30)

							if fatura then
								if vRP.getInventoryItemAmount(nuser_id,"cartao-debito") >= 1 then
									if banconu >= valorfatura then
										local tax = parseInt(3/100*valorfatura)
										local pagamento	= parseInt(valorfatura-tax)

										vRP.setBankMoney(user_id,banco+pagamento)
										vRP.setBankMoney(nuser_id,banconu-valorfatura)

										TriggerClientEvent("Notify",source,"sucesso","<b>"..identitynu.name.." "..identitynu.firstname.."</b> pagou <b>$"..valorfatura.." dólares</b> pelo serviço.s")
										TriggerClientEvent("Notify",nplayer,"sucesso","Você pagou <b>$"..valorfatura.." dólares</b> a <b>"..identity.name.." "..identity.firstname.."</b> pelo serviço.")

										vRPclient._stopAnim(source,false)
										vRPclient._DeletarObjeto(source)
									else
										TriggerClientEvent("Notify",source,"negado","<b>"..identitynu.name.." "..identitynu.firstname.."</b> não tem dinheiro suficiente para o pagamento.")
										TriggerClientEvent("Notify",nplayer,"negado","Saldo insuficiente.")
										vRPclient._stopAnim(source,false)
										vRPclient._DeletarObjeto(source)
									end
								else
									TriggerClientEvent("Notify",source,"negado","O cliente não possuí cartão de crédito para fazer o pagamento.")
									TriggerClientEvent("Notify",nplayer,"negado","Você não tem um cartão de crédito na mochila.")
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>"..identitynu.name.." "..identitynu.firstname.."</b> negou o pagamento.")
								vRPclient._stopAnim(source,false)
								vRPclient._DeletarObjeto(source)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você precisa colocar o valor que deseja cobrar!")
							vRPclient._stopAnim(source,false)
							vRPclient._DeletarObjeto(source)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Você não possuí uma maquina de cobranças em sua mochila.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Não há players por perto.")
				end

			elseif itemName == "identidade" then
				local nplayer = vRPclient.getNearestPlayer(source,2)
				if nplayer then
					local identity = vRP.getUserIdentity(user_id)
					if identity then
						TriggerClientEvent("Identity2",nplayer,identity.name,identity.firstname,identity.user_id,identity.registration)
					end
				end
			elseif itemName == "colete" then
				if vRP.tryGetInventoryItem(user_id,"colete",1) then
					vRPclient.setArmour(source,100)
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					TriggerClientEvent("itensNotify",source,'use',"Equipou",""..itemName.."")
				end
			elseif itemName == "repairkit" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.hasPermission(user_id,"mecanico.permissao") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,30000,"reparando veículo")
							SetTimeout(30000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('reparar',source)
								TriggerClientEvent('repararmotor',source,vehicle)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
								actived[user_id] = true
								TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,30000,"reparando veículo")
								TriggerClientEvent("itensNotify",source,'use',"Usou",""..itemName.."")
								SetTimeout(30000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('reparar',source)
									TriggerClientEvent('repararmotor',source,vehicle)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end
			elseif itemName == "paninho" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.tryGetInventoryItem(user_id,"paninho",1) then
							actived[user_id] = true
							TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
							TriggerClientEvent('cancelando',source,true)

							TriggerClientEvent("emotes",source,"pano")

							TriggerClientEvent("progress",source,10000,"limpando")
							TriggerClientEvent("itensNotify",source,'use',"Usou",""..itemName.."")

							SetTimeout(10000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('limpar',source)
								vRPclient._stopAnim(source,false)
								vRPclient._DeletarObjeto(src)
							end)
						end
					end
				end
			elseif itemName == "lockpick" then
				local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,2)
				local policia = vRP.getUsersByPermission("policia.permissao")
				if vehicle then
					if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and vRP.tryGetInventoryItem(user_id,"lockpick",1) then
						actived[user_id] = true
						TriggerClientEvent('cancelando',source,true)
						vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
						TriggerClientEvent("progress",source,15000,"roubando")
						TriggerClientEvent("itensNotify",source,'use',"Usou",""..itemName.."")
						SetTimeout(15000,function()
							actived[user_id] = nil
							TriggerClientEvent('cancelando',source,false)
							vRPclient._stopAnim(source,false)

							if math.random(100) >= 50 then
								TriggerEvent("setPlateEveryone",placa)
								vGARAGE.vehicleClientLock(-1,vnetid,1)
								TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
							else
								TriggerClientEvent("Notify",source,"negado","Roubo do veículo falhou e as autoridades foram acionadas.",8000)
								local policia = vRP.getUsersByPermission("policia.permissao")
								local x,y,z = vRPclient.getPosition(source)
								for k,v in pairs(policia) do
									local player = vRP.getUserSource(parseInt(v))
									if player then
										async(function()
											local id = idgens:gen()
											vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
											TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Roubo na ^1"..street.."^0 do veículo ^1"..model.."^0 de placa ^1"..placa.."^0 verifique o ocorrido.")
											pick[id] = vRPclient.addBlip(player,x,y,z,10,1,"Ocorrência",0.5,false)
											SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
										end)
									end
								end
							end
						end)
					end
				else						
					TriggerClientEvent("vrpdoorsystem:forceOpen",source,itemName)
				end
			elseif itemName == "capuz" then
				if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
					local nplayer = vRPclient.getNearestPlayer(source,2)
					if nplayer then
						vRPclient.setCapuz(nplayer)
						vRP.closeMenu(nplayer)
						TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.",8000)
					end
				end
			elseif itemName == "placa" then
                if vRPclient.GetVehicleSeat(source) then
                    if vRP.tryGetInventoryItem(user_id,"placa",1) then
                        local placa = vRP.generatePlate()
                        TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
                        TriggerClientEvent('cancelando',source,true)
                        TriggerClientEvent("vehicleanchor",source)
						TriggerClientEvent("progress",source,59500,"clonando")
						TriggerClientEvent("itensNotify",source,'use',"Usou",""..itemName.."")
                        SetTimeout(60000,function()
                            TriggerClientEvent('cancelando',source,false)
                            TriggerClientEvent("cloneplates",source,placa)
                            --TriggerEvent("setPlateEveryone",placa)
                            TriggerClientEvent("Notify",source,"sucesso","Placa clonada com sucesso.",8000)
                        end)
                    end
                end
			elseif itemName == "agua" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"agua",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_ld_flow_bottle",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRP.giveInventoryItem(user_id,"garrafa-vazia",1)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "leite" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"leite",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "cafe1" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafe1",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "cafecleite" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafecleite",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "cafeexpresso" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafeexpresso",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "capuccino" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"capuccino",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-55)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "frappuccino" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"frappuccino",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-65)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "cha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cha",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-50)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "icecha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"icecha",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-50)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "sprunk" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"sprunk",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ng_proc_sodacan_01b",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-65)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "cola" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cola",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ng_proc_sodacan_01a",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-70)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "energetico" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"energetico",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-100)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "pibwassen" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"pibwassen",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-10)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "tequilya" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"tequilya",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_logopen",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,15)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "patriot" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"patriot",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-10)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "blarneys" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"blarneys",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,15)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "jakeys" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"jakeys",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_logopen",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,15)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "barracho" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"barracho",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,15)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "ragga" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"ragga",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,15)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "nogo" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"nogo",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_logopen",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,15)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "mount" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"mount",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,20)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "cherenkov" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cherenkov",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_logopen",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,20)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "bourgeoix" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"bourgeoix",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,20)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "bleuterd" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"bleuterd",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_logopen",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Bebendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,20)
						vRP.varyHunger(user_id,0)
						TriggerClientEvent("inventory:checkDrunk",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "sanduiche" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"sanduiche",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					TriggerClientEvent("emotes",source,"comer")
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)

				end
			elseif itemName == "rosquinha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"rosquinha",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					TriggerClientEvent("emotes",source,"comer3")
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "hotdog" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"hotdog",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					TriggerClientEvent("emotes",source,"comer2")
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "xburguer" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"xburguer",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					TriggerClientEvent("emotes",source,"comer")
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "chips" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"chips",1) then

					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","ng_proc_food_chips01b",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "batataf" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"batataf",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_food_bs_chips",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "pizza" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"pizza",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","v_res_tt_pizzaplate",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "frango" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"frango",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_food_cb_nugets",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "bcereal" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"bcereal",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_choc_pq",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "bchocolate" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"bchocolate",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_choc_meto",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "taco" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"taco",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_taco_01",49,28422)
					TriggerClientEvent("progress",source,10000,"comendo")
					TriggerClientEvent("itensNotify",source,'use',"Comendo",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "paracetamil" and vRPCclient.checkVida(source) then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"paracetamil",1) then
					actived[user_id] = true
					
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Tomando",""..itemName.."")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "voltarom" and vRPCclient.checkVida(source) then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"voltarom",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Tomando",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "trandrylux" and vRPCclient.checkVida(source) then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"trandrylux",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Tomando",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "dorfrex" and vRPCclient.checkVida(source) then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"dorfrex",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Tomando",""..itemName.."")
					
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "buscopom" and vRPCclient.checkVida(source) then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"buscopom",1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")
					TriggerClientEvent("itensNotify",source,'use',"Tomando",""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
					end)
				end
			elseif itemName == "garrafa-vazia" then
				local src = source
				actived[user_id] = true
				TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
				TriggerClientEvent('vrp_watercooler:use',source)
				TriggerClientEvent('cancelando',source,true)
				SetTimeout(6000,function()
					actived[user_id] = nil
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
				end)
			elseif itemName == config.item[itemName] and vRPCclient.checkVida(source) then
				local src = source
				if vRP.tryGetInventoryItem(user_id,config.item[itemName],1) then
					actived[user_id] = true
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
					vRPclient._CarregarObjeto(src,config.item[itemName][1],config.item[itemName][2],config.item[itemName][3],49,28422)
					TriggerClientEvent("progress",source,10000,config.item[itemName][4])
					TriggerClientEvent("itensNotify",source,'use',config.item[itemName][4],""..itemName.."")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,config.item[itemName][5])
						vRP.varyHunger(user_id,config.item[itemName][6])
						vRPclient._DeletarObjeto(src)
					end)
				end
			end
		elseif type == 'equip' then
			if vRP.tryGetInventoryItem(user_id,itemName,1) then
				local weapons = {}
				local identity = vRP.getUserIdentity(user_id)
				
				weapons[string.gsub(itemName,"wbody","")] = { ammo = 0 }
				--print(weapons)
				vRPclient._giveWeapons(source,weapons)
				PerformHttpRequest(config.webhookEquip, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE ITEM EQUIPADO:\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM EQUIPOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM EQUIPADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ]"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
				TriggerClientEvent("itensNotify",source,'use',"Equipou",""..vRP.itemIndexList(itemName).."")
				TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')

			end
		elseif type == 'reloading' then
			local uweapons = vRPclient.getWeapons(source)
      		local weaponuse = string.gsub(itemName,"wammo","")
			local weaponusename = "wammo"..weaponuse
			--print(weaponuse)
			local identity = vRP.getUserIdentity(user_id)
      		if uweapons[weaponuse] then
        		local itemAmount = 0
        		local data = vRP.getUserDataTable(user_id)
        		for k,v in pairs(data.inventory) do
          			if weaponusename == k then
            			if v.amount > 250 then
              				v.amount = 250
            			end
            			itemAmount = v.amount
						if vRP.tryGetInventoryItem(user_id, weaponusename, parseInt(v.amount)) then
							local weapons = {}
							local nameFix = string.gsub(itemName,"|","-")
							weapons[weaponuse] = { ammo = v.amount }
							itemAmount = v.amount
							vRPclient._giveWeapons(source,weapons,false)
							
							PerformHttpRequest(config.webhookEquip, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE ITEM EQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM EQUIPOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM EQUIPADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..vRP.format(parseInt(v.amount)).."** ]"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
				
							TriggerClientEvent("itensNotify",source,'use',"Recarregou",""..nameFix.."")
							TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
						end
          			end
        		end
			end
		end
	end
end

AddEventHandler("vRP:playerLeave",function(user_id,source)
	actived[user_id] = nil
end)

RegisterCommand('garmas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local rtime = math.random(3,8)
	TriggerClientEvent("Notify",source,"aviso","<b>Aguarde!</b> Suas armas estão sendo desequipadas.",9500)
	TriggerClientEvent("progress",source,10000,"guardando")
	SetTimeout(1000*rtime,function()
		if user_id then
			local weapons = vRPclient.replaceWeapons(source,{})
			for k,v in pairs(weapons) do
				vRP.giveInventoryItem(user_id,"wbody"..k,1)
				PerformHttpRequest(config.webhookUnequip, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE ITEM DESEQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM DESEQUIPOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM EQUIPADO:**", value = "[ **Item: "..k.."** ][ **Quantidade: 1** ]"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
				if v.ammo > 0 then
					vRP.giveInventoryItem(user_id,"wammo"..k,v.ammo)
					PerformHttpRequest(config.webhookUnequip, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE ITEM DESEQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**QUEM DESEQUIPOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM DESEQUIPADO:**", value = "[ **Item: "..k.."** ][ **Quantidade: "..vRP.format(parseInt(v.ammo)).."** ]"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
				end
			end
			TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
		end
	end)
	SetTimeout(10000,function()
		TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
	end)
end)

--[[
RegisterCommand('gcolete',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local rtime = math.random(3,8)

	if vRPclient.getArmour(source) <= 99 then
		TriggerClientEvent("Notify",source,"negado","Você não pode desequipar um <b>colete danificado</b>.")
	else	
		TriggerClientEvent("Notify",source,"aviso","<b>Aguarde!</b> Você está desequipando seu colete.",9000)
		TriggerClientEvent("progress",source,10000,"guardando")
		SetTimeout(1000*rtime,function()
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete") <= vRP.getInventoryMaxWeight(user_id) then
				PerformHttpRequest(config.webhookUnequip, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE ITEM DESEQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{ name = "**QUEM DESEQUIPOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM DESEQUIPADO:**", value = "[ **Item: Colete** ][ **Quantidade: 1** ]"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
				vRP.giveInventoryItem(user_id,"colete",1)
				vRPclient.setArmour(source,0)
			else
				TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
			end
		end)
		SetTimeout(10000,function()
			TriggerClientEvent("itensNotify",source,'use',"Desequipou","Colete")
		end)
	end
end)--]]

function vRPN.armourOff()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local rtime = math.random(3,5)

	if vRPclient.getArmour(source) <= 99 then
		TriggerClientEvent("Notify",source,"negado","Você não pode desequipar um <b>colete danificado</b>.")
	else
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete") <= vRP.getInventoryMaxWeight(user_id) then
			TriggerClientEvent("notallowArmour",source)
			TriggerClientEvent("Notify",source,"aviso","<b>Aguarde!</b> Você está desequipando seu colete.",9000)
			TriggerClientEvent("progress",source,1000*rtime,"guardando")
			SetTimeout(1000*rtime,function()
				PerformHttpRequest(config.webhookUnequip, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE ITEM DESEQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{ name = "**QUEM DESEQUIPOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM DESEQUIPADO:**", value = "[ **Item: Colete** ][ **Quantidade: 1** ]"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
				vRP.giveInventoryItem(user_id,"colete",1)
			end)
			SetTimeout(1000*rtime+2000, function()
				TriggerClientEvent("allowArmour",source)
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
		end
	end
end

function vRPN.unEquip()
	local source = source
	local user_id = vRP.getUserId(source)
	local rtime = math.random(3,8)

	if user_id then
		if vRP.getExp(user_id,"physical","strength") == 1900 then -- 90Kg
			if vRP.getInventoryMaxWeight(user_id)-vRP.getInventoryWeight(user_id) >= 15 and vRPN.getRemaingSlots(user_id) > 17 then
				TriggerClientEvent("progress",source,10000,"guardando")
				TriggerClientEvent("Notify",source,"aviso","<b>Aguarde!</b> Você está desequipando sua mochila.",9000)
				SetTimeout(1000*rtime,function()
					vRP.varyExp(user_id,"physical","strength",-1880)
					vRP.giveInventoryItem(user_id,"mochilag",1)
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
				end)
				SetTimeout(10000,function()
					TriggerClientEvent("Notify",source,"sucesso","Você desequipou uma de suas mochilas.")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa esvaziar a mochila antes de fazer isso.")
			end
		elseif vRP.getExp(user_id,"physical","strength") == 1320 then -- 75Kg
			if vRP.getInventoryMaxWeight(user_id)-vRP.getInventoryWeight(user_id) >= 24 and vRPN.getRemaingSlots(user_id) > 11 then
				TriggerClientEvent("progress",source,10000,"guardando")
				TriggerClientEvent("Notify",source,"aviso","<b>Aguarde!</b> Você está desequipando sua mochila.",9000)
				SetTimeout(1000*rtime,function()
					vRP.varyExp(user_id,"physical","strength",-1300)
					vRP.giveInventoryItem(user_id,"mochilam",1)
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
				end)
				SetTimeout(10000,function()
					TriggerClientEvent("Notify",source,"sucesso","Você desequipou uma de suas mochilas.")
				end)
			else 
				TriggerClientEvent("Notify",source,"negado","Você precisa esvaziar a mochila antes de fazer isso.")
			end
		elseif vRP.getExp(user_id,"physical","strength") == 670 then -- 51Kg
			if vRP.getInventoryMaxWeight(user_id)-vRP.getInventoryWeight(user_id) >= 45 and vRPN.getRemaingSlots(user_id) > 5 then
				TriggerClientEvent("progress",source,10000,"guardando")
				TriggerClientEvent("Notify",source,"aviso","<b>Aguarde!</b> Você está desequipando sua mochila.",9000)
				SetTimeout(1000*rtime,function()
					vRP.varyExp(user_id,"physical","strength",-650)
					vRP.giveInventoryItem(user_id,"mochilap",1)
					TriggerClientEvent("inventory:mochilaoff",source)
					TriggerClientEvent('vrp_inventory:Update',source,'updateInventory')
				end)
				SetTimeout(10000,function()
					TriggerClientEvent("itensNotify",source,'use',"Desequipou","Mochila")
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa esvaziar a mochila antes de fazer isso.")
			end
		elseif vRP.getExp(user_id,"physical","strength") == 20 then -- 6Kg
			TriggerClientEvent("Notify",source,"negado","Você não tem mochilas equipadas.")
		end
	end
end

function vRPN.checkMochila()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getExp(user_id,"physical","strength") >= 670 then
		return true
	end
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end