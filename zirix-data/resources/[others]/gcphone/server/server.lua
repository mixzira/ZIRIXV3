local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
local idgens = Tools.newIDGenerator()
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("gcphone",src)

--[ WEBHOOKS ]------------------------------------------------------------------------------------------------------------------

local webhookbanco = ""
local plan = {}

--[ FUNCTIONS ]-----------------------------------------------------------------------------------------------------------------

function src.checkItemPhone()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.getInventoryItemAmount(user_id,"celular") >= 1 or vRP.getInventoryItemAmount(user_id,"celular-pro") >= 1 then
            return true 
        else
            TriggerClientEvent("Notify",source,"negado","Você não possui um celular em sua mochila.") 
            return false
        end
    end
end

--[ FUNCTIONS ]-----------------------------------------------------------------------------------------------------------------

math.randomseed(os.time()) 

function getPhoneRandomNumber()
    local numBase0 = math.random(100,999)
    local numBase1 = math.random(0,9999)
    local num = string.format("%03d-%04d", numBase0, numBase1)

	return num
end

function getNumberPhone(identifier)
	local result = MySQL.Sync.fetchAll("SELECT vrp_user_identities.phone FROM vrp_user_identities WHERE vrp_user_identities.user_id = @identifier",{ ['@identifier'] = identifier })
	if result[1] ~= nil then
		return result[1].phone
	end
	return nil
end

--[ FUNCTIONS ]-----------------------------------------------------------------------------------------------------------------

function getIdentifierByPhoneNumber(phone_number) 
	local result = MySQL.Sync.fetchAll("SELECT vrp_user_identities.user_id FROM vrp_user_identities WHERE vrp_user_identities.phone = @phone_number",{ ['@phone_number'] = phone_number })
	if result[1] ~= nil then
		return result[1].user_id
	end
	return nil
end

function getPlayerID(source)
	local player = vRP.getUserId(source)
	return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

function getOrGeneratePhoneNumber(sourcePlayer,identifier,cb)
	local sourcePlayer = sourcePlayer
	local identifier = identifier
	local myPhoneNumber = getNumberPhone(identifier)
	if myPhoneNumber == '0' or myPhoneNumber == nil then
		repeat
			myPhoneNumber = getPhoneRandomNumber()
			local id = getIdentifierByPhoneNumber(myPhoneNumber)
		until id == nil
		MySQL.Async.insert("UPDATE vrp_user_identities SET phone = @myPhoneNumber WHERE user_id = @identifier",{ ['@myPhoneNumber'] = myPhoneNumber, ['@identifier'] = identifier },function()
			cb(myPhoneNumber)
		end)
	else
		cb(myPhoneNumber)
	end
end

--[ FUNCTIONS ]-----------------------------------------------------------------------------------------------------------------

function getContacts(identifier)
	local result = MySQL.Sync.fetchAll("SELECT * FROM phone_users_contacts WHERE phone_users_contacts.identifier = @identifier",{ ['@identifier'] = identifier })
	return result
end

function addContact(source,identifier,number,display)
	local sourcePlayer = tonumber(source)
	MySQL.Async.insert("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)",{
		['@identifier'] = identifier,
		['@number'] = number,
		['@display'] = display
	},function()
		notifyContactChange(sourcePlayer,identifier)
	end)
end

function updateContact(source,identifier,id,number,display)
	local sourcePlayer = tonumber(source)
	MySQL.Async.insert("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id",{ 
		['@number'] = number,
		['@display'] = display,
		['@id'] = id
	},function()
		notifyContactChange(sourcePlayer,identifier)
	end)
end

function deleteContact(source, identifier, id)
    local sourcePlayer = tonumber(source)
    MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id", {
        ['@identifier'] = identifier,
        ['@id'] = id,
    })
    notifyContactChange(sourcePlayer, identifier)
end

function deleteAllContact(identifier)
    MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier", {['@identifier'] = identifier})
end

