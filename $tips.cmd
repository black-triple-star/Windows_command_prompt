rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

@echo off
cls

title "%~0"

rem ********************************************************************************
rem ���s�������o�͂������ꍇ�Aechooff ���Ă���echo.�@�Ƃ���B
echo.

echo on

rem ********************************************************************************
rem Windows �V���[�g�J�b�g�i.lnk�t�@�C���j�ŁA���΃p�X���w�肷����@�B�ȉ��̂悤�ɁAexplorer.exe �̈����ɂ���
rem %windir%\explorer.exe ".\bin\nomacs.exe"

rem ********************************************************************************
rem https://news.mynavi.jp/article/win10tips-459/
pushd ���g���΁AUNC�̃h���C�u���^�[�̊��蓖�Ă�����Ă���邪�Apushd���ƃ��[�U�[���ƃp�X���[�h���w��ł��Ȃ����ۂ�

rem ********************************************************************************
rem �J�����g�h���C�u�ƃJ�����g�f�B���N�g����ϐ��Ɋi�[������@

SET CURRENT_DRIVE=%CD:~0,1%
SET CURRENT_DIR=%CD%

echo %CURRENT_DRIVE%
echo %CURRENT_DIR%


rem ********************************************************************************
rem �p�X�̐ݒ�
set PATH=%PATH%;"C:\Program Files"
echo %PATH%

@echo off


rem ********************************************************************************

rem substring �̗�
rem %[���ϐ�]:~[�I�t�Z�b�g(�ʒu)],[������]%

set N=123456789
echo %N%
echo %N:~2,2%
echo %N:~2,5%

rem �ϐ���substring�̎d��
rem http://www.atmarkit.co.jp/fwin2k/win2ktips/419batchdate/batchdate.html
rem %V%			�ϐ�V�̒l�S��							%V% �ˁuABCDEFGHIJKL�v
rem %V:~m%		m�����ڂ���A�Ō�܂�					%V:~5% �ˁuFGHIJKL�v
rem %V:~m,n%	m�����ڂ���An������					%V:~5,2% �ˁuFG�v
rem %V:~m,-n%	m�����ڂ���A�Ō��n������������������	%V:~5,-2% �ˁuFGHIJ�v
rem %V:~-m%		��납��m�����ڂ���A�Ō�܂�			%V:~-5% �ˁuHIJKL�v
rem %V:~-m,n%	��납��m�����ڂ���An������			%V:~-5,2% �ˁuHI�v
rem %V:~-m,-n%	��납��m�����ڂ���A�Ō��n������������������						%V:~-5,-2% �ˁuHIJ�v
rem %V:c1=c2%	����c1�𕶎�c2�ɒu������B���ꂼ�ꕡ���̕������w�肷�邱�Ƃ��\	%V:ABC=abc% �ˁuabcDEFGHIJKL�v

rem �u��
set SAVE_DIR=%SAVE_DIR:/=\%
set SAVE_DIR=!SAVE_DIR:/=\!


rem ********************************************************************************
rem http://www.atmarkit.co.jp/ait/articles/0405/01/news002.html

rem �p�X�̍Ō�ɂ���\�}�[�N�����������B�i�p�X�̍Ō��\�}�[�N������Ɠ��삵�Ȃ��R�}���h������j

set HOGE=c:\temp\
echo %HOGE%
echo %HOGE:~-1%
if %HOGE:~-1%==\ (set HOGE=%HOGE:~0,-1%)
echo %HOGE%

rem �p�X�̍Ō�ɂ���\�}�[�N�����������B�i�p�X�̍Ō��\�}�[�N������Ɠ��삵�Ȃ��R�}���h������j
rem cd �� %cd% ���g���Bcd ����̂�pushd��popd�Ō��݂̃p�X�ɖ߂�悤�ɂ��Ă���B
pushd %cd%
set HOGE=C:\temp\
echo %HOGE%
cd /d  %HOGE%
set HOGE=%cd%
echo %HOGE%
popd

rem ********************************************************************************

rem ver�̌���
rem 2000
Microsoft Windows 2000 [Version 5.00.2195]
rem XP
Microsoft Windows XP [Version 5.1.2600]
rem XP 64
Microsoft Windows [Version 5.2.3790]
rem Vista (SP�𓖂Ă�ƈ�ԍŌ�̌����C���N�������g�����悤��)
Microsoft Windows [Version 6.0.6001]
rem 7
Microsoft Windows [Version 6.1.7600]
rem Windows Server 2012 (����)
Microsoft Windows [Version 6.2.9200]
rem Windows Server 2012 R2
Microsoft Windows [Version 6.3.9600]


rem  Windows NT �� Windows 2000/XP �𔻒肷����@
VER | %systemroot%\SysWOW64\find /I "Windows NT Version 4.0">NUL
IF NOT ERRORLEVEL 1 GOTO Fatal_WrongSystemVersion


rem  Windows 2000 ���ǂ����𔻒肷����@
VER | %systemroot%\SysWOW64\find /I "Microsoft Windows 2000 [Version 5.00.2195]">NUL
IF NOT ERRORLEVEL 1 (
	echo Windows 2000�ł�
) ELSE (
	echo Windows 2000�ł͂���܂���
)

rem  Windows XP ���ǂ����𔻒肷����@
VER | %systemroot%\SysWOW64\find /I "Microsoft Windows XP [Version 5.1.2600]">NUL
IF NOT ERRORLEVEL 1 (
	echo Windows XP�ł�
) ELSE (
	echo Windows XP�ł͂���܂���
)

rem  Windows Server 2003 ���ǂ����𔻒肷����@
VER | %systemroot%\SysWOW64\find /I "Microsoft Windows [Version 5.2.3790]">NUL
IF NOT ERRORLEVEL 1 (
	echo Windows Server 2003�ł�
) ELSE (
	echo Windows Server 2003�ł͂���܂���
)


rem Windows Vista ���ǂ����𔻒肷����@
rem Vista�i�ȍ~�H�j�o�[�W�����ԍ��̈�ԉ��̌����T�[�r�X�p�b�N�̔ԍ��ɂȂ��������i�H�j
VER | %systemroot%\SysWOW64\find /I "Microsoft Windows [Version 6.0.6001]">NUL
IF NOT ERRORLEVEL 1 (
	echo Windows Vista�ł�
) ELSE (
	echo Windows Vista�ł͂���܂���
)

rem  Windows 7 ���ǂ����𔻒肷����@
VER | %systemroot%\SysWOW64\find /I "Microsoft Windows [Version 6.1.7600]">NUL
IF NOT ERRORLEVEL 1 (
	echo Windows 7�ł�
) ELSE (
	echo Windows 7�ł͂���܂���
)

rem �o�[�W������ϐ��ɓ������@
for /f "tokens=1,2,3,4,5,6 delims=[] " %%I in ('ver') do (
	@echo %%I	%%J	%%K	%%L	%%M	%%N%%O
)

rem Windows ��32bit��64bit���𔻕�
if /i "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	echo 64bit Windows
)
if /i "%PROCESSOR_ARCHITECTURE%" == "x86" (
	echo 32bit Windows
)

pause

rem ********************************************************************************

rem ����̃v���Z�X���N�����Ă��Ȃ��ꍇ�A�N������B�iWindows XP �̂݁j
set PROCESS_NM=notepad.exe
tasklist | %systemroot%\SysWOW64\find /i "%PROCESS_NM%">NUL
if errorlevel d1 (
	start /b %PROCESS_NM%
)

rem ����̃v���Z�X���N�����Ă���ꍇ�A��x�����I�����Ă���N������B�iWindows XP �̂݁j
set PROCESS_NM=notepad.exe
tasklist | %systemroot%\SysWOW64\find /i "%PROCESS_NM%">NUL
if errorlevel 0 (
	taskkill /f /im %PROCESS_NM% /t
)
start /b %PROCESS_NM%

rem �G�X�P�[�v����
rem http://www.geocities.co.jp/SiliconValley-SanJose/1227/variable.html
rem  ���ϐ��Ƀ��_�C���N�g��p�C�v�A�����t�������L���Ȃǂ̓���L�� (>,>>,<,|,
rem  &) ��������ꍇ�ɂ́A����L���̐擪�ɃG�X�P�[�v���� (^) ��t����K�v��
rem  ����܂��B���Ƃ��Ί��ϐ� K �� special& �Ƃ��������������Ȃ�Aset 
rem  K=special^& �Ɠ��͂��܂�


pause

rem �^�X�N�X�P�W���[���[����N������ƁA�J�����g�f�B���N�g����%system%�ɂȂ�̂ŁA
rem �N������cmd�t�@�C���̃p�X����J�����g�f�B���N�g���𓾂�B
rem for /d %%V in (%0) do  (set BASHO=%%~dpV)
set BASHO=%~dp0
echo %BASHO%
pause

rem �f�B���N�g���ƃt�@�C���̔��ʁB�Ō��\��t����exist���������΂����B
set TEMP_FILE=%temp%\test.txt
echo test>"%TEMP_FILE%"
if exist "%TEMP_FILE%\" (
	echo �f�B���N�g���ł�
) else (
	rem �Ȃ����̂��̂��̂�exist�̃`�F�b�N������K�v������
	if exist "%TEMP_FILE%" (
		echo �t�@�C���ł�
	) else (
		echo �����������݂��Ȃ��B
	)

)
if exist "%TEMP%\" (
	echo �f�B���N�g���ł�
) else (
	rem �Ȃ����̂��̂��̂�exist�̃`�F�b�N������K�v������
	if exist "%TEMP_FILE%" (
		echo �t�@�C���ł�
	) else (
		echo �����������݂��Ȃ��B
	)
)

rem ********************************************************************************
rem for �ƈ����Ŏg����C���q
rem �C���q�t���ϐ� ���� 
rem %~I	%I ���A�͂�ł�����p�� ("") ���폜�����`�ɓW�J���܂��B 
rem %~fI	%I ���A���S�C���p�X���ɓW�J���܂��B 
rem %~dI	%I ���A�h���C�u���������ɓW�J���܂��B 
rem %~pI	%I ���A�p�X�����ɓW�J���܂��B 
rem %~nI	%I ���A�t�@�C���������ɓW�J���܂��B 
rem %~xI	%I ���A�t�@�C���g���q�����ɓW�J���܂��B 
rem %~sI	�p�X���A�Z�����O�ɓW�J���܂��B 
rem %~aI	%I ���A�t�@�C���̃t�@�C�������ɓW�J���܂��B 
rem %~tI	%I ���A�t�@�C���̓��t�Ǝ����ɓW�J���܂��B 
rem %~zI	%I ���A�t�@�C���̃T�C�Y�ɓW�J���܂��B 

rem ################################################################################################
rem �t�@�C���ƃf�B���N�g���̔���
for /d  %%V in (%*) do  (
	echo %%V
	if not exist  "%%~V"  (
		echo #######################################################################################
		echo "%%~V" �����݂��܂���
		echo �R�}���h�v�����v�g�̊֌W��A^, ^& ^( ^) �Ȃǂ��t�@�C�����Ɋ܂܂�Ă���Ɠ��삵�܂���
		echo #######################################################################################
		pause>nul
	) else (
		rem �������Q�l�ɂ��āA�f�B���N�g���ƃt�@�C���̎�������
		rem http://www.atmarkit.co.jp/fwin2k/operation/command003/command2.html
	rem	dir %%V 2>nul | %SYSTEMROOT%\system32\find "<DIR>          .."  >NUL
		dir "%%~V" 2>nul | %SYSTEMROOT%\system32\find "<DIR>          .."  >NUL
		if not errorlevel 1 (
			rem echo �Ώۃt�@�C�� %%V
			rem echo Path    = %%~pV
			rem echo Name    = %%~nV
			rem echo Ext     = %%~xV
			rem echo FullPath= %%~dpnV
			rem echo Name    = %%~nV
			rem echo Ext     = %%~xV
			rem http://pc5.2ch.net/test/read.cgi/win/1062775949/390���g�p����
rem			cd /d %%V
			cd /d "%%~V"
			rem �f�B���N�g���̏ꍇ�A����S��dir����
			for /f "delims=" %%W in ('dir /s /a-d /b') do (
				@echo %%~fW
			)
			cd ..
		) else (
			rem �t�@�C���̏ꍇ
			@echo %%~fV
		)
	)
)


rem ################################################################################################
rem �h���b�O�A���h�h���b�v��
for /d %%V in (%*) do  (
	set /a COUNTER=!COUNTER!+1
	rem �o�b�N�A�b�v�Ώۂ̃f�B���N�g�����̓t�@�C����������Ȃ��ꍇ�A�G���[
	IF NOT EXIST "%%~V" (
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
		cd /d %%V
		rem �h���b�O�A���h�h���b�v���f�B���N�g���̏ꍇ
		rem �f�B���N�g���̏ꍇ�A����S��dir����
		for /f "delims=" %%W in ('dir /s /a /b') do (
			@echo %%~fW
		)
		cd ..
rem 		rem �h���b�O�A���h�h���b�v���f�B���N�g���̏ꍇ
rem 		IF %USE_AS_PREFIX% == 1 (
rem 			rem �f�B���N�g�������uHISTORY_�����쐬�Ώہv�Ƃ���ꍇ
rem 			call :COPY_DIR "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME!\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "..\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
rem 		) ELSE (
rem 			rem �f�B���N�g�������u�����쐬�Ώ�_HISTORY�v�Ƃ���ꍇ
rem 			call :COPY_DIR "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\!FILE_NAME!_%HISTORY%\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "..\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
rem 		)
	) else (
		rem �t�@�C���̏ꍇ
		@echo %%~fV
rem 		rem �h���b�O�A���h�h���b�v���t�@�C���̏ꍇ
rem 		IF %USE_AS_PREFIX% == 1 (
rem 			rem �t�@�C�������uHISTORY_�����쐬�Ώہv�Ƃ���ꍇ
rem 			call :COPY_FILE "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!" "!FILE_PATH!\%HISTORY%\!FILE_NAME_EXT!\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
rem 		) ELSE (
rem 			rem �t�@�C�������u�����쐬�Ώ�_HISTORY�v�Ƃ���ꍇ
rem 			call :COPY_FILE "!FILE_PATH!\!FILE_NAME!!FILE_EXT!" "!FILE_PATH!\!FILE_NAME!!FILE_EXT!_%HISTORY%" "!FILE_PATH!\!FILE_NAME!!FILE_EXT!_%HISTORY%\!FILE_NAME!_!TIMESTAMP!!FILE_EXT!" "!FILE_NAME!_!TIMESTAMP!!FILE_EXT!.zip"
rem 		)
	)
)
:Err
echo ###############################################################
echo �o�b�N�A�b�v�̑Ώۂ��邢�̓o�b�N�A�b�v�̕ۑ��悪������܂���B
echo �R�}���h�v�����v�g�̊֌W��A^, ^& ^( ^) �Ȃǂ��t�@�C�����Ɋ܂܂�Ă���Ɠ��삵�܂���
echo ###############################################################
PAUSE>NUL
goto :EOF

rem ################################################################################################
rem if����and�����̗�
rem ################################################################################################

rem /i	��������r����ꍇ�ɁA�A���t�@�x�b�g�̑啶���Ə���������ʂ��Ȃ��B
if /i [ABC] equ [abc] (echo ����) else (echo �Ⴄ)
if  [ABC] equ [abc] (echo ����) else (echo �Ⴄ)

rem
EQU�@�@������ 
NEQ�@�@�������Ȃ� 
LSS�@�@��菬���� 
LEQ�@�@�ȉ� 
GTR�@�@���傫�� 
GEQ�@�@�ȏ� 

rem ********************************************************************************

rem if��
if not [1] == [0] (
	echo true�ł�
)
rem http://www.fpcu.jp/dosvcmd/bbs/log/cat3/if/4-1258.html
rem if����and�����̗�
if not [1] == [0] if not [a] == [b] if /i [a] == [A] (
	echo true�ł�
)

rem if����and�����̗�
if not [1] == [0] if not [a] == [b] if /i [a] == [b] (
	echo true�ł�
) else (
	echo false�ł�
)

pause

rem ********************************************************************************
rem �R�}���h�v�����v�g����G�N�X�v���[���[�ŏ���̃f�B���N�g�����J��
start .
start %temp%
rem http://pc12.2ch.net/test/read.cgi/win/1258643596/74
rem �R���s���[�^
%windir%\explorer.exe "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
rem �S�~��
%windir%\explorer.exe "::{645FF040-5081-101B-9F08-00AA002F954E}"
rem �}�C�h�L�������g
%windir%\explorer.exe "::{450D8FBA-AD25-11D0-98A8-0800361B1103}"
rem �f�X�N�g�b�v
%windir%\explorer.exe /n,/select,shell:::{603D3800-BD81-11d0-A3A5-00C04FD706EC}
%windir%\explorer.exe /n,/e,"%userprofile%\Desktop"

%windir%\explorer.exe /n,/e,"C:\"

rem �R�}���h�v�����v�g����G�N�X�v���[���[�ŏ���̃f�B���N�g���E�t�@�C����I��������Ԃɂ���B
%WINDIR%\explorer.exe /select,"C:\temp\�^�X�N�o�[�ɕ\������A�C�R���ƒʒm�̑I��.cmd"

%WINDIR%\explorer.exe /select,"C:\#Work\python_source"
rem /root �� /select �̑O�ɕt����ƁA���̃f�B���N�g�����J������ԂɂȂ�B�i�t�@�C���������ɂ���Ƃ��̃t�@�C�����J���j
rem �i/root �� /select �̌�ɕt����ƁA��L�̓���ɂȂ�Ȃ��j
%WINDIR%\explorer.exe /root,/select,"C:\#Work\python_source"

rem ********************************************************************************
rem ���̃^�C�}�[�@�\
rem ping ���g���ď������P�b���x�~�߂�i�~�߂Ȃ��ƃu���E�U��URL��n���O�Ƀt�@�C���������Ă��܂����߁j
rem http://fpcu.on.coocan.jp/dosvcmd/bbs/log/cat3/pausechoice/2-0952.html
ping localhost -n 2 > nul

rem ���莞�ԑ҂itimeout�jUNIX��sleep�Ɠ���
rem http://www.atmarkit.co.jp/fwin2k/win2ktips/1420sleep/sleep.html
rem 5�b�҂�
timeout /t 5 /nobreak
rem �i���ɑ҂�
timeout /t -1

rem ********************************************************************************
rem �����R�[�h��ς����
chcp 65001
chcp 932

rem ********************************************************************************
rem �R�}���h�v�����v�g�̋N�����ɁA����̃R�}���h�����s������@
cmd.exe  /f:on  /k �R�}���h

rem ********************************************************************************
rem �R�}���h�v�����v�g�̃R�}���h�̌��ʂ�ϐ��ɓ����B�ibash ����  USER_NAME=`whoami`  �����ŏo����z �j
rem ���O�C�����Ă��郆�[�U�[�����Z�b�g
for /f "tokens=* usebackq" %%i in (`whoami`) do (set USER_NAME=%%i)
rem %%i �� ) �̊ԂɃX�y�[�X�����Ă͂����Ȃ��B�X�y�[�X���ϐ��Ɋi�[����Ă��܂�
echo %USER_NAME%


rem ********************************************************************************
rem http://d.hatena.ne.jp/simply-k/20100821/1282490379
rem �o�b�`�t�@�C���Ŗ������[�v�����Add Starsakurai_youheisakurai_youhei
rem �R�}���h�v�����v�g/�o�b�`�t�@�C��
rem 
rem �o�b�`�t�@�C���ł̖������[�v�̍����ł��B*1
rem GOTO�����g�����@
rem GOTO�����g���ƁA�������[�v����邱�Ƃ��ł��܂��B
rem 
rem �T���v�� (Ctrl+C�ŏI�����Ă��������B)
rem 
@echo off
:LOOP
	echo loop
rem	timeout /t 1
rem	ping -n 1 localhost
goto :LOOP


setlocal ENABLEDELAYEDEXPANSION
set START=0
set END=100
set COUNTER=0
for /l %%H in (%START% , 1 ,%END%) do (
	set /a COUNTER=COUNTER+1
echo	!COUNTER!
)


exit /b 0

rem ********************************************************************************
rem FOR�����g�����@
rem FOR���𗘗p���Ė������[�v����邱�Ƃ��ł��܂��B�������A���̕��@�ɂ́A���[�v�𔲂��o���Ȃ��Ƃ������_������܂��B(��q)
rem �T���v�� (Ctrl+C�ŏI�����Ă��������B)
rem 
@echo off

for /l %%I in (0, 0, 0) do (
echo loop
)

exit /b 0


rem ********************************************************************************
rem �h���C�u���^�[�̃`�F�b�N
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
rem	echo %%i
	if exist %%i: (
		echo %%i: �h���C�u�͑��݂���
	) else (
		echo %%i: �h���C�u�͑��݂��Ȃ�
	)
)


rem ********************************************************************************
rem ���E�B���h�E���ċA�I�ɌĂяo���āA�ŏ���������
echo "%~0"
echo "%~dp0.\%~nx0"
if not "%~0"=="%~dp0.\%~nx0" (
	start /min cmd /c,"%~dp0.\%~nx0" %*
	exit
)
