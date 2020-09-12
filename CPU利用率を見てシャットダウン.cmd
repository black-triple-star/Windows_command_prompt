rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem CPU利用率を見てシャットダウン


@echo off
cls

setlocal ENABLEDELAYEDEXPANSION


rem CPUの利用率がこの値未満になった時にシャットダウンする
set /a THRESHOLD=10

rem CPU利用率を求める間隔
set INTERVAL=60

title  OSをシャットダウンするCPU利用率：%THRESHOLD% ％  、 CPU利用率を求める間隔：%INTERVAL% 秒間


rem wmic cpu get loadpercentage/value /every:10

rem wmic cpu get loadpercentage/value

rem EQU　　等しい 
rem NEQ　　等しくない 
rem LSS　　より小さい 
rem LEQ　　以下 
rem GTR　　より大きい 
rem GEQ　　以上 
rem  


:CALC_CPU_USAGE

for /f "tokens=2 delims=^= usebackq" %%i in (`wmic cpu get loadpercentage/value`) do (
	rem echo %%i
	set /a CPU=%%i
	echo CPU利用率　!CPU!
	if !CPU! LSS %THRESHOLD% (
		echo 閾値以下
		timeout /t %INTERVAL% /nobreak
		call :SHUTDOWN
rem		goto :CALC_CPU_USAGE
	) else (
		echo 閾値以上
		timeout /t %INTERVAL% /nobreak
		goto :CALC_CPU_USAGE
	)
)
goto :EOF

rem #############################################################################################
:SHUTDOWN
echo #################################
echo シャットダウン直前の待ち時間
echo #################################
timeout /t 60 /nobreak
rem 一分待って閾値以下の場合、シャットダウンする、閾値以上になったら、戻る
if !CPU! LSS %THRESHOLD% (
	echo シャットダウン処理
	shutdown.exe -s -f -t 0 -c "Windows will now shutdown soon"
) else (
	echo シャットダウン処理を取り消し
	goto :CALC_CPU_USAGE
)

