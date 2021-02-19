local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPex = {}
Tunnel.bindInterface("police_cloakroom",vRPex)

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
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paisanapolicia.permissao") then
		return true
	end
end

local recruta = {
	[1885233650] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 0,0 }, -- Maos
        [4] = { 35,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { -1,0 }, -- Acessorios			
        [8] = { 58,0 }, -- Camisa
        [9] = { 0,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 55,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 30,0 }, -- Maos
        [4] = { 34,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 6,0 }, -- Acessorios			
        [8] = { 35,0 }, -- Camisa
        [9] = { 0,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 48,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}

local investigador = {
    [1885233650] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 1,0 }, -- Maos
        [4] = { 4,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 31,3 }, -- Sapato
        [7] = { -1,0 }, -- Acessorios			
        [8] = { -1,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 86,3 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { 2,0 }, -- Orelhas
        ["p6"] = { -1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 12,0 }, -- Maos
        [4] = { 4,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 3,0 }, -- Sapato
        [7] = { -1,0 }, -- Acessorios			
        [8] = { 2,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 26,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { -1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}

local tatico = {
    [1885233650] = {
        [1] = { 53,9 }, -- Mascara
        [3] = { 38,0 }, -- Maos
        [4] = { 33,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { -1,0 }, -- Acessorios			
        [8] = { 131,0 }, -- Camisa
        [9] = { 0,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 53,0 }, -- Jaqueta
        ["p0"] = { 116,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { 53,9 }, -- Mascara
        [3] = { 38,0 }, -- Maos
        [4] = { 30,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { -1,0 }, -- Acessorios			
        [8] = { 2,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 46,0 }, -- Jaqueta
        ["p0"] = { 38,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}

local alta = {
    [1885233650] = {
        [1] = { -1,9 }, -- Mascara
        [3] = { 11,0 }, -- Maos
        [4] = { 4,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 0,0 }, -- Acessorios			
        [8] = { 15,0 }, -- Camisa
        [9] = { 0,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 42,0 }, -- Jaqueta
        ["p0"] = { 83,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 0,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 0,0 }, -- Maos
        [4] = { 7,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 6,0 }, -- Sapato
        [7] = { -1,0 }, -- Acessorios			
        [8] = { 2,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 27,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { 0,0 }, -- Orelhas
        ["p6"] = { 1,0 }, -- Braço Esquerdo
        ["p7"] = { 7,0 } -- Braço Direito
    }
}

RegisterServerEvent("recruta")
AddEventHandler("recruta",function()
    local user_id = vRP.getUserId(source)
    local custom = recruta
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("investigador")
AddEventHandler("investigador",function()
    local user_id = vRP.getUserId(source)
    local custom = investigador
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("tatico")
AddEventHandler("tatico",function()
    local user_id = vRP.getUserId(source)
    local custom = tatico
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("alta")
AddEventHandler("alta",function()
    local user_id = vRP.getUserId(source)
    local custom = alta
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
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