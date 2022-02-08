local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

cftv = {}
Tunnel.bindInterface('vrp_cftv',cftv)

--[ PERMISSION | FUNCTION ]-----------------------------------------------------------------------------------------------------

function cftv.permission()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id,'policia.permissao') or vRP.hasPermission(user_id,'administrador.permissao') then
		return true
	end
end
