rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem exe�̋N���󋵂����ăV���b�g�_�E������
title %~nx0

@echo off
cls


set PROCESS_NM=ffmpeg.exe
set PROCESS_NM=Lightroom.exe
set PROCESS_NM=HandBrake.exe

rem ##################################################################################
@echo off
:LOOP

echo ##################################################################################
echo %PROCESS_NM%  ���Ď�

timeout /t 60 /nobreak


tasklist /FI "IMAGENAME eq %PROCESS_NM%" | findstr /i "%PROCESS_NM%"
if errorlevel 1 (
	echo %PROCESS_NM%  ���N�����Ă��Ȃ�
	rem �V���b�g�_�E��
	shutdown.exe -s -f -t 60 -c "Windows will now shutdown in 60 seconds"
	rem �L�����Z������ɂ́A�ȉ������s����B
	rem shutdown.exe -a
) else (
	echo %PROCESS_NM%  ���N�����Ă���
)

goto :LOOP
rem ##################################################################################
