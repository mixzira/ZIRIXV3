local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPNserver = Tunnel.getInterface("vrp_identity")

local nuidentity = false
local identity = false

local css = [[
	@import url('https://fonts.googleapis.com/css?family=Muli:300,400,700');

	.clear {
		clear: both;
	}

	#DocumentSection {
		background-color: rgba(0,0,0,0.55);
		width: 350px;
		min-height: 250px;
		border-radius: 5px;
		box-shadow: 0px 0px 3px rgba(0, 0, 0, 0.08);
		text-align: center;
		position: absolute;
		right: 20px;
		bottom: 145px;
		font-family: 'Muli';
		color: #999;
		padding-bottom: 15px;
		z-index: 1;
		overflow: hidden;
	}

	#DocumentSectionNu {
		background-color: rgba(0,0,0,0.55);
		width: 350px;
		min-height: 200px;
		border-radius: 5px;
		box-shadow: 0px 0px 3px rgba(0, 0, 0, 0.08);
		text-align: center;
		position: absolute;
		right: 20px;
		bottom: 145px;
		font-family: 'Muli';
		color: #999;
		padding-bottom: 15px;
		z-index: 1;
		overflow: hidden;
	}

	#DocumentSection:before {
		background-color: rgba(255,255,255, 0.4);
		top: -193%;
		left: -100%;
		transform: rotate(-5deg);
		z-index: 1;
	}

	#DocumentSection:after {
		background-color: rgba(255,255,255, 0.5);
		top: -191%;
		left: -100%;
		transform: rotate(-6deg);
		z-index: 0;
	}

	#DocumentSection .avatar-img {
		width: 50px;
		height:1px;
		margin: 50px auto 0 auto;
		overflow:hidden;
		border-radius: 50px;
		opacity: 0%;
	}

	#DocumentSection .avatar-img img {
		width: 100%;
		opacity: 0%;
	}

	#DocumentSection .each-info {
		display: block;
		margin: 0;
		width: 70%;
		margin: 0 auto;
	}

	#DocumentSection .each-info.person-name {
		font-size: 20px;
	}

	#DocumentSection .each-info.person-age {
		font-size: 15px;
	}

	#DocumentSection .each-info.person-job {
		border-top: 1px solid rgba(255,255,255, 0.5);
		border-bottom: 1px solid rgba(255,255,255, 0.5);
		margin: 25px auto;
		padding: 10px 0;
		color: #b1b1b1;
		font-size: 18px;
	}

	#DocumentSection .secondary-info {
		margin-top: 15px;
	}

	#DocumentSection .secondary-info .clear {
		margin-bottom: 3px;
		display: block;
	}

	#DocumentSection .secondary-info .each-info strong {
		float: left;
		font-weight: 300;
	}

	#DocumentSection .secondary-info .each-info span {
		float: right;
		font-weight: bold;
		color: #b1b1b1;
	}
]]

RegisterKeyMapping ( 'vrp_identity:rg' , 'Identidade' , 'keyboard' , 'F11' )

RegisterCommand('vrp_identity:rg',function(source,args)
	
	if vRPNserver.checkItem() then
		if identity then
			vRP._removeDiv("rg")
			identity = false
			vRP._DeletarObjeto(tablet)
			TaskClearLookAt(GetPlayerPed(-1))
		else
			local foto, name, firstname, user_id, registration, age, phone, groupname, cnh = vRPNserver.Identidade()
			if foto == nil or foto == "" then
				foto  = ""
			end
			local html = string.format("<div id='DocumentSection'><div class='avatar-img'><img src='%s'></div> <div class='infos'><div class='main-info'>"..
				"<h1 class='each-info person-name'>%s %s</h1>"..
				"<div class='secondary-info'>"..
				"<div class='each-info'><strong>Idade:</strong><span class='person-age'>%s Anos</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>Passaporte:</strong><span class='person-id'>%s</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>Registro: </strong><span class='person-passport'>%s</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>Cargo:</strong><span class='person-job'>%s</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>CNH:</strong><span class='person-job'>%s</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>Telefone:</strong><span class='person-phone'>%s</span></div>"..
				"<div class='clear'></div>"..
				"</div>"..
				"</div>"..
				"</div>", foto, name, firstname, age, user_id, registration, groupname, cnh, phone)
			vRP._setDiv("rg", css, html)
			identity = true
		end
	end
end)

