local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface('vRP')


src = {}
Tunnel.bindInterface("vrp_race",src)
vSERVER = Tunnel.getInterface("vrp_race")

local blips = {}
local corridas = config.corridas

local lobby = false
local organizador = false
local corredor = false
local timer
local nrocorredores
local corrida
local indexcorrida
local tempocorrida
local checkpoint = 0
local posicao
local escolhido = false
local starting = false
local posicoes = {}
local timing

local nome
local seutempo
local melhortempo
local ranking 
local meurank
local info = false
local info2 = false

AddEventHandler('onClientResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
	  return
	end
	TriggerEvent("nation:bliprace")
end)

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---BLIPS-----------------------------------------------------------------------
-------------------------------------------------------------------------------
RegisterNetEvent("nation:bliprace")
AddEventHandler("nation:bliprace", function()
	for k,v in pairs(corridas) do
		if v.comeco and not DoesBlipExist(blips[k]) then
			local x,y,z = v.comeco[1],v.comeco[2],v.comeco[3]
			AddBlip(k,x,y,z)
		end
	end
end)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
---THREADS---------------------------------------------------------------------
-------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 500
		if not corrida then
			local ped = PlayerPedId()
			local playercoords = GetEntityCoords(ped)
			if not lobby then
				for k,v in pairs(corridas) do
					local coords = v.comeco
					local distance = #(playercoords - coords)
					if distance < 30 and IsPedInAnyVehicle(ped) then
						idle = 0
						local vehicle = GetVehiclePedIsIn(ped,false)
						if GetPedInVehicleSeat(vehicle,-1) == ped then
							DrawMarker(4, coords[1],coords[2],coords[3]+0.5,0,0,0,0,0,0,1.0,0.3,0.75,v.cor.r, v.cor.g, v.cor.b,155,0,0,0,1)
							DrawMarker(27,coords[1],coords[2],coords[3]-0.9,0,0,0,0,180.0,130.0,2.0,2.0,1.0,v.cor.r, v.cor.g, v.cor.b,155,0,0,1,1)
							if distance < 1.5 then
								nation_drawTxt(0.92, 1.4, 1.0,1.0,0.5, "Pressione ~r~E~w~ para organizar uma corrida.", 255, 255, 255, 255)
								if IsControlJustPressed(0,38) then
									if vSERVER.checkPermission() and not vSERVER.getLobby() then
										if vSERVER.checkCorredor(k) and vSERVER.setValor(k) then
											indexcorrida = vSERVER.getIndex()
											TriggerServerEvent("nation:timer")
										end
									else
										TriggerEvent("Notify","aviso","Você não tem permissão.", 5000)
									end
								end
							end
						end
					end
				end
			elseif indexcorrida then
				local coords = config.corridas[indexcorrida].comeco
				local cor = config.corridas[indexcorrida].cor
				local distance = #(playercoords - coords)
				if distance < 30 and IsPedInAnyVehicle(ped) then
					local vehicle = GetVehiclePedIsIn(ped,false)
					if GetPedInVehicleSeat(vehicle,-1) == ped then
						idle = 0
						DrawMarker(4, coords[1],coords[2],coords[3]+0.5,0,0,0,0,0,0,1.0,0.3,0.75,cor.r, cor.g, cor.b,155,0,0,0,1)
						DrawMarker(27,coords[1],coords[2],coords[3]-0.9,0,0,0,0,180.0,130.0,2.0,2.0,1.0,cor.r, cor.g, cor.b,155,0,0,1,1)
						if distance < 3 then
							nation_drawTxt(0.92, 1.4, 1.0,1.0,0.5, "Pressione ~y~E~w~ para participar da corrida.", 255, 255, 255, 255)
							if IsControlJustPressed(0,38) then
								if vSERVER.getLobby() then
									data = vSERVER.checkCorredor(vSERVER.getIndex())
									if data then
										if vSERVER.getValor() then
											indexcorrida = vSERVER.getIndex()
										end
									end
								else
									TriggerEvent("Notify","aviso","Não há corridas em andamento.", 5000)
								end
							end
						end
					end
				end
			end
		elseif corredor then
			idle = 100
			local ped = PlayerPedId()
			local playercoords = GetEntityCoords(ped)
			local points = corrida.checkpoints
			local x,y,z = table.unpack(points[checkpoint+1])
			local coords = vec3(x,y,z)
			local distance = #(playercoords - coords)
			if distance < 100 then
				idle = 0
				DrawMarker(1,x,y,z-3,0,0,0,0,0,0,12.0,12.0,8.0,255,255,255,55,0,0,0,0)
				DrawMarker(21,x,y,z+1,0,0,0,0,180.0,130.0,3.0,3.0,2.0,255,0,0,50,1,0,0,1)
				if distance < 10 then
					RemoveBlip(blip)
					vRP.playSound("CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					checkpoint = checkpoint+1
					if checkpoint < #corrida.checkpoints then
						x,y,z = table.unpack(points[checkpoint+1])
						CriandoBlip(x,y,z)
						vSERVER.refreshPos(checkpoint,tempocorrida)
					else
						vSERVER.refreshPos(checkpoint,tempocorrida)
						local tempofinal = corrida.tempo - tempocorrida
						vSERVER.checkReward(tempofinal,indexcorrida)
						meurank = posicao
						nome = vSERVER.getNickName()
						seutempo = calculateTempo(tempofinal)
						melhortempo = calculateTempo(vSERVER.getMyRank(indexcorrida))
						ranking = vSERVER.getGlobalRank(indexcorrida)
						showStats()
						src.finishCorrida()
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if escolhido then
			vSERVER.callPolice()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if tempocorrida and tempocorrida > 0 and checkpoint and corrida and #corrida.checkpoints > 0 and corredor and nrocorredores and posicao and posicoes and ranking then
			showInfo()
			showRunners()
		end
		if corredor and not IsPedInAnyVehicle(PlayerPedId()) then
			src.finishCorrida()
			RemoveBlip(blip)
			vSERVER.leaveRace()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if (corredor or organizador) and (nrocorredores) and not corrida and timer and indexcorrida then
			nation_drawTxt(0.70, 1.44, 1.0,1.0,0.4, "Corredores: ~b~"..nrocorredores.."~w~/~p~"..#config.corridas[indexcorrida].carros, 255, 255, 255, 255)
			nation_drawTxt(0.70, 1.42, 1.0,1.0,0.4, "Tempo: ~b~"..timer.."~w~ segundos", 255, 255, 255, 255)
		elseif timing then
			if timing > 0 then
				nation_drawTxt(0.98, 0.9, 1.0,1.0,2.0, "~b~"..timing, 255, 255, 255, 255)
			elseif timing <= 0 then
				vRP.playSound("Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				local time = 100
				while time > 0 do
					nation_drawTxt(0.95, 0.9, 1.0,1.0,2.0, "~y~VAI!", 255, 255, 255, 255)
					time = time-1
					Citizen.Wait(1)
				end
				timing = nil
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if starting then
			SetVehicleDoorsLocked(GetVehiclePedIsIn(PlayerPedId(),false), 4)
		end
	end
end)

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------FUNÇÕES-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------


function calculateTempo(t)
	local minutos = parseInt(t / 60)
	local segundos = 0
	if t >= 60 then
		segundos = t % 60
	else
		segundos = t
	end
	if minutos >= 0 and minutos <= 9 then
		minutos = tostring("0" .. minutos)
	else
		minutos = tostring(minutos)
	end
	if segundos >= 0 and segundos <= 9 then
		segundos = tostring("0" .. segundos)
	else
		segundos = tostring(segundos)
	end
	local tempin = tostring(minutos..":"..segundos)
	return tempin
end

function src.startingRace()
	if corredor then
		starting = true
		DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
		local cds,h = vSERVER.getVehiclePosition()
		SetEntityCoords(vehicle,cds[1],cds[2],cds[3])
		SetEntityHeading(vehicle,h)
		FreezeEntityPosition(vehicle,true)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
		if corrida then
			local points = corrida.checkpoints
			local x,y,z = table.unpack(points[checkpoint+1])
			CriandoBlip(x,y,z)
			vSERVER.refreshPos(checkpoint,tempocorrida)
			ranking = vSERVER.getGlobalRank(indexcorrida)
			startTiming()
		end
	end
end


function startTiming()
	timing = 5
	while timing and timing > 0 do
		TriggerEvent("vrp_sound:source","coin", 0.05)
		Citizen.Wait(1000)
		timing = timing - 1
	end
	FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(),false),false)
	starting = false
	SetVehicleDoorsLocked(GetVehiclePedIsIn(PlayerPedId(),false), 1)
	TriggerServerEvent("nation:racetime")
