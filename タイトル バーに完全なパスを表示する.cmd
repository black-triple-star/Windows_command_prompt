rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem �u�^�C�g�� �o�[�Ɋ��S�ȃp�X��\������v�̐؂�ւ�
rem ���W�X�g���̕ҏW���ʂ́AGUI�ł̑��쌋�ʁi�G�N�X�v���[���[�́u�t�H���_�[ �I�v�V�����v�̑{�����ʁj�Ɠ��������A�t���p�X���\������Ȃ�
rem OS���ċN������Δ��f�����

reg ADD %ShellFolders% /v "FullPath" /t REG_DWORD /d "1" /f


rem rem �g�O���ł��Ȃ��̂ł������牺�����s���Ȃ��B
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