function notifyContactChange(source,identifier)
	local sourcePlayer = tonumber(source)
	local identifier = identifier
	if sourcePlayer ~= nil then 
		TriggerClientEvent("gcPhone:contactList",sourcePlayer,getContacts(identifier))
	end
end

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact',function(display,phoneNumber)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	addContact(sourcePlayer,identifier,phoneNumber,display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact',function(id,display,phoneNumber)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	updateContact(sourcePlayer,identifier,id,phoneNumber,display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact',function(id)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteContact(sourcePlayer,identifier,id)
end)

--[ FUNCTIONS ]-----------------------------------------------------------------------------------------------------------------

function getMessages(identifier)
	local result = MySQL.Sync.fetchAll("SELECT phone_messages.* FROM phone_messages LEFT JOIN vrp_user_identities ON vrp_user_identities.user_id = @identifier WHERE phone_messages.receiver = vrp_user_identities.phone",{ ['@identifier'] = identifier })
	return result
end

RegisterServerEvent('gcPhone:_internalAddMessagedumpamistocazzo')
AddEventHandler('gcPhone:_internalAddMessagedumpamistocazzo', function(transmitter, receiver, message, owner, cb)
    cb(_internalAddMessage(transmitter, receiver, message, owner))
end)

function _internalAddMessage(transmitter, receiver, message, owner)
	local Query = "INSERT INTO phone_messages (`transmitter`,`receiver`,`message`,`isRead`,`owner`) VALUES(@transmitter,@receiver,@message,@isRead,@owner);"
	local Query2 = 'SELECT * from phone_messages WHERE `id` = (SELECT LAST_INSERT_ID());'
	local Parameters = {
		['@transmitter'] = transmitter,
		['@receiver'] = receiver,
		['@message'] = message,
		['@isRead'] = owner,
		['@owner'] = owner
	}
	return MySQL.Sync.fetchAll(Query .. Query2,Parameters)[1]
end

function addMessage(source,identifier,phone_number,message)
    local sourcePlayer = tonumber(source)
    local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
    local myPhone = getNumberPhone(identifier)
    if otherIdentifier ~= nil and vRP.getUserSource(otherIdentifier) ~= nil then
        local tomess = _internalAddMessage(myPhone,phone_number,message,0)
        TriggerClientEvent("gcPhone:receiveMessage",tonumber(vRP.getUserSource(otherIdentifier)),tomess)
    else
        _internalAddMessage(myPhone,phone_number,message,0)
    end
    local memess = _internalAddMessage(phone_number,myPhone,message,1)
    TriggerClientEvent("gcPhone:receiveMessage",sourcePlayer,memess)
end

function setReadMessageNumber(identifier, num)
	local mePhoneNumber = getNumberPhone(identifier)
	MySQL.Sync.execute("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter",{ 
		['@receiver'] = mePhoneNumber,
		['@transmitter'] = num
	})
end

function deleteMessage(msgId)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `id` = @id", {
        ['@id'] = msgId
    })
end

function deleteAllMessageFromPhoneNumber(source, identifier, phone_number)
    local source = source
    local identifier = identifier
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number", {['@mePhoneNumber'] = mePhoneNumber,['@phone_number'] = phone_number})
end

function deleteAllMessage(identifier)
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber", {
        ['@mePhoneNumber'] = mePhoneNumber
    })
end

local blips = {}
local inEmergency = {}

