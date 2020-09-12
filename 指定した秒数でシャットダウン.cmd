rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem 指定した秒数が経過したらシャットダウン

@echo off
cls

set HOURS=1
set MINUTES=15
set SECOND=3
set /a SHUTDOWN_SECONDS=60*60*%HOURS% + 60*%MINUTES% + %SECOND%

echo %HOURS% 時間 %MINUTES% 分 %SECOND% 秒後

echo %SHUTDOWN_SECONDS%

shutdown.exe -s -f -t %SHUTDOWN_SECONDS% -c "Windows will  shutdown in %HOURS% 時間 %MINUTES% 分 %SECOND% 秒"
