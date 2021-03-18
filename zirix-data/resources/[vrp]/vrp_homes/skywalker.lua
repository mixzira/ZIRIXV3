local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local sanitizes = module("zirix/others")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_homes",src)
vCLIENT = Tunnel.getInterface("vrp_homes")

local timer = false

vRP._prepare("homes/get_homeuser","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home")
vRP._prepare("homes/get_homeuserid","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id")

vRP._prepare("homes/get_homeuserowner","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP._prepare("homes/get_homeuserco_owner","SELECT * FROM vrp_homes_permissions WHERE co_owner = @co_owner AND home = @home AND owner = 1")

vRP._prepare("homes/get_homeuseridowner","SELECT * FROM vrp_homes_permissions WHERE home = @home AND owner = 1")
vRP._prepare("homes/get_homeuseridco_owner","SELECT * FROM vrp_homes_permissions WHERE home = @home AND co_owner = 1")

vRP._prepare("homes/get_homepermissions","SELECT * FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/add_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id) VALUES(@home,@user_id)")
vRP._prepare("homes/buy_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id,owner,tax,garage) VALUES(@home,@user_id,1,@tax,1)")

vRP._prepare("homes/set_permissions","UPDATE vrp_homes_permissions SET co_owner = @co_owner WHERE home = @home")

vRP._prepare("homes/count_homepermissions","SELECT COUNT(*) as qtd FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/upd_permissions","UPDATE vrp_homes_permissions SET garage = 1 WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/rem_permissions","DELETE FROM vrp_homes_permissions WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/upd_taxhomes","UPDATE vrp_homes_permissions SET tax = @tax WHERE user_id = @user_id, home = @home AND owner = 1")
vRP._prepare("homes/rem_allpermissions","DELETE FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/get_allhomes","SELECT * FROM vrp_homes_permissions WHERE owner = @owner")
vRP._prepare("homes/get_allvehs","SELECT * FROM vrp_vehicles")

local actived = {}
local blipHomes = {}

Citizen.CreateThread(function()
	while true do
		blipHomes = {}
		for k,v in pairs(config.homes) do
			local checkHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(k) })
			if checkHomes[1] == nil then
				table.insert(blipHomes,{ name = tostring(k) })
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(30*60000)
	end
end)

RegisterCommand('homes',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "add" and config.homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			local myCoHomes = vRP.query("homes/get_homeuserco_owner",{ co_owner = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] or myCoHomes[1] then
				local totalResidents = vRP.query("homes/count_homepermissions",{ home = tostring(args[2]) })
				
				if parseInt(totalResidents[1].qtd) >= parseInt(homes[tostring(args[2])][2]) then
					TriggerClientEvent("Notify",source,"negado","A residência "..tostring(args[2]).." atingiu o máximo de moradores.",10000)
					return
				end

				vRP.execute("homes/add_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
				
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					TriggerClientEvent("Notify",source,"sucesso","Permissão na residência <b>"..tostring(args[2]).."</b> adicionada para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
				end
			end
		elseif args[1] == "addco" and config.homes[tostring(args[2])] then
				local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
				if myHomes[1] then
					vRP.execute("homes/set_permissions",{ home = tostring(args[2]), co_owner = parseInt(args[3]) })

					local identity = vRP.getUserIdentity(parseInt(args[3]))
					if identity then
						TriggerClientEvent("Notify",source,"sucesso","Permissão na residência <b>"..tostring(args[2]).."</b> adicionada para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
		elseif args[1] == "rem" and config.homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			local myCoHomes = vRP.query("homes/get_homeuserco_owner",{ co_owner = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] or myCoHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
					local identity = vRP.getUserIdentity(parseInt(args[3]))
					if identity then
						TriggerClientEvent("Notify",source,"importante","Permissão na residência <b>"..tostring(args[2]).."</b> removida de <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "garage" and config.homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					if vRP.tryPayment(user_id,50000) then
						vRP.execute("homes/upd_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
						local identity = vRP.getUserIdentity(parseInt(args[3]))
						if identity then
							TriggerClientEvent("Notify",source,"sucesso","Adicionado a permissão da garagem a <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			end
		elseif args[1] == "list" then
			vCLIENT.setBlipsHomes(source,blipHomes)
		elseif args[1] == "check" and config.homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			local myCoHomes = vRP.query("homes/get_homeuserco_owner",{ co_owner = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] or myCoHomes[1] then
				local userHomes = vRP.query("homes/get_homepermissions",{ home = tostring(args[2]) })
				if parseInt(#userHomes) > 1 then
					local permissoes = ""
					for k,v in pairs(userHomes) do
						if v.user_id ~= user_id then
							local identity = vRP.getUserIdentity(v.user_id)
							permissoes = permissoes.."<b>Nome:</b> "..identity.name.." "..identity.firstname.." - <b>Passaporte:</b> "..v.user_id
							if k ~= #userHomes then
								permissoes = permissoes.."<br>"
							end
						end
						Citizen.Wait(10)
					end
					TriggerClientEvent("Notify",source,"importante","Permissões da residência <b>"..tostring(args[2]).."</b>: <br>"..permissoes,20000)
				else
					TriggerClientEvent("Notify",source,"negado","Nenhuma permissão encontrada.",20000)
				end
			end
		elseif args[1] == "transfer" and config.homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					local ok = vRP.request(source,"Transferir a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b> ?",30)
					if ok then
						vRP.execute("homes/rem_allpermissions",{ home = tostring(args[2]) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]), tax = parseInt(myHomes[1].tax) })
						TriggerClientEvent("Notify",source,"importante","Transferiu a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "tax" and config.homes[args[2]] then
			local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(args[2]) })
			if ownerHomes[1] then
				local house_price = parseInt(config.homes[args[2]].infos[1])
				local house_tax = 0.03
				if vRP.tryPayment(user_id,parseInt(house_price * house_tax)) then
					vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id) })
					vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id), tax = parseInt(os.time()) })
					TriggerClientEvent("Notify",source,"sucesso","Pagamento de <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b> efetuado com sucesso.",10000)
				else
					TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
				end
			end
		else
			local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(v.home) })
					if ownerHomes[1] then
						local house_price = parseInt(config.homes[tostring(v.home)]['infos'][1])
						local house_tax = 0.03


						if parseInt(os.time()) >= parseInt(ownerHomes[1].tax+24*15*60*60) then
							TriggerClientEvent("Notify",source,"negado","<b>Residência:</b> "..v.home.."<br><b>Property Tax:</b> Atrasado<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",20000)
						else
							TriggerClientEvent("Notify",source,"importante","<b>Residência:</b> "..v.home.."<br>Taxa em: "..vRP.getDayHours(parseInt(86400*15-(os.time()-ownerHomes[1].tax))).."<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",20000)
						end
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
		if parseInt(#myHomes) >= 1 then
			for k,v in pairs(myHomes) do
				vCLIENT.setBlipsOwner(source,v.home)
				Citizen.Wait(10)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 2
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)

