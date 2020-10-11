rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem ファイル・ディレクトリの履歴を作る。
rem ファイル・ディレクトリをこのcmdファイルにドラッグアンドドロップしてください。
rem その際、$HISTORY\ファイル名　というディレクトリを作り、その中に「ファイル名_そのファイルの保存日時」をコピーします。
rem 
rem 例
rem C:\temp\新しいテキスト ドキュメント.txt  を以下のファイルにコピーします。
rem C:\temp\$HISTORY\新しいテキスト ドキュメント.txt\新しいテキスト ドキュメント_20200912_1851.txt

rem コマンドプロンプトの制約上、ファイル名にカッコなどがあると動作しません。

@echo off
cls

chcp 932

rem ディレクトリ・ファイルの履歴を作る。Windows 2000,XP,Vista,7 用
rem ディレクトリ・ファイルをまるごとコピーして日付と時間をつける
rem ディレクトリ・ファイル兼用（ワイルドカード不可）
rem UNC 対応 （一時的にZドライブにマップする）

if [%1] == [] (
	echo ファイルまたはディレクトリをドラッグアンドドロップしてください。
	echo 終了します。
	pause>nul
)

rem 履歴を保存するディレクトリの接尾辞(アンダーバーは不要)
set HISTORY=$HISTORY
rem 上記接尾辞を接頭辞として使う場合は１、そうでない場合は０
set USE_AS_PREFIX=1
rem 履歴ファイル・ディレクトリを不可視にする場合は１、そうでない場合は０
set INVISIBLE=0
rem 圧縮しない場合は0、zipで圧縮する場合は1 , 7zipで圧縮する場合は2
set COMPRESS=0
rem 履歴数を設定する場合、その数を入力、全部保存する場合、0
set HISTORY_NUM=0
rem %temp% に、履歴ファイルの複製を作る場合は1、そうでない場合は０
set DUPLICATE=0
setlocal ENABLEDELAYEDEXPANSION

rem ###########################################################################

rem zipコマンド http://www.info-zip.org/pub/infozip/Zip.html#Win32
rem フルパスにでコールするとまともに動作しないので、PATHの設定をしておく
rem set PATH=%PATH%;%programfiles%;C:\bin;C:\bin\archiver
set PATH=%PATH%;%programfiles%;%~dp0;%~dp0archiver

set ZIP="zip.exe"
rem zip圧縮でも7zipのexeの方が圧縮率が高いので、こっちにする
rem http://www.7-zip.org/download.html
rem http://downloads.sourceforge.net/sevenzip/7za465.zip
set ZIP=7za.exe
set SEVEN_ZIP=7za.exe
set ZIP=C:\bin64\archiver\7z.exe
set SEVEN_ZIP=C:\bin64\archiver\7z.exe

rem UNCパスのファイルの履歴を作成する場合、ディレクトリを一時的にZドライブに割り当てる
set TEMP_DRIVE=Z:

rem ＜圧縮例＞
rem 7za.exe a -tzip "圧縮ファイル名.zip" "圧縮対象ディレクトリ|ファイル"
rem 7za.exe a -t7z "圧縮ファイル名.7z" "圧縮対象ディレクトリ|ファイル"
rem ＜解凍例＞
rem 7za.exe x "圧縮ファイル名.7z"

if [%COMPRESS%] == [1] (
rem 	%SEVEN_ZIP%
rem 	IF ERRORLEVEL 1 (
rem 		echo %SEVEN_ZIP% が見つからないので、終了します。
rem 		pause>nul
rem 		exit
rem 	) else (
rem 		rem 存在すれば、表示はいらないので、クリアする
rem 		cls
rem 	)
	if not exist "%SEVEN_ZIP%" (
		echo %SEVEN_ZIP% が見つからないので、終了します。
		pause>nul
		exit
	)
)

if [%COMPRESS%] == [2] (
rem 	%SEVEN_ZIP%
rem 	IF ERRORLEVEL 1 (
rem 		echo %SEVEN_ZIP% が見つからないので、終了します。
rem 		pause>nul
rem 		exit
rem 	) else (
rem 		rem 存在すれば、表示はいらないので、クリアする
rem 		cls
rem 	)
	if not exist "%SEVEN_ZIP%" (
		echo %SEVEN_ZIP% が見つからないので、終了します。
		pause>nul
		exit
	)
)

