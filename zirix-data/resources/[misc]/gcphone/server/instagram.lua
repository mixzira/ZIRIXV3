function InstagramGetPics (accountId, cb)
  if accountId == nil then
    MySQL.Async.fetchAll([===[
      SELECT instagram_pics.*,
        instagram_accounts.username as author,
        instagram_accounts.avatar_url as authorIcon
        FROM instagram_pics
        LEFT JOIN instagram_accounts
        ON instagram_pics.authorId = instagram_accounts.id
      ORDER BY time DESC LIMIT 130
      ]===], {}, cb)
  else
    MySQL.Async.fetchAll([===[
      SELECT instagram_pics.*,
        instagram_accounts.username as author,
        instagram_accounts.avatar_url as authorIcon,
        instagram_likes.id AS isLikes
        FROM instagram_pics
        LEFT JOIN instagram_accounts
        ON instagram_pics.authorId = instagram_accounts.id
        LEFT JOIN instagram_likes
        ON instagram_pics.id = instagram_likes.picId AND instagram_likes.authorId = @accountId
      ORDER BY time DESC LIMIT 130
    ]===], { ['@accountId'] = accountId }, cb)
  end
end

function getUserInstagram(username, realUser, cb)
  MySQL.Async.fetchAll("SELECT id, username as author, avatar_url as authorIcon, realUser FROM instagram_accounts WHERE instagram_accounts.username = @username AND instagram_accounts.realUser = @realUser", {
    ['@username'] = username,
    ['@realUser'] = realUser
  }, function (data)
    cb(data[1])
  end)
end

function InstagramPostPic (username, message, pic, sourcePlayer, realUser, cb)
  local sourcePlayer = tonumber(source)
  local srcIdentifier = getPlayerID(source)
  getUserInstagram(username, srcIdentifier, function (user)
    if user == nil then
      if sourcePlayer ~= nil then
        InstagramShowError(sourcePlayer, 'Instagram Info', 'APP_INSTAGRAM_NOTIF_LOGIN_ERROR')
      end
      return
    end
    MySQL.Async.insert("INSERT INTO instagram_pics (`authorId`, `message`, `pic`, `realUser`) VALUES(@authorId, @message, @pic, @realUser);", {
      ['@authorId'] = user.id,
      ['@message'] = message,
      ['@pic'] = pic,
      ['@realUser'] = realUser
    }, function (id)
      MySQL.Async.fetchAll('SELECT * from instagram_pics WHERE id = @id', {
        ['@id'] = id
    }, function (pics)
        pic = pics[1]
        pic['author'] = user.author
        pic['authorIcon'] = user.authorIcon
        TriggerClientEvent('gcPhone:instagram_newPics', -1, pic)
        TriggerEvent('gcPhone:instagram_newPics', pic)
      end)
    end)
  end)
end

function InstagramToogleLike (username, picId, sourcePlayer)
  local sourcePlayer = tonumber(source)
  local srcIdentifier = getPlayerID(source)
  getUserInstagram(username, srcIdentifier, function (user)
    if user == nil then
      if sourcePlayer ~= nil then
        InstagramShowError(sourcePlayer, 'Instagram Info', 'APP_INSTAGRAM_NOTIF_LOGIN_ERROR')
      end
      return
    end
    MySQL.Async.fetchAll('SELECT * FROM instagram_pics WHERE id = @id', {
      ['@id'] = picId
  }, function (pics)
      if (pics[1] == nil) then return end
      local pic = pics[1]
      MySQL.Async.fetchAll('SELECT * FROM instagram_likes WHERE authorId = @authorId AND picId = @picId', {
        ['authorId'] = user.id,
        ['picId'] = picId
      }, function (row)
        if (row[1] == nil) then
          MySQL.Async.insert('INSERT INTO instagram_likes (`authorId`, `picId`) VALUES(@authorId, @picId)', {
            ['authorId'] = user.id,
            ['picId'] = picId
          }, function (newrow)
            MySQL.Async.execute('UPDATE `instagram_pics` SET `likes`= likes + 1 WHERE id = @id', {
              ['@id'] = pic.id
            }, function ()
              TriggerClientEvent('gcPhone:instagram_updatePicLikes', -1, pic.id, pic.likes + 1)
              TriggerClientEvent('gcPhone:instagram_setPicLikes', sourcePlayer, pic.id, true)
              TriggerEvent('gcPhone:instagram_updatePicLikes', pic.id, pic.likes + 1)
            end)
          end)
        else
          MySQL.Async.execute('DELETE FROM instagram_likes WHERE id = @id', {
            ['@id'] = row[1].id,
          }, function (newrow)
            MySQL.Async.execute('UPDATE `instagram_pics` SET `likes`= likes - 1 WHERE id = @id', {
              ['@id'] = pic.id
            }, function ()
              TriggerClientEvent('gcPhone:instagram_updatePicLikes', -1, pic.id, pic.likes - 1)
              TriggerClientEvent('gcPhone:instagram_setPicLikes', sourcePlayer, pic.id, false)
              TriggerEvent('gcPhone:instagram_updatePicLikes', pic.id, pic.likes - 1)
            end)
          end)
        end
      end)
    end)
  end)
end

function InstagramCreateAccount(username, avatarUrl, realUser, cb)
  MySQL.Async.insert('INSERT IGNORE INTO instagram_accounts (`username`, `avatar_url`, `realUser`) VALUES(@username, @avatarUrl, @realUser)', {
    ['username'] = username,
    ['avatarUrl'] = avatarUrl,
    ['realUser'] = realUser
  }, cb)