function serviceMessage(phone, sourcePlayer, message, type)
	local source = sourcePlayer
	local user_id = vRP.getUserId(source)
	local answered = false

	if user_id then
		TriggerClientEvent("gcPhone:forceClosePhone", source)
		Citizen.Wait(500)
		local descricao 

		if type == "call" then
			descricao = vRP.prompt(source,"Descrição:","")
			if descricao == "" then
				return
			end
		else
			descricao = message
			if descricao == "" then
				return
			end
		end

		local x,y,z = vRPclient.getPosition(source)
		local players = {}
		local especialidade = false

		if phone == "911" then

			if inEmergency[user_id] == "911" then 
				TriggerClientEvent("Notify",source,"negado","Já Existe um chamado sendo averiguado!")
				return
			end

			players = vRP.getUsersByPermission("policia.permissao")
			especialidade = "policiais"

		elseif phone == "112" then

			if inEmergency[user_id] == "112" then 
				TriggerClientEvent("Notify",source,"negado","Já Existe um chamado sendo averiguado!")
				return
			end

			players = vRP.getUsersByPermission("paramedico.permissao")
			especialidade = "paramédicos"

		elseif phone == "mecanico" then

			if inEmergency[user_id] == "mecanico" then 
				TriggerClientEvent("Notify",source,"negado","Já Existe um chamado sendo averiguado!")
				return
			end

			players = vRP.getUsersByPermission("mecanico.permissao")
			especialidade = "mecânicos"

		elseif phone == "taxi" then

			if inEmergency[user_id] == "taxi" then 
				TriggerClientEvent("Notify",source,"negado","Já Existe um chamado sendo averiguado!")
				return
			end

			players = vRP.getUsersByPermission("taxista.permissao")
			especialidade = "taxistas"

		end
		
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")

		if #players == 0  and especialidade ~= "policiais" then
			TriggerClientEvent("Notify",source,"importante","Não há "..especialidade.." em serviço.")
		else
			local identitys = vRP.getUserIdentity(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
			inEmergency[user_id] = phone
			for l,w in pairs(players) do
				local player = vRP.getUserSource(parseInt(w))
				local nuser_id = vRP.getUserId(player)
				if player and player ~= source then
					async(function()
						vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
						TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},adm.."Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."], "..descricao)
						SetTimeout(30000, function() inEmergency[user_id] = false end)
						local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
						if ok then
							if not answered then
								answered = true
								local identity = vRP.getUserIdentity(nuser_id)
								TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
								vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
								vRPclient._setGPS(player,x,y)
							else
								TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")
								vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
							end
						end
						local id = idgens:gen()
						blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
						
						SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id)  end)
					end)
				end
			end
		end

	end
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage',function(phoneNumber,message)
	local sourcePlayer = tonumber(source)
	phoneNumber = string.gsub(phoneNumber,"%s+","")
	if phoneNumber == "911" then
		serviceMessage(phoneNumber, sourcePlayer, message, "message")
	elseif phoneNumber == "112" then
		serviceMessage(phoneNumber, sourcePlayer, message, "message")
	elseif phoneNumber == "taxi" then
		serviceMessage(phoneNumber, sourcePlayer, message, "message")
	elseif phoneNumber == "mecanico" then
		serviceMessage(phoneNumber, sourcePlayer, message, "message")
	else 
		local identifier = getPlayerID(source)
		addMessage(sourcePlayer,identifier,phoneNumber,message)
	end
end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage', function(msgId)
    deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber',function(number)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteAllMessageFromPhoneNumber(sourcePlayer,identifier,number)
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage',function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteAllMessage(identifier)
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber',function(num)
	local sourcePlayer = tonumber(source)  
	local identifier = getPlayerID(source)
	setReadMessageNumber(identifier,num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL',function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteAllMessage(identifier)
	deleteAllContact(identifier)
	appelsDeleteAllHistorique(identifier)
	TriggerClientEvent("gcPhone:allMessage",sourcePlayer,{})
	TriggerClientEvent("appelsDeleteAllHistorique",sourcePlayer,{})
end)

--[ FUNCTIONS ]-----------------------------------------------------------------------------------------------------------------

local AppelsEnCours = {}
local lastIndexCall = 10

function getHistoriqueCall(num)
	local result = MySQL.Sync.fetchAll("SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 120",{ ['@num'] = num })
	return result
end

function sendHistoriqueCall(src,num)
	local histo = getHistoriqueCall(num)
	TriggerClientEvent('gcPhone:historiqueCall',src,histo)
end

