function instoGetinstas (accountId, cb)
  if accountId == nil then
    MySQL.Async.fetchAll([===[
      SELECT insto_instas.*,
	    insto_accounts.forename,
		  insto_accounts.surname,
      insto_accounts.username as author,
      insto_accounts.avatar_url as authorIcon
      FROM insto_instas
      LEFT JOIN insto_accounts
      ON insto_instas.authorId = insto_accounts.id
      ORDER BY time DESC LIMIT 130
      ]===], {}, cb)
  else
    MySQL.Async.fetchAll([===[
      SELECT insto_instas.*,
	  	insto_accounts.forename,
		  insto_accounts.surname,
      insto_accounts.username as author,
      insto_accounts.avatar_url as authorIcon,
      insto_likes.id AS isLikes
      FROM insto_instas
      LEFT JOIN insto_accounts
      ON insto_instas.authorId = insto_accounts.id
      LEFT JOIN insto_likes 
      ON insto_instas.id = insto_likes.inapId AND insto_likes.authorId = @accountId
      ORDER BY time DESC LIMIT 130
    ]===], { ['@accountId'] = accountId }, cb)
  end
end

function instoGetFavotireinstas (accountId, cb)
  if accountId == nil then
    MySQL.Async.fetchAll([===[
      SELECT insto_instas.*,
	    insto_accounts.forename,
		  insto_accounts.surname,
      insto_accounts.username as author,
      insto_accounts.avatar_url as authorIcon
      FROM insto_instas
      LEFT JOIN insto_accounts
      ON insto_instas.authorId = insto_accounts.id
      WHERE insto_instas.TIME > CURRENT_TIMESTAMP() - INTERVAL '15' DAY
      ORDER BY likes DESC, TIME DESC LIMIT 30
    ]===], {}, cb)
  else
    MySQL.Async.fetchAll([===[
      SELECT insto_instas.*,
	    insto_accounts.forename,
		  insto_accounts.surname,
      insto_accounts.username as author,
      insto_accounts.avatar_url as authorIcon,
      insto_likes.id AS isLikes
      FROM insto_instas
      LEFT JOIN insto_accounts
      ON insto_instas.authorId = insto_accounts.id
      LEFT JOIN insto_likes 
      ON insto_instas.id = insto_likes.inapId AND insto_likes.authorId = @accountId
      WHERE insto_instas.TIME > CURRENT_TIMESTAMP() - INTERVAL '15' DAY
      ORDER BY likes DESC, TIME DESC LIMIT 30
    ]===], { ['@accountId'] = accountId }, cb)
  end
end

function getaUserIns(forename, surname, username, password, cb)
  MySQL.Async.fetchAll("SELECT id, forename, surname, username as author, avatar_url as authorIcon FROM insto_accounts WHERE insto_accounts.username = @username AND insto_accounts.password = @password", {
    ['@forename'] = forename,
    ['@surname'] = surname,
    ['@username'] = username,
    ['@password'] = password
  }, function (data)
    cb(data[1])
  end)
end

