local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_trunkchest",vRPN)
Proxy.addInterface("vrp_trunkchest",vRPN)

local uchests = {}
local vchests = {}
local actived = {}

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

slotsinv = 0
slotsmala = 0

function vRPN.Inventories()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
		local tSlot = vRP.verifySlots(user_id)
		local tcSlot = vRP.vehicleSlot(vname)
		
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

RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)