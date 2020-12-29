local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("vrp_lscustoms",emP)

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return (vRP.hasPermission(user_id,"mecanico.permissao"))
	end
end

local tbl = {
	[1] = { locked = false, player = nil }
}

RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage',function(b,garage)
	local source = source
	tbl[parseInt(garage)].locked = b
	if not b then
		tbl[parseInt(garage)].player = nil
	else
		tbl[parseInt(garage)].player = source
	end
	TriggerClientEvent('lockGarage',-1,tbl)
end)

RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo',function()
	TriggerClientEvent('lockGarage',-1,tbl)
end)

AddEventHandler('playerDropped',function()
	local source = source
	for i,g in pairs(tbl) do
		if g.player then
			if source == g.player then
				g.locked = false
				g.player = nil
				TriggerClientEvent('lockGarage',-1,tbl)
			end
		end
	end
end)

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name,button)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if button.price then
			if vRP.tryPayment(user_id,button.price) then
				TriggerClientEvent("LSC:buttonSelected",source,name,button,true)
			else
				TriggerClientEvent("LSC:buttonSelected",source,name,button,false)
			end
		else
			TriggerClientEvent("LSC:buttonSelected",source,name,button,false)
		end
	end
end)

RegisterServerEvent("LSC:finished")
AddEventHandler("LSC:finished",function(veh)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id then
				local mods = veh.mods
				local custom = {}

				custom.spoiler = mods[0].mod
				custom.fbumper = mods[1].mod
				custom.rbumper = mods[2].mod
				custom.skirts = mods[3].mod
				custom.exhaust = mods[4].mod
				custom.rollcage = mods[5].mod
				custom.grille = mods[6].mod
				custom.hood = mods[7].mod 
				custom.fenders = mods[8].mod
				custom.roof = mods[10].mod
				custom.engine = mods[11].mod
				custom.brakes = mods[12].mod
				custom.transmission = mods[13].mod
				custom.horn = mods[14].mod
				custom.suspension = mods[15].mod
				custom.armor = mods[16].mod
				custom.tires = mods[23].mod
				custom.tiresvariation = mods[23].variation

				custom.btires = mods[24].mod
				custom.btiresvariation = mods[24].variation

				custom.plateholder = mods[25].mod
				custom.vanityplates = mods[26].mod
				custom.trimdesign = mods[27].mod 
				custom.ornaments = mods[28].mod
				custom.dashboard = mods[29].mod
				custom.dialdesign = mods[30].mod
				custom.doors = mods[31].mod
				custom.seats = mods[32].mod
				custom.steeringwheels = mods[33].mod
				custom.shiftleavers = mods[34].mod
				custom.plaques = mods[35].mod
				custom.speakers = mods[36].mod
				custom.trunk = mods[37].mod 
				custom.hydraulics = mods[38].mod
				custom.engineblock = mods[39].mod
				custom.camcover = mods[40].mod
				custom.strutbrace = mods[41].mod
				custom.archcover = mods[42].mod
				custom.aerials = mods[43].mod
				custom.roofscoops = mods[44].mod
				custom.tank = mods[45].mod
				custom.doors = mods[46].mod
				custom.liveries = mods[48].mod

				custom.tyresmoke = mods[20].mod
				custom.headlights = mods[22].mod
				custom.turbo = mods[18].mod

				custom.color = veh.color
				custom.extracolor = veh.extracolor
				custom.neon = veh.neon
				custom.neoncolor = veh.neoncolor
				custom.smokecolor = veh.smokecolor
				custom.plateindex = veh.plateindex
				custom.windowtint = veh.windowtint
				custom.wheeltype = veh.wheeltype
				custom.bulletProofTyres = veh.bulletProofTyres

				vRP.setSData("custom:u"..parseInt(puser_id).."veh_"..vname,json.encode(custom))
			end
		end
	end
end)