set TIMESTAMP=a

rem ###########################################################################
rem 日付と時刻を変数に入れる
rem http://www.geocities.co.jp/SiliconValley-SanJose/1227/variable.html
rem なお正確に時刻でソートするには、コントロールパネル「地域と言語」で
rem 時刻の書式をHH:mm:ssにしなければならない。
set HOGE=%date:/=%
set FOO=%time::=%
rem ミリ秒を表示しない場合、下記コメントをはずす
rem set FOO=%FOO:~0,-3%
rem 時間の先頭にスペースがある場合、0に変えている。（例7->07）XP以降この書式が標準らしい
set DATE_TIME=%HOGE%_%FOO: =0%

rem  Windows 2000 かどうかを判定して日付の書式を変えている
VER | %systemroot%\SysWOW64\FIND /I "Microsoft Windows 2000 [Version 5.00.2195]">NUL
IF NOT ERRORLEVEL 1 (
	rem Windows 2000の場合、こっちを使う。（YYYYMMDDの先頭に曜日が入るため）
	set DATE_TIME=%HOGE:~2%_%FOO: =0%
)

rem ###########################################################################
set /a COUNTER=0

rem  echo %%V
rem  echo 対象ファイル %%V
rem  echo Path    = %%~pV
rem  echo Name    = %%~nV
rem  echo Ext     = %%~xV
rem  echo Path    = %%~dpnV

rem ドラッグアンドドロップ版
for /d %%V in (%*) do  (
	set /a COUNTER=!COUNTER!+1
	rem バックアップ対象のディレクトリ又はファイルが見つからない場合、エラー
	IF NOT EXIST %%V (
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
		rem ドラッグアンドドロップ＆ディレクトリの場合
		IF %USE_AS_PREFIX% == 1 (
			rem ディレクトリ名を「HISTORY_履歴作成対象」とする場合
			call :COPY_DIR "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME!\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "..\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
		) ELSE (
			rem ディレクトリ名を「履歴作成対象_HISTORY」とする場合
			call :COPY_DIR "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\!FILE_NAME!_%HISTORY%\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "..\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
		)
	) else (
		rem ドラッグアンドドロップ＆ファイルの場合
		IF %USE_AS_PREFIX% == 1 (
			rem ファイル名を「HISTORY_履歴作成対象」とする場合
			rem 保存場所は 「$HISTORY\ファイル名」である。これだとディレクトリ名がファイル名と一緒なので、同じ階層にファイルの移動が出来ない。
rem			call :COPY_FILE "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
			rem 保存場所を 「$HISTORY\ファイル名.d」にした。
			call :COPY_FILE "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!.d" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!.d\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
		) ELSE (
			rem ファイル名を「履歴作成対象_HISTORY」とする場合
			call :COPY_FILE "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\!FILE_NAME!!FILE_EXT!_%HISTORY%" "!FILE_PATH!\!FILE_NAME!!FILE_EXT!_%HISTORY%\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
		)
	)
)

rem メール添付して顧客に送る際のファイル名の一意性を担保したコピーが%temp%にあるので、開く
rem start /b %systemroot%\EXPLORER.EXE /n,/e,"%temp%"
echo.
echo.
echo ###################################################
if exist %TEMP_DRIVE%\nul ( NET USE %TEMP_DRIVE% /DELETE /Y)

goto :EOF

rem ##########################################################################
rem ##########################################################################
:COPY_DIR

rem 第1引数 履歴作成対象ディレクトリ
rem 第2引数 履歴作成対象ディレクトリを置くディレクトリ
rem 第3引数 履歴作成対象ディレクトリの圧縮ファイル名

rem @echo on
rem echo %1
rem echo %2
echo %3

IF NOT EXIST %1 (
	goto :Err
)

IF NOT EXIST %2 (
	mkdir %2
)

rem xcopy /eydhr %1 %2