local answered = {}

function src.checkPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if not vRP.searchReturn(source,user_id) then
				local homeResult = vRP.query("homes/get_homepermissions",{ home = tostring(homeName) })
				if parseInt(#homeResult) >= 1 then
					local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
					local resultOwner = vRP.query("homes/get_homeuseridowner",{ home = tostring(homeName) })
					if myResult[1] then

						if config.homes[homeName]['infos'][1] >= 7000000 then
							return true
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("losanjos/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> venceu por <b>3 dias</b> e a casa foi vendida.",10000)
							return false
						elseif parseInt(os.time()) <= parseInt(resultOwner[1].tax+24*15*60*60) then
							return true
						else
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end
					else
						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) and config.homes[homeName]['infos'][1] < 5000000 then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("losanjos/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							return false
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*15*60*60) and config.homes[homeName]['infos'][1] < 5000000 then
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end

						answered[user_id] = nil
						for k,v in pairs(homeResult) do
							local player = vRP.getUserSource(parseInt(v.user_id))
							if player then
								if not answered[user_id] then
									TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> tocou o interfone da residência <b>"..tostring(homeName).."</b>.<br>Deseja permitir a entrada do mesmo?",10000)
									local ok = vRP.request(player,"Permitir acesso a residência?",30)
									if ok then
										answered[user_id] = true
										return true
									end
								end
							end
							Citizen.Wait(10)
						end
					end
				elseif vRP.hasPermission(user_id,"visitante.permissao") then
					return true
				else
					local ok = vRP.request(source,"Deseja efetuar a compra da residência <b>"..tostring(homeName).."</b> por <b>$"..vRP.format(parseInt(config.homes[tostring(homeName)]['infos'][1])).."</b> ?",30)
					if ok then
						if vRP.hasPermission(user_id,config.brokerPerm) then
							local preco = parseInt(config.homes[tostring(homeName)]['infos'][1])
				
							if vRP.tryPayment(user_id,parseInt(preco)) then
								vRP.execute("homes/buy_permissions",{ home = tostring(homeName), user_id = parseInt(user_id), tax = parseInt(os.time()) })
								TriggerClientEvent("Notify",source,"sucesso","A residência <b>"..tostring(homeName).."</b> foi comprada com sucesso.",10000)
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)		
							end
						else
							TriggerClientEvent("Notify",source,"negado","Apenas corretores podem fazer isso.",10000)	
						end
					end
					return false
				end
			end
		end
	end
	return false
