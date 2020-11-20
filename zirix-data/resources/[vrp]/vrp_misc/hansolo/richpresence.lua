local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]---------------------------------------------------------------------------------------

misc = Tunnel.getInterface("vrp_misc")

--[ DISCORD ]---------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
        SetDiscordAppId(763536078132740107)

	    local players = misc.discord()
		
	    SetDiscordRichPresenceAsset('diamond')
		SetDiscordRichPresenceAssetText('Cidadãos: '..players..' de 200')
	    SetRichPresence('Faça parte da nossa família: discord.gg/diamondcity')
		Citizen.Wait(10000)
	end
end)