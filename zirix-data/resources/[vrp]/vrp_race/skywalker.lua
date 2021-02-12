local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

src = {}
Tunnel.bindInterface('vrp_race',src)
vCLIENT = Tunnel.getInterface('vrp_race')

local blips = {}
local lobby = false
local andamento = false
local tempo
local dinheiro
local reward
local index
local corrida
local corredores = {}
local posicoes = {}
local criando = false

vRP._prepare('vRP/create_races','INSERT IGNORE INTO vrp_race(user_id,nickname,races) VALUES(@user_id,@nickname,@races)')
vRP._prepare('vRP/get_races','SELECT * FROM vrp_race WHERE user_id = @user_id')
vRP._prepare('vRP/update_races','UPDATE vrp_race SET races = @races WHERE user_id = @user_id')
vRP._prepare('vRP/get_racesrank','SELECT * FROM vrp_race')
vRP._prepare('vRP/get_myrank','SELECT races FROM vrp_race WHERE user_id = @user_id')
vRP._prepare('vRP/get_nickname','SELECT nickname FROM vrp_race WHERE user_id = @user_id') 

AddEventHandler('vRP:playerSpawn',function(user_id, source, first_spawn)
    if first_spawn then 
        TriggerClientEvent('nation:bliprace',source)
    end
end)

AddEventHandler('vRP:playerJoinGroup', function(user_id, group, gtype)
    local player = vRP.getUserSource(user_id)
    if player then
    	TriggerClientEvent('nation:bliprace',player)
    end
end)

AddEventHandler('vRP:playerLeaveGroup', function(user_id, group, gtype)
    local player = vRP.getUserSource(user_id)
    if player then
    	TriggerClientEvent('nation:bliprace',player)
    end
end)

function src.getGlobalRank(corrida)
	local source = source
	local user_id = vRP.getUserId(source)
	local rows = vRP.query('vRP/get_racesrank')
	local primeiro = {'none',config.corridas[corrida].tempo}
	local segundo = {'none',config.corridas[corrida].tempo}
	local terceiro = {'none',config.corridas[corrida].tempo}
	if #rows > 0 then
		for k,v in pairs(rows) do
			local data = rows[k]
			local corridas = json.decode(data.races)
			local corridaatual = corridas[corrida]
			if corridaatual and corridaatual ~= 'null' then
				if corridaatual <= primeiro[2] then
					terceiro = segundo
					segundo = primeiro
					primeiro = {data.nickname,corridaatual}
				elseif corridaatual <= segundo[2] then
					terceiro = segundo
					segundo = {data.nickname,corridaatual}
				elseif corridaatual <= terceiro[2] then
					terceiro = {data.nickname,corridaatual}
				end
			end
		end
	end
	local rank = {primeiro = primeiro,segundo = segundo,terceiro = terceiro}
	return rank
end

function src.getMyRank(corrida)
	local source = source
	local user_id = vRP.getUserId(source)
	local myrank
	local rows = vRP.query('vRP/get_myrank', {user_id = user_id})
	if #rows > 0 then
		local data = rows[1]
		local corridas = json.decode(data.races)
		myrank = corridas[corrida]
	end
	return myrank
end

function src.getNickName(id)
	if id then
		local user_id = id
		local rows = vRP.query('vRP/get_nickname', {user_id = user_id})
		return rows[1].nickname
	else 
		local source = source
		local user_id = vRP.getUserId(source)
		local rows = vRP.query('vRP/get_nickname', {user_id = user_id})
		return rows[1].nickname
	end
end

