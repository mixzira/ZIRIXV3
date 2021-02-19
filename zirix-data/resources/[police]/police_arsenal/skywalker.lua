local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPex = {}
Tunnel.bindInterface("police_arsenal",vRPex)

local auth = false 

local customer = 'N/A'
local customerid = 'N/A'
local customeremail = 'N/A'
local customerdiscord = '<@N/A>'
local webhook = 'https://discord.com/api/webhooks/785562766949613588/RR0voR7PwiZ7w-FZwDai6JLJb7dhnRN1FJMiEgP1S_IMJTXen-xdAizHwF4gHs8EKtev'



function vRPex.checkPermission(permission)
	local src = source
    local user_id = vRP.getUserId(src)
    if user_id then
        return vRP.hasPermission(user_id,permission)
    end
end

function vRPex.checkOfficer()
	local src = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paisana-policia.permissao") then
		return true
	end
end

RegisterNetEvent('flix:onarmor')
AddEventHandler('flix:onarmor',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,config.vest) then
			vRPclient.setArmour(source,100)
			return true
		end
	end
end)

RegisterNetEvent('flix:offarmor')
AddEventHandler('flix:offarmor',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,config.vest) then
			vRPclient.setArmour(source,0)
			return true
		end
	end
end)

function vRPex.remEquip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRPclient.setArmour(source,0)
		vRPclient._replaceWeapons(source,{["WEAPON_UNARMED"] = { ammo = 0 }})
	end
end

RegisterServerEvent("bdl:onduty")
AddEventHandler("bdl:onduty",function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"paisana-policia.permissao") then
        vRP.addUserGroup(user_id,"policia")
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.",5000)
        
    else
        TriggerClientEvent("Notify",source,"negado","Você já está em serviço.",5000)
    end
end)

RegisterServerEvent("bdl:offduty")
AddEventHandler("bdl:offduty",function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") then
        vRP.addUserGroup(user_id,"paisana-policia")
		vRPex.remEquip()
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
		TriggerClientEvent("Notify",source,"aviso","Seus equipamentos foram guardados no arsenal.",5000) 
    else
        TriggerClientEvent("Notify",source,"negado","Você já está fora de serviço.",5000)
    end
end)

AddEventHandler("onResourceStart",function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("http://192.99.251.232:3501/auth/auth.json",function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest("https://api.ipify.org/",function(errorCode, resultData, resultHeaders)
                local data = json.decode(resultData1)
                for k,v in pairs(data) do
                    if k == GetCurrentResourceName() then
                        for a,b in pairs(v) do             
                            if resultData == b then
                                print("\27[32m["..GetCurrentResourceName().."] Autenticado;")
                                auth = true
                                return
                            end
                        end
                    end            
                end
				PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = "**Atenção:** <@&748720506169196675>**!**", embeds = {{title = "PRODUTO NÃO AUTENTICADO:\n⠀", thumbnail = {url = 'https://i.imgur.com/Y5Zktwm.png'}, fields = {{ name = "**Produto:**", value = ""..GetCurrentResourceName().."\n⠀"}, {name = "**• DADOS DO PROPRIETÁRIO:**", value = "⠀"}, {name = "**Nome completo:**", value = ""..customer..""}, {name = "**Nº contrato:**", value = ""..customerid..""}, {name = "**E-mail:**", value = ""..customeremail..""}, {name = "**Discord:**", value = ""..customerdiscord.."\n⠀"}, {name = "**• DADOS DE REDE:**", value = "⠀"}, {name = "**IP não autorizado:**", value = "` "..resultData.." `\n⠀"}}, footer = {text = 'ZIRAFLIX Inc. Todos os direitos reservados | '..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = 'https://i.imgur.com/Y5Zktwm.png'}, color = 1975079}}}), {['Content-Type'] = 'application/json'})                    
                print("\27[31m["..GetCurrentResourceName().."] Não autenticado! Adquira já o seu em www.ziraflix.com;")
            end)
        end)
    end
end)

function vRPex.checkAuth()
    if auth then
        return true
    end
end