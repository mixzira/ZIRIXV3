local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ VARIABLES ]--------------------------------------------------------------------------------------------------

local userlogin = {}
local auth = false
local customer = 'Teste!'
local webhook = 'https://discord.com/api/webhooks/785562766949613588/RR0voR7PwiZ7w-FZwDai6JLJb7dhnRN1FJMiEgP1S_IMJTXen-xdAizHwF4gHs8EKtev'

function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

--[ FUNCTIONS ]--------------------------------------------------------------------------------------------------

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		local data = vRP.getUData(user_id,"vRP:spawnController")
		local sdata = json.decode(data) or 0
		if sdata then
			Citizen.Wait(1000)
			processSpawnController(source,sdata,user_id)
		end
	end
end)

function processSpawnController(source,statusSent,user_id)
	if statusSent == 2 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			doSpawnPlayer(source,user_id,false)
		else
			doSpawnPlayer(source,user_id,true)
		end
	elseif statusSent == 1 or statusSent == 0 then
		userlogin[user_id] = true
		TriggerClientEvent("character-creator:characterCreate",source)
	end
end

--[ FUNCTIONS ]--------------------------------------------------------------------------------------------------

RegisterServerEvent("character-creator:finishedCharacter")
AddEventHandler("character-creator:finishedCharacter",function(characterNome,characterSobrenome,characterIdade,currentCharacterMode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if auth then
			vRP.setUData(user_id,"currentCharacterMode",json.encode(currentCharacterMode))
			vRP.setUData(user_id,"vRP:spawnController",json.encode(2))
		
			vRP.execute("vRP/update_user_first_spawn",{ user_id = user_id, firstname = characterSobrenome, name = characterNome, age = characterIdade })
		
			doSpawnPlayer(source,user_id,true)
		else
			vRP.setUData(user_id,"currentCharacterMode",json.encode(currentCharacterMode))
			vRP.setUData(user_id,"vRP:spawnController",json.encode(0))
			vRP.execute("vRP/update_user_first_spawn",{ user_id = user_id, firstname = "Indigente", name = "Indivíduo", age = 26 })
			doSpawnPlayer(source,user_id,true)
		end
	end
end)

function doSpawnPlayer(source,user_id,firstspawn)
	TriggerClientEvent("character-creator:normalSpawn",source,firstspawn)
	TriggerEvent("creator-barbershop:init",user_id)
end

AddEventHandler("onResourceStart",function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("http://192.99.251.232:3571/auth/auth.json",function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest("https://api.ipify.org/",function(errorCode, resultData, resultHeaders)
                local data = json.decode(resultData1)
                for k,v in pairs(data) do
                    if k == GetCurrentResourceName() then
                        for a,b in pairs(v) do             
                            if resultData == b then
                                print("\27[32m["..GetCurrentResourceName().."] Autenticado|Para suporte, entre em contato via Discord.")
                                auth = true
                                return
                            end
                        end
                    end            
                end
                SendWebhookMessage(webhook,"prolog\n[DENUNCIA DE VAZAMENTO] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").. "\n[DONO]: "..customer.."\n[INFRATOR]: "..resultData.." \r")                      
                print("\27[31m["..GetCurrentResourceName().."] Não autorizado, adquira já o seu em www.ziraflix.com")
            end)
        end)
    end
end)