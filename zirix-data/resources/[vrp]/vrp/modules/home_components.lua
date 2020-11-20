local sanitizes = module("cfg/sanitizes")

local function chest_create(owner_id,stype,sid,cid,config,data,x,y,z,player)
	local chest_enter = function(player,area)
	local user_id = vRP.getUserId(player)
	if user_id and (user_id == owner_id or vRP.hasPermission(user_id,"policia.permissao")) then
		vRP.openChest2(player,"u"..owner_id.."-"..config.name.."home",config.weight,nil,nil,nil)
	end
end

local chest_leave = function(player,area)
	vRP.closeMenu(player)
end

local nid = "vRP:home:slot"..stype..sid..":chest"
	vRP.setArea(player,nid,x,y,z,1,1,chest_enter,chest_leave)
end

local function chest_destroy(owner_id,stype,sid,cid,config,x,y,z,player)
	local nid = "vRP:home:slot"..stype..sid..":chest"
	vRPclient._removeNamedMarker(player,nid)
	vRP.removeArea(player,nid)
end

vRP.defHomeComponent("chest",chest_create,chest_destroy)

local function wardrobe_create(owner_id,stype,sid,cid,config,data,x,y,z,player)
	local wardrobe_enter = nil
	wardrobe_enter = function(player,area)
	local user_id = vRP.getUserId(player)
	if user_id and user_id == owner_id then
		local udata = vRP.getUserDataTable(user_id)

		local menu = { name = "Guarda-Roupas" }

		local udata = vRP.getUData(user_id,"vRP:home:wardrobe")
		local sets = json.decode(udata)
		if sets == nil then
			sets = {}
		end

		menu["> Salvar"] = { function(player, choice)
			local setname = vRP.prompt(player,"Nome:","")
			setname = sanitizeString(setname,sanitizes.text[1],sanitizes.text[2])
			if string.len(setname) > 0 then
				local custom =vRPclient.getCustomization(player)
				sets[setname] = custom
				vRP.setUData(user_id,"vRP:home:wardrobe",json.encode(sets))
				wardrobe_enter(player,area)
			end
		end }

		local choose_set = function(player,choice)
		local custom = sets[choice]
		if custom then
			vRPclient._setCustomization(player,custom)
		end
	end

	for k,v in pairs(sets) do
		menu[k] = { choose_set }
	end

	vRP.openMenu(player,menu)
    end
end

local wardrobe_leave = function(player,area)
	vRP.closeMenu(player)
end

local nid = "vRP:home:slot"..stype..sid..":wardrobe"
	vRP.setArea(player,nid,x,y,z,1,1,wardrobe_enter,wardrobe_leave)
end

local function wardrobe_destroy(owner_id,stype,sid,cid,config,data,x,y,z,player)
	local nid = "vRP:home:slot"..stype..sid..":wardrobe"
	vRPclient._removeNamedMarker(player,nid)
	vRP.removeArea(player,nid)
end

vRP.defHomeComponent("wardrobe",wardrobe_create,wardrobe_destroy)