function src.checkCorredor(corrida)
	local source = source
	local user_id = vRP.getUserId(source)
	local data = {}
	local rows = vRP.query('vRP/get_races', {user_id = user_id})
	if #rows > 0 then
		data = json.decode(rows[1].races)
		if not data[corrida] or data[corrida] == 'null' then
			data[corrida] = config.corridas[corrida].tempo
			vRP.execute('vRP/update_races', {user_id = user_id, races = json.encode(data)})
		end
		return data
	else
		local nickname = vRP.prompt(source,'Digite um apelido de corrida: ', '')
		if nickname and nickname ~= '' and nickname ~= '  ' and string.len(nickname) < 8 and not string.find(nickname, ' ') then
			local corridas = {}
			local i = 1
			while i <= #config.corridas do
				corridas[i] = config.corridas[i].tempo
				i = i+1
			end
			nickname = nickname:gsub('%\n', '')
			vRP.execute('vRP/create_races', {user_id = user_id, nickname = nickname, races = json.encode(corridas)})
			rows = vRP.query('vRP/get_races', {user_id = user_id})
			data = rows[1]
			return data
		end
	end
	TriggerClientEvent('Notify',source,'aviso','Apelido inválido!', 5000)
	return false
end

function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local perm = config.organizador_permissao
	if perm then
		if vRP.hasPermission(user_id,perm) then		
			return true
		end
	else
		return true
	end
	return false
end

