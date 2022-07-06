local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

src = {}
Tunnel.bindInterface('vrp_multi_chars', src)
zCLIENT = Tunnel.getInterface('vrp_multi_chars')

local index = 0
local genderIcon = 'assets/error.png'
local spawnLogin = {}
local creating = false

vRP.prepare('vRP/get_users', 'SELECT * FROM vrp_user_ids WHERE identifier = @identifier')

function getPlayerCharacters(identifier)
	return vRP.query('vRP/get_users', { identifier = identifier })
end

function src.verifyChars()
    local source = source
    local steam = vRP.getSteam(source)
    local chars = getPlayerCharacters(steam)
    if chars then
        for a, b in pairs(chars) do
            local currentCharacterModeConsult = vRP.getUData(parseInt(b.user_id), 'currentCharacterMode')
            if currentCharacterModeConsult ~= '' then
                return true
            end
        end
    end
    return false
end

function src.getChars()
    local source = source
    local steam = vRP.getSteam(source)
    local chars = getPlayerCharacters(steam)
    local charSlot = 4
    local characters = {}

    if chars then
        for a, b in pairs(chars) do
            local identity = vRP.getUserIdentity(b.user_id)
            local currentCharacterModeConsult = vRP.getUData(parseInt(b.user_id), 'vRP:datatable')
            if currentCharacterModeConsult ~= '' then
                if currentCharacterModeConsult ~= nil then
                    local currentCharacterModeResult = json.decode(currentCharacterModeConsult)
                    if tonumber(currentCharacterModeResult.customization.modelhash) == 1885233650 then
                        genderIcon = 'assets/masculino.png'
                    else
                        genderIcon = 'assets/feminino.png'  
                    end
                end
                charSlot = charSlot - 1
                table.insert(characters, { id = b.user_id, name = identity.name, firstname = identity.firstname, registration = identity.registration, phone = identity.phone, genderIcon = genderIcon })
            end
        end
        return characters, charSlot        
    end
    return nil
end

function src.setupCharacteristics(user_id)
    local clothingsConsult = vRP.getUData(parseInt(user_id), 'vRP:datatable')
	local clothingsResult = json.decode(clothingsConsult)
    
    local currentCharacterModeConsult = vRP.getUData(parseInt(user_id), 'currentCharacterMode')
	local currentCharacterModeResult = json.decode(currentCharacterModeConsult)

    if clothingsResult and currentCharacterModeResult then
        return clothingsResult.customization, currentCharacterModeResult
    end

end

function src.deleteChar(id)
	local source = source
	local steam = vRP.getSteam(source)
	vRP.execute('vRP/remove_user', { user_id = parseInt(id) })
	Citizen.Wait(1000)
	return getPlayerCharacters(steam)
end

RegisterServerEvent('chars:teste')
AddEventHandler('chars:teste', function(user_id)
    local source = source
    zCLIENT.spawnChar(source, user_id)
end)

RegisterServerEvent('chars:setup')
AddEventHandler('chars:setup', function(source)
	TriggerClientEvent('chars:setupChar', source)
end)

RegisterServerEvent('chars:charChosen')
AddEventHandler('chars:charChosen', function(id)
	local source = source
    TriggerEvent('baseModule:idLoaded', source, id, nil)
    --TriggerEvent('character-creator:spawn', source, id)
end)

RegisterServerEvent('chars:createFirstChar')
AddEventHandler('chars:createFirstChar', function()
    local source = source
	local steam = vRP.getSteam(source)
    local rows = vRP.query('vRP/userid_byidentifier', { identifier = steam })
    local user_id = rows[1].user_id

    if not creating then
        local registration = vRP.generateRegistrationNumber()
        local phone = vRP.generatePhoneNumber()

        TriggerClientEvent('Notify', source, 'importante', 'Aguarde, estamos iniciando o criador de personagem...', 5000)
        
        vRP.execute('vRP/init_user_identity',{
            user_id = user_id,
            registration = registration,
            phone = phone,
            firstname = 'Indigente',
            name = 'Individuo',
            age = 18
        })

        Citizen.Wait(1000)

        spawnLogin[parseInt(user_id)] = true
        TriggerEvent('baseModule:idLoaded', source, user_id)
        TriggerClientEvent('closeInterfaceCreateChar', source)
        TriggerEvent('character-creator:spawn', user_id, source, true)
    end
end)

RegisterServerEvent('chars:createChar')
AddEventHandler('chars:createChar', function()
    local source = source
	local steam = vRP.getSteam(source)
    local persons = getPlayerCharacters(steam)
    local consult = vRP.query('vRP/userid_byidentifier', { identifier = steam })

    if parseInt(#persons) >= 1 then
        local rows = vRP.query('vRP/get_userdata', { user_id = consult[1].user_id, key = 'vRP:datatable' })
	    local array = json.decode(rows[1].dvalue)
        for a, b in pairs(array.groups)  do
            if a == config.permissions then
                if not creating then
                    local rows, affected = vRP.query('vRP/create_user', {})

                    TriggerClientEvent('Notify', source, 'importante', 'Aguarde, estamos iniciando o criador de personagem...', 5000)
                    
                    if #rows then
                        local ids = GetPlayerIdentifiers(source)
                        local user_id = rows[1].id
                        for l, w in pairs(ids) do
                            if (string.find(w,'ip:') == nil) then
                                vRP.execute('vRP/add_identifier',{ user_id = user_id, identifier = w })
                            end
                        end
                        
                        local registration = vRP.generateRegistrationNumber()
                        local phone = vRP.generatePhoneNumber()
                        
                        vRP.execute('vRP/init_user_identity',{
                            user_id = user_id,
                            registration = registration,
                            phone = phone,
                            firstname = 'Indigente',
                            name = 'Individuo',
                            age = 18
                        })

                        Citizen.Wait(1000)

                        spawnLogin[parseInt(user_id)] = true
                        TriggerEvent('baseModule:idLoaded', source, user_id)
                        TriggerClientEvent('closeInterfaceCreateChar', source)
                        TriggerEvent('character-creator:spawn', user_id, source, true)
                        return vRP.setWhitelisted(user_id, true)
                    end
                end
            end
        end
        return TriggerClientEvent('Notify', source, 'importante', 'Você atingiu o limite de personagens.', 5000)
    end
end)