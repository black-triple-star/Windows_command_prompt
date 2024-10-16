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

rem ＆＆ を使って、左のコマンドの実行に成功したときに右のコマンドを実行する。＆が一つだとエラーでも次のコマンドが実行される。

rem ｜を使って、最初のコマンドが失敗したときのみ、2つ目のコマンドを実行したい場合は、"||"で複数のコマンドを繋げます。
rem https://www.pg-fl.jp/program/dos/doscmd/str_l_and.htm
rem http://excmd.seesaa.net/article/156181146.html
rem http://tugi.hatenablog.com/entry/2014/09/18/204239
rem https://akamist.com/blog/archives/1327
C:\Windows\System32\cmd.exe /k set PATH=C:\Program Files (x86)\VMware\VMware Player\;%PATH% && vctl.exe -h

set PATH=C:\Program Files (x86)\VMware\VMware Player\;%PATH% && echo aa


shutdown -a & echo シャットダウンがスケジュールされてなくても、echoできる。
shutdown -a && echo シャットダウンがスケジュールされてると、echoできる。（スケジュールされてないと、echoできない）
shutdown -a || echo シャットダウンがスケジュールされてないと、echoされる
shutdown -a | echo シャットダウンがスケジュールされてなくても、echoできる

shutdown.exe -s -f -t 7200

rem ネストも可能らしい
rem (command1 & command2) || command3

rem ********************************************************************************
rem コマンドが正常終了したかの判定
rem 存在しないディレクトリをdirするとエラーとなる
dir C:\dummy
dir %userprofile%
IF ERRORLEVEL 1 (
	echo エラー
) ELSE (
	echo 正常実行
)


rem ********************************************************************************
rem 改行だけを出力したい場合、echooff してからecho.　とする。
rem https://jj-blues.com/cms/wantto-echonewline/
rem https://www.k-tanaka.net/windows/cmd/echo.html
rem https://www.projectgroup.info/tips/Windows/cmd_0003.html
echo.

echo on

rem ********************************************************************************
rem 【バッチファイル】文字列を改行なしで表示  https://qiita.com/koryuohproject/items/f53ace4bcd3bf0b261be
SET /P X=文字列<NUL
@rem ファイルに上書き
SET /P X=文字列<NUL >ファイル
@rem ファイルに追記
SET /P X=文字列<NUL >>ファイル

rem 改行ありでコピー
echo 改行ありでコピー|clip

rem 改行なしでコピー、ただし、スペースが入る
SET /P X=改行なしでコピー<NUL|clip

rem ********************************************************************************
rem Windows ショートカット（.lnkファイル）で、相対パスを指定する方法。以下のように、explorer.exe の引数にする
rem %windir%\explorer.exe ".\bin\nomacs.exe"

rem ********************************************************************************
rem https://news.mynavi.jp/article/win10tips-459/
pushd を使えば、UNCのドライブレターの割り当てをやってくれるが、pushdだとユーザー名とパスワードを指定できないっぽい

rem ********************************************************************************
rem 管理者によるコマンドプロンプトでも消去・所有者変更・権限変更ができない場合の消し方
rem https://denor.jp/%E3%83%95%E3%82%A9%E3%83%AB%E3%83%80%E3%82%92%E3%81%A9%E3%81%86%E3%81%97%E3%81%A6%E3%82%82%E5%89%8A%E9%99%A4%E3%81%A7%E3%81%8D%E3%81%AA%E3%81%84%E5%A0%B4%E5%90%88%E3%81%AE%E5%AF%BE%E5%BF%9C%E4%BE%8B
rem DOSデバイスパス表記で消す
rem rd "\\?\C:\<削除するフォルダのパスを途中まで入力後TABで補完＞”
rem 例
rem rd /s  /q  \\?\D:\MEGA\Rubbish\2021-12-03\

rem ********************************************************************************
rem カレントドライブとカレントディレクトリを変数に格納する方法

SET CURRENT_DRIVE=%CD:~0,1%
SET CURRENT_DIR=%CD%

echo %CURRENT_DRIVE%
echo %CURRENT_DIR%


rem ********************************************************************************
rem パスの設定
set PATH=%PATH%;"C:\Program Files"
echo %PATH%

@echo off


rem ********************************************************************************

rem substring の例
rem %[環境変数]:~[オフセット(位置)],[文字数]%

set N=123456789
echo %N%
echo %N:~2,2%
echo %N:~2,5%

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

