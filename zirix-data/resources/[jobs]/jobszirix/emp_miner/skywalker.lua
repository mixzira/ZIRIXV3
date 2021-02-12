local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp11 = {}
Tunnel.bindInterface("emp_miner",emp11)

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local ammount = {}
local percentage = 0
local itemName = ""

--[ RANDOM AMMOUNT | FUNCTION ]-------------------------------------------------------------------------------------------------

function emp11.ammount()
	local source = source
	if ammount[source] == nil then
		ammount[source] = parseInt(math.random(configminer.miner[1],configminer.miner[2]))
	end
end

--[ CHECK WEIGHT | FUNCTION ]---------------------------------------------------------------------------------------------------

function emp11.checkWeight()
	emp11.ammount()

	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		percentage = math.random(100)
		if percentage <= 58 then
			itemName = configminer.ferro
		elseif percentage >= 59 and percentage <= 79 then
			itemName = configminer.prata
		elseif percentage >= 80 and percentage <= 90 then
			itemName = configminer.ouro
		elseif percentage >= 91 then
			itemName = configminer.diamante
		end
		return vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemName)*ammount[source] <= vRP.getInventoryMaxWeight(user_id) and vRP.tryGetInventoryItem(user_id,configminer.stone,configminer.ammountstone) and TriggerClientEvent("itensNotify",source,"usar","Usou","ponta-britadeira")
	end
end

--[ COLLECT | FUNCTION ]--------------------------------------------------------------------------------------------------------

function emp11.collectOres()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		vRP.giveInventoryItem(user_id,itemName,ammount[source])
		TriggerClientEvent("itensNotify",source,"sucesso","Minerou",""..itemName.."",""..ammount[source].."",""..vRP.format(vRP.getItemWeight(itemName)*parseInt(ammount[source])).."")
		ammount[source] = nil
	end
end

--[ COLLECT | FUNCTION ]--------------------------------------------------------------------------------------------------------

function emp11.checkPlate(modelo)
	local source = source
	local user_id = vRP.getUserId(source)
	local veh,vhash,vplaca,vname = vRPclient.vehListHash(source,4)
	if veh and vhash == modelo then
		local placa_user_id = vRP.getUserByRegistration(vplaca)
		if user_id == placa_user_id then
			return true
		end
	end
end

--[ COLLECT | FUNCTION ]--------------------------------------------------------------------------------------------------------

function emp11.checkCrimeRecord()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.checkCrimeRecord(user_id) > 0 then
			TriggerClientEvent("Notify",source,"negado","Não contratamos pessoas com <b>Ficha Criminal</b>.",10000)
			return false
		else
			return true
		end
	end
end