end


function src.finishCorrida()
	lobby = false
	corredor = false
	nrocorredores = nil
	tempocorrida = nil
	checkpoint = 0
	posicao = nil
	escolhido = false
	corrida = false
	indexcorrida = nil
	posicoes = {}
	vRP._removeDiv("RaceInfo")
	vRP._removeDiv("RaceRunners")
	info = false
	info2 = false
end

function src.notifyOrganizador(type,message)
	if organizador then
		TriggerEvent("Notify",type,message)
	end
end

function src.notifyCorredores(type,message)
	if corredor then
		TriggerEvent("Notify",type,message)
	end
end

function src.updateOrganizador(status)
	organizador = status
end

function src.updateNroCorredores(nro)
	nrocorredores = nro
end

function src.updateLobby(status)
	lobby = status
end

function src.updateCorredor(status)
	corredor = status
end

function src.updateCorrida(status)
	corrida = status
end

function src.updateTempo(t)
	if corredor then
		tempocorrida = t
	end
end

function src.updateTimer(t)
	timer = t
end

function src.isCorredor()
	return corredor
end

function src.isOrganizador()
	return organizador
end

function src.removeBlips()
	RemoveBlip(blip)
end

function src.updateIndex(i)
	indexcorrida = i
end

function src.updatePosition(p,p2)
	if corredor then
		posicao = p
		posicoes = p2
	end
