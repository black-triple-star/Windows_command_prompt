rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
rem chcp 1200 & rem "UTF-16"
chcp 65001 & rem "UTF-8"
chcp 932 & rem "CP932"
rem chcp 65001 ����ƁArem �� echo �������������邱�Ƃ�����B���̏ꍇ�A��d���p���ň͂߂΂悢�B

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


@echo  off
cls

set CHECK_OBJ=C:\temp\photos
set CHECK_OBJ=C:\temp\photos2
rem set CHECK_OBJ=C:\temp\PowerToys.URL
set CHECK_OBJ=C:\temp\PowerToys2.URL
set CHECK_OBJ=C:\LibreOffice
set CHECK_OBJ=C:\temp\youtube_dl_list.txt
set CHECK_OBJ=C:\temp\������\���₫��46 - ����ł������Ă�.mp4
echo %CHECK_OBJ%


rem ************************************************************************************************

setlocal enabledelayedexpansion
rem && �̑O�ɃX�y�[�X�����Ă͂����Ȃ��B�X�y�[�X���ϐ��Ɋi�[����Ă��܂�
for /f "tokens=* usebackq" %i in (`echo %CHECK_OBJ%`) do (set FILE_DIR=%~dpi&& set FILE_NM=%~nxi)
rem �p�X�̍Ō�ɂ���\�}�[�N�����������B�i�p�X�̍Ō��\�}�[�N������Ɠ��삵�Ȃ��R�}���h������j
if "%FILE_DIR:~-1%"=="\" (set FILE_DIR=%FILE_DIR:~0,-1%)
echo %FILE_DIR%
echo %FILE_NM%
rem �f�B���N�g���A�V���{���b�N�����N�Ȃ�A<DIR> ,  <SYMLINKD> ���\�������A�t�@�C���Ȃ�t�@�C���T�C�Y���Ԃ��Ă���B
rem �t�@�C�����A�f�B���N�g�����A�V���{���b�N�����N���ɃX�y�[�X���܂܂��ꍇ�A���삵�Ȃ��Ƃ����v���I�Ȍ��ׂ�����B
for /f "tokens=1,2,3,4 usebackq" %i in (`dir %FILE_DIR%`) do ( if [%~l]==[%FILE_NM%] ( echo %~k) )
pause

rem ************************************************************************************************
rem �f�B���N�g�����t�@�C�������`�F�b�N������@
rem	dir !FILE_PATH!\!FILE_NAME!!FILE_EXT! 2>nul | %systemroot%\SysWOW64\find /i "<DIR>          .."  >NUL
dir "%CHECK_OBJ%" 2>nul | %systemroot%\SysWOW64\find /i "<DIR>          .."  >NUL
rem errorlevel�Ŕ��ʂ��Ă��邽�߁A�����ɐV���ȃR�}���h�����Ă͂����Ȃ�
if not errorlevel 1 (
	echo �f�B���N�g��
) else (
	rem �V���{���b�N�����N���������ɓ���
	rem ���݂��Ȃ��ꍇ�Aelse�ɓ����Ă��܂�
	echo �t�@�C��
)
pause

rem ************************************************************************************************
rem �f�B���N�g�����t�@�C�������`�F�b�N������@
setlocal ENABLEDELAYEDEXPANSION
if exist "%CHECK_OBJ%" (
	if exist "%CHECK_OBJ%\*" (
		echo �f�B���N�g��
rem		cd  /d   "%CHECK_OBJ%"
	) else (
		echo �t�@�C��
rem		for /f "tokens=* usebackq" %%i in (`echo "%CHECK_OBJ%"`) do (set FILE_DIR=%%~dpi)
rem		cd  /d   !FILE_DIR!
	)
) else (
	echo ���݂��Ȃ�
)
pause

rem ��s�ŏ����Ƃ����Ȃ�
if exist "%CHECK_OBJ%" (if exist "%CHECK_OBJ%\*" (set CHECK_OBJ=�f�B���N�g��) else (set CHECK_OBJ=�t�@�C��)) else (set CHECK_OBJ=���݂��Ȃ�)
echo %CHECK_OBJ%

pause

rem �������̓_���A���݂��Ȃ��ꍇ�Aelse�ɓ����Ă��܂�
if exist "%CHECK_OBJ%\*" (
	echo �f�B���N�g��
) else (
	rem ���݂��Ȃ��ꍇ�Aelse�ɓ����Ă��܂�
	echo �t�@�C��
)
pause

rem \* �����Ȃ��ƁA�t�@�C�����f�B���N�g�����ǂ�������v����
if exist "%CHECK_OBJ%" (
	echo �t�@�C��
)
pause
rem ************************************************************************************************

