-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem,time)
	SendNUIMessage({ css = css, mensagem = mensagem, time = time })
end)


RegisterNetEvent("NotifyAdm")
AddEventHandler("NotifyAdm",function(nomeadm,mensagem)
	SendNUIMessage({ css = "aviso", mensagem = "<b>"..mensagem.."</b><br>- Administrador :<b> "..nomeadm.."</b>", time = 30000 })
end)

RegisterNetEvent("NotifyPol")
AddEventHandler("NotifyPol",function(nomeadm,mensagem)
	SendNUIMessage({ css = "importante", mensagem = "<b>"..mensagem.."</b><br> - <b>"..nomeadm.."</b>", time = 30000 })
end)

RegisterNetEvent("NotifyAdmCallback")
AddEventHandler("NotifyAdmCallback",function(nomeadm,mensagem)
	SendNUIMessage({ css = "retorno", mensagem = "<b>"..mensagem.."</b><br>- "..nomeadm, time = 15000 })
end)