end

function src.checkIntPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
			if myResult[1] or vRP.hasPermission(user_id,config.policePerm) then
				if not timer then
					timer = true

					SetTimeout(3000,function()
						timer = false
					end)

					return true
				end
			end
		end
	end
	return false
end

RegisterCommand('outfit',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local homeName = vCLIENT.getHomeStatistics(source)
		local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
		if myResult[1] then
			local data = vRP.getSData("outfit:"..tostring(homeName))
			local result = json.decode(data) or {}
			if result then
				if args[1] == "save" and args[2] then
					local custom = vRPclient.getCustomPlayer(source)
					if custom then
						local outname = sanitizeString(rawCommand:sub(13),sanitizes.homename[1],sanitizes.homename[2])
						if result[outname] == nil and string.len(outname) > 0 then
							result[outname] = custom
							vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
							TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> adicionado com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"aviso","Nome escolhido já existe na lista de <b>Outfits</b>.",10000)
						end
					end
				elseif args[1] == "rem" and args[2] then
					local outname = sanitizeString(rawCommand:sub(12),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						result[outname] = nil
						vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> removido com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				elseif args[1] == "apply" and args[2] then
					local outname = sanitizeString(rawCommand:sub(14),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						TriggerClientEvent("updateRoupas",source,result[outname])
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> aplicado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				else
					for k,v in pairs(result) do
						TriggerClientEvent("Notify",source,"importante","<b>Outfit:</b> "..k,20000)
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)

function src.openChest(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(homeName))
		local result = json.decode(data) or {}
		local tcSlot = src.verifyChestSlots(homeName)
		local tSlot = vRP.verifySlots(user_id)

		if result then
			if tcSlot ~= nil then
				tcSlot = tcSlot
			else
				tcSlot = 11
			end

			if tSlot ~= nil then
				tSlot = tSlot
			else
				tSlot = 11
			end

			for k,v in pairs(result) do
				if vRP.itemBodyList(k) then
					tcSlot = tcSlot - 1
					table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
				end
			end

			local inv = vRP.getInventory(parseInt(user_id))

			for k,v in pairs(inv) do
				if vRP.itemBodyList(k) then
					tSlot = tSlot - 1
					table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
				end
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(config.homes[tostring(homeName)]['infos'][3]),parseInt(tSlot),parseInt(tcSlot)
	end
	return false
end

function src.verifyChestSlots(homeName)
	return config.homes[tostring(homeName)]['infos'][4]
end

function src.haveMoreChestSlots(homeName)
	local chestData = "chest:"..tostring(homeName)
	if vRP.getRemaingChestSlots(chestData,src.verifyChestSlots(homeName)) > 0 then
		return true
	else
		return false
	end
end

function src.storeItem(homeName,itemName,amount)
    if itemName then
        local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			local identity = vRP.getUserIdentity(user_id)
			if vRP.storeChestItem(user_id,"chest:"..tostring(homeName),itemName,amount,config.homes[tostring(homeName)]['infos'][1],config.homes[tostring(homeName)]['infos'][4]) then
				TriggerClientEvent("vrp_homes:Update",source,"updateVault")
				TriggerClientEvent("itensNotify",source,"sucesso","Guardou",""..vRP.itemIndexList(itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(itemName)*parseInt(amount)).."")
				PerformHttpRequest(config.webhookSend, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE BAÚ:\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**CASA:**", value = "**"..tostring(homeName)..""}, {name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
			end
        end
    end
end

function src.takeItem(homeName,itemName,amount)
    if itemName then
        local source = source
        local user_id = vRP.getUserId(source)
		if user_id then
			local identity = vRP.getUserIdentity(user_id)
            if vRP.tryChestItem(user_id,"chest:"..tostring(homeName),itemName,amount) then
				TriggerClientEvent("vrp_homes:Update",source,"updateVault")
				TriggerClientEvent("itensNotify",source,"sucesso","Pegou",""..vRP.itemIndexList(itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(itemName)*parseInt(amount)).."")
				PerformHttpRequest(config.webhookTake, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "REGISTRO DE BAÚ:\n⠀", thumbnail = {url = config.webhookIcon}, fields = {{name = "**CASA:**", value = "**"..tostring(homeName)..""}, {name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"}, {name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = config.webhookBottomText..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = config.webhookIcon}, color = config.webhookColor}}}), {['Content-Type'] = 'application/json'})
			end
        end
    end
end

function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,config.policePerm) then
			return true
		end
		return false
	end
end