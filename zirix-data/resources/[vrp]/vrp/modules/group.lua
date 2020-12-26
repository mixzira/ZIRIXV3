local groups = groups.list
local users = groups.users

function vRP.getGroupTitle(group)
	local g = groups[group]
	if g and g._config and g._config.title then
		return g._config.title
	end
	return group
end

function vRP.getUserGroups(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then 
		if data.groups == nil then
			data.groups = {}
		end
		return data.groups
	else
		return {}
	end
end

function vRP.getUserGroupByType(user_id,gtype)
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
				return kgroup._config.title
			end
		end
	end
	return ""
end
function vRP.addUserGroup(user_id,group)
	if not vRP.hasGroup(user_id,group) then
		local user_groups = vRP.getUserGroups(user_id)
		local ngroup = groups[group]
		if ngroup then
			if ngroup._config and ngroup._config.gtype ~= nil then
				local _user_groups = {}
				for k,v in pairs(user_groups) do
					_user_groups[k] = v
				end

				for k,v in pairs(_user_groups) do
					local kgroup = groups[k]
					if kgroup and kgroup._config and ngroup._config and kgroup._config.gtype == ngroup._config.gtype then
						vRP.removeUserGroup(user_id,k)
					end
				end
			end

			user_groups[group] = true
			local player = vRP.getUserSource(user_id)
			if ngroup._config and ngroup._config.onjoin and player ~= nil then
				ngroup._config.onjoin(player)
			end

			local gtype = nil
			if ngroup._config then
				gtype = ngroup._config.gtype 
			end
			TriggerEvent("vRP:playerJoinGroup",user_id,group,gtype)
		end
	end
end

function vRP.getUsersByPermission(perm)
	local users = {}
	for k,v in pairs(vRP.rusers) do
		if vRP.hasPermission(tonumber(k),perm) then
			table.insert(users,tonumber(k))
		end
	end
	return users
end

function vRP.removeUserGroup(user_id,group)
	local user_groups = vRP.getUserGroups(user_id)
	local groupdef = groups[group]
	if groupdef and groupdef._config and groupdef._config.onleave then
		local source = vRP.getUserSource(user_id)
		if source then
			groupdef._config.onleave(source)
		end
	end

	local gtype = nil
	if groupdef._config then
		gtype = groupdef._config.gtype 
	end

	TriggerEvent("vRP:playerLeaveGroup",user_id,group,gtype)
	user_groups[group] = nil
end

function vRP.hasGroup(user_id,group)
	local user_groups = vRP.getUserGroups(user_id)
	return (user_groups[group] ~= nil)
end

local func_perms = {}

function vRP.registerPermissionFunction(name,callback)
	func_perms[name] = callback
end

vRP.registerPermissionFunction("not",function(user_id,parts)
	return not vRP.hasPermission(user_id,"!"..table.concat(parts,".",2))
end)

vRP.registerPermissionFunction("is",function(user_id,parts)
	local param = parts[2]
	if param == "inside" then
		local player = vRP.getUserSource(user_id)
		if player then
			return vRPclient.isInside(player)
		end
	elseif param == "invehicle" then
		local player = vRP.getUserSource(user_id)
		if player then
			return vRPclient.isInVehicle(player)
		end
	end
end)

function vRP.hasPermission(user_id,perm)
	local user_groups = vRP.getUserGroups(user_id)
	local fchar = string.sub(perm,1,1)

	if fchar == "@" then
		local _perm = string.sub(perm,2,string.len(perm))
		local parts = splitString(_perm,".")
		if #parts == 3 then
			local group = parts[1]
			local aptitude = parts[2]
			local op = parts[3]

			local alvl = math.floor(vRP.expToLevel(vRP.getExp(user_id,group,aptitude)))

			local fop = string.sub(op,1,1)
			if fop == "<" then
				local lvl = parseInt(string.sub(op,2,string.len(op)))
				if alvl < lvl then
					return true
				end
			elseif fop == ">" then
				local lvl = parseInt(string.sub(op,2,string.len(op)))
				if alvl > lvl then
					return true
				end
			else
				local lvl = parseInt(string.sub(op,1,string.len(op)))
				if alvl == lvl then
					return true
				end
			end
		end
	elseif fchar == "#" then
		local _perm = string.sub(perm,2,string.len(perm))
		local parts = splitString(_perm,".")
		if #parts == 2 then
			local item = parts[1]
			local op = parts[2]

			local amount = vRP.getInventoryItemAmount(user_id, item)

			local fop = string.sub(op,1,1)
			if fop == "<" then
				local n = parseInt(string.sub(op,2,string.len(op)))
				if amount < n then
					return true
				end
			elseif fop == ">" then
				local n = parseInt(string.sub(op,2,string.len(op)))
				if amount > n then
					return true
				end
			else
				local n = parseInt(string.sub(op,1,string.len(op)))
				if amount == n then
					return true
				end
			end
		end
	elseif fchar == "!" then
		local _perm = string.sub(perm,2,string.len(perm))
		local parts = splitString(_perm,".")
		if #parts > 0 then
			local fperm = func_perms[parts[1]]
			if fperm then
				return fperm(user_id, parts) or false
			else
				return false
			end
		end
	else
		local nperm = "-"..perm
		for k,v in pairs(user_groups) do
			if v then
				local group = groups[k]
				if group then
					for l,w in pairs(group) do
						if l ~= "_config" and w == nperm then
							return false
						end
					end
				end
			end
		end

		for k,v in pairs(user_groups) do
			if v then
				local group = groups[k]
				if group then
					for l,w in pairs(group) do
						if l ~= "_config" and w == perm then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

function vRP.hasPermissions(user_id, perms)
	for k,v in pairs(perms) do
		if not vRP.hasPermission(user_id, v) then
			return false
		end
	end
	return true
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		if user_id == 1 then
			vRP.addUserGroup(user_id, groups.masterGroup)
		end
	end

	local user_groups = vRP.getUserGroups(user_id)

	for k,v in pairs(user_groups) do
		local group = groups[k]
		if group and group._config and group._config.onspawn then
			group._config.onspawn(source)
		end
	end
end)