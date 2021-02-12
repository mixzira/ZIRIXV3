inMenu = true
local bank = 0
local firstname = ''
local lastname = ''

RegisterNetEvent("vRP:updateBalanceGc")
AddEventHandler('vRP:updateBalanceGc', function(bank)
      SendNUIMessage({event = 'updateBankbalance', banking = bank})    
end)

RegisterNetEvent('esx:playerLoaded21')
AddEventHandler('esx:playerLoaded21', function(playerData)
      local accounts = playerData.accounts or {}
      for index, account in ipairs(accounts) do 
            if account.name == 'bank' then
                  setBankBalance(account.money)
                  break
            end
      end
end)

RegisterNetEvent('esx:setAccountMoney21')
AddEventHandler('esx:setAccountMoney21', function(account)
      if account.name == 'bank' then
            setBankBalance(account.money)
      end
end)

RegisterNetEvent("es:addedBank")
AddEventHandler("es:addedBank", function(m)
      setBankBalance(bank + m)
end)

RegisterNetEvent("es:removedBank")
AddEventHandler("es:removedBank", function(m)
      setBankBalance(bank - m)
end)

RegisterNetEvent('es:displayBank')
AddEventHandler('es:displayBank', function(bank)
      setBankBalance(bank)
end)

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('gcPhone:transfer', data.to, data.amountt)
end)

RegisterNetEvent("gcPhone:firstname")
AddEventHandler("gcPhone:firstname", function(_name)
  firstname = _name
  SendNUIMessage({event = 'updateMyFirstname', firstname = firstname})
end)

RegisterNetEvent("gcPhone:lastname")
AddEventHandler("gcPhone:lastname", function(_firstname)
  lastname = _firstname
  SendNUIMessage({event = 'updateMyListname', lastname = lastname})
end)


