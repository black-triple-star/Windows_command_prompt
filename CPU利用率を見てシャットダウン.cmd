rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem CPU���p�������ăV���b�g�_�E��


@echo off
cls

setlocal ENABLEDELAYEDEXPANSION


rem CPU�̗��p�������̒l�����ɂȂ������ɃV���b�g�_�E������
set /a THRESHOLD=10

rem CPU���p�������߂�Ԋu
set INTERVAL=60

title  OS���V���b�g�_�E������CPU���p���F%THRESHOLD% ��  �A CPU���p�������߂�Ԋu�F%INTERVAL% �b��


rem wmic cpu get loadpercentage/value /every:10

rem wmic cpu get loadpercentage/value

rem EQU�@�@������ 
rem NEQ�@�@�������Ȃ� 
rem LSS�@�@��菬���� 
rem LEQ�@�@�ȉ� 
rem GTR�@�@���傫�� 
rem GEQ�@�@�ȏ� 
rem  


:CALC_CPU_USAGE

for /f "tokens=2 delims=^= usebackq" %%i in (`wmic cpu get loadpercentage/value`) do (
	rem echo %%i
	set /a CPU=%%i
	echo CPU���p���@!CPU!
	if !CPU! LSS %THRESHOLD% (
		echo 臒l�ȉ�
		timeout /t %INTERVAL% /nobreak
		call :SHUTDOWN
rem		goto :CALC_CPU_USAGE
	) else (
		echo 臒l�ȏ�
		timeout /t %INTERVAL% /nobreak
		goto :CALC_CPU_USAGE
	)
)
goto :EOF

rem #############################################################################################
:SHUTDOWN
echo #################################
echo �V���b�g�_�E�����O�̑҂�����
echo #################################
timeout /t 60 /nobreak
rem �ꕪ�҂���臒l�ȉ��̏ꍇ�A�V���b�g�_�E������A臒l�ȏ�ɂȂ�����A�߂�
if !CPU! LSS %THRESHOLD% (
	echo �V���b�g�_�E������
	shutdown.exe -s -f -t 0 -c "Windows will now shutdown soon"
) else (
	echo �V���b�g�_�E��������������
	goto :CALC_CPU_USAGE
)

