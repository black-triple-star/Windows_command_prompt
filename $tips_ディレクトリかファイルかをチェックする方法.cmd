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


@echo  off
cls

set CHECK_OBJ=C:\temp\photos
set CHECK_OBJ=C:\temp\photos2
rem set CHECK_OBJ=C:\temp\PowerToys.URL
set CHECK_OBJ=C:\temp\PowerToys2.URL
set CHECK_OBJ=C:\LibreOffice
set CHECK_OBJ=C:\temp\youtube_dl_list.txt
set CHECK_OBJ=C:\temp\日向坂\けやき坂46 - それでも歩いてる.mp4
echo %CHECK_OBJ%


rem ************************************************************************************************

setlocal enabledelayedexpansion
rem && の前にスペースを入れてはいけない。スペースも変数に格納されてしまう
for /f "tokens=* usebackq" %i in (`echo %CHECK_OBJ%`) do (set FILE_DIR=%~dpi&& set FILE_NM=%~nxi)
rem パスの最後にある\マークを除去する例。（パスの最後に\マークがあると動作しないコマンドがある）
if "%FILE_DIR:~-1%"=="\" (set FILE_DIR=%FILE_DIR:~0,-1%)
echo %FILE_DIR%
echo %FILE_NM%
rem ディレクトリ、シンボリックリンクなら、<DIR> ,  <SYMLINKD> が表示される、ファイルならファイルサイズが返ってくる。
rem ファイル名、ディレクトリ名、シンボリックリンク名にスペースが含まれる場合、動作しないという致命的な欠陥がある。
for /f "tokens=1,2,3,4 usebackq" %i in (`dir %FILE_DIR%`) do ( if [%~l]==[%FILE_NM%] ( echo %~k) )
pause

rem ************************************************************************************************
rem ディレクトリかファイルかをチェックする方法
rem	dir !FILE_PATH!\!FILE_NAME!!FILE_EXT! 2>nul | %systemroot%\SysWOW64\find /i "<DIR>          .."  >NUL
dir "%CHECK_OBJ%" 2>nul | %systemroot%\SysWOW64\find /i "<DIR>          .."  >NUL
rem errorlevelで判別しているため、ここに新たなコマンドを入れてはいけない
if not errorlevel 1 (
	echo ディレクトリ
) else (
	rem シンボリックリンクもこっちに入る
	rem 存在しない場合、elseに入ってしまう
	echo ファイル
)
pause

rem ************************************************************************************************
rem ディレクトリかファイルかをチェックする方法
setlocal ENABLEDELAYEDEXPANSION
if exist "%CHECK_OBJ%" (
	if exist "%CHECK_OBJ%\*" (
		echo ディレクトリ
rem		cd  /d   "%CHECK_OBJ%"
	) else (
		echo ファイル
rem		for /f "tokens=* usebackq" %%i in (`echo "%CHECK_OBJ%"`) do (set FILE_DIR=%%~dpi)
rem		cd  /d   !FILE_DIR!
	)
) else (
	echo 存在しない
)
pause

rem 一行で書くとこうなる
if exist "%CHECK_OBJ%" (if exist "%CHECK_OBJ%\*" (set CHECK_OBJ=ディレクトリ) else (set CHECK_OBJ=ファイル)) else (set CHECK_OBJ=存在しない)
echo %CHECK_OBJ%

pause

rem こっちはダメ、存在しない場合、elseに入ってしまう
if exist "%CHECK_OBJ%\*" (
	echo ディレクトリ
) else (
	rem 存在しない場合、elseに入ってしまう
	echo ファイル
)
pause

rem \* をつけないと、ファイルもディレクトリもどちらも合致する
if exist "%CHECK_OBJ%" (
	echo ファイル
)
pause
rem ************************************************************************************************