rem 置換
set SAVE_DIR=%SAVE_DIR:/=\%
set SAVE_DIR=!SAVE_DIR:/=\!


rem ********************************************************************************
rem http://www.atmarkit.co.jp/ait/articles/0405/01/news002.html

rem パスの最後にある\マークを除去する例。（パスの最後に\マークがあると動作しないコマンドがある）

set HOGE=c:\temp\
echo %HOGE%
echo %HOGE:~-1%
if "%HOGE:~-1%"=="\" (set HOGE=%HOGE:~0,-1%)
rem if %HOGE:~-1%==\ (set HOGE=%HOGE:~0,-1%)
echo %HOGE%

rem パスの最後にある\マークを除去する例。（パスの最後に\マークがあると動作しないコマンドがある）
rem cd と %cd% を使う。cd するのでpushdとpopdで現在のパスに戻るようにしている。
pushd %cd%
set HOGE=C:\temp\
echo %HOGE%
cd /d  %HOGE%
set HOGE=%cd%
echo %HOGE%
popd

rem ********************************************************************************

rem verの結果
rem 2000
Microsoft Windows 2000 [Version 5.00.2195]
rem XP
Microsoft Windows XP [Version 5.1.2600]
rem XP 64
Microsoft Windows [Version 5.2.3790]
rem Vista (SPを当てると一番最後の桁がインクリメントされるようだ)
Microsoft Windows [Version 6.0.6001]
rem 7
Microsoft Windows [Version 6.1.7600]
rem Windows Server 2012 (無印)
Microsoft Windows [Version 6.2.9200]
rem Windows Server 2012 R2
Microsoft Windows [Version 6.3.9600]


rem  Windows NT か Windows 2000/XP を判定する方法
VER | %systemroot%\SysWOW64\find /I "Windows NT Version 4.0">NUL
IF NOT ERRORLEVEL 1 GOTO Fatal_WrongSystemVersion


rem  Windows 2000 かどうかを判定する方法
VER | %systemroot%\SysWOW64\find /I "Microsoft Windows 2000 [Version 5.00.2195]">NUL
IF NOT ERRORLEVEL 1 (
	echo Windows 2000です
) ELSE (
	echo Windows 2000ではありません
)

rem  Windows XP かどうかを判定する方法
VER | %systemroot%\SysWOW64\find /I "Microsoft Windows XP [Version 5.1.2600]">NUL
IF NOT ERRORLEVEL 1 (
	echo Windows XPです
) ELSE (
	echo Windows XPではありません
)

rem  Windows Server 2003 かどうかを判定する方法
VER | %systemroot%\SysWOW64\find /I "Microsoft Windows [Version 5.2.3790]">NUL
IF NOT ERRORLEVEL 1 (
	echo Windows Server 2003です
) ELSE (
	echo Windows Server 2003ではありません
)


rem Windows Vista かどうかを判定する方法
rem Vista（以降？）バージョン番号の一番下の桁がサービスパックの番号になったかも（？）
VER | %systemroot%\SysWOW64\find /I "Microsoft Windows [Version 6.0.6001]">NUL
IF NOT ERRORLEVEL 1 (
	echo Windows Vistaです
) ELSE (
	echo Windows Vistaではありません
)

rem  Windows 7 かどうかを判定する方法
VER | %systemroot%\SysWOW64\find /I "Microsoft Windows [Version 6.1.7600]">NUL
IF NOT ERRORLEVEL 1 (
	echo Windows 7です
) ELSE (
	echo Windows 7ではありません
)

rem バージョンを変数に入れる方法
for /f "tokens=1,2,3,4,5,6 delims=[] " %%I in ('ver') do (
	@echo %%I	%%J	%%K	%%L	%%M	%%N%%O
)

rem Windows が32bitか64bitかを判別
if /i "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	echo 64bit Windows
)
if /i "%PROCESSOR_ARCHITECTURE%" == "x86" (
	echo 32bit Windows
)

pause

set TEMP_FILE=%~dpn0.txt
rem ファイルを読み込みながら、echo する。その際、%TEMP_FILE% を二重引用符で囲ってはいけない。つまり、ファイル名にスペースを入れてはいけない。
for /F "eol=# tokens=1,2 delims=	" %%I in ( %TEMP_FILE% ) do  (
	echo "%%~I"	"%%~J"
)

