local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:clear')
RegisterNetEvent('__cfx_internal:serverPrint')
RegisterNetEvent('_chat:messageEntered')

RegisterNetEvent('chatMessageProximity')
AddEventHandler('chatMessageProximity',function(id,name,firstname,message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		TriggerEvent('chatMessage',""..name.." "..firstname.."",{131,174,0},message)
	end
end)

RegisterNetEvent('chatMessageProximity2')
AddEventHandler('chatMessageProximity2',function(id, author, color, text)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)

	if pid == myId then
		TriggerEvent('chatMessage', author, color, text)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)),GetEntityCoords(GetPlayerPed(pid))) < 10.999 then
		TriggerEvent('chatMessage', author, color, text)
	end
end)

AddEventHandler('chatMessage', function(author, color, text)
	local args = { text }
	if author ~= "" then
		table.insert(args, 1, author)
	end
	SendNUIMessage({ type = 'ON_MESSAGE', message = { color = color, multiline = true, args = args } })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
	SendNUIMessage({ type = 'ON_MESSAGE', message = { templateId = 'print', multiline = true, args = { msg } } })
end)

AddEventHandler('chat:addMessage', function(message)
	SendNUIMessage({ type = 'ON_MESSAGE', message = message })
end)

AddEventHandler('chat:addTemplate', function(id, html)
	SendNUIMessage({ type = 'ON_TEMPLATE_ADD',template = { id = id, html = html } })
end)

AddEventHandler('chat:clear', function(name)
	SendNUIMessage({ type = 'ON_CLEAR' })
end)

RegisterNUICallback('chatResult', function(data, cb)
	chatInputActive = false
	SetNuiFocus(false)

	if not data.canceled then
		local id = PlayerId()
		local r, g, b = 0, 0x99, 255

		if data.message:sub(1, 1) == '/' then
			ExecuteCommand(data.message:sub(2))
		else
			TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
		end
	end

	cb('ok')
end)

local function refreshThemes()
	local themes = {}

	for resIdx = 0, GetNumResources() - 1 do
		local resource = GetResourceByFindIndex(resIdx)

		if GetResourceState(resource) == 'started' then
			local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

			if numThemes > 0 then
				local themeName = GetResourceMetadata(resource, 'chat_theme')
				local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

				if themeName and themeData then
					themeData.baseUrl = 'nui://' .. resource .. '/'
					themes[themeName] = themeData
				end
			end
		end
	end
	SendNUIMessage({ type = 'ON_UPDATE_THEMES', themes = themes })
end

AddEventHandler('onClientResourceStart',function(resName)
	Citizen.Wait(500)
	refreshThemes()
end)

RegisterNUICallback('loaded',function(data,cb)
	refreshThemes()
	chatLoaded = true
	cb('ok')
end)

local menu_chat = false
RegisterNetEvent("status:chat")
AddEventHandler("status:chat",function(status)
	menu_chat = status
end)

RegisterCommand('chat',function(source, args, rawCommand)
	if not menu_chat then
		menu_chat = true
	else
		menu_chat = false
	end
end)

Citizen.CreateThread(function()
	SetTextChatEnabled(false)
	SetNuiFocus(false)

	while true do
		Citizen.Wait(1)
		if not chatInputActive then
			if IsControlPressed(0,245) then
				chatInputActive = true
				chatInputActivating = true

				SendNUIMessage({ type = 'ON_OPEN' })
			end
		end

		if chatInputActivating then
			if not IsControlPressed(0,245) then
				SetNuiFocus(true)
				chatInputActivating = false
			end
		end

		if chatLoaded then
			local shouldBeHidden = false

			if IsScreenFadedOut() or IsPauseMenuActive() or menu_chat then
				shouldBeHidden = true
			end

			if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
				chatHidden = shouldBeHidden
				SendNUIMessage({ type = 'ON_SCREEN_STATE_CHANGE', shouldHide = shouldBeHidden })
			end
		end
	end
end)