function src.setValor(race)
	if not criando then
		criando = true
		local source = source
		local user_id = vRP.getUserId(source)
		local valor = vRP.prompt(source,'Digite o valor de entrada da corrida: ', '')
		valor = parseInt(valor)
		if valor and valor > 0 then
			dinheiro = valor
			if vRP.request(source,'Você deseja pagar <b>$ '..vRP.format(dinheiro)..'</b> sujo(s) para entrar na corrida?', 30) then
				if vRP.tryGetInventoryItem(user_id,'dinheiro-sujo',dinheiro) then
					TriggerClientEvent('Notify',source,'sucesso','Valor da corrida definido em <b>$ '..vRP.format(dinheiro)..'</b>.', 5000)
					lobby = true
					index = race
					corrida = config.corridas[race]
					vCLIENT.updateLobby(-1,lobby)
					vCLIENT.updateOrganizador(source, true)
					vCLIENT.updateNroCorredores(-1,#corredores)
					vCLIENT.updateIndex(-1,index)
					local nickname = src.getNickName(user_id)
					table.insert(corredores, { corredor = user_id })
					vCLIENT.updateCorredor(source,true)
					vCLIENT.updateNroCorredores(-1,#corredores)
					TriggerClientEvent('Notify',source,'sucesso','Você está participando da corrida.', 5000)
					TriggerClientEvent('Notify',source,'aviso','<b>NÃO SAIA DO VEÍCULO, SE NÃO SERÁ REMOVIDO DA CORRIDA!</b>', 5000)
					vCLIENT.notifyOrganizador(-1,'importante','<b>'..nickname..'</b> entrou na corrida.', 5000)
					criando = false
					return true
				else
					TriggerClientEvent('Notify',source,'negado','Você não possui <b>$ '..vRP.format(dinheiro)..' sujo(s).', 5000)
					dinheiro = nil
				end
			end
		else
			TriggerClientEvent('Notify',source,'negado','Valor inválido.', 5000)
		end
		criando = false
	end
	return false
end

RegisterServerEvent('nation:timer')
AddEventHandler('nation:timer', function()
	local timer = config.tempoinicial
	while timer > 0 do
		timer = timer  -1
		vCLIENT.updateTimer(-1,timer)
		Wait(1000)
	end
	vCLIENT.updateTimer(-1)
	andamento = true
	TriggerEvent('nation:iniciarracha')
end)

function src.getIndex()
	return index
end

function src.getValor()
	local source = source
	local user_id = vRP.getUserId(source)
	if #corredores >= config.maxcorredores or #corredores >= #corrida.carros then
		TriggerClientEvent('Notify',source,'negado','Não há mais vagas.', 5000)
		return false
	elseif vCLIENT.isCorredor(source) then
		TriggerClientEvent('Notify',source,'negado','Você já está participando da corrida.', 5000)
		return false
	elseif not config.organizador_participar and vCLIENT.isOrganizador(source) then
		TriggerClientEvent('Notify',source,'aviso','Você não pode participar de uma corrida que está organizando.', 5000)
		return false
	elseif vRP.hasPermission(user_id,'policia.permissao') then
		TriggerClientEvent('Notify',source,'aviso','COXINHA NÃO PODE PARTICIPAR DA CORRIDA!.', 5000)
		return false
	elseif andamento then
		TriggerClientEvent('Notify',source,'aviso','A corrida já começou.', 5000)
		return false
	end
	if dinheiro then
		if vRP.request(source,'Você deseja pagar <b>$ '..vRP.format(dinheiro)..'</b> sujo(s) para entrar na corrida?', 30) then
			if vRP.tryGetInventoryItem(user_id,'dinheiro-sujo',dinheiro) then
				local nickname = src.getNickName(user_id)
				table.insert(corredores, { corredor = user_id })
				vCLIENT.updateCorredor(source,true)
				vCLIENT.updateNroCorredores(-1,#corredores)
				TriggerClientEvent('Notify',source,'sucesso','Você está participando da corrida.', 5000)
				TriggerClientEvent('Notify',source,'aviso','<b>NÃO SAIA DO VEÍCULO, SE NÃO SERÁ REMOVIDO DA CORRIDA!</b>', 5000)
				vCLIENT.notifyOrganizador(-1,'importante','<b>'..nickname..'</b> entrou na corrida.', 5000)
				return true
			else
				TriggerClientEvent('Notify',source,'negado','Você não possui <b>$ '..vRP.format(dinheiro)..' sujo(s).', 5000)
			end
		end
	end
	return false
end

function src.leaveRace()
	local source = source
	local user_id = vRP.getUserId(source)
	for k,v in pairs(corredores) do
		if v.corredor == user_id then
			table.remove(corredores, k)
			vCLIENT.updateNroCorredores(-1,#corredores)
			local nickname = src.getNickName(user_id)
			vCLIENT.notifyOrganizador(-1,'aviso','<b>'..nickname..'</b> saiu da corrida.', 5000)
			TriggerClientEvent('Notify',source,'aviso','Você saiu da corrida!', 5000)
		end
	end
	if #corredores == 0 then
		finishRace()
	end
end

function src.getVehiclePosition()
	local source = source
	local user_id = vRP.getUserId(source)
	for k,v in pairs(corredores) do
		if user_id == v.corredor then
			return corrida.carros[k].cds, corrida.carros[k].h
		end
	end
end

RegisterServerEvent('nation:racetime')
AddEventHandler('nation:racetime', function()
	src.startRace()
end)

function src.startRace()
	if not tempo then
		tempo = corrida.tempo
		while tempo and tempo >= 0 do
			vCLIENT.updateTempo(-1,tempo)
			tempo = tempo - 1
			Citizen.Wait(1000)
		end
		finishRace()
	end
end

function src.refreshPos(cp,time)
	local source = source
	local user_id = vRP.getUserId(source)
	for k,v in pairs(posicoes) do
		if user_id == v.corredor then
			posicoes[k].checkpoint = cp
			posicoes[k].time = time
		end
	end
	src.getPos()
end

function src.getPos()
	local ranking = {}
	for k, v in ipairs(posicoes) do
		table.insert(ranking,{k,v})
	end
	table.sort(ranking, function(a,b) 
		if a[2].checkpoint == b[2].checkpoint then
			return(a[2].time > b[2].time)
		end
		return(a[2].checkpoint > b[2].checkpoint)
	end)
	local pos = {}
  	local i = 1
 	while i <= #ranking do
      	pos[i] = src.getNickName(ranking[i][2].corredor)
      	i = i+1
  	end
	for _, v in ipairs(ranking) do
		local src = vRP.getUserSource(v[2].corredor)
		if src then
			vCLIENT.updatePosition(src,_,pos)
		end
	end
end

function getRank()
	local ranking = {}
	for k, v in ipairs(posicoes) do
		table.insert(ranking,{k,v})
	end
	table.sort(ranking, function(a,b) 
		if a[2].checkpoint == b[2].checkpoint then
			return(a[2].time > b[2].time)
		end
		return(a[2].checkpoint > b[2].checkpoint)
	end)
	return ranking
end

function src.checkReward(tempofinal,index)
	local source = source
	local user_id = vRP.getUserId(source)
	local nickname = src.getNickName(user_id)
	local ranks = getRank()
	local rank
	if tempofinal and index then
		src.updateGlobalRank(user_id,tempofinal,index)
	end
	for k,v in ipairs(ranks) do
		if v[2].corredor == user_id then
			rank = k
		end
	end
	TriggerClientEvent('Notify',source,'importante','Corrida Terminada! Classificação:  <b>'..rank..'º</b> Colocado.', 5000)
	vCLIENT.notifyOrganizador(-1,'importante','<b>'..nickname..'</b> terminou a corrida e ficou em <b>'..rank..'º</b> colocado.', 5000)
	if rank == 1 then
		vRP.giveInventoryItem(user_id,'dinheiro-sujo',reward)
		TriggerClientEvent('Notify',source,'sucesso','Parabéns, você recebeu $ <b>'..vRP.format(reward)..'</b> sujo(s).', 5000)
	end
	if rank == #corredores then
		tempo = 5
	end
end


function src.updateGlobalRank(user_id,tempo,corrida)
	local data = {}
	local rows = vRP.query('vRP/get_races', {user_id = user_id})
	if #rows > 0 then
		data = json.decode(rows[1].races)
		if data[corrida] then
			local tempoantigo = tonumber(data[corrida])
			if tempo < tempoantigo then
				data[corrida] = tempo
				vRP.execute('vRP/update_races', {user_id = user_id, races = json.encode(data)})
			end
		else
			data[corrida] = tempo
			vRP.execute('vRP/update_races', {user_id = user_id, races = json.encode(data)})
		end
	end
end


function src.getLobby()
	return lobby
end

function finishRace()
	vCLIENT.notifyOrganizador(-1,'importante','Corrida finalizada.', 5000)
	dinheiro = nil
	lobby = false
	corrida = nil
	tempo = nil
	reward = nil
	index = nil
	andamento = false
	corredores = {}
	posicoes = {}
	vCLIENT.updateEscolhido(-1,false)
	vCLIENT.updateTempo(-1,tempo)
	vCLIENT.updateCorrida(-1,false)
	vCLIENT.updateLobby(-1,lobby)
	vCLIENT.updateCorredor(-1,false)
	vCLIENT.updateOrganizador(-1,false)
	vCLIENT.updateNroCorredores(-1,nil)
	vCLIENT.updatePosition(-1,nil)
	vCLIENT.removeBlips(-1)
	vCLIENT.finishCorrida(-1)
end

function src.callPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local policia = vRP.getUsersByPermission('')
	for k,v in pairs(policia) do
		local src = vRP.getUserSource(v)
		blips[v] = vRPclient.addBlip(src,x,y,z,161,1,'~r~Corredor Ilegal',0.6,false)
	end
	Wait(250)
	for k,v in pairs(policia) do
		local src = vRP.getUserSource(v)
		vRPclient.removeBlip(src,blips[v])
	end
end

RegisterServerEvent('nation:iniciarracha')
AddEventHandler('nation:iniciarracha', function()
	if lobby and #corredores >= config.mincorredores and not reward then
		reward = dinheiro * #corredores
		local i = 1
		while i <= #corredores do
			posicoes[i] = { corredor = corredores[i].corredor, checkpoint = 0, time = corrida.tempo}
			i = i + 1
		end
		local random = math.random(1,#corredores)
		local src = vRP.getUserSource(corredores[random].corredor)
		if src then
			vCLIENT.updateEscolhido(src,true)
			local cops = vRP.getUsersByPermission('policia.permissao')
			for k,v in pairs(cops) do
				vCLIENT.denuncia(vRP.getUserSource(v))
			end
		end
		vCLIENT.updateCorrida(-1,corrida)
		vCLIENT.notifyCorredores(-1,'importante','Corrida iniciada com sucesso.', 5000)
		vCLIENT.updateTempo(-1,corrida.tempo)
		vCLIENT.startingRace(-1)
--		src.startRace()
--		finishRace()
	else
		vCLIENT.notifyCorredores(-1,'aviso','Número insuficiente de corredores.', 5000)
		finishRace()
	end
end)