rem 所定のディレクトリ配下のファイル全てを加工する
for /f "delims=" %%V in ('dir /b /s /o-d /on *.csv') do (
	echo %%V
	rem 何らかの処理を行う
)


rem ********************************************************************************

rem 特定のプロセスが起動していない場合、起動する。（Windows XP のみ）
set PROCESS_NM=notepad.exe
tasklist | %systemroot%\SysWOW64\find /i "%PROCESS_NM%">NUL
if errorlevel 1 (
	start /b %PROCESS_NM%
)

rem 特定のプロセスが起動している場合、一度強制終了してから起動する。（Windows XP のみ）
set PROCESS_NM=notepad.exe
tasklist | %systemroot%\SysWOW64\find /i "%PROCESS_NM%">NUL
if errorlevel 0 (
	taskkill /f /im %PROCESS_NM% /t
)
start /b %PROCESS_NM%

rem エスケープ文字
rem http://www.geocities.co.jp/SiliconValley-SanJose/1227/variable.html
rem  環境変数にリダイレクトやパイプ、条件付き処理記号などの特殊記号 (>,>>,<,|,
rem  &) を代入する場合には、特殊記号の先頭にエスケープ文字 (^) を付ける必要が
rem  あります。たとえば環境変数 K に special& という文字列を入れるなら、set 
rem  K=special^& と入力します


pause

rem タスクスケジューラーから起動すると、カレントディレクトリが%system%になるので、
rem 起動するcmdファイルのパスからカレントディレクトリを得る。
rem for /d %%V in (%0) do  (set HERE=%%~dpV)
set HERE=%~dp0
echo %HERE%
pause

rem ********************************************************************************

set TEMP_FILE=%temp%\test.txt
echo test>"%TEMP_FILE%"

set TEMP_OBJ=%temp%
set TEMP_OBJ=%TEMP_FILE%
dir "%TEMP_OBJ%" 2>nul | %systemroot%\SysWOW64\find /i "<DIR>          .."  >NUL
rem errorlevelで判別しているため、ここに新たなコマンドを入れてはいけない
if not errorlevel 1 (
	echo ディレクトリ
) else (
	echo ファイル
)


rem ディレクトリとファイルの判別。最後に\を付けてexist判定をすればいい。
set TEMP_FILE=%temp%\test.txt
echo test>"%TEMP_FILE%"
if exist "%TEMP_FILE%\" (
	echo ディレクトリです
) else (
	rem なお名称そのものでexistのチェックをする必要がある
	if exist "%TEMP_FILE%" (
		echo ファイルです
	) else (
		echo そもそも存在しない。
	)

)
if exist "%TEMP%\" (
	echo ディレクトリです
) else (
	rem なお名称そのものでexistのチェックをする必要がある
	if exist "%TEMP_FILE%" (
		echo ファイルです
	) else (
		echo そもそも存在しない。
	)
)

rem 一行で書くとこうなる
set OBJECT=%TEMP_FILE%
set OBJECT=%TEMP%
set OBJECT=aaaaa
if exist "%OBJECT%\" ( set OBJ_TYPE=ディレクトリ ) else ( if exist "%OBJECT%" ( set OBJ_TYPE=ファイル ) else ( set OBJ_TYPE=そもそも存在しない。))
echo %OBJ_TYPE%


rem ********************************************************************************
rem for と引数で使える修飾子
rem 修飾子付き変数 説明 
rem %~I	%I を、囲んでいる引用符 ("") を削除した形に展開します。 
rem %~fI	%I を、完全修飾パス名に展開します。 
rem %~dI	%I を、ドライブ文字だけに展開します。 
rem %~pI	%I を、パスだけに展開します。 
rem %~nI	%I を、ファイル名だけに展開します。 
rem %~xI	%I を、ファイル拡張子だけに展開します。 
rem %~sI	パスを、短い名前に展開します。 
rem %~aI	%I を、ファイルのファイル属性に展開します。 
rem %~tI	%I を、ファイルの日付と時刻に展開します。 
rem %~zI	%I を、ファイルのサイズに展開します。 

rem ********************************************************************************
rem ファイル名から拡張子などを取り出す
rem https://orangeclover.hatenablog.com/entry/20101004/1286120668

rem forループの中で変数の中身を取り出すわけでないので、これは不要
rem setlocal enabledelayedexpansion

set INPUT_FILE=D:\GitHub\tools\tips.bas

@echo off
cls

