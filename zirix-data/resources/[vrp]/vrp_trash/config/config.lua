config = {}

config.propTrashCans = {
    { 'prop_bin_01a' },
    { 'prop_bin_03a' },
    { 'prop_bin_05a' },
    { 'prop_dumpster_01a' },
    { 'prop_dumpster_02a' },
    { 'prop_dumpster_02b' },
    { 'prop_dumpster_4a' },
    { 'prop_dumpster_4b' }
}

config.foodTrashPayment = {
    [1] = { ['item'] = "agua" },
	[2] = { ['item'] = "sanduiche" }
}

config.clothesTrashPayment = {
    [1] = { ['item'] = "oculos" },
	[2] = { ['item'] = "mascara" }
}

config.eletricTrashPayment = {
    [1] = { ['item'] = "celular-queimado" },
	[2] = { ['item'] = "radio-queimado" },
	[3] = { ['item'] = "tablet-queimado" }
}

config.itemTrashPayment = { 1,2 }
config.moneyTrashPayment = { 30, 150 }
config.timeTrashCooldown = 600