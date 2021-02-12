resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'tracker.html'

client_scripts {
  'mtracker.lua',
  'cfg.lua'
}

files {
  'img/phone.png',
  'img/tracker_background.png',
  'img/tracker_bar.png',
  'img/tracker_player.png',
  'img/tracker_target.png',
  'beep.ogg',
  'tracker.html'
}

exports {
  'isrunning'
}