echo %INPUT_FILE%
for /f %%V in ("%INPUT_FILE%") do (
	echo %%V
	echo %%~fV
	echo %%~dV
	echo %%~pV
	echo %%~dpnV
	echo %%~nV
	echo %%~nxV
	echo %%~xV
	echo %%~sV
	echo %%~aV
	rem ファイル更新日付とバイト数
	echo %%~tV
	echo %%~zV
	set FILE_NAME=%%~dpnV
	set FILE_EXT=%%~xV
)
echo ####################
echo %FILE_NAME%
echo %FILE_EXT%


rem ファイルのフルパスからディレクトリとファイル名を分離する
set BROWSER=C:\bin64\FirefoxPortable\App\Firefox64\firefox.exe
set BROWSER=C:\bin64\GoogleChromePortable\App\Chrome-bin\chrome.exe
rem set BROWSER=C:\Program Files\Google\Chrome\Application\chrome.exe
rem rem set BROWSER=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe
rem rem Edge でもロードできるが、カッコが入ってるとダメで（^でエスケープしてもダメ）、ショートファイル名である必要がある。
rem set BROWSER=C:\Progra~1\Microsoft\Edge\Application\msedge.exe

rem ファイルのフルパスからディレクトリを取り出す。 %%i と ) の間にスペースを入れてはいけない。スペースも変数に格納されてしまう
for /f "tokens=* usebackq" %%i in (`echo %BROWSER%`) do (set FILE_DIR=%%~dpi)
rem パスの最後にある\マークを除去する例。（パスの最後に\マークがあると動作しないコマンドがある）
if "%FILE_DIR:~-1%"=="\" (set FILE_DIR=%FILE_DIR:~0,-1%)
rem if %FILE_DIR:~-1%==\ (set FILE_DIR=%FILE_DIR:~0,-1%)
echo %FILE_DIR%

rem ファイルのフルパスからファイル名を取り出す
for /f "tokens=* usebackq" %%i in (`echo %BROWSER%`) do (set FILE_NM=%%~nxi)
echo %FILE_NM%

rem 1行で書くとこうなる
rem ファイルのフルパスからディレクトリとファイル名を分離する && の前にスペースを入れてはいけない。スペースも変数に格納されてしまう
for /f "tokens=* usebackq" %%i in (`echo %BROWSER%`) do (set FILE_DIR=%%~dpi&& set FILE_NM=%%~nxi)
rem パスの最後にある\マークを除去する例。（パスの最後に\マークがあると動作しないコマンドがある）
if "%FILE_DIR:~-1%"=="\" (set FILE_DIR=%FILE_DIR:~0,-1%)
set PATH="%FILE_DIR%";%PATH% && echo %PATH%
echo %FILE_DIR%
echo %FILE_NM%
rem FILE_NMを二重引用符で囲むと動作しない。
start /d "%FILE_DIR%" /b %FILE_NM%
rem	tasklist | %systemroot%\SysWOW64\find /i "%FILE_NM%">NUL
rem	if errorlevel 1 (
rem		start /d "%FILE_DIR%" /b %FILE_NM%
rem	)
pause



rem 1行で書くとこうなる
rem ファイルのフルパスからディレクトリとファイル名を分離する && の前にスペースを入れてはいけない。スペースも変数に格納されてしまう
set INPUT_FILE=D:\GitHub\tools\tips.bas
for /f %%V in ("%INPUT_FILE%") do ( set DRIVE_LETTER=%%~dV&&  set DRIVE_AND_DIR=%%~dpV&&  set FULL_PATH=%%~dpnxV&&  set BASENAME=%%~nxV&& set FILE_EXT=%%~xV)
for /f %V in ("%INPUT_FILE%") do ( set DRIVE_LETTER=%~dV&&  set DRIVE_AND_DIR=%~dpV&&  set FULL_PATH=%~dpnxV&&  set BASENAME=%~nxV&& set FILE_EXT=%~xV)
echo ####################
echo "%FULL_PATH%"
echo "%DRIVE_LETTER%"
echo "%DRIVE_AND_DIR%"
echo "%BASENAME%"
echo "%FILE_EXT%"

