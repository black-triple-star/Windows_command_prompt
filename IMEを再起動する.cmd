rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem IMEを再起動するバッチファイル
rem 管理者権限で動かすこと
rem https://qwerty.work/blog/2020/09/ime-ctfmonexe.php

@echo off
@setlocal enabledelayedexpansion
 
echo.
echo IMEを再起動します。

echo.
echo プロセスIDを調べています。
rem for /f "tokens=1,2" %%i in ('tasklist /fi "imagename eq ctfmon.exe"') do @set PID=%%j
for /f "tokens=1,2" %%i in ('tasklist /fi "imagename eq ctfmon.exe"') do (@set PID=%%j)
echo "!PID!"

tasklist /fi "imagename eq ctfmon.exe"

rem 余計なスペースを削除
rem call :Trim !PID!

rem echo プロセスIDを"!PID!"を取得しました。

echo IMEを終了させています。
taskkill /pid !PID!

echo IMEを起動しています。
ctfmon.exe

echo IMEの再起動が完了しました。

rem goto End
rem 
rem 
rem :End
rem rem *************************************************************************************************
rem 
rem endlocal
rem pause
rem exit
rem  
rem :Trim
rem set PID=%*
