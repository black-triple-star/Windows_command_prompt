rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932


@echo off
cls

setlocal ENABLEDELAYEDEXPANSION

rem �p�\�R�����m�Œ��ڃt�@�C�����L���s���ׂ̐ݒ�

rem set SHARE_NAME=WORK
rem ���O�C�����Ă��郆�[�U�[�����Z�b�g
for /f "tokens=* usebackq" %%i in (`whoami`) do (set USER_NAME=%%i)
rem %%i �� ) �̊ԂɃX�y�[�X�����Ă͂����Ȃ��B�X�y�[�X���ϐ��Ɋi�[����Ă��܂�
echo %USER_NAME%
cls

rem http://www.atmarkit.co.jp/ait/articles/0609/09/news020.html
rem ���݂̋��L�̈ꗗ������
net share



rem if [%MODE%] == [] (
if not defined MODE (
	rem ������n���ċN�����邽�߂ɂ���if�����t���Ă���
	echo ###############################
	echo ���L����ꍇ	1
	echo ���L����������ꍇ	1�ȊO
	echo ###############################
	set /p MODE=">"
)

IF /i [%MODE%] == [1] (
	echo on
	rem /grant �I�v�V������t���Ȃ���everyone , full�A�N�Z�X�ƂȂ�̂Œ���
	rem #############################################################################
	set SHARE_DIR=C:\WORK
	set SHARE_NAME=WORK
	echo !SHARE_DIR!
	net share !SHARE_NAME!=!SHARE_DIR!  /cache:none   /GRANT:!USER_NAME!,full
	rem #############################################################################
) else (
	rem ���L����������
	set SHARE_NAME=WORK
	net share !SHARE_NAME! /delete
)

rem ���݂̋��L�̈ꗗ������
net share

@echo off
pause>nul