rem 変数名を二重引用符で囲めばいいかと思うがダメ。 二重引用符も && 直前のスペースも変数にセットされる。
set INPUT_FILE=D:\GitHub\tools\tips.bas
for /f %%V in ("%INPUT_FILE%") do ( set DRIVE_LETTER="%%~dV"  &&  set DRIVE_AND_DIR="%%~dpV"  &&  set FULL_PATH="%%~dpnxV"  &&  set FILE_NAME="%%~dpnV"  && set FILE_EXT="%%~xV")
for /f %V in ("%INPUT_FILE%") do ( set DRIVE_LETTER="%~dV"  &&  set DRIVE_AND_DIR="%~dpV"  &&  set FULL_PATH="%~dpnxV"  &&  set FILE_NAME="%~dpnV"  && set FILE_EXT="%~xV")
echo ####################
echo [%FULL_PATH%]
echo [%DRIVE_LETTER%]
echo [%DRIVE_AND_DIR%]
echo [%FILE_NAME%]
echo [%FILE_EXT%]


pause


rem ################################################################################################
rem ファイルとディレクトリの判別
for /d  %%V in (%*) do  (
	echo %%V
	if not exist  "%%~V"  (
		echo #######################################################################################
		echo "%%~V" が存在しません
		echo コマンドプロンプトの関係上、^, ^& ^( ^) などがファイル名に含まれていると動作しません
		echo #######################################################################################
		pause>nul
	) else (
		rem ここを参考にして、ディレクトリとファイルの自動判別
		rem http://www.atmarkit.co.jp/fwin2k/operation/command003/command2.html
	rem	dir %%V 2>nul | %SYSTEMROOT%\system32\find "<DIR>          .."  >NUL
		dir "%%~V" 2>nul | %SYSTEMROOT%\system32\find "<DIR>          .."  >NUL
		if not errorlevel 1 (
			rem echo 対象ファイル %%V
			rem echo Path    = %%~pV
			rem echo Name    = %%~nV
			rem echo Ext     = %%~xV
			rem echo FullPath= %%~dpnV
			rem echo Name    = %%~nV
			rem echo Ext     = %%~xV
			rem http://pc5.2ch.net/test/read.cgi/win/1062775949/390を使用した
rem			cd /d %%V
			cd /d "%%~V"
			rem ディレクトリの場合、中を全部dirする
			for /f "delims=" %%W in ('dir /s /a-d /b') do (
				@echo %%~fW
			)
			cd ..
		) else (
			rem ファイルの場合
			@echo %%~fV
		)
	)
)


