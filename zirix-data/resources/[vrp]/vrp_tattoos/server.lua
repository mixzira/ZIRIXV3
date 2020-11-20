local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPts = {}
Tunnel.bindInterface("vrp_tattoos",vRPts)
Proxy.addInterface("vrp_tattoos",vRPts)
TSclient = Tunnel.getInterface("vrp_tattoos")

local cfg = module("vrp_tattoos","cfg/tattoos")

function vRPts.openTattooshop(source,shop)
	local user_id = vRP.getUserId(source)
	if user_id then
		local menudata = { name = "Tatuagens" }
		local kitems = {}
		local old_custom = TSclient.getTattoos(source)
		local tattoshop_choice = function(player,choice)
			local tattoo = cfg.tattoos[shop][choice][1]
			if tattoo then
				local applied = false
				if tattoo == "CLEAR" then
					local ok = vRP.request(source,"Tem certeza que deseja <b>limpar</b> as tatuagens?",30)
					if ok then
						TriggerClientEvent("Notify",source,"sucesso","Limpeza concluida.")
						TSclient.cleanPlayer(source)
					end
				else
					local custom = TSclient.getTattoos(source)
					for k,v in pairs(custom) do
						if k == tattoo then
							applied = true
						end
					end
					if not applied then
						TriggerClientEvent("Notify",source,"sucesso","Tatuagem adicionada.")
						TSclient.addTattoo(source,tattoo,shop)
						TriggerClientEvent("reloadtattos",source)
					else
						TriggerClientEvent("Notify",source,"negado","Tatuagem removida.")
						TSclient.delTattoo(source,tattoo)
						TriggerClientEvent("reloadtattos",source)
					end
				end
			end
		end
		menudata.onclose = function(player)
			local custom = TSclient.getTattoos(source)
			local price = 0
			for k,v in pairs(custom) do
				local old = old_custom[k]
				if not old then price = price + 500 end
			end

			if vRP.tryPayment(user_id,price) then
				vRP.setUData(user_id,"vRP:tattoos",json.encode(custom))
				if price > 0 then
					TriggerClientEvent("Notify",source,"sucesso","Pagou <b>$"..price.." dólares</b>.")
				end
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
				TSclient.setTattoos(source,old_custom)
			end
		end

		for k,v in pairs(cfg.tattoos[shop]) do
			if k ~= "_config" then
				menudata[k] = { tattoshop_choice }
			end
		end
		vRP.openMenu(source,menudata)
	end
end

local function build_client_tattooshops(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(cfg.shops) do
			local shop,x,y,z = table.unpack(v)
			local group = cfg.tattoos[shop]

			if group then
				local gcfg = group._config

				local function tattooshop_enter(source)
					vRPts.openTattooshop(source,shop)
				end

				local function tattooshop_leave(source)
					vRP.closeMenu(source)
				end

				vRPclient._addMarker(source,23,x,y,z-0.95,1,1,0.5,255,0,0,50,100)
				vRP.setArea(source,"vRP:tattooshop"..k,x,y,z,1,1,tattooshop_enter,tattooshop_leave)
			end
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_client_tattooshops(source)
		local custom = {}
		local data = vRP.getUData(user_id,"vRP:tattoos")
		if data then
			custom = json.decode(data)
			TSclient.setTattoos(source,custom)
		end
	end
end)