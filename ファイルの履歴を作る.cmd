rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem �t�@�C���E�f�B���N�g���̗��������B
rem �t�@�C���E�f�B���N�g��������cmd�t�@�C���Ƀh���b�O�A���h�h���b�v���Ă��������B
rem ���̍ہA$HISTORY\�t�@�C�����@�Ƃ����f�B���N�g�������A���̒��Ɂu�t�@�C����_���̃t�@�C���̕ۑ������v���R�s�[���܂��B
rem 
rem ��
rem C:\temp\�V�����e�L�X�g �h�L�������g.txt  ���ȉ��̃t�@�C���ɃR�s�[���܂��B
rem C:\temp\$HISTORY\�V�����e�L�X�g �h�L�������g.txt\�V�����e�L�X�g �h�L�������g_20200912_1851.txt

rem �R�}���h�v�����v�g�̐����A�t�@�C�����ɃJ�b�R�Ȃǂ�����Ɠ��삵�܂���B

@echo off
cls

chcp 932

rem �f�B���N�g���E�t�@�C���̗��������BWindows 2000,XP,Vista,7 �p
rem �f�B���N�g���E�t�@�C�����܂邲�ƃR�s�[���ē��t�Ǝ��Ԃ�����
rem �f�B���N�g���E�t�@�C�����p�i���C���h�J�[�h�s�j
rem UNC �Ή� �i�ꎞ�I��Z�h���C�u�Ƀ}�b�v����j

if [%1] == [] (
	echo �t�@�C���܂��̓f�B���N�g�����h���b�O�A���h�h���b�v���Ă��������B
	echo �I�����܂��B
	pause>nul
)

rem ������ۑ�����f�B���N�g���̐ڔ���(�A���_�[�o�[�͕s�v)
set HISTORY=$HISTORY
rem ��L�ڔ�����ړ����Ƃ��Ďg���ꍇ�͂P�A�����łȂ��ꍇ�͂O
set USE_AS_PREFIX=1
rem �����t�@�C���E�f�B���N�g����s���ɂ���ꍇ�͂P�A�����łȂ��ꍇ�͂O
set INVISIBLE=0
rem ���k���Ȃ��ꍇ��0�Azip�ň��k����ꍇ��1 , 7zip�ň��k����ꍇ��2
set COMPRESS=0
rem ���𐔂�ݒ肷��ꍇ�A���̐�����́A�S���ۑ�����ꍇ�A0
set HISTORY_NUM=0
rem %temp% �ɁA�����t�@�C���̕��������ꍇ��1�A�����łȂ��ꍇ�͂O
set DUPLICATE=0
setlocal ENABLEDELAYEDEXPANSION

rem ###########################################################################

rem zip�R�}���h http://www.info-zip.org/pub/infozip/Zip.html#Win32
rem �t���p�X�ɂŃR�[������Ƃ܂Ƃ��ɓ��삵�Ȃ��̂ŁAPATH�̐ݒ�����Ă���
rem set PATH=%PATH%;%programfiles%;C:\bin;C:\bin\archiver
set PATH=%PATH%;%programfiles%;%~dp0;%~dp0archiver

set ZIP="zip.exe"
rem zip���k�ł�7zip��exe�̕������k���������̂ŁA�������ɂ���
rem http://www.7-zip.org/download.html
rem http://downloads.sourceforge.net/sevenzip/7za465.zip
set ZIP=7za.exe
set SEVEN_ZIP=7za.exe
set ZIP=C:\bin64\archiver\7z.exe
set SEVEN_ZIP=C:\bin64\archiver\7z.exe

rem UNC�p�X�̃t�@�C���̗������쐬����ꍇ�A�f�B���N�g�����ꎞ�I��Z�h���C�u�Ɋ��蓖�Ă�
set TEMP_DRIVE=Z:

rem �����k�၄
rem 7za.exe a -tzip "���k�t�@�C����.zip" "���k�Ώۃf�B���N�g��|�t�@�C��"
rem 7za.exe a -t7z "���k�t�@�C����.7z" "���k�Ώۃf�B���N�g��|�t�@�C��"
rem ���𓀗၄
rem 7za.exe x "���k�t�@�C����.7z"

if [%COMPRESS%] == [1] (
rem 	%SEVEN_ZIP%
rem 	IF ERRORLEVEL 1 (
rem 		echo %SEVEN_ZIP% ��������Ȃ��̂ŁA�I�����܂��B
rem 		pause>nul
rem 		exit
rem 	) else (
rem 		rem ���݂���΁A�\���͂���Ȃ��̂ŁA�N���A����
rem 		cls
rem 	)
	if not exist "%SEVEN_ZIP%" (
		echo %SEVEN_ZIP% ��������Ȃ��̂ŁA�I�����܂��B
		pause>nul
		exit
	)
)

if [%COMPRESS%] == [2] (
rem 	%SEVEN_ZIP%
rem 	IF ERRORLEVEL 1 (
rem 		echo %SEVEN_ZIP% ��������Ȃ��̂ŁA�I�����܂��B
rem 		pause>nul
rem 		exit
rem 	) else (
rem 		rem ���݂���΁A�\���͂���Ȃ��̂ŁA�N���A����
rem 		cls
rem 	)
	if not exist "%SEVEN_ZIP%" (
		echo %SEVEN_ZIP% ��������Ȃ��̂ŁA�I�����܂��B
		pause>nul
		exit
	)
)

set TIMESTAMP=a

rem ###########################################################################
rem ���t�Ǝ�����ϐ��ɓ����
rem http://www.geocities.co.jp/SiliconValley-SanJose/1227/variable.html
rem �Ȃ����m�Ɏ����Ń\�[�g����ɂ́A�R���g���[���p�l���u�n��ƌ���v��
rem �����̏�����HH:mm:ss�ɂ��Ȃ���΂Ȃ�Ȃ��B
set HOGE=%date:/=%
set FOO=%time::=%
rem �~���b��\�����Ȃ��ꍇ�A���L�R�����g���͂���
rem set FOO=%FOO:~0,-3%
rem ���Ԃ̐擪�ɃX�y�[�X������ꍇ�A0�ɕς��Ă���B�i��7->07�jXP�ȍ~���̏������W���炵��
set DATE_TIME=%HOGE%_%FOO: =0%

rem  Windows 2000 ���ǂ����𔻒肵�ē��t�̏�����ς��Ă���
VER | %systemroot%\SysWOW64\FIND /I "Microsoft Windows 2000 [Version 5.00.2195]">NUL
IF NOT ERRORLEVEL 1 (
	rem Windows 2000�̏ꍇ�A���������g���B�iYYYYMMDD�̐擪�ɗj�������邽�߁j
	set DATE_TIME=%HOGE:~2%_%FOO: =0%
)

rem ###########################################################################
set /a COUNTER=0

rem  echo %%V
rem  echo �Ώۃt�@�C�� %%V
rem  echo Path    = %%~pV
rem  echo Name    = %%~nV
rem  echo Ext     = %%~xV
rem  echo Path    = %%~dpnV

rem �h���b�O�A���h�h���b�v��
for /d %%V in (%*) do  (
	set /a COUNTER=!COUNTER!+1
	rem �o�b�N�A�b�v�Ώۂ̃f�B���N�g�����̓t�@�C����������Ȃ��ꍇ�A�G���[
	IF NOT EXIST %%V (
		echo "%%~V" �����݂��܂���
		echo �R�}���h�v�����v�g�̊֌W��A^, ^& ^( ^) �Ȃǂ��t�@�C�����Ɋ܂܂�Ă���Ɠ��삵�܂���
		goto :Err
	)
	set FULL_FILE_NAME=%%~V
	set FILE_PATH=%%~dpV
	if !FILE_PATH:~-1!==\ (set FILE_PATH=!FILE_PATH:~0,-1!)
	set FILE_NAME=%%~nV
	set FILE_EXT=%%~xV
	set FILE_NAME_EXT=%%~nxV
	set FILE_PATHNAME=%%~dpnV
	rem UNC���ǂ����̔���p
	set TWO_CHAR=!FULL_FILE_NAME:~0,2!
rem echo !FULL_FILE_NAME!
rem echo !FILE_PATH!
rem echo !FILE_NAME!
rem echo !FILE_EXT!
rem echo !FILE_PATHNAME!
rem	echo !TWO_CHAR!
rem echo !COUNTER!
	
rem ������skip�����UNC�Ή��O�Ɠ�������ƂȂ�
	rem UNC ����1��ڂ̂� UNC�p�X�� Z �h���C�u�ɂ���
	if [!TWO_CHAR!]==[\\] if !COUNTER! == 1 (
		echo UNC
		if exist %TEMP_DRIVE%\nul ( NET USE %TEMP_DRIVE% /DELETE /Y)
		NET USE %TEMP_DRIVE% "!FILE_PATH!" /PERSISTENT:NO
	)
	if [!TWO_CHAR!]==[\\] (
		set FILE_PATH=%TEMP_DRIVE%
rem		echo !FILE_PATH!
	)
rem skip�́A�����܂ŁB
rem		�����쐬���̓����ł͂Ȃ��A�t�@�C���E�f�B���N�g���X�V���̓�����ڔ����ɂ���
	rem echo %%~tV
	set TIMESTAMP=%%~tV
	set TIMESTAMP=!TIMESTAMP:/=!
	set TIMESTAMP=!TIMESTAMP::=!
	set TIMESTAMP=!TIMESTAMP: =_!
rem	echo !TIMESTAMP!
	
	rem �������Q�l�ɂ��āA�f�B���N�g���ƃt�@�C���̎�������
	rem http://www.atmarkit.co.jp/fwin2k/operation/command003/command2.html
rem	dir %%V 2>nul | %systemroot%\SysWOW64\find /i "<DIR>          .."  >NUL
	dir !FILE_PATH!\!FILE_NAME!!FILE_EXT! 2>nul | %systemroot%\SysWOW64\find /i "<DIR>          .."  >NUL
	rem errorlevel�Ŕ��ʂ��Ă��邽�߁A�����ɐV���ȃR�}���h�����Ă͂����Ȃ�
	if not errorlevel 1 (
		rem �h���b�O�A���h�h���b�v���f�B���N�g���̏ꍇ
		IF %USE_AS_PREFIX% == 1 (
			rem �f�B���N�g�������uHISTORY_�����쐬�Ώہv�Ƃ���ꍇ
			call :COPY_DIR "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME!\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "..\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
		) ELSE (
			rem �f�B���N�g�������u�����쐬�Ώ�_HISTORY�v�Ƃ���ꍇ
			call :COPY_DIR "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\!FILE_NAME!_%HISTORY%\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "..\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
		)
	) else (
		rem �h���b�O�A���h�h���b�v���t�@�C���̏ꍇ
		IF %USE_AS_PREFIX% == 1 (
			rem �t�@�C�������uHISTORY_�����쐬�Ώہv�Ƃ���ꍇ
			rem �ۑ��ꏊ�� �u$HISTORY\�t�@�C�����v�ł���B���ꂾ�ƃf�B���N�g�������t�@�C�����ƈꏏ�Ȃ̂ŁA�����K�w�Ƀt�@�C���̈ړ����o���Ȃ��B
rem			call :COPY_FILE "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
			rem �ۑ��ꏊ�� �u$HISTORY\�t�@�C����.d�v�ɂ����B
			call :COPY_FILE "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!.d" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!.d\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
		) ELSE (
			rem �t�@�C�������u�����쐬�Ώ�_HISTORY�v�Ƃ���ꍇ
			call :COPY_FILE "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\!FILE_NAME!!FILE_EXT!_%HISTORY%" "!FILE_PATH!\!FILE_NAME!!FILE_EXT!_%HISTORY%\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
		)
	)
)

rem ���[���Y�t���Čڋq�ɑ���ۂ̃t�@�C�����̈�Ӑ���S�ۂ����R�s�[��%temp%�ɂ���̂ŁA�J��
rem start /b %systemroot%\EXPLORER.EXE /n,/e,"%temp%"
echo.
echo.
echo ###################################################
if exist %TEMP_DRIVE%\nul ( NET USE %TEMP_DRIVE% /DELETE /Y)

goto :EOF

rem ##########################################################################
rem ##########################################################################
:COPY_DIR

rem ��1���� �����쐬�Ώۃf�B���N�g��
rem ��2���� �����쐬�Ώۃf�B���N�g����u���f�B���N�g��
rem ��3���� �����쐬�Ώۃf�B���N�g���̈��k�t�@�C����

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
rem exclude���X�g�̍쐬
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
rem KNIME�p
echo \internal>>"%temp%\exclude.txt"
echo \port_>>"%temp%\exclude.txt"
rem VMS��vdt�t�@�C���̂����Amod , modlist�ƑΉ����ĂȂ�vdt�t�@�C�������O����
rem mod , modlist�ƑΉ����Ă���vdt�t�@�C���́A�e��\�����f���̌��ʂ��̂��̂ł���̂ŁA�o�b�N�A�b�v�ΏۂɊ܂߂�K�v������
set PREV_PATH=%CD%
cd /d "%1"
for /f "delims=" %%V in ('dir /b /o-d *.vdt ^| sort') do (
rem	echo %%~nV.mod*
	if exist %%~nV.mod* (
		echo %%V�@�́Axcopy����
	) else (
		echo %%V�@�́Axcopy���Ȃ�
		echo %%V>>"%temp%\exclude.txt"
	)
)
cd /d "%PREV_PATH%"

xcopy /EXCLUDE:%temp%\exclude.txt /eydhr %1 %2

rem exclude���X�g�̏���
del /f /q %temp%\exclude.txt
rem #################################################################

if [%COMPRESS%] == [0] (
	rem �O�̂��ߓǂݎ���p�ɂ���
	attrib /D /S +R %2\*
	attrib /D /S +R %2
)

rem ���k����
if not [%COMPRESS%] == [0] (
	cd /d %2
	rem #################################################################
	rem zip���k
	if [%COMPRESS%] == [1] (
		rem 7za.exe a -tzip "���k�t�@�C����" "���k�Ώۃf�B���N�g��"
		rem stdout�ɕ������o���Ȃ��悤�ɂ��邽�߁Anul�Ƀ��_�C���N�g���Ă���
		%ZIP% a -tzip -mx9 %3 .\*
		attrib /D /S +R %3
	)
	rem 7ZIP���k
	if [%COMPRESS%] == [2] (
		rem 7za.exe a -t7z "���k�t�@�C����" "���k�Ώۃf�B���N�g��"
		rem stdout�ɕ������o���Ȃ��悤�ɂ��邽�߁Anul�Ƀ��_�C���N�g���Ă���
		rem %3 �̖��̕��ʂ݂̂����o���Ă��邽�߁A��d���p����..\��t�^���Ȃ�����
		%SEVEN_ZIP% a -t7z -mx9 "..\%~n3.7z" .\*
		attrib /D /S +R "..\%~n3.7z"
	)
	cd /d ..
	rd /s /q %2
)

rem �ۑ����闚�𐔂𒴂����ꍇ�A%temp%�Ɉړ�����B�i�폜���邱�Ƃ��\�j
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

rem �s���ɂ���
if [%INVISIBLE%] == [1] (
	attrib +H %1
) else (
	attrib -H %1
)
rem �����쐬���ʂ�����ꍇ
rem start /b %systemroot%\EXPLORER.EXE /n,/e,%2

goto :EOF

rem ##########################################################################
rem ##########################################################################
:COPY_FILE
rem ��1���� �����쐬�Ώۃt�@�C��
rem ��2���� �����쐬�Ώۃt�@�C����u���f�B���N�g��
rem ��3���� �����쐬�Ώۃt�@�C���̃e���|�����i���k�̂��߂̃t�@�C���j
rem ��4���� �����쐬�Ώۃt�@�C���̈��k�t�@�C����

rem @echo on
echo %1
echo %2
echo %3
echo %~nx3
echo %4

IF NOT EXIST %1 (
	goto :Err
)

rem �V���[�g�J�b�g�̗����͍쐬���Ȃ�
if /i [%~x1] == [.lnk] (goto :Eof)
if /i [%~x1] == [.url] (goto :Eof)

rem �Ȃ����̃R�}���h���������̂��o���Ă��Ȃ�
rem attrib /S /D -H %1

rem �����쐬�Ώۃt�@�C����u���f�B���N�g�����쐬
IF NOT EXIST %2 (
	mkdir %2
)

rem echo "%~1"
rem echo "%~2"
rem echo "%~3"
rem �ۑ����_�ł̗������쐬�ς݂̏ꍇ�A������B
if exist %3 (
	echo ���̍X�V�����ł̗������쐬�ς݂Ȃ̂ŁA�������I�����܂�
	goto :EOF
)

rem �����쐬�̂��߂̃R�s�[�����s
copy /y %1 %3

rem ���[���Y�t���Čڋq�ɑ���ۂ́A�t�@�C�����̈�Ӑ���S�ۂ��邽�߂ɃR�s�[�B�i%temp%�@�Ȃ�J���₷���̂Łj
if [%DUPLICATE%] == [1] (
	copy /y %3 "%temp%"
)

rem ���X���k���Ă��邽�߁A����ȏ㈳�k���Ă��Ӗ��������A�����͒P�Ɉ��k�������Ȃ��ꍇ�A�����ɋL�q����
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
rem office 2007�̃t�@�C����xml�Ȃǂ�zip���k�������̂炵��
if /i [%~x2] == [.docx] (set EXEC_FLG=0)
if /i [%~x2] == [.pptx] (set EXEC_FLG=0)
if /i [%~x2] == [.xlsx] (set EXEC_FLG=0)
rem �ēx�A�ϐ�COMPRESS��ݒ肵�Ȃ���
set /a COMPRESS=%COMPRESS% * %EXEC_FLG%

if [%COMPRESS%] == [0] (
	rem �O�̂��ߓǂݎ���p�ɂ���
	attrib /D /S +R %3
)
rem ���k����
if not [%COMPRESS%] == [0] (
	cd /d %2
	rem #################################################################
	rem zip���k
	if [%COMPRESS%] == [1] (
		rem 7za.exe a -tzip "c:\temp\test.zip" "7-zip.chm"
		rem stdout�ɕ������o���Ȃ��悤�ɂ��邽�߁Anul�Ƀ��_�C���N�g���Ă���
		%ZIP% a -tzip -mx9  %4 "%~nx3"
		attrib /D /S +R %4
	)
	rem 7ZIP���k
	if [%COMPRESS%] == [2] (
		rem 7za.exe a -t7z "c:\temp\test.7z" "7-zip.chm"
		rem stdout�ɕ������o���Ȃ��悤�ɂ��邽�߁Anul�Ƀ��_�C���N�g���Ă���
		rem %4 �̖��̕��ʂ݂̂����o���Ă��邽�߁A��d���p����t�^���Ȃ�����
		%SEVEN_ZIP% a -t7z -mx9 "%~n4.7z" "%~nx3"
		attrib /D /S +R "%~n4.7z"
	)
	rem ���̈��k����
rem	if [%COMPRESS%] == [3] (
	rem ���̈��k����
rem	)
	del /f /q %3
)

rem �ۑ����闚�𐔂𒴂����ꍇ�A%temp%�Ɉړ�����B�i�폜���邱�Ƃ��\�j
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

rem �s���ɂ���
if [%INVISIBLE%] == [1] (
	attrib +H %2
) else (
	attrib -H %2
)

rem �����쐬���ʂ�����ꍇ
rem start /b %systemroot%\EXPLORER.EXE /n,/e,%2

goto :EOF


rem ##########################################################################
rem ##########################################################################
:Err
echo ###############################################################
echo �o�b�N�A�b�v�̑Ώۂ��邢�̓o�b�N�A�b�v�̕ۑ��悪������܂���B
echo �R�}���h�v�����v�g�̊֌W��A^, ^& ^( ^) �Ȃǂ��t�@�C�����Ɋ܂܂�Ă���Ɠ��삵�܂���
echo ###############################################################
PAUSE>NUL
