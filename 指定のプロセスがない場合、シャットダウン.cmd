rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem 所定のexeが実行してない場合、シャットダウン

@echo off
@setlocal enabledelayedexpansion
cls

cd /d "%~dp0"
title "%~0"

rem プロセスIDを調べる間隔
set INTERVAL=60

set EXE_NM=robocopy.exe
echo %EXE_NM%

:TASKLIST

echo ######################################
tasklist /fi "imagename eq  %EXE_NM%"
for /f "tokens=1,2" %%i in ('tasklist /fi "imagename eq  %%EXE_NM%%"') do (
	@set PID=%%j
rem	echo !PID!
)
rem echo !PID!
rem echo !PID:~0,7!

rem 指定のexeが動いてないとプロセスidに「指定された条件に一致するタスクは実行されていません。」がセットされる
rem if "!PID!" == "指定された条件に一致するタスクは実行されていません。" (
rem 	goto :SHUTDOWN
rem ) else (
rem		timeout /t %INTERVAL% /nobreak
rem		goto :TASKLIST
rem )

rem 指定のexeが動いてないとプロセスidに「指定された条件に一致するタスクは実行されていません。」がセットされる
echo !PID! | findstr /c:"指定された条件に一致するタスクは実行"
IF NOT ERRORLEVEL 1 (
	rem 指定のexeが動いていない場合、こっち
	goto :SHUTDOWN
) ELSE (
	rem 指定のexeが動いている場合、こっち
	timeout /t %INTERVAL% /nobreak
	goto :TASKLIST
)


goto :EOF

rem #############################################################################################
:SHUTDOWN
echo #################################
echo シャットダウン直前の待ち時間
echo #################################
timeout /t 30 /nobreak
echo シャットダウン処理
rem shutdown.exe -s -f -t 0 -c "Windows will now shutdown soon"
rem シャットダウンをキャンセルできるように30秒の猶予を設ける
shutdown.exe -s -f -t 30 -c  "Windows will shutdown in 30 seconds"
rem シャットダウンをキャンセルするには、これ↓を実行
rem shutdown.exe -a

goto :EOF
