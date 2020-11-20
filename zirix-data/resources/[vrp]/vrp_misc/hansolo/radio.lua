local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]---------------------------------------------------------------------------------------

misc = Tunnel.getInterface("vrp_misc")

--[ VARIÁVEIS ]-------------------------------------------------------------------------------------

local emradio = false

--[ ENTRAR NO CANAL ]-------------------------------------------------------------------------------

RegisterNetEvent('vrp_misc:onGroupRadio')
AddEventHandler('vrp_misc:onGroupRadio', function()
  if not emradio then
    emradio = true

    if misc.permissaoDpla() then
      exports.tokovoip_script:addPlayerToRadio(1)
      channel = 1
    
    elseif misc.permissaoDmla() then
      exports.tokovoip_script:addPlayerToRadio(2)
      channel = 2

    elseif misc.permissaoTaxista() then
      exports.tokovoip_script:addPlayerToRadio(3)
      channel = 3

    elseif misc.permissaoMecanico() then
      exports.tokovoip_script:addPlayerToRadio(4)
      channel = 4

    elseif misc.permissaoBennys() then
      exports.tokovoip_script:addPlayerToRadio(5)
      channel = 5

    elseif misc.permissaoBallas() then
      exports.tokovoip_script:addPlayerToRadio(6)
      channel = 6

    elseif misc.permissaoGrove() then
      exports.tokovoip_script:addPlayerToRadio(7)
      channel = 7

    elseif misc.permissaoFamilies() then
      exports.tokovoip_script:addPlayerToRadio(8)
      channel = 8

    elseif misc.permissaoMedellin() then
      exports.tokovoip_script:addPlayerToRadio(9)
      channel = 9

    elseif misc.permissaoMotoclub() then
      exports.tokovoip_script:addPlayerToRadio(10)
      channel = 10

    elseif misc.permissaoBratva() then
      exports.tokovoip_script:addPlayerToRadio(11)
      channel = 11

    elseif misc.permissaoNdrangheta() then
      exports.tokovoip_script:addPlayerToRadio(12)
      channel = 12

    elseif misc.permissaoNynax() then
      exports.tokovoip_script:addPlayerToRadio(13)
      channel = 13

    elseif misc.permissaoSemantic() then
    exports.tokovoip_script:addPlayerToRadio(14)
    channel = 14

    end
  else
    emradio = false
    exports.tokovoip_script:removePlayerFromRadio(1)
    exports.tokovoip_script:removePlayerFromRadio(2)
    exports.tokovoip_script:removePlayerFromRadio(3)
    exports.tokovoip_script:removePlayerFromRadio(4)
    exports.tokovoip_script:removePlayerFromRadio(5)
    exports.tokovoip_script:removePlayerFromRadio(6)
    exports.tokovoip_script:removePlayerFromRadio(7)
    exports.tokovoip_script:removePlayerFromRadio(8)
    exports.tokovoip_script:removePlayerFromRadio(9)
    exports.tokovoip_script:removePlayerFromRadio(10)
    exports.tokovoip_script:removePlayerFromRadio(11)
    exports.tokovoip_script:removePlayerFromRadio(12)
    exports.tokovoip_script:removePlayerFromRadio(13)
    exports.tokovoip_script:removePlayerFromRadio(14)
  end
end)

RegisterNetEvent('vrp_misc:onRadio')
AddEventHandler('vrp_misc:onRadio', function(radio)
  local canal = parseInt(radio)

  if not emradio then
    exports.tokovoip_script:addPlayerToRadio(canal)
    channel = canal
    emradio = true
  else
    emradio = false
    exports.tokovoip_script:removePlayerFromRadio(canal)
  end
end)