function saveAppels(appelInfo)
	if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
		MySQL.Async.insert("INSERT INTO phone_calls (`owner`,`num`,`incoming`,`accepts`) VALUES(@owner,@num,@incoming,@accepts)",{ ['@owner'] = appelInfo.transmitter_num, ['@num'] = appelInfo.receiver_num, ['@incoming'] = 1, ['@accepts'] = appelInfo.is_accepts },function()
			notifyNewAppelsHisto(appelInfo.transmitter_src,appelInfo.transmitter_num)
		end)
	end
	if appelInfo.is_valid == true then
		local num = appelInfo.transmitter_num
		if appelInfo.hidden == true then
			mun = "####-####"
		end
		MySQL.Async.insert("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)",{ ['@owner'] = appelInfo.receiver_num, ['@num'] = num, ['@incoming'] = 0, ['@accepts'] = appelInfo.is_accepts },function()
			if appelInfo.receiver_src ~= nil then
				notifyNewAppelsHisto(appelInfo.receiver_src,appelInfo.receiver_num)
			end
		end)
	end
end

function notifyNewAppelsHisto (src, num) 
    sendHistoriqueCall(src, num)
end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall',function()
	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	local srcPhone = getNumberPhone(srcIdentifier)
	sendHistoriqueCall(sourcePlayer,num)
end)

RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall',function(source,phone_number,rtcOffer,extraData)
	local rtcOffer = rtcOffer
	if phone_number == nil or phone_number == '' then
		return
	end

	local hidden = string.sub(phone_number,1,1) == '#'
	if hidden == true then
		phone_number = string.sub(phone_number,2)
	end

	local indexCall = lastIndexCall
	lastIndexCall = lastIndexCall + 1

	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	local srcPhone = ''

	if extraData ~= nil and extraData.useNumber ~= nil then
		srcPhone = extraData.useNumber
	else
		srcPhone = getNumberPhone(srcIdentifier)
	end

	local destPlayer = getIdentifierByPhoneNumber(phone_number)
	local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
	AppelsEnCours[indexCall] = { id = indexCall, transmitter_src = sourcePlayer, transmitter_num = srcPhone, receiver_src = nil, receiver_num = phone_number, is_valid = destPlayer ~= nil, is_accepts = false, hidden = hidden, rtcOffer = rtcOffer, extraData = extraData }
    
	if is_valid == true then
		if vRP.getUserSource(destPlayer) ~= nil then
			srcTo = tonumber(vRP.getUserSource(destPlayer))
			if srcTo ~= nill then
				AppelsEnCours[indexCall].receiver_src = srcTo
				TriggerClientEvent('gcPhone:waitingCall',sourcePlayer,AppelsEnCours[indexCall],true)
				TriggerClientEvent('gcPhone:waitingCall',srcTo,AppelsEnCours[indexCall],false)
			else
				TriggerClientEvent('gcPhone:waitingCall',sourcePlayer,AppelsEnCours[indexCall],true)
			end
		end
	else
		TriggerEvent('gcPhone:addCall',AppelsEnCours[indexCall])
		TriggerClientEvent('gcPhone:waitingCall',sourcePlayer,AppelsEnCours[indexCall],true)
	end
end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall',function(phone_number,rtcOffer,extraData)
	local source = source
	phoneNumber = string.gsub(phone_number,"%s+","")

	if phoneNumber == "911" then
		serviceMessage(phoneNumber, source, "", "call")
	elseif phoneNumber == "112" then
		serviceMessage(phoneNumber, source, "", "call")
	elseif phoneNumber == "taxi" then
		serviceMessage(phoneNumber, source, "", "call")
	elseif phoneNumber == "mecanico" then
		serviceMessage(phoneNumber, source, "", "call")
	else 
		TriggerEvent('gcPhone:internal_startCall',source,phone_number,rtcOffer,extraData)
	end
end)

RegisterServerEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates',function(callId,candidates)
	if AppelsEnCours[callId] ~= nil then
		local source = source
		local to = AppelsEnCours[callId].transmitter_src
		if source == to then 
			to = AppelsEnCours[callId].receiver_src
		end
		TriggerClientEvent('gcPhone:candidates',to,candidates)
	end
