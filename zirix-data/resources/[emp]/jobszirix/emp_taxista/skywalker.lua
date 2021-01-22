local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

emp9 = {}
Tunnel.bindInterface("emp_taxista",emp9)

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local taxiMeter = {}

--[ FUNCTIONS ]-----------------------------------------------------------------------------------------------------------

function emp9.addGroup()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.addUserGroup(user_id,configtaxi.group)
end

function emp9.removeGroup()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.removeUserGroup(user_id,configtaxi.remgroup)
end

function emp9.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,configtaxi.permgroup)
end

function emp9.checkPayment(payment)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
     randmoney = parseInt(math.random(configtaxi.taxipayment[1],configtaxi.taxipayment[2])*payment)
     vRP.giveDinheirama(user_id,parseInt(randmoney))
        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
	end
end

--[ TAXIMETRO | FUNCTION ]-----------------------------------------------------------------------------------------------------------

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.3) / mult
end

function splitString(str, sep)
  if sep == nil then sep = "%s" end

  local t={}
  local i=1

  for str in string.gmatch(str, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end

  return t
end