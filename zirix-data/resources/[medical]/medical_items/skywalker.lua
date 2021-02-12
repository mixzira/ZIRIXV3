local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

src = {}
Tunnel.bindInterface('medical_items',src)
vCLIENT = Tunnel.getInterface('medical_items')

local valores = {
	{ item = "headblock", quantidade = 1, compra = 0 },
	{ item = "gesso", quantidade = 1, compra = 0 },
	{ item = "bandagem", quantidade = 1, compra = 0 },
	{ item = "cinta", quantidade = 1, compra = 0 },
}

function src.checkPermission(permission)
	local src = source
    local user_id = vRP.getUserId(src)
    if user_id then
        return vRP.hasPermission(user_id,permission)
    end
end

RegisterServerEvent("medical-pegar")
AddEventHandler("medical-pegar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.compra)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Pegou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item)..".")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)