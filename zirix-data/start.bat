@echo off

echo ===-------------------------------===
echo     ZIRIX V3 (3.2.0)
echo     Developed by: ZIRAFLIX
echo     Discord: discord.gg/ziraflix
echo     Contact: contato@ziraflix.com
echo ===-------------------------------===

pause
start ..\artifacts\FXServer.exe +exec config\config.cfg +set onesync on +set onesync_population false
exit