local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPex = {}
Tunnel.bindInterface("police_arsenal",vRPex)

function vRPex.checkPermission(permission)
	local src = source
    local user_id = vRP.getUserId(src)
    if user_id then
        return vRP.hasPermission(user_id,permission)
    end
end

function vRPex.checkOfficer()
	local src = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paisana-policia.permissao") then
		return true
	end
end

RegisterNetEvent('flix:onarmor')
AddEventHandler('flix:onarmor',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,config.vest) then
			vRPclient.setArmour(source,100)
			return true
		end
	end
end)

RegisterNetEvent('flix:offarmor')
AddEventHandler('flix:offarmor',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,config.vest) then
			vRPclient.setArmour(source,0)
			return true
		end
	end
end)

function vRPex.remEquip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRPclient.setArmour(source,0)
		vRPclient._replaceWeapons(source,{["WEAPON_UNARMED"] = { ammo = 0 }})
	end
end

RegisterServerEvent("bdl:onduty")
AddEventHandler("bdl:onduty",function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"paisana-policia.permissao") then
        vRP.addUserGroup(user_id,"policia")
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.",5000)
        
    else
        TriggerClientEvent("Notify",source,"negado","Você já está em serviço.",5000)
    end
end)

RegisterServerEvent("bdl:offduty")
AddEventHandler("bdl:offduty",function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") then
        vRP.addUserGroup(user_id,"paisana-policia")
		vRPex.remEquip()
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
		TriggerClientEvent("Notify",source,"aviso","Seus equipamentos foram guardados no arsenal.",5000) 
    else
        TriggerClientEvent("Notify",source,"negado","Você já está fora de serviço.",5000)
    end
end)