end)

RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall',function(infoCall,rtcAnswer)
	local id = infoCall.id
	if AppelsEnCours[id] ~= nil then
		AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
		if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src ~= nil then
			AppelsEnCours[id].is_accepts = true
			AppelsEnCours[id].rtcAnswer = rtcAnswer
			TriggerClientEvent('gcPhone:acceptCall',AppelsEnCours[id].transmitter_src,AppelsEnCours[id],true)
			TriggerClientEvent('gcPhone:acceptCall',AppelsEnCours[id].receiver_src,AppelsEnCours[id],false)
			saveAppels(AppelsEnCours[id])
		end
	end
end)

RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall',function(infoCall)
	local id = infoCall.id
	if AppelsEnCours[id] ~= nil then
		if AppelsEnCours[id].transmitter_src ~= nil then
			TriggerClientEvent('gcPhone:rejectCall',AppelsEnCours[id].transmitter_src)
		end
		if AppelsEnCours[id].receiver_src ~= nil then
			TriggerClientEvent('gcPhone:rejectCall',AppelsEnCours[id].receiver_src)
		end

		if AppelsEnCours[id].is_accepts == false then 
			saveAppels(AppelsEnCours[id])
		end
		TriggerEvent('gcPhone:removeCall',AppelsEnCours)
		AppelsEnCours[id] = nil
	end
end)

RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique',function(numero)
	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	local srcPhone = getNumberPhone(srcIdentifier)
	MySQL.Sync.execute("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num",{
		['@owner'] = srcPhone,
		['@num'] = numero
	})
end)

function appelsDeleteAllHistorique(srcIdentifier)
    local srcPhone = getNumberPhone(srcIdentifier)
    MySQL.Sync.execute("DELETE FROM phone_calls WHERE `owner` = @owner", {
        ['@owner'] = srcPhone
    })
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique',function()
	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	appelsDeleteAllHistorique(srcIdentifier)
end)

--[ FUNCTIONS ]-----------------------------------------------------------------------------------------------------------------

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
    local num = getNumberPhone(identifier)
    
	getOrGeneratePhoneNumber(sourcePlayer,identifier,function(myPhoneNumber)
		TriggerClientEvent("gcPhone:myPhoneNumber",sourcePlayer,myPhoneNumber)
		TriggerClientEvent("vRP:updateBalanceGc", source, bmoney)
		TriggerClientEvent("gcPhone:contactList",sourcePlayer,getContacts(identifier))
        TriggerClientEvent("gcPhone:allMessage",sourcePlayer,getMessages(identifier))
        TriggerClientEvent('gcPhone:getBourse', sourcePlayer, getBourse())
        sendHistoriqueCall(sourcePlayer, num)
	end)

	local consulta = vRP.getUData(user_id,"vRP:plano")
	local resultado = json.decode(consulta) or {}
	vRP.setUData(vRP.getUserId(source), "vRP:plano", json.encode(resultado))
	resultado = resultado.tempo or 0
	if tonumber(resultado) > 0 then
		plan[user_id] = resultado
	end
end)

RegisterServerEvent('gcPhone:allUpdate')
AddEventHandler('gcPhone:allUpdate',function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	local num = getNumberPhone(identifier)

	local _source = source
    local user_id = vRP.getUserId(_source)
	local getbankmoney = vRP.getBankMoney(user_id)

	TriggerClientEvent("gcPhone:myPhoneNumber",sourcePlayer,num)
	TriggerClientEvent("vRP:updateBalanceGc",_source,getbankmoney)
	TriggerClientEvent("gcPhone:contactList",sourcePlayer,getContacts(identifier))
	TriggerClientEvent("gcPhone:allMessage",sourcePlayer,getMessages(identifier))
    TriggerClientEvent('gcPhone:getBourse', sourcePlayer, getBourse())

	sendHistoriqueCall(sourcePlayer,num)
end)

