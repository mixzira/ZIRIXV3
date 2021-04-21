local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

src = {}
Tunnel.bindInterface('medical_system',src)
vCLIENT = Tunnel.getInterface('medical_system')

local idgens = Tools.newIDGenerator()
local morto = false

local bones = {
	[11816] = 'Pélvis',
	[58271] = 'Coxa Esquerda',
	[63931] = 'Panturrilha Esquerda',
	[14201] = 'Pé Esquerdo',
	[2108] = 'Dedo do Pé Esquerdo',
	[65245] = 'Pé Esquerdo',
	[57717] = 'Pé Esquerdo',
	[46078] = 'Joelho Esquerdo',
	[51826] = 'Coxa Direita',
	[36864] = 'Panturrilha Direita',
	[52301] = 'Pé Direito',
	[20781] = 'Dedo do Pé Direito',
	[35502] = 'Pé Direito',
	[24806] = 'Pé Direito',
	[16335] = 'Joelho Direito',
	[23639] = 'Coxa Direita',
	[6442] = 'Coxa Direita',
	[57597] = 'Espinha Cervical',
	[23553] = 'Espinha Toráxica',
	[24816] = 'Espinha Lombar',
	[24817] = 'Espinha Sacral',
	[24818] = 'Espinha Cocciana',
	[64729] = 'Escápula Esquerda',
	[45509] = 'Braço Esquerdo',
	[61163] = 'Antebraço Esquerdo',
	[18905] = 'Mão Esquerda',
	[18905] = 'Mão Esquerda',
	[26610] = 'Dedo Esquerdo',
	[4089] = 'Dedo Esquerdo',
	[4090] = 'Dedo Esquerdo',
	[26611] = 'Dedo Esquerdo',
	[4169] = 'Dedo Esquerdo',
	[4170] = 'Dedo Esquerdo',
	[26612] = 'Dedo Esquerdo',
	[4185] = 'Dedo Esquerdo',
	[4186] = 'Dedo Esquerdo',
	[26613] = 'Dedo Esquerdo',
	[4137] = 'Dedo Esquerdo',
	[4138] = 'Dedo Esquerdo',
	[26614] = 'Dedo Esquerdo',
	[4153] = 'Dedo Esquerdo',
	[4154] = 'Dedo Esquerdo',
	[60309] = 'Mão Esquerda',
	[36029] = 'Mão Esquerda',
	[61007] = 'Antebraço Esquerdo',
	[5232] = 'Antebraço Esquerdo',
	[22711] = 'Cotovelo Esquerdo',
	[10706] = 'Escápula Direita',
	[40269] = 'Braço Direito',
	[28252] = 'Antebraço Direito',
	[57005] = 'Mão Direita',
	[58866] = 'Dedo Direito',
	[64016] = 'Dedo Direito',
	[64017] = 'Dedo Direito',
	[58867] = 'Dedo Direito',
	[64096] = 'Dedo Direito',
	[64097] = 'Dedo Direito',
	[58868] = 'Dedo Direito',
	[64112] = 'Dedo Direito',
	[64113] = 'Dedo Direito',
	[58869] = 'Dedo Direito',
	[64064] = 'Dedo Direito',
	[64065] = 'Dedo Direito',
	[58870] = 'Dedo Direito',
	[64080] = 'Dedo Direito',
	[64081] = 'Dedo Direito',
	[28422] = 'Mão Direita',
	[6286] = 'Mão Direita',
	[43810] = 'Antebraço Direito',
	[37119] = 'Antebraço Direito',
	[2992] = 'Cotovelo Direito',
	[39317] = 'Pescoço',
	[31086] = 'Cabeça',
	[12844] = 'Cabeça',
	[65068] = 'Rosto'
}

function src.checkPermission(permission)
	local src = source
    local user_id = vRP.getUserId(src)
    if user_id then
        return vRP.hasPermission(user_id,permission)
    end
end

function src.checkOfficer()
	local src = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,config.medicpermission) then
		return true
	end
end

