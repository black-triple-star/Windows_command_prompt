rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem プロセスの強制終了

@echo off
cls

echo %cd%
echo %~dp0

set EXE_NM=AutoHotkey.exe
rem v1.1.07
set EXE_NM=AutoHotkey_2017-0302.exe
set EXE_NM=AutoHotkeyU64_v1.1.32.exe
set EXE_NM=AutoHotkeyU64_v1.1.33.02.exe

rem exeの名称が25byte を超えるとtasklistで表示できないので、findstr の為に、25byteでsubstringしている
set PROCESS_NM=%EXE_NM:~0,25%

echo %PROCESS_NM%


tasklist /FI "IMAGENAME eq %EXE_NM%" | findstr /i "%PROCESS_NM%"
if errorlevel 1 (
	rem 起動していない
) else (
	rem 起動済みの場合、終了する。
	taskkill /f /im "%EXE_NM%"
)

rem 再起動する場合、ここを有効にする
rem start /b %ComSpec% /c start /high %~dp0%EXE_NM%

