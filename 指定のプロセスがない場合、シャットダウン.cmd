rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem �����exe�����s���ĂȂ��ꍇ�A�V���b�g�_�E��

@echo off
@setlocal enabledelayedexpansion
cls

cd /d "%~dp0"
title "%~0"

rem �v���Z�XID�𒲂ׂ�Ԋu
set INTERVAL=60

set EXE_NM=robocopy.exe
echo %EXE_NM%

:TASKLIST

echo ######################################
tasklist /fi "imagename eq  %EXE_NM%"
for /f "tokens=1,2" %%i in ('tasklist /fi "imagename eq  %%EXE_NM%%"') do (
	@set PID=%%j
rem	echo !PID!
)
rem echo !PID!
rem echo !PID:~0,7!

rem �w���exe�������ĂȂ��ƃv���Z�Xid�Ɂu�w�肳�ꂽ�����Ɉ�v����^�X�N�͎��s����Ă��܂���B�v���Z�b�g�����
rem if "!PID!" == "�w�肳�ꂽ�����Ɉ�v����^�X�N�͎��s����Ă��܂���B" (
rem 	goto :SHUTDOWN
rem ) else (
rem		timeout /t %INTERVAL% /nobreak
rem		goto :TASKLIST
rem )

rem �w���exe�������ĂȂ��ƃv���Z�Xid�Ɂu�w�肳�ꂽ�����Ɉ�v����^�X�N�͎��s����Ă��܂���B�v���Z�b�g�����
echo !PID! | findstr /c:"�w�肳�ꂽ�����Ɉ�v����^�X�N�͎��s"
IF NOT ERRORLEVEL 1 (
	rem �w���exe�������Ă��Ȃ��ꍇ�A������
	goto :SHUTDOWN
) ELSE (
	rem �w���exe�������Ă���ꍇ�A������
	timeout /t %INTERVAL% /nobreak
	goto :TASKLIST
)


goto :EOF

rem #############################################################################################
:SHUTDOWN
echo #################################
echo �V���b�g�_�E�����O�̑҂�����
echo #################################
timeout /t 30 /nobreak
echo �V���b�g�_�E������
rem shutdown.exe -s -f -t 0 -c "Windows will now shutdown soon"
rem �V���b�g�_�E�����L�����Z���ł���悤��30�b�̗P�\��݂���
shutdown.exe -s -f -t 30 -c  "Windows will shutdown in 30 seconds"
rem �V���b�g�_�E�����L�����Z������ɂ́A���ꁫ�����s
rem shutdown.exe -a

goto :EOF
