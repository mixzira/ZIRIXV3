local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

cftv = {}
Tunnel.bindInterface('vrp_cftv',cftv)

function cftv.permission()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id,'policia.permissao') or vRP.hasPermission(user_id,'administrador.permissao') then
		return true
	end
end