rem ################################################################################################
rem ドラッグアンドドロップ版
for /d %%V in (%*) do  (
	set /a COUNTER=!COUNTER!+1
	rem バックアップ対象のディレクトリ又はファイルが見つからない場合、エラー
	IF NOT EXIST "%%~V" (
		echo "%%~V" が存在しません
		echo コマンドプロンプトの関係上、^, ^& ^( ^) などがファイル名に含まれていると動作しません
		goto :Err
	)
	set FULL_FILE_NAME=%%~V
	set FILE_PATH=%%~dpV
	if !FILE_PATH:~-1!==\ (set FILE_PATH=!FILE_PATH:~0,-1!)
	set FILE_NAME=%%~nV
	set FILE_EXT=%%~xV
	set FILE_NAME_EXT=%%~nxV
	set FILE_PATHNAME=%%~dpnV
	rem UNCかどうかの判定用
	set TWO_CHAR=!FULL_FILE_NAME:~0,2!
rem echo !FULL_FILE_NAME!
rem echo !FILE_PATH!
rem echo !FILE_NAME!
rem echo !FILE_EXT!
rem echo !FILE_PATHNAME!
rem	echo !TWO_CHAR!
rem echo !COUNTER!
	
rem ここをskipするとUNC対応前と同じ動作となる
	rem UNC かつ1回目のみ UNCパスを Z ドライブにする
	if [!TWO_CHAR!]==[\\] if !COUNTER! == 1 (
		echo UNC
		if exist %TEMP_DRIVE%\nul ( NET USE %TEMP_DRIVE% /DELETE /Y)
		NET USE %TEMP_DRIVE% "!FILE_PATH!" /PERSISTENT:NO
	)
	if [!TWO_CHAR!]==[\\] (
		set FILE_PATH=%TEMP_DRIVE%
rem		echo !FILE_PATH!
	)
rem skipは、ここまで。
rem		履歴作成時の日時ではなく、ファイル・ディレクトリ更新時の日時を接尾辞にした
	rem echo %%~tV
	set TIMESTAMP=%%~tV
	set TIMESTAMP=!TIMESTAMP:/=!
	set TIMESTAMP=!TIMESTAMP::=!
	set TIMESTAMP=!TIMESTAMP: =_!
rem	echo !TIMESTAMP!
	
	rem ここを参考にして、ディレクトリとファイルの自動判別
	rem http://www.atmarkit.co.jp/fwin2k/operation/command003/command2.html
rem	dir %%V 2>nul | %systemroot%\SysWOW64\find /i "<DIR>          .."  >NUL
	dir !FILE_PATH!\!FILE_NAME!!FILE_EXT! 2>nul | %systemroot%\SysWOW64\find /i "<DIR>          .."  >NUL
	rem errorlevelで判別しているため、ここに新たなコマンドを入れてはいけない
	if not errorlevel 1 (
		cd /d %%V
		rem ドラッグアンドドロップ＆ディレクトリの場合
		rem ディレクトリの場合、中を全部dirする
		for /f "delims=" %%W in ('dir /s /a /b') do (
			@echo %%~fW
		)
		cd ..
rem 		rem ドラッグアンドドロップ＆ディレクトリの場合
rem 		IF %USE_AS_PREFIX% == 1 (
rem 			rem ディレクトリ名を「HISTORY_履歴作成対象」とする場合
rem 			call :COPY_DIR "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME!\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "..\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
rem 		) ELSE (
rem 			rem ディレクトリ名を「履歴作成対象_HISTORY」とする場合
rem 			call :COPY_DIR "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\!FILE_NAME!_%HISTORY%\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "..\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
rem 		)
	) else (
		rem ファイルの場合
		@echo %%~fV
rem 		rem ドラッグアンドドロップ＆ファイルの場合
rem 		IF %USE_AS_PREFIX% == 1 (
rem 			rem ファイル名を「HISTORY_履歴作成対象」とする場合
rem 			call :COPY_FILE "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
rem 		) ELSE (
rem 			rem ファイル名を「履歴作成対象_HISTORY」とする場合
rem 			call :COPY_FILE "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\!FILE_NAME!!FILE_EXT!_%HISTORY%" "!FILE_PATH!\!FILE_NAME!!FILE_EXT!_%HISTORY%\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
rem 		)
	)
)
:Err
echo ###############################################################
echo バックアップの対象あるいはバックアップの保存先が見つかりません。
echo コマンドプロンプトの関係上、^, ^& ^( ^) などがファイル名に含まれていると動作しません
echo ###############################################################
PAUSE>NUL
goto :EOF

rem ################################################################################################
rem if文のand条件の例
rem ################################################################################################

rem /i	文字列を比較する場合に、アルファベットの大文字と小文字を区別しない。
if /i [ABC] equ [abc] (echo 同じ) else (echo 違う)
if  [ABC] equ [abc] (echo 同じ) else (echo 違う)

rem
EQU　　等しい
NEQ　　等しくない
LSS　　より小さい
LEQ　　以下
GTR　　より大きい
GEQ　　以上

rem ********************************************************************************

rem if文
if not [1] == [0] (
	echo trueです
)
rem http://www.fpcu.jp/dosvcmd/bbs/log/cat3/if/4-1258.html
rem if文のand条件の例
if not [1] == [0] if not [a] == [b] if /i [a] == [A] (
	echo trueです
)

rem if文のand条件の例
if not [1] == [0] if not [a] == [b] if /i [a] == [b] (
	echo trueです
) else (
	echo falseです
)

pause



rem ********************************************************************************
rem コマンドプロンプトからエクスプローラーで所定のディレクトリを開く
start .
start %temp%
rem http://pc12.2ch.net/test/read.cgi/win/1258643596/74
rem コンピュータ
%windir%\explorer.exe "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
rem ゴミ箱
%windir%\explorer.exe "::{645FF040-5081-101B-9F08-00AA002F954E}"
rem マイドキュメント
%windir%\explorer.exe "::{450D8FBA-AD25-11D0-98A8-0800361B1103}"
rem デスクトップ
%windir%\explorer.exe /n,/select,shell:::{603D3800-BD81-11d0-A3A5-00C04FD706EC}
%windir%\explorer.exe /n,/e,"%userprofile%\Desktop"

%windir%\explorer.exe /n,/e,"C:\"

rem コマンドプロンプトからエクスプローラーで所定のディレクトリ・ファイルを選択した状態にする。
%WINDIR%\explorer.exe /select,"C:\temp\タスクバーに表示するアイコンと通知の選択.cmd"