end

function InstagramShowError (sourcePlayer, title, message)
  TriggerClientEvent('gcPhone:instagram_showError', sourcePlayer, message)
end
function InstagramShowSuccess (sourcePlayer, title, message)
  TriggerClientEvent('gcPhone:instagram_showSuccess', sourcePlayer, title, message)
end

RegisterServerEvent('gcPhone:instagram_login')
AddEventHandler('gcPhone:instagram_login', function(username)
  local sourcePlayer = tonumber(source)
  local srcIdentifier = getPlayerID(source)
  getUserInstagram(username, srcIdentifier, function (user)
    if user == nil then
      InstagramShowError(sourcePlayer, 'Instagram Info', 'APP_INSTAGRAM_NOTIF_LOGIN_ERROR')
    else
      InstagramShowSuccess(sourcePlayer, 'Instagram Info', 'APP_INSTAGRAM_NOTIF_LOGIN_SUCCESS')
      TriggerClientEvent('gcPhone:instagram_setAccount', sourcePlayer, username, realUser, user.authorIcon)
    end
  end)
end)

RegisterServerEvent('gcPhone:instagram_createAccount')
AddEventHandler('gcPhone:instagram_createAccount', function(username, avatarUrl)
  local sourcePlayer = tonumber(source)
  local srcIdentifier = getPlayerID(source)

  InstagramCreateAccount(username, avatarUrl, srcIdentifier, function (id)
    if (id ~= 0) then
      TriggerClientEvent('gcPhone:instagram_setAccount', sourcePlayer, username, avatarUrl)
      InstagramShowSuccess(sourcePlayer, 'Instagram Info', 'APP_INSTAGRAM_NOTIF_ACCOUNT_CREATE_SUCCESS')
    else
      InstagramShowError(sourcePlayer, 'Instagram Info', 'APP_INSTAGRAM_NOTIF_ACCOUNT_CREATE_ERROR')
    end
  end)
end)

RegisterServerEvent('gcPhone:instagram_getPics')
AddEventHandler('gcPhone:instagram_getPics', function(username)
  local sourcePlayer = tonumber(source)
  local srcIdentifier = getPlayerID(source)
  if username ~= nil and username ~= "" then
    getUserInstagram(username, srcIdentifier, function (user)
      local accountId = user and user.id
      InstagramGetPics(accountId, function (pics)
        TriggerClientEvent('gcPhone:instagram_getPics', sourcePlayer, pics)
      end)
    end)
  else
    InstagramGetPics(nil, function (pics)
      TriggerClientEvent('gcPhone:instagram_getPics', sourcePlayer, pics)
    end)
  end
end)

RegisterServerEvent('gcPhone:instagram_postPics')
AddEventHandler('gcPhone:instagram_postPics', function(username, message, pic)
  local sourcePlayer = tonumber(source)
  local srcIdentifier = getPlayerID(source)
  InstagramPostPic(username, message, pic, sourcePlayer, srcIdentifier)
end)

RegisterServerEvent('gcPhone:instagram_toogleLikePic')
AddEventHandler('gcPhone:instagram_toogleLikePic', function(username, picId)
  local sourcePlayer = tonumber(source)
  InstagramToogleLike(username, picId, sourcePlayer)
end)

RegisterServerEvent('gcPhone:instagram_comment')
AddEventHandler('gcPhone:instagram_comment', function(username, picId)
  InstagramShowError(sourcePlayer, 'Instagram Info', 'Bu özellik maalesef şuanda kullanılabilir değil.')
end)

RegisterServerEvent('gcPhone:instagram_setAvatarUrl')
AddEventHandler('gcPhone:instagram_setAvatarUrl', function(username, avatarUrl)
  local sourcePlayer = tonumber(source)
  MySQL.Async.execute("UPDATE `instagram_accounts` SET `avatar_url`= @avatarUrl WHERE instagram_accounts.username = @username", {
    ['@username'] = username,
    ['@avatarUrl'] = avatarUrl
  }, function (result)
    if (result == 1) then
      TriggerClientEvent('gcPhone:instagram_setAccount', sourcePlayer, username, avatarUrl)
      InstagramShowSuccess(sourcePlayer, 'Instagram Info', 'APP_INSTAGRAM_NOTIF_AVATAR_SUCCESS')
    else
      InstagramShowError(sourcePlayer, 'Instagram Info', 'APP_INSTAGRAM_NOTIF_LOGIN_ERROR')
    end
  end)
end)


--[[
  Discord WebHook
  set discord_webhook 'https//....' in config.cfg
--]]
AddEventHandler('gcPhone:instagram_newPics', function (pic)
  -- print(json.encode(tweet))
  local discord_webhook = GetConvar('discord_webhook', '')
  if discord_webhook == '' then
    return
  end
  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = pic.author,
    ["embeds"] = {{
      ["thumbnail"] = {
        ["url"] = pic.authorIcon
      },
      ["color"] = 1942002,
      ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ", pic.time / 1000 )
    }}
  }
  local isHttp = string.sub(pic.message, 0, 7) == 'http://' or string.sub(pic.message, 0, 8) == 'https://'
  local ext = string.sub(pic.message, -4)
  local isImg = ext == '.png' or ext == '.pjg' or ext == '.gif' or string.sub(pic.message, -5) == '.jpeg'
  if (isHttp and isImg) and true then
    data['embeds'][1]['image'] = { ['url'] = pic.message }
  else
    data['embeds'][1]['description'] = pic.message
  end
  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)
