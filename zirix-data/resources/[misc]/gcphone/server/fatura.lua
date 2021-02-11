ESX = nil

TriggerEvent('esx:getSharedObj21', function(obj) ESX = obj end)

function FaturaGetBilling (accountId, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll([===[
      SELECT * FROM billing WHERE identifier = @identifier
      ]===], { ['@identifier'] = xPlayer.identifier }, cb)
  end 

function getUserFatura(phone_number, firstname, cb)
  MySQL.Async.fetchAll("SELECT firstname, phone_number FROM users WHERE users.firstname = @firstname AND users.phone_number = @phone_number", {
    ['@phone_number'] = phone_number,
	['@firstname'] = firstname
  }, function (data)
    cb(data[1])
  end)
end

RegisterServerEvent('gcPhone:fatura_getBilling')
AddEventHandler('gcPhone:fatura_getBilling', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
  if phone_number ~= nil and phone_number ~= "" and firstname ~= nil and firstname ~= "" then
    getUserFatura(phone_number, firstname, function (user)
      local accountId = user and user.id
      FaturaGetBilling(accountId, function (billingg)
        TriggerClientEvent('gcPhone:fatura_getBilling', sourcePlayer, billingg)
      end)
    end)
  else
    FaturaGetBilling(nil, function (billingg)
      TriggerClientEvent('gcPhone:fatura_getBilling', sourcePlayer, billingg)
    end)
  end
end)


RegisterServerEvent("gcPhone:faturapayBill")
AddEventHandler("gcPhone:faturapayBill", function(id, sender, amount, target, sharedAccountName)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE id = @id', {
		['@id'] = id
	}, function(data)

	local xTarget = ESX.GetPlayerFromIdentifier(sender)
	local target = data[1].target
	local target_type = data[1].target_type
	
	if target_type=='player' then
	
	if xTarget ~= nil then	
    if amount ~= nil then
        if xPlayer.getBank() >= amount then	

					MySQL.Async.execute('DELETE from billing WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						xPlayer.removeAccountMoney('bank', amount)
						xTarget.addAccountMoney('bank',amount)

						TriggerClientEvent("esx:showNotification21", src, "Fatura ödendi $" .. amount)
						TriggerClientEvent("esx:showNotification21", sender, "Yeterli paran yok.")
						TriggerClientEvent("esx:showNotification21", xTarget.source, "Fatura Ödendi $" .. amount)

					end)
					
				else
					TriggerClientEvent("esx:showNotification21", sender, "Yeterli paran yok.")
					TriggerClientEvent("esx:showNotification21", src, "Fatura ödendi $" .. amount)


				end

			else
				
				TriggerClientEvent("esx:showNotification21", xTarget.source, "Fatura Ödendi of $" .. amount)

			end				
	
    end
	
	
	
	
	else
TriggerEvent('esx_addonaccount:getSharedAccount21', target, function(account)	

if xTarget ~= nil then	
    if amount ~= nil then
        if xPlayer.getBank() >= amount then	

					MySQL.Async.execute('DELETE from billing WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						xPlayer.removeAccountMoney('bank', amount)
						account.addMoney(amount)

						TriggerClientEvent("esx:showNotification21", src, "Fatura ödendi $" .. amount)
						TriggerClientEvent("esx:showNotification21", sender, "Yeterli paran yok.")
						TriggerClientEvent("esx:showNotification21", xTarget.source, "Fatura Ödendi $" .. amount)

					end)
					
				else
					TriggerClientEvent("esx:showNotification21", sender, "Yeterli paran yok.")
					TriggerClientEvent("esx:showNotification21", src, "Fatura ödendi $" .. amount)


				end

			else
				
				TriggerClientEvent("esx:showNotification21", xTarget.source, "Fatura Ödendi of $" .. amount)

			end				
	
    end
	
end)

end





end)
end)


--====================================================================================
-- EXTRA LEAKS | https://discord.gg/extraleaks
--====================================================================================