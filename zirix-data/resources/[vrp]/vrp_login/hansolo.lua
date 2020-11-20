local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ FUNCTION ]---------------------------------------------------------------------------------------------------------------------------

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end

--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "rodoviaria" then
		vRP.teleport(451.31, -629.21, 28.54)
	elseif data == "aeroporto" then
		vRP.teleport(-1037.64, -2737.77, 20.17)
	end
	ToggleActionMenu()
	TriggerEvent("ToogleBackCharacter")
	TriggerEvent("status:hud",false)
end)

RegisterCommand("tlogin",function(source,args)
	ToggleActionMenu()
end)

--[ TOOGLE LOGIN ]-----------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('vrp:ToogleLoginMenu')
AddEventHandler('vrp:ToogleLoginMenu',function()
	ToggleActionMenu()
end)