local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local system = {}

RegisterServerEvent("eblips:add")
AddEventHandler("eblips:add", function(person)
	system[person.src] = person
	for k,v in pairs(system) do
		TriggerClientEvent("eblips:updateAll",k,system)
		Citizen.Wait(10)
	end
	TriggerClientEvent("eblips:toggle",person.src,true)
end)

RegisterServerEvent("eblips:add2")
AddEventHandler("eblips:add2", function(person)
	system[person.src] = person
	for k,v in pairs(system) do
		TriggerClientEvent("eblips:updateAll",k,system)
		Citizen.Wait(10)
	end
end)

RegisterServerEvent("eblips:remove")
AddEventHandler("eblips:remove",function(src)
	system[src] = nil
	for k,v in pairs(system) do
		TriggerClientEvent("eblips:remove",tonumber(k),src)
		Citizen.Wait(10)
	end
	TriggerClientEvent("eblips:toggle",src,false)
end)

AddEventHandler("playerDropped",function()
	if system[source] then
		system[source] = nil
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		if vRP.hasPermission(user_id,"policia.permissao") then
			TriggerEvent("eblips:add",{ name = "Agente", src = source, color = 5 })
		elseif vRP.hasPermission(user_id,"ems.permissao") then
			TriggerEvent("eblips:add2",{ name = "Colaborador", src = source, color = 48 })
		end
	end
end)