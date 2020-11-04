rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932


rem Windowsの隠し属性の切り替え
rem XPではうまく動作しない・・・

@echo off
cls

rem http://golorih.exblog.jp/11461370/
set ShellFolders=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
rem for /f "usebackq tokens=*" %%i in (`reg query "%ShellFolders%" /v Hidden`) do (@set WHICH=%%i)
for /f "usebackq tokens=3 delims=	 " %%i in (`reg query "%ShellFolders%" /v Hidden`) do (@set WHICH=%%i)
echo %WHICH%

if "%WHICH%" == "0x1" (
	rem 通常の隠しファイル属性
	set Hidden_VALUE=2
	rem 保護されたOSのシステムファイルの表示設定
	set ShowSuperHidden_VALUE=0
) else (
	rem 通常の隠しファイル属性
	set Hidden_VALUE=1
	rem 保護されたOSのシステムファイルの表示設定
	set ShowSuperHidden_VALUE=1
)

rem http://journal.mycom.co.jp/column/winxp/014/index.html
rem reg ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer /v ThumbnailSize /t REG_DWORD
reg ADD %ShellFolders% /f /v Hidden /t REG_DWORD /d %Hidden_VALUE%

reg ADD %ShellFolders% /f /v ShowSuperHidden /t REG_DWORD /d %ShowSuperHidden_VALUE%
