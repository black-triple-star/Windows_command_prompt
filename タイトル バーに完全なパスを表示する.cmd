rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem �u�^�C�g�� �o�[�Ɋ��S�ȃp�X��\������v�̐؂�ւ�

rem "https://automationlabo.com/wat/?p=1954"
rem reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d "1" /f
rem reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d "0" /f


@echo off
cls

set ShellFolders=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState
for /f "usebackq tokens=3 delims=	 " %%i in (`reg query "%ShellFolders%" /v "FullPath"`) do (@set WHICH=%%i)
echo %WHICH%


if "%WHICH%" == "0x1" (
	set VALUE=0
) else (
	set VALUE=1
)

reg ADD %ShellFolders% /v "FullPath" /t REG_DWORD /d "%VALUE%" /f