end

function src.updateEscolhido(bool)
	escolhido = bool
end

function src.denuncia()
	ShowAdvancedNotification("CHAR_DEFAULT", "~b~Anônimo", "~r~Denúncia Anônima", "~y~Corrida Ilegal em andamento.")
end

function nation_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


function CriandoBlip(x,y,z)
	blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,1)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("~r~CheckPoint")
	EndTextCommandSetBlipName(blip)
end

function AddBlip(i,x,y,z)
	blips[i] = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips[i],38)
	SetBlipColour(blips[i],1)
	SetBlipScale(blips[i],0.6)
	SetBlipAsShortRange(blips[i],true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Organizar Corrida")
	EndTextCommandSetBlipName(blips[i])
end


function notifyRace(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


function ShowAdvancedNotification(icon, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, 4, sender, title, text)
    DrawNotification(false, true)
end

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------






------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------NUI-----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

function showStats()
	local css = [[
	@import url('https://fonts.googleapis.com/css2?family=Odibee+Sans&display=swap');

	@font-face {
		font-family: 'Azonix Regular';
		font-style: normal;
		font-weight: normal;
		src: local('Azonix Regular'), url('Azonix.woff') format('woff');
	}

	.clear {
		clear: both;
	}

	#RaceSection {
		width: 450px;
		height: 800px;
		border-radius: 15px;
		text-align: center;
		position: absolute;
		left: 39%;
		bottom: 2%;
		font-family: 'Azonix Regular';
		font-style: italic;
		letter-spacing: 2px;
		color: #999;
		text-transform: uppercase;
		padding-bottom: 15px;
		z-index: 1;
		overflow: hidden;
	}

	#RaceSection .main-info {
		position: relative;
		top: 70px;
	}

	#RaceSection .secondary-info {
		position: relative;
		left: 15%;
		width: 70%;
		top: 25px;
	}

	#RaceSection .secondary-info .clear {
		margin-bottom: 3px;
		display: block;
	}

	#RaceSection .tertiary-info {
		position: relative;
		top: 30px;
	}

	#RaceSection .tertiary-info .clear {
		margin-bottom: 3px;
		display: block;
	}

	#RaceSection .main-info finish {
		position: relative;
		bottom: 25px;
		font-style: italic;
		text-align: center;
		font-size: 50px;
		font-weight: 100;
		color: #fff;
	}

	#RaceSection .main-info lugar {
		position: relative;
		bottom: 40px;
		font-style: italic;
		text-align: center;
		font-size: 70px;
		font-weight: 100;
		color: #ff3333;
	}

	#RaceSection .secondary-info time {
		position: relative;
		background-color: rgba(51, 0, 0,.25);
		font-style: italic;
		text-align: left;
		float: left;
		font-size: 18px;
		height: 35px;
		font-weight: 100;
		color: #fff;
		width: 100%;
		border-radius: 5px;
	}

	#RaceSection .ranking {
		position: relative;
		top: 30px;
		font-style: italic;
		text-align: center;
		font-size: 65px;
		font-weight: 100;
		color: #fff;
	}

	#RaceSection .first {
		position: relative;
		font-style: italic;
		text-align: left;
		font-weight: 100;
		font-size: 20px;
		font-weight: 100;
		left: 15%;
		color: #fff;
		width: 70%;
		height: 35px;
		background-color: rgba(51, 0, 0,.25);
		border-radius: 5px;

	}

	#RaceSection .first2 {
		position: absolute;
		left: 15%;
		width: 45px;
		height: 35px;
		background-color: #ff3333;
		border-radius: 5px;

	}

	#RaceSection .firstt {
		position: absolute;
		font-style: italic;
		font-size: 18px;
		font-weight: 100;
		left: 10%;
		color: #fff;
		width: 70%;
		height: 35px;
		top: 7px;
		border-radius: 5px;

	}

	#RaceSection .second {
		position: relative;
		font-style: italic;
		text-align: left;
		font-size: 18px;
		font-weight: 100;
		width: 70%;
		height: 35px;
		left: 15%;
		top: 5px;
		color: #fff;
		background-color: rgba(51, 0, 0,.25);
		border-radius: 5px;
	}

	#RaceSection .second2 {
		position: absolute;
		top: 40%;
		left: 15%;
		width: 45px;
		height: 35px;
		background-color: #ff3333;
		border-radius: 5px;

	}

	#RaceSection .secondt {
		position: absolute;
		font-style: italic;
		font-size: 18px;
		font-weight: 100;
		left: 10%;
		color: #fff;
		width: 70%;
		height: 35px;
		top: 51px;
		border-radius: 5px;

	}

	#RaceSection .third {
		position: relative;
		font-style: italic;
		text-align: left;
		font-size: 18px;
		font-weight: 100;
		width: 70%;
		left: 15%;
		height: 35px;
		top: 10px;
		color: #fff;
		background-color: rgba(51, 0, 0,.25);
		border-radius: 5px;
	}

	#RaceSection .third2 {
		position: absolute;
		left: 15%;
		top: 78%;
		width: 45px;
		height: 35px;
		background-color: #ff3333;
		border-radius: 5px;

	}

	#RaceSection .thirdt {
		position: absolute;
		font-style: italic;
		font-size: 18px;
		font-weight: 100;
		left: 10%;
		color: #fff;
		width: 70%;
		height: 35px;
		top: 94px;
		border-radius: 5px;

	}

	#RaceSection .close {
		position: absolute;
		font-style: italic;
		font-size: 20px;
		top: 115%;
		left: 15%;
		font-weight: 100;
		color: #ff3333;
		width: 70%;
		height: 35px;
	}
	
	.fadeIn {
		-webkit-animation: fadeIn 2s ease-in-out;
		-moz-animation: fadeIn 2s ease-in-out;
		-o-animation: fadeIn 2s ease-in-out;
		animation: fadeIn 2s ease-in-out;
		}
	
		@-webkit-keyframes fadeIn {
		0% { opacity: 0; }
		100% { opacity: 1; } 
		}
		@-moz-keyframes fadeIn {
		0% { opacity: 0;}
		100% { opacity: 1; }
		}
		@-o-keyframes fadeIn {
		0% { opacity: 0; }
		100% { opacity: 1; }
		}
		@keyframes fadeIn {
		0% { opacity: 0; }
		100% { opacity: 1; }
		}
	]]

	local html = string.format(
	"<div class='fadeIn'>"..
		"<div id='RaceSection'>"..
			"<div class='infos'>"..
				"<div class='main-info'>"..
					"<h1 class='finish'><finish>posição</finish></h1>"..
					"<h1 class='lugar' style='width: 70%%; position: relative; left: 15%%;'><lugar>%sº lugar</lugar></h1>"..
				"</div>"..
				"<div class='secondary-info'>"..
					"<div class='time'><time><a class='time1' style='position: relative; color: #ff3333; left: 20px; top: 7px;'>Tempo</a><t class='tempo' style='position: relative; right: 20px; float: right; top: 7px;'>%s</t></time></div>"..
					"<div class='clear'></div>"..
					"<div class='clear'></div>"..
					"<div class='clear'></div>"..
					"<div class='time'><time><a class='time1' style='position: relative; color: #ff3333; left: 20px; top: 7px;'>Melhor Tempo</a><t class='tempo' style='position: relative; right: 20px; float: right; top: 7px;'>%s</t></time></div>"..
					"<div class='clear'></div>"..
				"</div>"..
				"<h2 class='ranking'>Ranking</h2>"..
				"<div class='tertiary-info'>"..
					"<div class='clear'></div>"..
					"<div class='first2'></div>"..
					"<div class='first'><a class='primeiro' style='position: relative; left: 15px; top: 8px;'>1</a></div>"..
					"<div class='firstt' style='position: absolute; left: 60px; text-align: center;'>%s</div>"..
					"<div class='firstt' style='position: absolute; left: 175px;'>%s</div>"..
					"<div class='clear'></div>"..
					"<div class='second2'></div>"..
					"<div class='second'><t class='txt' style='position: relative; left: 14px; top: 8px;'>2</t></div>"..
					"<div class='secondt' style='position: absolute; left: 60px; text-align: center;'>%s</div>"..
					"<div class='secondt' style='position: absolute; left: 175px;'>%s</div>"..
					"<div class='clear'></div>"..
					"<div class='third2'></div>"..
					"<div class='third'><t class='txt' style='position: relative; left: 14px; top: 8px;'>3</t></div>"..
					"<div class='thirdt' style='position: absolute; left: 60px; text-align: center;'>%s</div>"..
					"<div class='thirdt' style='position: absolute; left: 175px;'>%s</div>"..
					"<div class='clear'></div>"..
					"<div class='close'>Pressione F7 para fechar</div>"..
					"<div class='clear'></div>"..
				"</div>"..
			"</div>"..
		"</div>"..
	"</div>", posicao, seutempo, melhortempo, ranking.primeiro[1], calculateTempo(ranking.primeiro[2]), ranking.segundo[1], calculateTempo(ranking.segundo[2]), ranking.terceiro[1], calculateTempo(ranking.terceiro[2])
--	"</div>", "1","00:15", "00:10","emerson", "00:12", "toshi", "00:15", "renato", "00:20"
	)
	TriggerScreenblurFadeIn(3000)
	vRP._setDiv("RaceStatus", css, html)
	Citizen.CreateThread(function()
		local nui = true
		while nui do
			Citizen.Wait(0)
			if IsControlJustPressed(0,168) then
				vRP._removeDiv("RaceStatus", css, html)
				nui = false
				TriggerScreenblurFadeOut(3000)
			end
		end
	end)
