local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_dealership",src)
vCLIENT = Tunnel.getInterface("vrp_dealership")

local auth = false 

local customer = 'N/A'
local customerid = 'N/A'
local customeremail = 'N/A'
local customerdiscord = '<@N/A>'
local webhook = 'https://discord.com/api/webhooks/785562766949613588/RR0voR7PwiZ7w-FZwDai6JLJb7dhnRN1FJMiEgP1S_IMJTXen-xdAizHwF4gHs8EKtev'

local motos = {}
local carros = {}
local import = {} 
local vehicle = {}
local pedidos = {}

Citizen.CreateThread(function()
	for k,v in pairs(vRP.vehicleGlobal()) do
		if v.tipo == "carros" then
			local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(carros,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "motos" then
			local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(motos,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "import" then
			local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(import,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
	end
end)

function src.updateVehicles(vname,vehtype)
	if vehtype == "carros" then
		for k,v in pairs(carros) do
			if v.k == vname then
				table.remove(carros,k)
				local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(carros,{ k = vname, nome = vRP.vehicleName(vname), price = (vRP.vehiclePrice(vname)), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "motos" then
		for k,v in pairs(motos) do
			if v.k == vname then
				table.remove(motos,k)
				local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(motos,{ k = vname, nome = vRP.vehicleName(vname), price = (vRP.vehiclePrice(vname)), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "import" then
		for k,v in pairs(import) do
			if v.k == vname then
				table.remove(import,k)
				local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(import,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice(vname), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	end
end

function src.Carros()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carros
	end
end

function src.Motos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return motos
	end
end

function src.Import()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return import
	end
end

function src.buyRents(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local spawnveh = vCLIENT.buyRent(source,name,1000,1000,100,custom,0,0,0,0,0,0,true)
end

function src.addEstoque(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--if vRP.hasPermission(user_id,"concessionaria.permissao") then
			if vRP.vehicleType(name) == "import" then
				TriggerClientEvent("Notify",source,"importante","Você não pode pedir mais veículos exclusivos.",8000)
			else
				local maxvehs = vRP.query("losanjos/con_maxvehs",{ user_id = parseInt(user_id) })
				local maxgars = vRP.query("losanjos/get_users",{ user_id = parseInt(user_id) })
				local vehicle = vRP.query("losanjos/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })

				if vRP.hasPermission(user_id,"ultimate.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 20 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"platinum.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 15 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"gold.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 10 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"standard.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 5 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				else
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 2 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				end

				if vehicle[1] then
					TriggerClientEvent("Notify",source,"importante","Você já possui um <b>"..vRP.vehicleName(name).."</b> em sua garagem.",10000)
					return
				else
					local rows2 = vRP.query("losanjos/get_estoque",{ vehicle = name })

					if pedidos[vRP.vehicleName(name)] == true then
						TriggerClientEvent("Notify",source,"importante","Estoque de <b>"..vRP.vehicleName(name).."</b> já está sobre encomenda.",8000)
					else
						if parseInt(rows2[1].quantidade) <= 0 then
							TriggerClientEvent("Notify",source,"sucesso","Estoque de <b>"..vRP.vehicleName(name).."</b> será adicionado em alguns minutos.",8000)
							pedidos[vRP.vehicleName(name)] = true

							SetTimeout(900000,function()
								vRP.execute("losanjos/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) + 1 })
								TriggerClientEvent("Notify",source,"sucesso","Estoque de <b>"..vRP.vehicleName(name).."</b> adicionado.",8000)
								src.updateVehicles(name,vRP.vehicleType(name))
								if vRP.vehicleType(name) == "carros" then
									TriggerClientEvent('dealership:Update',source,'updateCarros')
								elseif vRP.vehicleType(name) == "motos" then
									TriggerClientEvent('dealership:Update',source,'updateMotos')
								elseif vRP.vehicleType(name) == "import" then
									TriggerClientEvent('dealership:Update',source,'updateImport')
								end
								pedidos[vRP.vehicleName(name)] = false
								return
							end)

						else
							TriggerClientEvent("Notify",source,"importante","<b>"..vRP.vehicleName(name).."</b> já possui no estoque.",8000)
						end
					end
				end
			end
		--end
	end
end

function src.buyDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--if vRP.hasPermission(user_id,"concessionaria.permissao") then
			if vRP.vehicleType(name) == "import" then
				TriggerClientEvent("Notify",source,"importante","Você não pode comprar veículos exclusivos.",8000)
			else
				local maxvehs = vRP.query("losanjos/con_maxvehs",{ user_id = parseInt(user_id) })
				local maxgars = vRP.query("losanjos/get_users",{ user_id = parseInt(user_id) })
				local vehicle = vRP.query("losanjos/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })

				if vRP.hasPermission(user_id,"ultimate.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 20 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"platinum.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 15 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"gold.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 10 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"standard.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 5 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				else
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 2 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				end

				if vehicle[1] then
					TriggerClientEvent("Notify",source,"importante","Você já possui um <b>"..vRP.vehicleName(name).."</b> em sua garagem.",10000)
					return
				else
					local rows2 = vRP.query("losanjos/get_estoque",{ vehicle = name })

					if parseInt(rows2[1].quantidade) <= 0 then
						TriggerClientEvent("Notify",source,"aviso","Estoque de <b>"..vRP.vehicleName(name).."</b> indisponível.",8000)
						return
					end

					local preco = vRP.vehiclePrice(name)

					if vRP.tryPayment(user_id,parseInt(preco)) then
						vRP.execute("losanjos/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) - 1 })
						vRP.execute("losanjos/add_vehicle",{ user_id = parseInt(user_id), vehicle = name, ipva = os.time() })

						TriggerClientEvent("Notify",source,"sucesso","Você comprou um <b>"..vRP.vehicleName(name).."</b> por <b>$ "..vRP.format(parseInt(preco)).." dólares</b>.",10000)
						
						src.updateVehicles(name,vRP.vehicleType(name))
						
						if vRP.vehicleType(name) == "carros" then
							TriggerClientEvent('dealership:Update',source,'updateCarros')
						elseif vRP.vehicleType(name) == "motos" then
							TriggerClientEvent('dealership:Update',source,'updateMotos')
						elseif vRP.vehicleType(name) == "import" then
							TriggerClientEvent('dealership:Update',source,'updateImport')
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")			
					end
				end
			end
		--end
	end
end

function src.permissao()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id,"concessionaria.permissao")
end

AddEventHandler("onResourceStart",function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("http://192.99.251.232:3501/auth/auth.json",function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest("https://api.ipify.org/",function(errorCode, resultData, resultHeaders)
                local data = json.decode(resultData1)
                for k,v in pairs(data) do
                    if k == GetCurrentResourceName() then
                        for a,b in pairs(v) do             
                            if resultData == b then
                                print("\27[32m["..GetCurrentResourceName().."] Autenticado;")
                                auth = true
                                return
                            end
                        end
                    end            
                end
				PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = "**Atenção:** <@&748720506169196675>**!**", embeds = {{title = "PRODUTO NÃO AUTENTICADO:\n⠀", thumbnail = {url = 'https://i.imgur.com/Y5Zktwm.png'}, fields = {{ name = "**Produto:**", value = ""..GetCurrentResourceName().."\n⠀"}, {name = "**• DADOS DO PROPRIETÁRIO:**", value = "⠀"}, {name = "**Nome completo:**", value = ""..customer..""}, {name = "**Nº contrato:**", value = ""..customerid..""}, {name = "**E-mail:**", value = ""..customeremail..""}, {name = "**Discord:**", value = ""..customerdiscord.."\n⠀"}, {name = "**• DADOS DE REDE:**", value = "⠀"}, {name = "**IP não autorizado:**", value = "` "..resultData.." `\n⠀"}}, footer = {text = 'ZIRAFLIX Inc. Todos os direitos reservados | '..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = 'https://i.imgur.com/Y5Zktwm.png'}, color = 1975079}}}), {['Content-Type'] = 'application/json'})                    
                print("\27[31m["..GetCurrentResourceName().."] Não autenticado! Adquira já o seu em www.ziraflix.com;")
            end)
        end)
    end
end)

function src.checkAuth()
    if auth then
        return true
    end
end