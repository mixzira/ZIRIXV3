local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]------------------------------------------------------------------------------------

misc = {}
Tunnel.bindInterface("vrp_misc",misc)

--[ VARIABLES ]-------------------------------------------------------------------------------------

SetConvarServerInfo("tags", "zirix, ziraflix")
SetConvarServerInfo("DevelopedBy", "ZIRAFLIX")
SetConvarServerInfo("Discord", "discord.gg/ziraflix")
SetConvarServerInfo("Website", "www.ziraflix.com")

local cooldown = {}

--[ RICHPRESENCE | FUNCTION ]-----------------------------------------------------------------------

function misc.discord()
	local quantidade = 0
	local users = vRP.getUsers()

	for k,v in pairs(users) do
		quantidade = quantidade + 1
	end

	return parseInt(quantidade)
end

--[ RADIO PERMISSION | FUNCTION ]-------------------------------------------------------------------

function misc.permissaoDpla()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"policia.permissao")
end

function misc.permissaoDmla()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"ems.permissao")
end

function misc.permissaoTaxista()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"taxista.permissao")
end

function misc.permissaoMecanico()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"mecanico.permissao")
end

function misc.permissaoBennys()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"bennys.permissao")
end

function misc.permissaoBallas()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"ballas.permissao")
end

function misc.permissaoGrove()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"grove.permissao")
end

function misc.permissaoFamilies()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"families.permissao")
end

function misc.permissaoMedellin()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"medellin.permissao")
end

function misc.permissaoMotoclub()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"motoclub.permissao")
end

function misc.permissaoBratva()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"bratva.permissao")
end

function misc.permissaoNdrangheta()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"ndrangheta.permissao")
end

function misc.permissaoNynax()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"nynax.permissao")
end

function misc.permissaoSemantic()
	local source = source
	local user_id = vRP.getUserId(source)
	
	return vRP.hasPermission(user_id,"semantic.permissao")
end

--[ /RADIO | COMMAND ]------------------------------------------------------------------------------

RegisterCommand('radio',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	
	if vRP.getInventoryItemAmount(user_id,"radio") >= 1 then
		if args[1] == "f" then
			TriggerClientEvent("vrp_misc:onRadio",source,args[2])
		else
			TriggerClientEvent("vrp_misc:onGroupRadio",source)
		end
	else
		TriggerClientEvent("Notify",source,"aviso","Você <b>não possui</b> um <b>rádio</b> na mochila.") 
	end
end)

--[ WATHER ITEM DAMAGE | EVENT ]--------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(cooldown) do
			if v > 0 then
				cooldown[k] = v - 1
			end
		end
	end
end)