RegisterCommand("rg",function(source,args)
	if vRPNserver.checkPlayer() then
		if nuidentity then
			vRP._removeDiv("rg")
			nuidentity = false
			vRP._DeletarObjeto(tablet)
			TaskClearLookAt(GetPlayerPed(-1))
		else
			local foto, name, firstname, registration, passport, age, cnh = vRPNserver.nuIdentidade()
			if foto == nil or foto == "" then
				foto  = ""
			end
			local html = string.format("<div id='DocumentSectionNu'><div class='avatar-img'><img src='%s'></div> <div class='infos'><div class='main-info'>"..
				"<h1 class='each-info person-nameNu'>%s %s</h1>"..
				"<div class='secondary-info'>"..
				"<div class='each-info'><strong>Idade:</strong><span class='person-age'> %s Anos</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>Registro: </strong><span class='person-passport'> %s</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>Passaporte: </strong><span class='person-passport'> %s</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>CNH:</strong><span class='person-job'> %s</span></div>"..
				"<div class='clear'></div>"..
				"</div>"..
				"</div>"..
				"</div>", foto, name, firstname, age, registration, passport, cnh)
			vRP._setDiv("rg", css, html)
			nuidentity = true
		end
	end
end)

RegisterCommand("arg",function(source,args)
	if vRPNserver.checkPlayer2() then
		if nuidentity then
			vRP._removeDiv("rg")
			nuidentity = false
			TaskClearLookAt(GetPlayerPed(-1))
		else
			local foto, name, firstname, registration, passport, age, cnh = vRPNserver.nuIdentidade2()
			if foto == nil or foto == "" then
				foto  = ""
			end
			local html = string.format("<div id='DocumentSectionNu'><div class='avatar-img'><img src='%s'></div> <div class='infos'><div class='main-info'>"..
				"<h1 class='each-info person-nameNu'>%s %s</h1>"..
				"<div class='secondary-info'>"..
				"<div class='each-info'><strong>Idade:</strong><span class='person-age'> %s Anos</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>Registro: </strong><span class='person-passport'> %s</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>Passaporte: </strong><span class='person-passport'> %s</span></div>"..
				"<div class='clear'></div>"..
				"<div class='each-info'><strong>CNH:</strong><span class='person-job'> %s</span></div>"..
				"<div class='clear'></div>"..
				"</div>"..
				"</div>"..
				"</div>", foto, name, firstname, age, registration, passport, cnh)
			vRP._setDiv("rg", css, html)
			nuidentity = true
		end
	end
end)

local ponto = {
	{ ['x'] = -552.85, ['y'] = -190.74, ['z'] = 38.22 }
}

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		for k,v in pairs(ponto) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local ponto = ponto[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), ponto.x, ponto.y, ponto.z, true ) < 5.1 then
				DrawText3D(ponto.x, ponto.y, ponto.z, "Pressione [~b~E~w~] para ~b~CRIAR~w~ IDENTIDADE  [~b~G~w~] para ~b~SEGUNDA VIA~w~ da IDENTIDADE.")
			end
			
			if distance < 10.1 then
				DrawMarker(23,ponto.x,ponto.y,ponto.z-0.99,0,0,0,0,0,0,0.7,0.7,0.5, 95, 189, 235, 180,0,0,0,0)
				idle = 5
				if distance < 1.2 then
					if IsControlJustPressed(0,38) then
						vRPNserver.modifyIdentidade() 
					end

					if IsControlJustPressed(0,47) then
						vRPNserver.giveIdentidade()
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())  
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end