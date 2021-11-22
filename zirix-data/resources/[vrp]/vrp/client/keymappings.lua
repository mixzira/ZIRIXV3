RegisterKeyMapping('vrp:use', 'Interação', 'keyboard', binds.use)

RegisterCommand('vrp:use', function(source, args, rawCommand)
    TriggerEvent('vrp_trash:use')
    TriggerEvent('vrp_machines:use')
    TriggerEvent('vrp_chest:use')
    TriggerEvent('vrp_homes:join')
    TriggerEvent('vrp_homes:exit')
    TriggerEvent('vrp_homes:chest')
    TriggerEvent('vrp_homes:invade')
    TriggerEvent('vrp_shops:open')
    TriggerEvent('vrp_advanced_shops:use')
end)

----------------------------------------------------------------------------------------------------

RegisterKeyMapping('vrp_trunkchest:trunk', '[V] Porta Malas', 'keyboard', binds.trunkchest)

RegisterCommand('vrp_trunkchest:trunk',function(source, args, rawCommand)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		TriggerEvent('Notify','negado','Você não pode fazer isso dentro do carro.')
	else
		TriggerEvent('vrp_trunkchest:Open')
	end
end)

----------------------------------------------------------------------------------------------------

RegisterKeyMapping('vrp_identity:rg' , 'Identidade' , 'keyboard' , binds.identity )

RegisterCommand('vrp_identity:rg',function()
    TriggerEvent('vrp_identity:rg')
end)

----------------------------------------------------------------------------------------------------

RegisterKeyMapping('vrp_inventory:openInv', 'Inventário', 'keyboard', binds.inventory)

RegisterCommand('vrp_inventory:openInv', function()
    TriggerEvent('vrp_inventory:openInv')
end)

----------------------------------------------------------------------------------------------------

RegisterKeyMapping('vrp_garages:lock', '[V] Trancar/destrancar veiculo', 'keyboard', binds.carlock)

RegisterCommand('vrp_garages:lock', function()
    TriggerEvent('vrp_garages:lock')
end)

----------------------------------------------------------------------------------------------------

RegisterKeyMapping ( 'vrp_hud:belt' , 'Cinto de segurança' , 'keyboard' , binds.belt )

RegisterCommand('vrp_hud:belt', function()
    TriggerEvent('vrp_hud:belt')
end)