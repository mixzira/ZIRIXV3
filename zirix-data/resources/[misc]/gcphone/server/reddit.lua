function RedditGetChanells (accountId, cb)
  if accountId == nil then
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM phone_ch_reddit
      ORDER BY time DESC LIMIT 130
      ]===], {}, cb)
  end
end

RegisterServerEvent('gcPhone:reddit_getChanells')
AddEventHandler('gcPhone:reddit_getChanells', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
    RedditGetChanells(nil, function (channnels)
      TriggerClientEvent('gcPhone:reddit_getChanells', sourcePlayer, channnels)
    end)
end)

function RedditCreatChannel(redgkit, cb)
  MySQL.Async.insert('INSERT IGNORE INTO phone_ch_reddit (`redgkit`) VALUES(@redgkit)', {
    ['redgkit'] = redgkit
  }, cb)
end


RegisterServerEvent('gcPhone:reddit_postChanell')
AddEventHandler('gcPhone:reddit_postChanell', function(redgkit)
  local sourcePlayer = tonumber(source)
  RedditCreatChannel(redgkit, sourcePlayer)
end)

function RedditGetMessageChannel (redgkit, cb)
    MySQL.Async.fetchAll("SELECT * FROM phone_reddit WHERE redgkit = @redgkit ORDER BY time DESC LIMIT 100", { 
        ['@redgkit'] = redgkit
    }, cb)
end

function RedditAddMessage (redgkit, reditsage)
  local Query = "INSERT INTO phone_reddit (`redgkit`, `reditsage`) VALUES(@redgkit, @reditsage);"
  local Query2 = 'SELECT * from phone_reddit WHERE `id` = @id;'
  local Parameters = {
    ['@redgkit'] = redgkit,
    ['@reditsage'] = reditsage
  }
  MySQL.Async.insert(Query, Parameters, function (id)
    MySQL.Async.fetchAll(Query2, { ['@id'] = id }, function (reponse)
      TriggerClientEvent('gcPhone:reddit_receive', -1, reponse[1])
    end)
  end)
end


RegisterServerEvent('gcPhone:reddit_channel')
AddEventHandler('gcPhone:reddit_channel', function(redgkit)
  local sourcePlayer = tonumber(source)
  RedditGetMessageChannel(redgkit, function (reditsages)
    TriggerClientEvent('gcPhone:reddit_channel', sourcePlayer, redgkit, reditsages)
  end)
end)

RegisterServerEvent('gcPhone:reddit_addMessage')
AddEventHandler('gcPhone:reddit_addMessage', function(redgkit, reditsage)
  RedditAddMessage(redgkit, reditsage)
end)