rem #################################################################
rem excludeリストの作成
if exist %temp%\exclude.txt ( del /f /q %temp%\exclude.txt )
echo $~>>"%temp%\exclude.txt"
echo ~$>>"%temp%\exclude.txt"
echo ~WRL>>"%temp%\exclude.txt"
echo .lnk>>"%temp%\exclude.txt"
echo .tmp>>"%temp%\exclude.txt"
echo .temp>>"%temp%\exclude.txt"
echo .bkf>>"%temp%\exclude.txt"
echo Thumbs.db>>"%temp%\exclude.txt"
echo pagefile.sys>>"%temp%\exclude.txt"
echo win386.swp>>"%temp%\exclude.txt"
rem KNIME用
echo \internal>>"%temp%\exclude.txt"
echo \port_>>"%temp%\exclude.txt"
rem VMSのvdtファイルのうち、mod , modlistと対応してないvdtファイルを除外する
rem mod , modlistと対応しているvdtファイルは、各種予測モデルの結果そのものであるので、バックアップ対象に含める必要がある
set PREV_PATH=%CD%
cd /d "%1"
for /f "delims=" %%V in ('dir /b /o-d *.vdt ^| sort') do (
rem	echo %%~nV.mod*
	if exist %%~nV.mod* (
		echo %%V　は、xcopyする
	) else (
		echo %%V　は、xcopyしない
		echo %%V>>"%temp%\exclude.txt"
	)
)
cd /d "%PREV_PATH%"

xcopy /EXCLUDE:%temp%\exclude.txt /eydhr %1 %2

rem excludeリストの除去
del /f /q %temp%\exclude.txt
rem #################################################################

if [%COMPRESS%] == [0] (
	rem 念のため読み取り専用にする
	attrib /D /S +R %2\*
	attrib /D /S +R %2
)

rem 圧縮処理
if not [%COMPRESS%] == [0] (
	cd /d %2
	rem #################################################################
	rem zip圧縮
	if [%COMPRESS%] == [1] (
		rem 7za.exe a -tzip "圧縮ファイル名" "圧縮対象ディレクトリ"
		rem stdoutに文字を出さないようにするため、nulにリダイレクトしている
		%ZIP% a -tzip -mx9 %3 .\*
		attrib /D /S +R %3
	)
	rem 7ZIP圧縮
	if [%COMPRESS%] == [2] (
		rem 7za.exe a -t7z "圧縮ファイル名" "圧縮対象ディレクトリ"
		rem stdoutに文字を出さないようにするため、nulにリダイレクトしている
		rem %3 の名称部位のみを取り出しているため、二重引用符と..\を付与しなおした
		%SEVEN_ZIP% a -t7z -mx9 "..\%~n3.7z" .\*
		attrib /D /S +R "..\%~n3.7z"
	)
	cd /d ..
	rd /s /q %2
)

rem 保存する履歴数を超えた場合、%temp%に移動する。（削除することも可能）
if not [%HISTORY_NUM%] == [0] (
rem	echo %cd%\%HISTORY%\%~n1
	set /a COUNT=0
	cd /d %cd%\%HISTORY%\%~n1
	for /f "delims=" %%V in ('dir /b /o-d') do (
rem		echo %%V
		set /a COUNT=!COUNT!+1
		if !COUNT! GTR !HISTORY_NUM! (
rem			echo "%%V"
			move /y "%%V" "%temp%"
rem			rmdir /s /q "%%V"
		)
	)
)

rem 不可視にする
if [%INVISIBLE%] == [1] (
	attrib +H %1
) else (
	attrib -H %1
)
rem 履歴作成結果を見る場合
rem start /b %systemroot%\EXPLORER.EXE /n,/e,%2

goto :EOF

rem ##########################################################################
rem ##########################################################################
:COPY_FILE
rem 第1引数 履歴作成対象ファイル
rem 第2引数 履歴作成対象ファイルを置くディレクトリ
rem 第3引数 履歴作成対象ファイルのテンポラリ（圧縮のためのファイル）
rem 第4引数 履歴作成対象ファイルの圧縮ファイル名

rem @echo on
echo %1
echo %2
echo %3
echo %~nx3
echo %4

IF NOT EXIST %1 (
	goto :Err
)

rem ショートカットの履歴は作成しない
if /i [%~x1] == [.lnk] (goto :Eof)
if /i [%~x1] == [.url] (goto :Eof)

rem なぜこのコマンドを書いたのか覚えていない
rem attrib /S /D -H %1

rem 履歴作成対象ファイルを置くディレクトリを作成
IF NOT EXIST %2 (
	mkdir %2
)

