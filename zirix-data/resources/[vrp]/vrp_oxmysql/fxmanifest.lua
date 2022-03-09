fx_version 'cerulean'
game 'gta5'

author 'KokeroO - Discord:Kokero#3996 - https://github.com/KokeroO/'
description 'vRP oxmysql Legacy driver is a script that bridges the gap between server and oxmysql.'
version '2022.02.26'
dependencies {
  'vrp',
  'oxmysql' --Version >= 2.0.1
}

server_scripts {
  '@vrp/lib/utils.lua',
  '@oxmysql/lib/MySQL.lua',
  'init.lua'
}