@echo off

echo ===-------------------------------===
echo     ZIRIX V3 (3.2.0)
echo     Developed by: ZIRAFLIX
echo     Discord: discord.gg/ziraflix
echo     Contact: contato@ziraflix.com
echo ===-------------------------------===

pause
start ..\build\FXServer.exe +exec config\config.cfg +set onesync_enableInfinity 1 onesync_enableBeyond 1 onesync_population 1 +set sv_enforceGameBuild tuner
exit