function src.checkServices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local paramedicos = vRP.getUsersByPermission(config.medicpermission)
		if parseInt(#paramedicos) == 0 then
			return true
		end
	end
end

	local headTwo = false
	local breastTwo = false
	local legsTwo = false
	local footTwo = false
	
function src.raiox()
    local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local head = false
	local breast = false
	local legs = false
	local foot = false
	if nplayer then
		local diagnostic = vCLIENT.getDiagnostic(nplayer)
		for k,v in pairs(diagnostic) do
			if morto == false then
				if diagnostic then
					if k == 31086 or k == 12844 or k == 65068 or k == 39317 then -- cabeca/pescoco
						head = true
						headTwo = true
					end
					if k == 58271 or k == 51826 or k == 23639 or k == 6442 or k == 45509 or k == 61163
						or k == 61007 or k == 5232 or k == 40269 or k == 28252 or k == 43810 or k == 37119
						or k == 22711 or k == 2992 or k == 11816 or k == 63931 or k == 36864 or k == 46078 
						or k == 16335 then --Pernas/coxas/bracos/antebracos/cotovelos/pelvis/panturrilha/joelho
						legs = true
						legsTwo = true
					end
					if k == 2108 or k == 20781 or k == 26610 or k == 4089 or k == 4090 or k == 26611 
						or k == 4169 or k == 4170 or k == 26612 or k == 4185 or k == 4186 or k == 26613 
						or k == 4137 or k == 4138 or k == 26614 or k == 4153 or k == 4154 or k == 58866
						or k == 64016 or k == 64017 or k == 58867 or k == 64096 or k == 64097 or k == 58868
						or k == 64112 or k == 64113 or k == 58869 or k == 64064 or k == 64065 or k == 58870
						or k == 64080 or k == 64081 or k == 18905 or k == 60309 or k == 36029 or k == 57005
						or k == 28422 or k == 6286 or k == 14201 or k == 65245 or k == 57717 or k == 52301 
						or k == 35502 or k == 24806 then -- pé/mão/dedo do pé/mão
						foot = true
						footTwo = true
					end
					if k == 57597 or k == 23553 or k == 24816 or k == 24817 or k == 24818 or k == 64729 
						or k == 10706 then --Escapula/Espinhas cervicais/lobar/chacal
						breast = true
						breastTwo = true
					end
				end
			end
		end
		return head, legs, foot, breast 
	end
end



RegisterCommand(config.treatment,function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local medico = user_id
    if vRP.hasPermission(user_id,config.medicpermission) then
		local nplayer = vRPclient.getNearestPlayer(source,2)
        if nplayer then
			local vida = vRPclient.getHealth(nplayer)
			if vida >=103 then
				if headTwo == true then
					if vRP.tryGetInventoryItem(user_id, "headblock",1) then
						TriggerClientEvent("Notify",source,"sucesso","Tratamento de coluna iniciado.",8000)
						TriggerClientEvent("tratamento",nplayer)
						TriggerClientEvent("resetDiagnostic",nplayer)
						TriggerClientEvent("resetBleeding",nplayer)
						TriggerClientEvent("resetWarfarina",nplayer)
						headTwo = false
					
					else 
						TriggerClientEvent("Notify",source,"negado","Você não possui o item necessario",8000)
					end
				
				else
					TriggerClientEvent("Notify",source,"negado","A cabeça não está machucada.",8000)
				end
				if legsTwo == true then
					if vRP.tryGetInventoryItem(user_id, "gesso",1) then
						TriggerClientEvent("Notify",source,"sucesso","Tratamento de braços/pernas iniciado.",8000)
						TriggerClientEvent("tratamento",nplayer)
						TriggerClientEvent("resetDiagnostic",nplayer)
						TriggerClientEvent("resetBleeding",nplayer)
						TriggerClientEvent("resetWarfarina",nplayer)
						legsTwo = false
					
					else
						TriggerClientEvent("Notify",source,"negado","Você não possui o item necessario",8000)
					end
				
				else
					TriggerClientEvent("Notify",source,"negado","Os braços/pernas não estão machucados.",8000)
				end
				if footTwo == true then
					if vRP.tryGetInventoryItem(user_id, "bandagem",1) then
						TriggerClientEvent("Notify",source,"sucesso","Tratamento de mãos/pés iniciado.",8000)
						TriggerClientEvent("tratamento",nplayer)
						TriggerClientEvent("resetDiagnostic",nplayer)
						TriggerClientEvent("resetBleeding",nplayer)
						TriggerClientEvent("resetWarfarina",nplayer)
						footTwo = false
					
					else
						TriggerClientEvent("Notify",source,"negado","Você não possui o item necessario",8000)
					end
				
				else
					TriggerClientEvent("Notify",source,"negado","As mãos/pés não estão machucados.",8000)
				end
				if breastTwo == true then
					if vRP.tryGetInventoryItem(user_id, "cinta",1) then
						TriggerClientEvent("Notify",source,"sucesso","Tratamento de torax iniciado.",8000)
						TriggerClientEvent("tratamento",nplayer)
						TriggerClientEvent("resetDiagnostic",nplayer)
						TriggerClientEvent("resetBleeding",nplayer)
						TriggerClientEvent("resetWarfarina",nplayer)
						breastTwo = false
					
					else
						TriggerClientEvent("Notify",source,"negado","Você não possui o item necessario",8000)
					end
				
				else
					TriggerClientEvent("Notify",source,"negado","O torax não está machucado.",8000)
				end
            end
        end
    end
end)

RegisterCommand(config.revive,function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,config.medicpermission) then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isInComa(nplayer) then
				local identity_user = vRP.getUserIdentity(user_id)
				local nuser_id = vRP.getUserId(nplayer)
				local identity_coma = vRP.getUserIdentity(nuser_id)
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
				TriggerClientEvent("progress",source,30000,"reanimando")
				SetTimeout(30000,function()				
					vRPclient.killGod(nplayer)
					vRPclient._stopAnim(source,false)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent("Notify",source,"importante","O paciente foi reanimado.")
					TriggerClientEvent('cancelando',source,false)
				end)
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
		end
	end
end)