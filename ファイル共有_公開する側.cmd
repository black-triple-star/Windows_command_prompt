rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932


@echo off
cls

setlocal ENABLEDELAYEDEXPANSION

rem パソコン同士で直接ファイル共有を行う為の設定

rem set SHARE_NAME=WORK
rem ログインしているユーザー名をセット
for /f "tokens=* usebackq" %%i in (`whoami`) do (set USER_NAME=%%i)
rem %%i と ) の間にスペースを入れてはいけない。スペースも変数に格納されてしまう
echo %USER_NAME%
cls

rem http://www.atmarkit.co.jp/ait/articles/0609/09/news020.html
rem 現在の共有の一覧を見る
net share



rem if [%MODE%] == [] (
if not defined MODE (
	rem 引数を渡して起動するためにこのif文が付いている
	echo ###############################
	echo 共有する場合	1
	echo 共有を解除する場合	1以外
	echo ###############################
	set /p MODE=">"
)

IF /i [%MODE%] == [1] (
	echo on
	rem /grant オプションを付けないとeveryone , fullアクセスとなるので注意
	rem #############################################################################
	set SHARE_DIR=C:\WORK
	set SHARE_NAME=WORK
	echo !SHARE_DIR!
	net share !SHARE_NAME!=!SHARE_DIR!  /cache:none   /GRANT:!USER_NAME!,full
	rem #############################################################################
) else (
	rem 共有を解除する
	set SHARE_NAME=WORK
	net share !SHARE_NAME! /delete
)

rem 現在の共有の一覧を見る
net share

@echo off
pause>nul


