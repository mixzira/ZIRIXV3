local cfg = module("cfg/cloakrooms")

local menus = {}

function vRP.save_idle_custom(player,custom)
	local r_idle = {}
	local user_id = vRP.getUserId(player)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			if data.cloakroom_idle == nil then
				data.cloakroom_idle = custom
			end

			for k,v in pairs(data.cloakroom_idle) do
				r_idle[k] = v
			end
		end
	end
	return r_idle
end

function vRP.removeCloak(player)
	local user_id = vRP.getUserId(player)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			if data.cloakroom_idle ~= nil then
				vRPclient._setCustomization(player,data.cloakroom_idle)
				data.cloakroom_idle = nil
			end
		end
	end
end

async(function()
	for k,v in pairs(cfg.cloakroom_types) do
		local menu = { name = k }
		menus[k] = menu
		local not_uniform = false

		if v._config and v._config.not_uniform then
			not_uniform = true
		end

		local choose = function(player,choice)
			local custom = v[choice]
			if custom then
				old_custom = vRPclient.getCustomization(player)
				local idle_copy = {}

				if not not_uniform then
					idle_copy = vRP.save_idle_custom(player,old_custom)
				end

				if custom.model then
					idle_copy.modelhash = nil
				end

				for l,w in pairs(custom) do
					idle_copy[l] = w
				end

				vRPclient._setCustomization(player,idle_copy)
			end
		end

		if not not_uniform then
			menu["> Retirar"] = { function(player,choice) vRP.removeCloak(player) end }
		end

		for l,w in pairs(v) do
			if l ~= "_config" then
				menu[l] = { choose }
			end
		end
	end
end)

local function build_client_points(source)
	for k,v in pairs(cfg.cloakrooms) do
		local gtype,x,y,z = table.unpack(v)
		local cloakroom = cfg.cloakroom_types[gtype]
		local menu = menus[gtype]
		if cloakroom and menu then
			local gcfg = cloakroom._config or {}
			local function cloakroom_enter(source,area)
				local user_id = vRP.getUserId(source)
				if user_id and vRP.hasPermissions(user_id,gcfg.permissions or {}) then
					if gcfg.not_uniform then
						local data = vRP.getUserDataTable(user_id)
					end
					vRP.openMenu(source,menu)
				end
			end

			local function cloakroom_leave(source,area)
				vRP.closeMenu(source)
			end

			vRP.setArea(source,"vRP:cfg:cloakroom"..k,x,y,z,2,2,cloakroom_enter,cloakroom_leave)
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_client_points(source)
	end
end)