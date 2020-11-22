@echo off

echo ===-------------------------------===
echo     ZIRIX V3 (3.0.1)
echo     Developed by: ZIRAFLIX
echo     Discord: discord.gg/ziraflix
echo     Contact: contato@ziraflix.com
echo ===-------------------------------===

pause
start ..\build\FXServer.exe +exec config\config.cfg +set onesync on +set onesync_population false
exit