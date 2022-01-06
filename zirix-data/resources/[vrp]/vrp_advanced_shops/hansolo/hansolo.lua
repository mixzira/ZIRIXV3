local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

vSERVER = Tunnel.getInterface('vrp_advanced_shops')

src = {}
Tunnel.bindInterface('vrp_advanced_shops',src)

local shops = {}
local users = {}

local menuactive = false
local openShop = {}
local tShop = ''
local dShop = ''
local tRobbery = 0
local inRobbery = false
local rShop = nil

RegisterNUICallback('buyItem',function(data)
	vSERVER.buyItem(data.item,data.amount,openShop)
end)

RegisterNUICallback('sellItem',function(data)
	vSERVER.sellItem(data.item,data.amount,openShop)
end)

RegisterNUICallback('optionsOn',function()
	SendNUIMessage({ action = 'optionsOn' })
end)

RegisterNUICallback('optionsOff',function()
	SendNUIMessage({ action = 'optionsOff' })
end)

RegisterNUICallback('upgrade',function(data)
	vSERVER.upgradeShop(data.item,data.stock,data.security,openShop)
end)

RegisterNUICallback('upgradePrice',function(data)	
	vSERVER.upgradePrice(data.item,openShop)
end)

RegisterNUICallback('shopClose',function(data)
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = 'hideMenu' })
	menuactive = false
	openShop = nil
	dShop = nil
	TriggerEvent('cancelando',false)
end)

RegisterNUICallback('requestShops',function(data,cb)
	local sname = dShop
	local inventory, weight, maxweight, slots, fslots, fshopslots, shop, vault, maxvault, options, maxstock, security = vSERVER.openNav(sname)
	local imageService = config.imageService
	if inventory then
		cb({ inventory = inventory, weight = weight, maxweight = maxweight, slots = slots, fslots = fslots, fshopslots = fshopslots, shop = shop, sname = sname, vault = vault, maxvault = maxvault, options = options, maxstock = maxstock, security = security, imageService = imageService })
	end
end)

function toggleActionMenu(type)
	menuactive = not menuactive
	if menuactive then
		TransitionToBlurred(1000)
		SetNuiFocus(true,true)
		SendNUIMessage({ action = 'showMenu', type = type })
		TriggerEvent('cancelando',true)
		if vSERVER.checkOwner(type) then
			SendNUIMessage({ action = 'ownerOn' })
		end
	else
		TransitionFromBlurred(1000)
		SetNuiFocus(false,false)
		SendNUIMessage({ action = 'hideMenu' })
		openShop = nil
		tShop = nil
		TriggerEvent('cancelando',false)
	end
end

function LoadModel(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Citizen.Wait(10)
	end
end

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end

function createBlip()
	for k,v in pairs(config.shops) do
		local info = v.info
		local fantasy = vSERVER.getFantasy(k)
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipColour(info.blip, info.color)
        SetBlipScale(info.blip, 0.5)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(fantasy)
        EndTextCommandSetBlipName(info.blip)
    end
end

function drawText3D(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end

RegisterNetEvent('vrp_advanced_shops:use')
AddEventHandler('vrp_advanced_shops:use',function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	if GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_UNARMED') and not IsPedInAnyVehicle(ped) then
		for k,v in pairs(config.shops) do
			local vault = v.vault
			local info = v.info
			local purchase = v.purchase
			tShop = k
			for k,v in pairs(v.coords) do
				local bowz,cdz = GetGroundZFor_3dCoord(v.x, v.y, v.z)
				local distance = GetDistanceBetweenCoords(v.x, v.y, cdz, x, y, z, true)
				if distance < 1.2 then
					dShop = tShop
					toggleActionMenu(dShop)
					openShop = tShop
				end
			end
			local bowz,cdz = GetGroundZFor_3dCoord(vault.position.x, vault.position.y, vault.position.z)
			local distance = GetDistanceBetweenCoords(vault.position.x, vault.position.y, cdz, x, y, z, true)
			if distance < 1.2 and not inRobbery then
				rShop = k
				vSERVER.vaultRobbery(rShop)
			end
			local bowz2, cdz2 = GetGroundZFor_3dCoord(purchase.x, purchase.y, purchase.z)
			local distance2 = GetDistanceBetweenCoords(purchase.x, purchase.y, cdz2, x, y, z, true)
			if distance2 < 1.2 then
				vSERVER.buyStore(tShop)
			end
		end
	end
end)

RegisterNetEvent('vrp_advanced_shops:close')
AddEventHandler('vrp_advanced_shops:close',function(action)
    TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = 'hideMenu' })
	openShop = nil
	tShop = nil
	TriggerEvent('cancelando',false)
end)