end


function showInfo()
	local css1 = [[
		@import url('https://fonts.googleapis.com/css2?family=Odibee+Sans&display=swap');

		@font-face {
			font-family: 'Azonix Regular';
			font-style: normal;
			font-weight: normal;
			src: local('Azonix Regular'), url('Azonix.woff') format('woff');
		}
	
		.clear {
			clear: both;
		}

		#RaceInfoPosition {
			width: 150px;
			height: 30px;
			text-align: center;
			position: absolute;
			left: 20px;
			top: 360px;
			font-family: 'Azonix Regular';
			letter-spacing: 1px;
			background-image: linear-gradient(to right,rgba(0, 0, 0,.85), rgba(0, 0, 0,.0));
			font-style: italic;
			text-transform: uppercase;
			transform: perspective(400px) rotateY(25deg);
			color: #fff;
			padding-bottom: 45px;
			border-radius: 15px;
			z-index: 1;
		}

		#RaceInfoPosition .position {
			position: absolute;
			left: 10px;
			font-size: 65px;
			color: #fff;
		}

		#RaceInfoPosition .bar {
			position: relative;
			top: 15px;
			font-size: 30px;
			color: #ff3333;
		}

		#RaceInfoPosition .positions {
			position: relative;
			font-size: 20px;
			color: #ff3333;
		}
	
		#RaceInfoSection {
			width: 300px;
			min-height: 10px;
			max-height: 200px;
			border-radius: 15px;
			text-align: center;
			position: absolute;
			text-transform: uppercase;
			right: 1%;
			top: 40px;
			font-family: 'Azonix Regular';
			transform: perspective(400px) rotateY(-15deg);
			letter-spacing: 1px;
			font-style: italic;
			color: #999;
			padding-bottom: 15px;
			z-index: 1;
		}

		#RaceInfoSection .checkpoint {
			position: relative;
			height: 80px;
			margin-top: 15px;
			border-radius: 5px;
			font-size: 50px;
		}

		#RaceInfoSection .countdown {
			position: absolute;
			background-image: linear-gradient(to right,rgba(255, 51, 51,.85), rgba(255, 51, 51,.0));
			height: 30px;
			width: 200px;
			right: 30px;
			top: 70px;
			border-radius: 5px;
		}

		#RaceInfoSection .tempo {
			position: absolute;
			background-image: linear-gradient(to right,rgba(255, 51, 51,.85), rgba(255, 51, 51,.0));
			width: 200px;
			height: 30px;
			right: 30px;
			top: 105px;
			border-radius: 5px;
		}
	
		#RaceInfoSection .each-info {
			width: 80%;
			margin: 0 auto;
			color: #fff;
			font-size: 13px;
		}

		#RaceInfoSection .each-info strong {
			position: absolute;
			left: 5px;
			top: 7px;
			font-size: 13px;
			float: left;
			font-weight: 100;
		}

		#RaceInfoSection .each-info barra {
			position: absolute;
			float: right;
			color: #0773D2;
			font-size: 25px;
			right: 35px;
		}
		
		#RaceInfoSection .each-info cptext {
			position: relative;
			color: #ff3333;
			float: right;
			right: 20px;
			bottom: 15px;
			font-size: 20px;
		}

		#RaceInfoSection .each-info cptext2 {
			position: relative;
			color: white;
			top: 5px;
			font-size: 40px;
		}

		#RaceInfoSection .each-info cptext3 {
			position: relative;
			color: #ff3333;
			left: 5px;
			font-size: 20px;
		}

		#RaceInfoSection .each-info span {
			position: relative;
			float: right;
			font-weight: 100;
		}

		#RaceInfoSection .person-id {
			position: relative;
			right: 7px;
			top: 7px;
			font-size: 14px;
		}

		]]
	
		local html1 = string.format(
			"<div class='separar'>"..
				"<div id='RaceInfoPosition'>"..
					"<div class='position'>%s"..
						"<l class='bar'>/<a class='positions'>%s</a></l>"..
					"</div>"..
				"</div>"..
				"<div class='clear'></div>"..
				"<div id='RaceInfoSection'>"..
					"<div class='checkpoint'>"..
						"<div class='each-info'><cptext>Checkpoints&nbsp;<cptext2>%s</cptext2><cptext3>/%s</cptext3></cptext></div>"..
						"<div class='clear'></div>"..
					"</div>"..
					"<div class='countdown'>"..
						"<div class='each-info'><strong>Contagem:</strong><span class='ct' style='font-size: 14px; position: absolute; right: 30px; top:7px;'>%s</span></div>"..
						"<div class='clear'></div>"..
					"</div>"..
					"<div class='tempo'>"..
						"<div class='each-info'><strong>Tempo: </strong><span class='person-id'>%s</span></div>"..
						"<div class='clear'></div>"..
					"</div>"..
				"</div>"..
			"</div>", tostring(posicao), tostring(nrocorredores),tostring(checkpoint),tostring(#corrida.checkpoints), calculateTempo(tempocorrida), calculateTempo(corrida.tempo - tempocorrida)
--			"</div>", "4", "6","1","8", "1:00", "2:00"
		)
	if not info then
		vRP._setDiv("RaceInfo", css1, html1)
		info = true
	else
		vRP._setDivContent("RaceInfo",html1)
	end
end


------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	vRP._removeDiv("RaceInfo", css, html)
	vRP._removeDiv("RaceRunners", css, html)
--	showRunners()
--	showInfo()
--	showStats()
end)

