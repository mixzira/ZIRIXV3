function YellowGetPagess (accountId, cb)
  if accountId == nil then
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM yellow_tweets
      ORDER BY time DESC LIMIT 130
      ]===], {}, cb)
  end
end

function YellowUsersPagess (phone_number, cb)
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM yellow_tweets
	    WHERE phone_number = @phone_number
      ORDER BY time DESC LIMIT 130
      ]===], {['@phone_number'] = phone_number}, cb)
end

function BankUserTransfer (identifier, cb)
    MySQL.Async.fetchAll([===[ SELECT * FROM bank_transfer ]===], {}, cb)
end

function getUserYellow(phone_number, firstname, cb)
  MySQL.Async.fetchAll("SELECT firstname, phone_number FROM users WHERE users.firstname = @firstname AND users.phone_number = @phone_number", {
    ['@phone_number'] = phone_number,
	  ['@firstname'] = firstname
  }, function (data)
    cb(data[1])
  end)
end

RegisterServerEvent('gcPhone:yellow_getUserTweets')
AddEventHandler('gcPhone:yellow_getUserTweets', function(phone_number)
  local sourcePlayer = tonumber(source)
  local name = getIdentity(source)
    YellowUsersPagess(name.phone_number, function (pagess)
      TriggerClientEvent('gcPhone:yellow_getUserTweets', sourcePlayer, pagess)
    end)
end)

RegisterServerEvent('gcPhone:bank_gkst')
AddEventHandler('gcPhone:bank_gkst', function(identifier)
  local sourcePlayer = tonumber(source)
    BankUserTransfer(nil, function (bankgks)
      TriggerClientEvent('gcPhone:bank_gkst', sourcePlayer, bankgks)
    end)
end)


function YellowPostPages (phone_number, firstname, lastname, message, image, sourcePlayer, cb)
    getUserYellow(phone_number, firstname, function (user)
    MySQL.Async.insert("INSERT INTO yellow_tweets (`phone_number`, `firstname`, `lastname`, `message`, `image`) VALUES(@phone_number, @firstname, @lastname, @message, @image);", {
	  ['@phone_number'] = phone_number,
	  ['@firstname'] = firstname,
	  ['@lastname'] = lastname,
    ['@message'] = message,
	  ['@image'] = image
    }, function (id)
      MySQL.Async.fetchAll('SELECT * from yellow_tweets WHERE id = @id', {
        ['@id'] = id
      }, function (pagess)
        pages = pagess[1]
        pages['firstname'] = user.firstname
        pages['phone_number'] = user.phone_number
        TriggerClientEvent('gcPhone:yellow_newPagess', -1, pages)
        TriggerEvent('gcPhone:yellow_newPagess', pages)
      end)
    end)
  end)
end

function YellowUsersDelete (yellowId, phone_number, sourcePlayer)
    MySQL.Async.execute('DELETE FROM yellow_tweets WHERE id = @id AND phone_number = @phone_number', {
      ['@id'] = yellowId,
	  ['@phone_number'] = phone_number
    }, function ()
	end)
end

RegisterServerEvent('gcPhone:yellow_usersDeleteTweet')
AddEventHandler('gcPhone:yellow_usersDeleteTweet', function(yellowId, phone_number)
  local sourcePlayer = tonumber(source)
  local name = getIdentity(source)
  YellowUsersDelete(yellowId, name.phone_number, sourcePlayer)
end)

function YellowShowError (sourcePlayer, title, message, image)
  TriggerClientEvent('gcPhone:yellow_showError', sourcePlayer, message, image)
end

function YellowShowSuccess (sourcePlayer, title, message, image)
  TriggerClientEvent('gcPhone:yellow_showSuccess', sourcePlayer, title, message, image)
end

RegisterServerEvent('gcPhone:yellow_getPagess')
AddEventHandler('gcPhone:yellow_getPagess', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
    YellowGetPagess(nil, function (pagess)
      TriggerClientEvent('gcPhone:yellow_getPagess', sourcePlayer, pagess)
    end)
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			phone_number = identity['phone_number'],
		}
	else
		return nil
	end
end

RegisterServerEvent('gcPhone:yellow_postPagess')
AddEventHandler('gcPhone:yellow_postPagess', function(firstname, phone_number, lastname, message, image)
  local sourcePlayer = tonumber(source)
  local name = getIdentity(source)
  YellowPostPages(name.phone_number, name.firstname, name.lastname, message, image, sourcePlayer)
end)