RegisterNetEvent('vrp_advanced_shops:Update')
AddEventHandler('vrp_advanced_shops:Update',function(action)
	SendNUIMessage({ action = action })
end)

local shopNameR = nil
local shopSecurity = nil

RegisterNetEvent('vrp_advanced_shops:startRobbery')
AddEventHandler('vrp_advanced_shops:startRobbery',function(shop, security)
	shopNameR = shop
	shopSecurity = security
	inRobbery = true
end)

RegisterNetEvent('vrp_advanced_shops:updateBlip')
AddEventHandler('vrp_advanced_shops:updateBlip',function()
	createBlip()
end)

Citizen.CreateThread(function() 
	createBlip()
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

Citizen.CreateThread(function()
    while true do
		local idle = 1000
		if inRobbery then
			idle = 5
			local ped = PlayerPedId()
			local x,y,z = GetEntityCoords(ped)
			local deletProps = false
			
			if shopSecurity == 3 then
				tRobbery = 50
			elseif shopSecurity == 2 then
				tRobbery = 27
			elseif shopSecurity == 1 then
				tRobbery = 13
			end

			local vault = 0
			local distance = 0

			for k,v in pairs(config.shops) do
				vault = v.vault
				distance = GetDistanceBetweenCoords(vault.position.x, vault.position.y, vault.position.z, x,y,z,true)
				if distance <= 3 then
					break
				end
			end

			TaskGoStraightToCoord(ped, vault.position.x,vault.position.y,vault.position.z,1.0, 100000, vault.position.h, 2.0)

			if distance <= 0.3 then
				ClearPedTasks(ped)
				SetEntityHeading(ped, vault.position.h)
			end

			local thermal_hash = GetHashKey('hei_prop_heist_thermite_flash')
			local bagHash4 = GetHashKey('p_ld_heist_bag_s_pro_o')
			local coords = GetEntityCoords(ped)
			
			LoadModel(thermal_hash)
			Citizen.Wait(10)
			LoadModel(bagHash4)
			Citizen.Wait(10)

			thermalentity = CreateObject(thermal_hash, (vault.position.x+vault.position.y+vault.position.z-0.20)-40, true, true)
			
			local bagProp4 = CreateObject(bagHash4, coords-20, true, false)
			
			SetEntityAsMissionEntity(thermalentity, true, true)
			SetEntityAsMissionEntity(bagProp4, true, true)
			
			termitacolocando = true
			
			local boneIndexf1 = GetPedBoneIndex(PlayerPedId(), 28422)
			local bagIndex1 = GetPedBoneIndex(PlayerPedId(), 57005)
			
			Citizen.Wait(500)
			
			SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
			AttachEntityToEntity(thermalentity, PlayerPedId(), boneIndexf1, 0.0, 0.0, 0.0, 180.0, 180.0, 0, 1, 1, 0, 1, 1, 1)
			AttachEntityToEntity(bagProp4, PlayerPedId(), bagIndex1, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
			RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
			
			while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') do
				Citizen.Wait(100)
			end
			
			vRP._playAnim(false,{{'anim@heists@ornate_bank@thermal_charge','thermal_charge'}},false)
			
			Citizen.Wait(2500)
			
			DetachEntity(bagProp4, 1, 1)
			
			FreezeEntityPosition(bagProp4, true)
			
			Citizen.Wait(2500)
			FreezeEntityPosition(bagProp4, false)
			AttachEntityToEntity(bagProp4, PlayerPedId(), bagIndex1, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
			
			Citizen.Wait(1000)
			DeleteEntity(bagProp4)
			SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
			DeleteEntity(thermalentity)
			ClearPedTasks(ped)
			TriggerEvent('Notify','importante','Você plantou a bomba, cuidado...')
			
			local counter = 0
			
			while counter <= tRobbery and inRobbery do
				if tRobbery == 13 then
					TriggerEvent('vrp_sound:distance', source, 0.8, 'bomb_25', 0.5)
					Citizen.Wait(25000)
					counter = tRobbery + 1
				elseif tRobbery == 27 then
					if counter <= 14 then
						TriggerEvent('vrp_sound:distance', source, 0.8, 'bomb_25', 0.5)
						Citizen.Wait(1000)
					else
						TriggerEvent('vrp_sound:distance', source, 0.8, 'bomb_25', 0.5)
						Citizen.Wait(25000)
						counter = tRobbery + 1
					end
				elseif tRobbery == 50 then
					if counter <= 25 then
						TriggerEvent('vrp_sound:distance', source, 0.8, 'bomb_25', 0.5)
						Citizen.Wait(1000)
					else
						TriggerEvent('vrp_sound:distance', source, 0.8, 'bomb_25', 0.5)
						Citizen.Wait(25000)
						counter = tRobbery + 1
					end
				end
				counter = counter + 1
			end
			
			AddExplosion(vault.position.x, vault.position.y, vault.position.z, 2, 100.0, true, false, true)
			local moneyProp = 'hei_prop_heist_cash_pile'
			RequestModel(moneyProp)
			
			while not HasModelLoaded(moneyProp) do
				Citizen.Wait(10)
			end
			
			if not HasModelLoaded(moneyProp) then
				SetModelAsNoLongerNeeded(moneyProp)
			else
				SetModelAsNoLongerNeeded(moneyProp)
				local counterwell = 4
				local amount = 5
				local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
				while counterwell >= 0 and inRobbery do
					Citizen.Wait(5)
					x,y,z = table.unpack(GetEntityCoords(ped))
					
					local distancewell = GetDistanceBetweenCoords( vault.position.x, vault.position.y, vault.position.z, x, y, z,true)
					local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)
					if amount >= 0 then
						oMoney = CreateObjectNoOffset(moneyProp, vault.position.x2, vault.position.y2, vault.position.z2-0.94, 1, 0, 1)
						PlaceObjectOnGroundProperly(oMoney)
						SetModelAsNoLongerNeeded(oMoney)
						Citizen.InvokeNative(0xAD738C3085FE7E11,oMoney,true,true)
						FreezeEntityPosition(oMoney,true)
						SetEntityAsNoLongerNeeded(oMoney)
						x2,y2,z2 = table.unpack(GetEntityCoords(oMoney))
						amount = amount - 1
					end
					if distancewell <= 1 then
						drawText3D(x2,y2,z2,'~b~[E] ~w~PEGAR')
						if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) and not IsEntityDead(ped) then
							vRP._playAnim(false,{{'pickup_object','pickup_low'}},false)
							Citizen.Wait(1000)
							SetEntityVisible(oMoney, true)
							AttachEntityToEntity(oMoney, PlayerPedId(), boneIndex, 0.125, 0.0, -0.05, 360.0, 150.0, 360.0, true, true, false, true, 1, true)
							Citizen.Wait(800)
							SetEntityVisible(oMoney, false)
							vSERVER.paymentRobbery(shopNameR)
							if counterwell <= 1 then
								local dAmount = 0
								deletProps = true
								if deletProps then
									repeat
										Citizen.Wait(100)
										if DoesObjectOfTypeExistAtCoords(vault.position.x2, vault.position.y2, vault.position.z2-0.94,0.9,GetHashKey(moneyProp),true) then
											oMoney = GetClosestObjectOfType(vault.position.x2, vault.position.y2, vault.position.z2-0.94,0.9,GetHashKey(moneyProp),false,false,false)
											Citizen.InvokeNative(0xAD738C3085FE7E11,oMoney,true,true)
											SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(oMoney))
											DeleteObject(oMoney)
											dAmount = dAmount + 1
										end
									until dAmount > 4 
										deletProps = false
										inRobbery = false
								end
							end
							counterwell = counterwell - 1
						end
					end
					if distancewell > 15 then
						TriggerEvent('Notify','importante','Você fugiu do roubo e deixou tudo para trás')
						counterwell = -1
						inRobbery = false
					end
				end
				DeleteEntity(oMoney)
			end
		end
		Citizen.Wait(idle)
	end
end)