--[ FUNCTIONS ]-----------------------------------------------------------------------------------------------------------------

function getBourse()
    local result = {
        {
            libelle = 'Google',
            price = 125.2,
            difference =  -12.1
        },
        {
            libelle = 'Microsoft',
            price = 132.2,
            difference = 3.1
        },
        {
            libelle = 'Amazon',
            price = 120,
            difference = 0
        }}
    return result
end

AddEventHandler('onMySQLReady',function()
	MySQL.Async.fetchAll("DELETE FROM phone_messages WHERE (DATEDIFF(CURRENT_DATE,time) > 10)")
end)

RegisterNetEvent("vRP/update_gc_phone")
AddEventHandler("vRP/update_gc_phone", function()
	local _source = source
    local user_id = vRP.getUserId(_source)
	local getbankmoney = vRP.getBankMoney(user_id)

	TriggerClientEvent("vRP:updateBalanceGc",_source,getbankmoney)
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local _source = source
    local user_id = vRP.getUserId(_source)
	local getbankmoney = vRP.getBankMoney(user_id)
	
    TriggerClientEvent("vRP:updateBalanceGc",_source,getbankmoney)
end)

RegisterServerEvent('bank:transfer20')
AddEventHandler('bank:transfer20', function(id, amount)
    local _source = source
    local user_id = vRP.getUserId(source)
    local targetPlayer = vRP.getUserSource(tonumber(id))
	local amount =  tonumber(amount)
	
	if amount <= 0 then
		return TriggerClientEvent("Notify",_source,"negado","Você digitou uma quantia inválida.")
	elseif amount > 5000 then
		return TriggerClientEvent("Notify",_source,"negado","O valor excede o limite de transferência por dispositivel móvel.")
	end

    local identity = vRP.getUserIdentity(user_id)
    local identityT = vRP.getUserIdentity(tonumber(id))    
	
	if targetPlayer == nil then
		return TriggerClientEvent("Notify",_source,"negado","Usuario invalido.")
	elseif targetPlayer == user_id then
		return TriggerClientEvent("Notify",_source,"negado","Você não pode transferir dinheiro para si mesmo!")
    else
		local myBank = vRP.getBankMoney(user_id)
		local tax = parseInt(7/100*amount)
		local pagtax = parseInt(amount+tax)

		if tonumber(user_id) ~= tonumber(id) then
			if myBank >= amount then
				vRP.setBankMoney(user_id, myBank - pagtax)
				vRP.giveBankMoney(tonumber(id),amount)
				
				TriggerClientEvent("Notify",targetPlayer,"sucesso","Você rebeu $" .. amount .." de "  ..identity.name.. " ID: " .. tostring(user_id))
				TriggerClientEvent("Notify",_source,"sucesso","Tranferencia sucedida")
			else
				TriggerClientEvent("Notify",_source,"sucesso","SEM MONEY") 
			end
		end

    end
end)

AddEventHandler("vRP:playerLeave", function(user_id, group, gtype)
	if plan[user_id] then
		plan[user_id] = nil
	end
end)

Citizen.CreateThread(function()
	while true do
		for k, v in pairs(plan) do
			plan[k] = v-1
			if plan[k] <= 0 then
				plan[k] = nil
				vRP.setUData(k, "vRP:plano", json.encode({}))
			else
				local vl = {}
				vl.tempo = v
				vRP.setUData(k, "vRP:plano", json.encode(vl))
			end
		end
		Citizen.Wait(10000)
	end
end)

function src.planoCheck()
	local source = source
	local user_id = vRP.getUserId(source)
	local consulta = vRP.getUData(user_id,"vRP:plano")
	local resultado = json.decode(consulta) or {}
	
	resultado = resultado.tempo or 0

	if tonumber(resultado) <= 0 then
		TriggerClientEvent("Notify",source,"negado","Você não possui plano de celular disponivel.") 
		return false
	else
		return true
	end
end