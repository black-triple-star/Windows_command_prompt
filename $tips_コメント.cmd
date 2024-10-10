rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
rem chcp 1200 & rem "UTF-16"
chcp 65001 & rem "UTF-8"
chcp 932 & rem "CP932"
rem chcp 65001 すると、rem や echo が文字化けすることがある。この場合、二重引用符で囲めばよい。

@echo off
cls

cd /d "%~dp0"
set HERE=%~dp0
rem echo %HERE:~-1%
if "%HERE:~-1%"=="\" (set HERE=%HERE:~0,-1%)
rem echo %HERE%
echo %CD%
title "%~0"
rem setlocal ENABLEDELAYEDEXPANSION

rem set PATH="%CD%";%PATH%
rem echo %PATH%

rem ********************************************************************************


rem コマンドの後にコメントを入れたい場合、& , && , || でつなげばよい。| は次のコマンドにつなぐので、エラーになる。
echo テスト1 & rem "コメント"
echo テスト2 && rem "コメント"
rem echo テスト3 | rem "コメント"
echo テスト4 || rem "コメント"
echo テスト0 & echo "コメント"
pause

rem これだと、rem以降の文字もechoコマンドの引数になってしまう。
echo テスト  rem コメント

pause

rem ********************************************************************************

rem コメント中に ? があるとエラーになることがある。二重引用符で括ると大丈夫である。

echo 二重引用符でくくると動作する
rem "htps://www.hogeho.com/?o=98766"

echo クエスチョンマークを2byte可すれば動作する。
rem htps://www.hogeho.com/？o=777777

echo ^%は動作するが、echoの際、ハットでエスケープしても出来ない。
rem htps://www.hogeho.com/%3D%20


echo クエスチョンマークをハットでエスケープしてもダメ、下のpauseまで行かず、ここで終了してしまう。
rem htps://www.hogeho.com/^?o=777777

rem ********************************************************************************


pause
