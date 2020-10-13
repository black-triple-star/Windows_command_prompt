rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

@echo off
cls
rem 共有ディレクトリのドライブ名を固定的に設定する
rem http://www.rimesene.co.jp/mesene/contents/tipsnt/setw04.htm


title 共有ディレクトリの設定

rem ユーザー名の指定は必須ではない
set USER_NM=%USERNAME%
set USER_NM=hoge


rem 接続する時、1。切断するとき、1以外。
set CONNECT_FLG=%1
rem MacOS X が作成した不可視ファイルを削除する時、1。
set DEL_FLG=%2


rem ========================================================================
rem 引用符でくくってはいけない。
call :CONNECT T:   \\192.168.0.12\data
rem call :CONNECT U:   \\192.168.0.7\ears-00mvwb0
rem call :CONNECT V:   \\192.168.0.7\home

goto :EOF

rem ========================================================================
:CONNECT

set SHARE_NM=%2
if %SHARE_NM:~-1%==\ (set SHARE_NM=%SHARE_NM:~0,-1%)

echo %SHARE_NM%


rem NET USE <ドライブ名> <共有名> <パスワード> /USER:<ユーザー名>
rem NET USE T: \\192.168.0.10\data hohoho /USER:takashi
rem NET USE T: /DELETE

if [%CONNECT_FLG%] == [] (
	rem 引数がない場合（単体で実行した場合など）、こっちを通過
	rem マウントを切り替え
	if not exist %1\nul (
		if DEFINED USER_NM (
			rem NET USE t: \\192.68.0.10\data /user:takashi を発行する
			NET USE %1 %SHARE_NM% /USER:%USER_NM% /PERSISTENT:NO
		) ELSE (
			NET USE %1 %SHARE_NM% /PERSISTENT:NO
		)
	) else (
		echo %1 はマウント中です。
		NET USE %1 /DELETE /Y
	)
) else (
	rem 引数がある場合、こっちを通過
	rem マウント済みかチェック
rem 	if not exist %DRIVE_LETTER%:\nul (
rem 		set CONNECT_FLG=1
rem 	) else (
rem 		set CONNECT_FLG=0
rem 	)
	IF [%CONNECT_FLG%] == [1] (
		if not exist %1\nul (
			if DEFINED USER_NM (
				rem NET USE t: \\192.68.0.10\data /user:takashi を発行する
				NET USE %1 %SHARE_NM% /USER:%USER_NM% /PERSISTENT:NO
			) ELSE (
				NET USE %1 %SHARE_NM% /PERSISTENT:NO
			)
		) else (
			echo %1 はマウント中です。
			NET USE %1 /DELETE /Y
		)
		if [%DEL_FLG%] == [1] (
			echo DS_Store の削除中
			for /f "delims=" %%I in ('dir /s /a /b "%1\.DS_Store"') do (
				del /f /q /a "%%I"
			)
			
			echo 2EDS_~!3 の削除中
			for /f "delims=" %%I in ('dir /s /a /b "%1\2EDS_~!3"') do (
				del /f /q /a "%%I"
			)
		)
	) ELSE (
		if not exist %1\nul (
			echo %1 はマウントされていません。
		) else (
	rem		NET USE %1 /DELETE
			NET USE %1 /DELETE /Y
		)
	)
)
goto :EOF

rem MacOS X が作成した不可視ファイルを削除
rem attrib /s -h ".DS_Store"
rem del /f /s /q ".DS_Store"
rem attrib /s -h "2EDS_~!3"
rem del /f /s /q "2EDS_~!3"