function showRunners()
	local runners = ""
	local top = 5
	local i = 1
	local padrao = "&nbsp;"
	while i <= #posicoes do
		if i == 1 then
			padrao = "&nbsp;&nbsp;"
		end
		if posicao ~= i then
			runners = string.format(runners..
				"<div class='quadrado' style='position: absolute; height: 25px; width: 30px; left: 15px; top: "..top.."px; background-color: rgba(255, 255, 255,.25);'>&nbsp;</div>"..
				"<div class='runners' style='position: absolute; width: 150px; height: 25px; text-align: left; left: 15px; top: "..top.."px; background-image: linear-gradient(to right,rgba(255, 255, 255,.35), rgba(255, 255, 255,.0));'>"..
					"<div class='text' style='position: relative; left: 10px; top: 5px;'>%s "..padrao.."%s</div>"..
				"</div>", i,posicoes[i]
			)
		else
			runners = string.format(runners..
				"<div class='quadrado' style='position: absolute; height: 25px; width: 30px; left: 15px; top: "..top.."px; background-color: rgba(255, 255, 255,.35);'>&nbsp;</div>"..
				"<div class='runners' style='position: absolute; width: 150px; text-align: left; height: 25px; left: 15px; top: "..top.."px; background-image: linear-gradient(to right,rgba(255, 51, 51,.75), rgba(232, 26, 85,.0));'>"..
					"<div class='text' style='position: relative; left: 10px; top: 5px;'>%s "..padrao.."%s</div>"..
				"</div>", i,posicoes[i]
			)
		end
		top = top + 30
		i = i+1
	end
	local rank = ranking
	padrao = "&nbsp;"
	local ranks = string.format(
		"<div class='quadrado' style='position: absolute; width: 30px; height: 25px; left: 15px; top: 35px; background-color: rgba(255, 255, 255,.35); border-radius: 10px;'>&nbsp;</div>"..
		"<div class='runners' style='position: absolute; width: 170px; height: 25px; text-align: left; left: 15px; top: 35px; background-image: linear-gradient(to right,rgba(255, 190, 77,.85), rgba(255, 190, 77,.0)); border-radius: 10px;'>"..
		"<div class='text' style='position: relative; left: 10px; top: 5px;'>1 "..padrao.."&nbsp;%s<a class='text2' style='text-align: right; float: right;'>%s</a></div>"..
		
		"<div class='quadrado' style='position: absolute; width: 30px; height: 25px; top: 35px; background-color: rgba(255, 255, 255,.35); border-radius: 10px;'>&nbsp;</div>"..
		"<div class='runners' style='position: absolute; width: 170px; height: 25px; text-align: left; top: 35px; background-image: linear-gradient(to right,rgba(179, 179, 179,.85), rgba(179, 179, 179,.0)); border-radius: 10px;'>"..
		"<div class='text' style='position: relative; left: 10px; top: 5px;'>2 "..padrao.."%s<a class='text2' style='text-align: right; float: right;'>%s</a></div>"..
		
		"<div class='quadrado' style='position: absolute; width: 30px; height: 25px; top: 35px; background-color: rgba(255, 255, 255,.35); border-radius: 10px;'>&nbsp; </div>"..
		"<div class='runners' style='position: absolute; width: 170px; height: 25px; text-align: left; top: 35px; background-image: linear-gradient(to right,rgba(255, 112, 77,.85), rgba(255, 112, 77,.0)); border-radius: 10px;'>"..
		"<div class='text' style='position: relative; left: 10px; top: 5px;'>3 "..padrao.."%s<a class='text2' style='text-align: right; float: right;'>%s</a></div>"..
		"</div>", rank.primeiro[1], calculateTempo(rank.primeiro[2]), rank.segundo[1], calculateTempo(rank.segundo[2]), rank.terceiro[1], calculateTempo(rank.terceiro[2])
	)

	local css1 = [[
		@import url('https://fonts.googleapis.com/css2?family=Odibee+Sans&display=swap');

		@font-face {
			font-family: 'Azonix Regular';
			font-style: normal;
			font-weight: normal;
			src: local('Azonix Regular'), url('Azonix.woff') format('woff');
		}
	
		.clear {
			clear: both;
		}

		#RaceRunners {
			width: 180px;
			min-height: 10px;
			max-height: 100px;
			text-align: center;
			position: absolute;
			left: 5px;
			top: 450px;
			transform: perspective(400px) rotateY(25deg);
			font-family: 'Azonix Regular';
			letter-spacing: 1px;
			font-style: italic;
			font-weight: 100;
			font-size: 14px;
			color: #fff;
			padding-bottom: 45px;
			text-transform: uppercase;
			z-index: 1;
		}

		#RaceRanking {
			width: 200px;
			height: 100px;
			text-align: center;
			position: absolute;
			background-image: linear-gradient(to bottom,rgba(0, 0, 0,.65), rgba(0, 0, 0,.4));
			right: 35px;
			bottom: 150px;
			transform: perspective(400px) rotateY(-25deg);
			font-family: 'Azonix Regular';
			letter-spacing: 1px;
			font-style: italic;
			font-weight: 100;
			font-size: 12px;
			border-radius: 15px;
			color: #fff;
			padding-bottom: 45px;
			text-transform: uppercase;
			z-index: 1;
		}

		]]
	
		local html1 = string.format(
			"<div id='RaceRunners'>"..runners.."</div>"..
			"<div id='RaceRanking'><a class='rank' style='position: relative; top: 5px; font-size: 25px;'>Ranking</a>"..ranks.."</div>" 
		)
	if not info2 then
		vRP._setDiv("RaceRunners", css1, html1)
		info2 = true
	else
		vRP._setDivContent("RaceRunners",html1)
	end
end