rem echo "%~1"
rem echo "%~2"
rem echo "%~3"
rem 保存時点での履歴が作成済みの場合、抜ける。
if exist %3 (
	echo この更新日時での履歴が作成済みなので、処理を終了します
	goto :EOF
)

rem 履歴作成のためのコピーを実行
copy /y %1 %3

rem メール添付して顧客に送る際の、ファイル名の一意性を担保するためにコピー。（%temp%　なら開きやすいので）
if [%DUPLICATE%] == [1] (
	copy /y %3 "%temp%"
)

rem 元々圧縮しているため、これ以上圧縮しても意味が無い、或いは単に圧縮したくない場合、ここに記述する
set EXEC_FLG=1
if /i [%~x2] == [.r] (set EXEC_FLG=0)
if /i [%~x2] == [.cmd] (set EXEC_FLG=0)
if /i [%~x2] == [.bat] (set EXEC_FLG=0)
if /i [%~x2] == [.zip] (set EXEC_FLG=0)
if /i [%~x2] == [.kdb] (set EXEC_FLG=0)
if /i [%~x2] == [.str] (set EXEC_FLG=0)
if /i [%~x2] == [.str-] (set EXEC_FLG=0)
if /i [%~x2] == [.xmind] (set EXEC_FLG=0)
if /i [%~x2] == [.py] (set EXEC_FLG=0)
rem if /i [%~x2] == [.doc] (set EXEC_FLG=0)
rem if /i [%~x2] == [.ppt] (set EXEC_FLG=0)
rem if /i [%~x2] == [.xls] (set EXEC_FLG=0)
rem office 2007のファイルはxmlなどをzip圧縮したものらしい
if /i [%~x2] == [.docx] (set EXEC_FLG=0)
if /i [%~x2] == [.pptx] (set EXEC_FLG=0)
if /i [%~x2] == [.xlsx] (set EXEC_FLG=0)
rem 再度、変数COMPRESSを設定しなおす
set /a COMPRESS=%COMPRESS% * %EXEC_FLG%

if [%COMPRESS%] == [0] (
	rem 念のため読み取り専用にする
	attrib /D /S +R %3
)
rem 圧縮処理
if not [%COMPRESS%] == [0] (
	cd /d %2
	rem #################################################################
	rem zip圧縮
	if [%COMPRESS%] == [1] (
		rem 7za.exe a -tzip "c:\temp\test.zip" "7-zip.chm"
		rem stdoutに文字を出さないようにするため、nulにリダイレクトしている
		%ZIP% a -tzip -mx9  %4 "%~nx3"
		attrib /D /S +R %4
	)
	rem 7ZIP圧縮
	if [%COMPRESS%] == [2] (
		rem 7za.exe a -t7z "c:\temp\test.7z" "7-zip.chm"
		rem stdoutに文字を出さないようにするため、nulにリダイレクトしている
		rem %4 の名称部位のみを取り出しているため、二重引用符を付与しなおした
		%SEVEN_ZIP% a -t7z -mx9 "%~n4.7z" "%~nx3"
		attrib /D /S +R "%~n4.7z"
	)
	rem 他の圧縮処理
rem	if [%COMPRESS%] == [3] (
	rem 他の圧縮処理
rem	)
	del /f /q %3
)

rem 保存する履歴数を超えた場合、%temp%に移動する。（削除することも可能）
if not [%HISTORY_NUM%] == [0] (
	cd /d %2
	set /a COUNT=0
	for /f "delims=" %%V in ('dir /b /o-d') do (
rem		echo %%V
		set /a COUNT=!COUNT!+1
		if !COUNT! GTR !HISTORY_NUM! (
			move /y "%%V" "%temp%"
rem			del /f /q "%%V"
		)
rem	pause
	)
)

rem 不可視にする
if [%INVISIBLE%] == [1] (
	attrib +H %2
) else (
	attrib -H %2
)

rem 履歴作成結果を見る場合
rem start /b %systemroot%\EXPLORER.EXE /n,/e,%2

goto :EOF


rem ##########################################################################
rem ##########################################################################
:Err
echo ###############################################################
echo バックアップの対象あるいはバックアップの保存先が見つかりません。
echo コマンドプロンプトの関係上、^, ^& ^( ^) などがファイル名に含まれていると動作しません
echo ###############################################################
PAUSE>NUL