%WINDIR%\explorer.exe /select,"C:\#Work\python_source"
rem /root を /select の前に付けると、そのディレクトリを開いた状態になる。（ファイルを引数にするとそのファイルを開く）
rem （/root を /select の後に付けると、上記の動作にならない）
%WINDIR%\explorer.exe /root,/select,"C:\#Work\python_source"


rem コマンドプロンプトからエクスプローラーで所定のディレクトリ・ファイルを選択した状態にする。
set OBJECT=C:\Users\中村崇NAKAMURATAKASHIYT\Documents\GitHub\tools
if exist "%OBJECT%\*" ( %WINDIR%\explorer.exe /root,/select,"%OBJECT%" ) else ( if exist "%OBJECT%" ( %WINDIR%\explorer.exe /select,"%OBJECT%" ) else ( echo "%OBJECT%" は存在しない。))

rem --------------------------------------------------------------------------------
rem コマンドプロンプトからエクスプローラーでUNCのディレクトリを開く
rem explorer.exe に UNCパスを渡せば、cmd.exe から UNC が開ける
%WINDIR%\explorer.exe /select,"\\192.168.0.1\data"
rem /root を /select の前に付けると、そのディレクトリを開いた状態になる。（ファイルを引数にするとそのファイルを開く）
rem （/root を /select の後に付けると、上記の動作にならない）
%WINDIR%\explorer.exe /root,/select,"\\192.168.0.1\data"



rem ********************************************************************************
rem 一種のタイマー機能
rem ping を使って処理を１秒程度止める（止めないとブラウザにURLを渡す前にファイルが消えてしまうため）
rem http://fpcu.on.coocan.jp/dosvcmd/bbs/log/cat3/pausechoice/2-0952.html
ping localhost -n 2 > nul

rem 所定時間待つ（timeout）UNIXのsleepと同じ
rem http://www.atmarkit.co.jp/fwin2k/win2ktips/1420sleep/sleep.html
rem 5秒待つ
timeout /t 5 /nobreak
rem 永遠に待つ
timeout /t -1

rem ********************************************************************************
rem 文字コードを変える例
chcp 65001
chcp 932

rem ********************************************************************************
rem コマンドプロンプトの起動時に、所定のコマンドを実行する方法
cmd.exe  /f:on  /k コマンド

rem ********************************************************************************
rem コマンドプロンプトのコマンドの結果を変数に入れる。（bash だと  USER_NAME=`whoami`  だけで出来る奴 ）
rem ログインしているユーザー名をセット
for /f "tokens=* usebackq" %%i in (`whoami`) do (set USER_NAME=%%i)
rem %%i と ) の間にスペースを入れてはいけない。スペースも変数に格納されてしまう
echo %USER_NAME%



rem ********************************************************************************
rem http://d.hatena.ne.jp/simply-k/20100821/1282490379
rem バッチファイルで無限ループを作るAdd Starsakurai_youheisakurai_youhei
rem コマンドプロンプト/バッチファイル
rem 
rem バッチファイルでの無限ループの作り方です。*1
rem GOTO文を使う方法
rem GOTO文を使うと、無限ループを作ることができます。
rem 
rem サンプル (Ctrl+Cで終了してください。)
rem 
@echo off
:LOOP
	echo loop
rem	timeout /t 1
rem	ping -n 1 localhost
goto :LOOP


setlocal ENABLEDELAYEDEXPANSION
set START=0
set END=100
set COUNTER=0
for /l %%H in (%START% , 1 ,%END%) do (
	set /a COUNTER=COUNTER+1
echo	!COUNTER!
)


exit /b 0

rem ********************************************************************************
rem FOR文を使う方法
rem FOR文を利用して無限ループを作ることもできます。ただし、この方法には、ループを抜け出せないという問題点があります。(後述)
rem サンプル (Ctrl+Cで終了してください。)
rem 
@echo off

for /l %%I in (0, 0, 0) do (
echo loop
)

exit /b 0


rem ********************************************************************************
rem ドライブレターのチェック
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
rem	echo %%i
	if exist %%i: (
		echo %%i: ドライブは存在する
	) else (
		echo %%i: ドライブは存在しない
	)
)


rem ********************************************************************************
rem 自ウィンドウを再帰的に呼び出して、最小化させる
echo "%~0"
echo "%~dp0.\%~nx0"
if not "%~0"=="%~dp0.\%~nx0" (
	start /min cmd /c,"%~dp0.\%~nx0" %*
	exit
)


