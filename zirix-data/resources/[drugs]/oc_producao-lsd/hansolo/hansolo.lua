----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("oc_producao-lsd")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = -2469.54, ['y'] = 3700.93, ['z'] = 14.74 }, -- PADRAO
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false
local produzindo = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "lsd-baixa" then
		TriggerServerEvent("produzir-lsd","lsd-baixa")

	elseif data == "lsd-media" then
		TriggerServerEvent("produzir-lsd","lsd-media")

	elseif data == "lsd-alta" then
		TriggerServerEvent("produzir-lsd","lsd-alta")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterCommand("fechar",function()
	ToggleActionMenu()
	onmenu = false
end)

RegisterNetEvent("fechar-nui-lsd")
AddEventHandler("fechar-nui-lsd", function()
	ToggleActionMenu()
	onmenu = false
end)

RegisterNetEvent("produzindo-true")
AddEventHandler("produzindo-true", function()
	produzindo = true
end)

RegisterNetEvent("produzindo-false")
AddEventHandler("produzindo-false", function()
	produzindo = false
end)

-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000

		for k,v in pairs(prodMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachine = prodMachine[k]
			local idBancada = prodMachine[id]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachine.x, prodMachine.y, prodMachine.z, true ) < 1.2 and not onmenu then
				drawTxt("Pressione [~r~E~w~] para acessar a ~r~PRODUÇÃO DE LSD~w~.",4,0.5,0.92,0.35,255,255,255,180)
			end
			if distance <= 5 then
				DrawMarker(23, prodMachine.x, prodMachine.y, prodMachine.z-0.97,0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 136, 96, 240, 180, 0, 0, 0, 0)
				idle = 5
				if distance <= 1.2 then
					if not produzindo then
						if IsControlJustPressed(0,38) and oC.checkPermissao() then
							ToggleActionMenu()
							onmenu = true
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end