function instoPostinap (username, password, message, sourcePlayer, realUser, image, filters, cb)
  getaUserIns(forename, surname, username, password, function (user)
    if user == nil then
      if sourcePlayer ~= nil then
        instoShowError(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_LOGIN_ERROR')
      end
      return
    end
    MySQL.Async.insert("INSERT INTO insto_instas (`authorId`, `message`, `realUser`, `image`, `filters`) VALUES(@authorId, @message, @realUser, @image, @filters);", {
      ['@authorId'] = user.id,
      ['@message'] = message,
      ['@realUser'] = realUser,
	    ['@image'] = image,
	    ['@filters'] = filters
    }, function (id)
      MySQL.Async.fetchAll('SELECT * from insto_instas WHERE id = @id', {
        ['@id'] = id
      }, function (instas)
        inap = instas[1]
		    inap['forename'] = user.forename
		    inap['surname'] = user.surname
        inap['author'] = user.author
        inap['authorIcon'] = user.authorIcon
        TriggerClientEvent('gcPhone:insto_newinstas', -1, inap)
        TriggerEvent('gcPhone:insto_newinstas', inap)
      end)
    end)
  end)
end

function instoToogleLike (forename, surname, username, password, inapId, sourcePlayer)
  getaUserIns(forename, surname, username, password, function (user)
    if user == nil then
      if sourcePlayer ~= nil then
        instoShowError(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_LOGIN_ERROR')
      end
      return
    end
    MySQL.Async.fetchAll('SELECT * FROM insto_instas WHERE id = @id', {
      ['@id'] = inapId
    }, function (instas)
      if (instas[1] == nil) then return end
      local inap = instas[1]
      MySQL.Async.fetchAll('SELECT * FROM insto_likes WHERE authorId = @authorId AND inapId = @inapId', {
        ['authorId'] = user.id,
        ['inapId'] = inapId
      }, function (row) 
        if (row[1] == nil) then
          MySQL.Async.insert('INSERT INTO insto_likes (`authorId`, `inapId`) VALUES(@authorId, @inapId)', {
            ['authorId'] = user.id,
            ['inapId'] = inapId
          }, function (newrow)
            MySQL.Async.execute('UPDATE `insto_instas` SET `likes`= likes + 1 WHERE id = @id', {
              ['@id'] = inap.id
            }, function ()
              TriggerClientEvent('gcPhone:insto_updateinapLikes', -1, inap.id, inap.likes + 1)
              TriggerClientEvent('gcPhone:insto_setinapLikes', sourcePlayer, inap.id, true)
              TriggerEvent('gcPhone:insto_updateinapLikes', inap.id, inap.likes + 1)
            end)    
          end)
        else
          MySQL.Async.execute('DELETE FROM insto_likes WHERE id = @id', {
            ['@id'] = row[1].id,
          }, function (newrow)
            MySQL.Async.execute('UPDATE `insto_instas` SET `likes`= likes - 1 WHERE id = @id', {
              ['@id'] = inap.id
            }, function ()
              TriggerClientEvent('gcPhone:insto_updateinapLikes', -1, inap.id, inap.likes - 1)
              TriggerClientEvent('gcPhone:insto_setinapLikes', sourcePlayer, inap.id, false)
              TriggerEvent('gcPhone:insto_updateinapLikes', inap.id, inap.likes - 1)
            end)
          end)
        end
      end)
    end)
  end)
end

function instoCreateAccount(forename, surname, username, password, avatarUrl, cb)
  MySQL.Async.insert('INSERT IGNORE INTO insto_accounts (`forename`, `surname`, `username`, `password`, `avatar_url`) VALUES(@forename, @surname, @username, @password, @avatarUrl)', {
    ['forename'] = forename,
	  ['surname'] = surname,
    ['username'] = username,
    ['password'] = password,
    ['avatarUrl'] = avatarUrl
  }, cb)
end

function instoShowError (sourcePlayer, title, message, image, filters)
  TriggerClientEvent('gcPhone:insto_showError', sourcePlayer, message, image, filters)
end

function instoShowSuccess (sourcePlayer, title, message, image, filters)
  TriggerClientEvent('gcPhone:insto_showSuccess', sourcePlayer, title, message, image, filters)
end

RegisterServerEvent('gcPhone:insto_login')
AddEventHandler('gcPhone:insto_login', function(username, password)
  local sourcePlayer = tonumber(source)
  getaUserIns(forename, surname, username, password, function (user)
    if user == nil then
      instoShowError(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_LOGIN_ERROR')
    else
      instoShowSuccess(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_LOGIN_SUCCESS')
      TriggerClientEvent('gcPhone:insto_setAccount', sourcePlayer, username, password, user.authorIcon)
    end
  end)
end)

RegisterServerEvent('gcPhone:insto_changePassword')
AddEventHandler('gcPhone:insto_changePassword', function(forename, surname, username, password, newPassword)
  local sourcePlayer = tonumber(source)
  getaUserIns(forename, surname, username, password, function (user)
    if user == nil then
      instoShowError(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_NEW_PASSWORD_ERROR')
    else
      MySQL.Async.execute("UPDATE `insto_accounts` SET `password`= @newPassword WHERE insto_accounts.username = @username AND insto_accounts.password = @password", {
        ['@username'] = username,
        ['@password'] = password,
        ['@newPassword'] = newPassword
      }, function (result)
        if (result == 1) then
          TriggerClientEvent('gcPhone:insto_setAccount', sourcePlayer, forename, surname, username, newPassword, user.authorIcon)
          instoShowSuccess(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_NEW_PASSWORD_SUCCESS')
        else
          instoShowError(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_NEW_PASSWORD_ERROR')
        end
      end)
    end
  end)
end)


RegisterServerEvent('gcPhone:insto_createAccount')
AddEventHandler('gcPhone:insto_createAccount', function(forename, surname, username, password, avatarUrl)
  local sourcePlayer = tonumber(source)
  instoCreateAccount(forename, surname, username, password, avatarUrl, function (id)
    if (id ~= 0) then
      instoShowSuccess(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_ACCOUNT_CREATE_SUCCESS')
    else
      instoShowError(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_ACCOUNT_CREATE_ERROR')
    end
  end)
end)

RegisterServerEvent('gcPhone:insto_getinstas')
AddEventHandler('gcPhone:insto_getinstas', function(forename, surname, username, password)
  local sourcePlayer = tonumber(source)
  if username ~= nil and username ~= "" and password ~= nil and password ~= "" then
    getaUserIns(forename, surname, username, password, function(user)
      local accountId = user and user.id
      instoGetinstas(accountId, function (instas)
        TriggerClientEvent('gcPhone:insto_getinstas', sourcePlayer, instas)
      end)
    end)
  else
    instoGetinstas(nil, function (instas)
      TriggerClientEvent('gcPhone:insto_getinstas', sourcePlayer, instas)
    end)
  end
end)

RegisterServerEvent('gcPhone:insto_getFavoriteinstas')
AddEventHandler('gcPhone:insto_getFavoriteinstas', function(forename, surname, username, password)
  local sourcePlayer = tonumber(source)
  if username ~= nil and username ~= "" and password ~= nil and password ~= "" then
    getaUserIns(forename, surname, username, password, function (user)
      local accountId = user and user.id
      instoGetFavotireinstas(accountId, function (instas)
        TriggerClientEvent('gcPhone:insto_getFavoriteinstas', sourcePlayer, instas)
      end)
    end)
  else
    instoGetFavotireinstas(nil, function (instas)
      TriggerClientEvent('gcPhone:insto_getFavoriteinstas', sourcePlayer, instas)
    end)
  end
end)

RegisterServerEvent('gcPhone:insto_postinstas')
AddEventHandler('gcPhone:insto_postinstas', function(username, password, message, image, filters)
  local _source = source
  local sourcePlayer = tonumber(_source)
  local srcIdentifier = getPlayerID(source)
  instoPostinap(username, password, message, sourcePlayer, srcIdentifier, image, filters)
end)

RegisterServerEvent('gcPhone:insto_toogleLikeinap')
AddEventHandler('gcPhone:insto_toogleLikeinap', function(forename, surname, username, password, inapId)
  local sourcePlayer = tonumber(source)
  instoToogleLike(forename, surname, username, password, inapId, sourcePlayer)
end)


RegisterServerEvent('gcPhone:insto_setAvatarUrl')
AddEventHandler('gcPhone:insto_setAvatarUrl', function(username, password, avatarUrl)
  local sourcePlayer = tonumber(source)
  MySQL.Async.execute("UPDATE `insto_accounts` SET `avatar_url`= @avatarUrl WHERE insto_accounts.username = @username AND insto_accounts.password = @password", {
    ['@username'] = username,
    ['@password'] = password,
    ['@avatarUrl'] = avatarUrl
  }, function (result)
    if (result == 1) then
      TriggerClientEvent('gcPhone:insto_setAccount', sourcePlayer, username, password, avatarUrl)
      instoShowSuccess(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_AVATAR_SUCCESS')
    else
      instoShowError(sourcePlayer, 'Instagram', 'APP_INSTAGRAM_NOTIF_LOGIN_ERROR')
    end
  end)
end)