local Tools = module("lib/Tools")

local menu_ids = Tools.newIDGenerator()
local client_menus = {}
local rclient_menus = {}

function vRP.openMenu(source,menudef)
	local menudata = {}
	menudata.choices = {}

	for k,v in pairs(menudef) do
		if k ~= "name" and k ~= "onclose" and k ~= "css" then
			table.insert(menudata.choices,{k,v[2]})
		end
	end

	table.sort(menudata.choices, function(a,b)
		return string.upper(a[1]) < string.upper(b[1])
	end)

	menudata.name = menudef.name or "Menu"
	menudata.css = menudef.css or {}
	menudata.id = menu_ids:gen() 

	client_menus[menudata.id] = { def = menudef, source = source }
	rclient_menus[source] = menudata.id

	vRPclient._closeMenu(source)
	vRPclient._openMenuData(source,menudata)
end

function vRP.closeMenu(source)
	vRPclient._closeMenu(source)
end

local prompts = {}
function vRP.prompt(source,title,default_text)
	local r = async()
	prompts[source] = r
	vRPclient._prompt(source,title,default_text)
	return r:wait()
end

local request_ids = Tools.newIDGenerator()
local requests = {}

function vRP.request(source,text,time)
	local r = async()
	local id = request_ids:gen()
	local request = { source = source, cb_ok = r, done = false }
	requests[id] = request

	vRPclient.request(source,id,text,time)

	SetTimeout(time*1000,function()
		if not request.done then
			request.cb_ok(false)
			request_ids:free(id)
			requests[id] = nil
		end
	end)
	return r:wait()
end

local menu_builders = {}
function vRP.registerMenuBuilder(name,builder)
	local mbuilders = menu_builders[name]
	if not mbuilders then
		mbuilders = {}
		menu_builders[name] = mbuilders
	end
	table.insert(mbuilders,builder)
end

function vRP.buildMenu(name,data)
	local r = async()
	local choices = {}
	local mbuilders = menu_builders[name]
	if mbuilders then
		local count = #mbuilders
		for k,v in pairs(mbuilders) do
			local done = false
			local function add_choices(bchoices)
				if not done then
					done = true

					if bchoices then
						for k,v in pairs(bchoices) do
							choices[k] = v
						end
					end

					count = count-1
					if count == 0 then
						r(choices)
					end
				end
			end
			v(add_choices,data)
		end
		return r:wait()
	end

	return {}
end

function vRP.openMainMenu(source)
	local menudata = vRP.buildMenu("main",{ player = source })
	menudata.name = "Telefone"
	vRP.openMenu(source,menudata)
end

function tvRP.closeMenu(id)
	local source = source
	local menu = client_menus[id]
	if menu and menu.source == source then
		if menu.def.onclose then
			menu.def.onclose(source)
		end
		menu_ids:free(id)
		client_menus[id] = nil
		rclient_menus[source] = nil
	end
end

function tvRP.validMenuChoice(id,choice,mod)
	local source = source
	local menu = client_menus[id]
	if menu and menu.source == source then
		local ch = menu.def[choice]
		if ch then
			local cb = ch[1]
			if cb then
				cb(source,choice,mod)
			end
		end
	end
end

function tvRP.promptResult(text)
	if text == nil then
		text = ""
	end

	local prompt = prompts[source]
	if prompt ~= nil then
		prompts[source] = nil
		prompt(text)
	end
end

function tvRP.requestResult(id,ok)
	local request = requests[id]
	if request and request.source == source then
		request.done = true
		request.cb_ok(not not ok)
		request_ids:free(id)
		requests[id] = nil
	end
end

function tvRP.openMainMenu()
	vRP.openMainMenu(source)
end

AddEventHandler("vRP:playerLeave",function(user_id,source)
	local id = rclient_menus[source]
	if id then
		local menu = client_menus[id]
		if menu and menu.source == source then
			if menu.def.onclose then
				menu.def.onclose(source)
			end

			menu_ids:free(id)
			client_menus[id] = nil
			rclient_menus[source] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRYDELETEPED ]-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
AddEventHandler("trydeleteped",function(index)
	TriggerClientEvent("syncdeleteped",-1,index)
end)