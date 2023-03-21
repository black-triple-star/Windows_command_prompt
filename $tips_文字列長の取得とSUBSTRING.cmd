
rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

cd /d "%~dp0" && set BASHO=%~dp0
if "%BASHO:~-1%"=="\" (set BASHO=%BASHO:~0,-1%)
echo %CD%
title "%~0"

setlocal enabledelayedexpansion

@echo off
cls
rem ********************************************************************************

rem @echo off
cls

set FILE_NM=D:\Music\柳ジョージ-2008-鉄のララバイ・バイバイブラザー\01 鉄のララバイ.mp3
set CURRENT_DIR=D:\Music
set LEN=0


rem フルパスから、カレントディレクトリより後ろを取り出す為、カレントディレクトリの文字列長を得る
echo %CURRENT_DIR%
call :STRLEN   "%CURRENT_DIR%"
echo %LEN%


set /a LEN=%LEN%+1

rem フルパス
echo フルパス
echo %FILE_NM%

rem ********************************************************************************
rem substring の例
rem %[環境変数]:~[オフセット(位置)],[文字数]%

rem set N=123456789
rem echo %N%
rem echo %N:~2,2%
rem echo %N:~2,5%

rem 変数のsubstringの仕方
rem http://www.atmarkit.co.jp/fwin2k/win2ktips/419batchdate/batchdate.html
rem %V%			変数Vの値全体							%V% ⇒「ABCDEFGHIJKL」
rem %V:~m%		m文字目から、最後まで					%V:~5% ⇒「FGHIJKL」
rem %V:~m,n%	m文字目から、n文字分					%V:~5,2% ⇒「FG」
rem %V:~m,-n%	m文字目から、最後のn文字分を除いたもの	%V:~5,-2% ⇒「FGHIJ」
rem %V:~-m%		後ろからm文字目から、最後まで			%V:~-5% ⇒「HIJKL」
rem %V:~-m,n%	後ろからm文字目から、n文字分			%V:~-5,2% ⇒「HI」
rem %V:~-m,-n%	後ろからm文字目から、最後のn文字分を除いたもの						%V:~-5,-2% ⇒「HIJ」
rem %V:c1=c2%	文字c1を文字c2に置換する。それぞれ複数の文字を指定することも可能	%V:ABC=abc% ⇒「abcDEFGHIJKL」
rem ********************************************************************************


rem SUBSTRING の結果
echo SUBSTRING の結果
set FILE_NM=!FILE_NM:~%LEN%!
echo %FILE_NM%

rem \ を / に置換する
echo \ を / に置換する
set FILE_NM=%FILE_NM:\=/%

echo %FILE_NM%

pause>nul
:goto EOF

rem ##########################################################################
rem 文字列長を取得する
rem http://piyopiyocs.blog115.fc2.com/blog-entry-898.html
rem ##########################################################################
:STRLEN

set str=%~1
rem set LEN=0
echo %str%
:LOOP
if not "%str%"=="" (
	set str=%str:~1%
	set /a LEN=%LEN%+1
	goto :LOOP
)

goto :EOF
rem ##########################################################################
