--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------

local run = {}

--[ FUNÇÕES & EVENTOS ]------------------------------------------------------------------------------------------------------------------

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	local consulta = vRP.getUData(user_id,"vRP:vip")
	local resultado = json.decode(consulta) or {}
	vRP.setUData(vRP.getUserId(source), "vRP:vip", json.encode(resultado))
	resultado = resultado.tempo or 0
	if tonumber(resultado) > 0 then
		run[user_id] = resultado
	end
	if tonumber(resultado) <= 0 then
		vRP.removevip(user_id)	
	end	
end)

function vRP.removevip(a)
	if vRP.hasPermission(a,"ultimate.permissao") then	
		vRP.removeUserGroup(a,"ultimate")
	elseif vRP.hasPermission(a,"platina.permissao") then	
		vRP.removeUserGroup(a,"platina")
	elseif vRP.hasPermission(a,"ouro.permissao") then	
		vRP.removeUserGroup(a,"ouro")
	elseif vRP.hasPermission(a,"standard.permissao") then	
		vRP.removeUserGroup(a,"standard")
	end	
end	

AddEventHandler("vRP:playerLeave", function(user_id, group, gtype)
	if run[user_id] then
		run[user_id] = nil
	end
end)

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(run) do
			run[k] = v-1
			if run[k] <= 0 then
				run[k] = nil
				vRP.setUData(k, "vRP:vip", json.encode({}))
			else
				local vl = {}
				vl.tempo = v
				vRP.setUData(k, "vRP:vip", json.encode(vl))
			end
		end
		Citizen.Wait(10000)
	end
end)