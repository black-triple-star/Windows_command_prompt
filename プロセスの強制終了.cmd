rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem �v���Z�X�̋����I��

@echo off
cls

echo %cd%
echo %~dp0

set EXE_NM=AutoHotkey.exe
rem v1.1.07
set EXE_NM=AutoHotkey_2017-0302.exe
set EXE_NM=AutoHotkeyU64_v1.1.32.exe
set EXE_NM=AutoHotkeyU64_v1.1.33.02.exe

rem exe�̖��̂�25byte �𒴂����tasklist�ŕ\���ł��Ȃ��̂ŁAfindstr �ׂ̈ɁA25byte��substring���Ă���
set PROCESS_NM=%EXE_NM:~0,25%

echo %PROCESS_NM%


tasklist /FI "IMAGENAME eq %EXE_NM%" | findstr /i "%PROCESS_NM%"
if errorlevel 1 (
	rem �N�����Ă��Ȃ�
) else (
	rem �N���ς݂̏ꍇ�A�I������B
	taskkill /f /im "%EXE_NM%"
)

rem �ċN������ꍇ�A������L���ɂ���
rem start /b %ComSpec% /c start /high %~dp0%EXE_NM%

