rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem 「タイトル バーに完全なパスを表示する」の切り替え
rem レジストリの編集結果は、GUIでの操作結果（エクスプローラーの「フォルダー オプション」の捜査結果）と同じだが、フルパスが表示されない
rem OSを再起動すれば反映される

reg ADD %ShellFolders% /v "FullPath" /t REG_DWORD /d "1" /f


rem rem トグルできないのでここから下を実行しない。
rem rem "https://automationlabo.com/wat/?p=1954"
rem rem reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d "1" /f
rem rem reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d "0" /f
rem 
rem 
rem @echo off
rem cls
rem 
rem set ShellFolders=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState
rem for /f "usebackq tokens=3 delims=	 " %%i in (`reg query "%ShellFolders%" /v "FullPath"`) do (@set WHICH=%%i)
rem echo %WHICH%
rem 
rem 
rem if "%WHICH%" == "0x1" (
rem 	set VALUE=0
rem ) else (
rem 	set VALUE=1
rem )
rem 
rem reg ADD %ShellFolders% /v "FullPath" /t REG_DWORD /d "%VALUE%" /f
rem 
rem 
rem 
