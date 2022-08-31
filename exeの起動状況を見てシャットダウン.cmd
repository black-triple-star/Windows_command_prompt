rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem exeの起動状況を見てシャットダウンする
title %~nx0

@echo off
cls


set PROCESS_NM=ffmpeg.exe
set PROCESS_NM=Lightroom.exe
set PROCESS_NM=HandBrake.exe

rem ##################################################################################
@echo off
:LOOP

echo ##################################################################################
echo %PROCESS_NM%  を監視

timeout /t 60 /nobreak


tasklist /FI "IMAGENAME eq %PROCESS_NM%" | findstr /i "%PROCESS_NM%"
if errorlevel 1 (
	echo %PROCESS_NM%  が起動していない
	rem シャットダウン
	shutdown.exe -s -f -t 60 -c "Windows will now shutdown in 60 seconds"
	rem キャンセルするには、以下を実行する。
	rem shutdown.exe -a
) else (
	echo %PROCESS_NM%  が起動している
)

goto :LOOP
rem ##################################################################################
