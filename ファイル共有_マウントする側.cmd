rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932


@echo off
cls

setlocal ENABLEDELAYEDEXPANSION

rem マウントする

set SERVER_NM=\\192.168.99.3
set SERVER_NM=\\192.168.0.19
rem set SERVER_NM=\\192.168.99.2
set SHARE_NM=%SERVER_NM%\work
set DRIVE_LETTER=U:

rem whoami の結果を書く事、アクティブディレクトリーのユーザーの場合、「ドメイン名\ユーザー名」となる
set USER_NAME=ユーザー名
set PASSWORD=パスワード

rem rem ドライブレターのチェック
rem for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
rem rem	echo %%i
rem 	if exist %%i: (
rem 		echo %%i: ドライブは存在する
rem 	) else (
rem 		echo %%i: ドライブは存在しない
rem 	)
rem )

rem if [%MODE%] == [] (
if not defined MODE (
	rem 引数を渡して起動するためにこのif文が付いている
	echo ###############################
	echo マウントする場合	1
	echo マウントを解除する場合	1以外
	echo ###############################
	set /p MODE=">"
)

IF /i [%MODE%] == [1] (
	rem マウントする
	rem -------------------------------------------------------------------------------------------
rem	set SERVER_NM=\\192.168.99.3
	rem set SERVER_NM=\\192.168.99.2
	set SHARE_NM=!SERVER_NM!\work
	set DRIVE_LETTER=V:
	net use    !DRIVE_LETTER!    !SHARE_NM!    !PASSWORD!    /USER:!USER_NAME!   /PERSISTENT:NO
	rem -------------------------------------------------------------------------------------------
) else (
	rem マウントを解除する
	set DRIVE_LETTER=V:
	net use !DRIVE_LETTER! /delete
)

explorer shell:::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
