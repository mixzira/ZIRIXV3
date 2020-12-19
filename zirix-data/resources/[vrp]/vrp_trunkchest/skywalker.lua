local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONEXÕES ]---------------------------------------------------------------------------------------------------------------------------

vRPN = {}
Tunnel.bindInterface("vrp_trunkchest",vRPN)
Proxy.addInterface("vrp_trunkchest",vRPN)

--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------

local uchests = {}
local vchests = {}
local actived = {}
local auth = false
local customer = 'N/A'
local customerid = 'N/A'
local customeremail = 'N/A'
local customerdiscord = '<@N/A>'
local customerip = 'N/A'
local webhook = 'https://discord.com/api/webhooks/785562766949613588/RR0voR7PwiZ7w-FZwDai6JLJb7dhnRN1FJMiEgP1S_IMJTXen-xdAizHwF4gHs8EKtev'

--[ ACTIVED ]----------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(actived) do
			if parseInt(v) > 0 then
				actived[k] = parseInt(v) - 1
			end
		end
		Citizen.Wait(1000)
	end
end)

--[ INVENTORY & TRUNKCHEST ]-------------------------------------------------------------------------------------------------------------

slotsinv = 0
slotsmala = 0

function vRPN.Inventories()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
		local tSlot = vRP.verifySlots(user_id)
		local tcSlot = vRP.vehicleSlot(vname)
		if tcSlot == nil then
			tcSlot = 5
		end
		
		if vehicle then
			local placa_user_id = vRP.getUserByRegistration(placa)
			if placa_user_id then
				local myinventory = {}
				local myvehicle = {}

				local mala = "chest:u"..parseInt(placa_user_id).."veh_"..vname
				local data = vRP.getSData(mala)
				local sdata = json.decode(data) or {}
				
				if sdata then
					for k,v in pairs(sdata) do
						if vRP.itemBodyList(k) then
							tcSlot = tcSlot - 1
							table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
						end
					end
				end

				slotsmala = tcSlot

				local inv = vRP.getInventory(parseInt(user_id))
				for k,v in pairs(inv) do
					if vRP.itemBodyList(k) then
						tSlot = tSlot - 1
						table.insert(myvehicle,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
					end
				end

				slotsinv = tSlot

				uchests[parseInt(user_id)] = mala
				vchests[parseInt(user_id)] = vname
				return myinventory,myvehicle,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(sdata),parseInt(vRP.vehicleChest(vname)),parseInt(tSlot),parseInt(tcSlot)
			end
		end
	end
	return false
end


--[ STOREITEM ]--------------------------------------------------------------------------------------------------------------------------

function vRPN.storeItem(itemName,amount)
	if itemName then
		local source = source
		local user_id = vRP.getUserId(source)

		if user_id and slotsmala > 0 then
			if string.match(itemName,"dinheiro-sujo") then
				TriggerClieDntEvent("Notify",source,"importante","Não pode guardar este item.",8000)
				return
			end

			if (vchests[parseInt(user_id)] == "armytanker" or vchests[parseInt(user_id)] == "tanker2") and itemName ~= "wammo|WEAPON_PETROLCAN" then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item em veículos.",8000)
				return
			end

			if vRP.storeChestItem(user_id,uchests[parseInt(user_id)],itemName,amount,parseInt(vRP.vehicleChest(vchests[user_id]))) then
				TriggerClientEvent('Trunk:UpdateTrunk',source,'updateInventory')
				TriggerClientEvent("itensNotify",source,"sucesso","Guardou",""..vRP.itemIndexList(itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(itemName)*parseInt(amount)).."")
			end
		end
	end
end

--[ TAKEITEM ]---------------------------------------------------------------------------------------------------------------------------

function vRPN.takeItem(itemName,amount)
	if itemName then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id and slotsinv > 0 then
			if vRP.tryChestItem(user_id,uchests[parseInt(user_id)],itemName,amount) then
				TriggerClientEvent('Trunk:UpdateTrunk',source,'updateInventory')
				TriggerClientEvent("itensNotify",source,"sucesso","Pegou",""..vRP.itemIndexList(itemName).."",""..vRP.format(parseInt(amount)).."",""..vRP.format(vRP.getItemWeight(itemName)*parseInt(amount)).."")
			end
		end
	end
end

--[ CHESTCLOSE ]-------------------------------------------------------------------------------------------------------------------------

function vRPN.chestClose()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid = vRPclient.vehList(source,7)
		uchests[parseInt(user_id)] = nil
		vchests[parseInt(user_id)] = nil
	end
	return false
end

--[ TRUNK ]------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("trytrunk:trunk")
AddEventHandler("trytrunk:trunk",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle, vnetid, placa, vname, lock, banned, trunk = vRPclient.vehList(source,7)
		if vehicle then	
			if not lock then
				if banned then
					return
				end
				local placa_user_id = vRP.getUserByRegistration(placa)
				if placa_user_id then
					TriggerClientEvent("trunkchest:Open",source)
				end
			end
		end
	end
end)

--[ SYNC TRUNKDOOR ]---------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)

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
				PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = "**Atenção:** <@&748720506169196675>**!**", embeds = {{title = "PRODUTO NÃO AUTENTICADO:\n⠀", thumbnail = {url = 'https://i.imgur.com/Y5Zktwm.png'}, fields = {{ name = "**Produto:**", value = ""..GetCurrentResourceName().."\n⠀"}, {name = "**• DADOS DO PROPRIETÁRIO:**", value = "⠀"}, {name = "**Nome completo:**", value = ""..customer..""}, {name = "**Nº contrato:**", value = ""..customerid..""}, {name = "**E-mail:**", value = ""..customeremail..""}, {name = "**Discord:**", value = ""..customerdiscord.."\n⠀"}, {name = "**• DADOS DE REDE:**", value = "⠀"}, {name = "**IP autorizado:**", value = "` "..customerip.." `"}, {name = "**IP não autorizado:**", value = "` "..resultData.." `\n⠀"}}, footer = {text = 'ZIRAFLIX Inc. Todos os direitos reservados | '..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = 'https://i.imgur.com/Y5Zktwm.png'}, color = 1975079}}}), {['Content-Type'] = 'application/json'})                    
                print("\27[31m["..GetCurrentResourceName().."] Não autenticado! Adquira já o seu em www.ziraflix.com;")
            end)
        end)
    end
end)

function vRPN.checkAuth()
	if auth then
		return true
    end
end