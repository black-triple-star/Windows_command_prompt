rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem �w�肵���b�����o�߂�����V���b�g�_�E��

@echo off
cls

set HOURS=1
set MINUTES=15
set SECOND=3
set /a SHUTDOWN_SECONDS=60*60*%HOURS% + 60*%MINUTES% + %SECOND%

echo %HOURS% ���� %MINUTES% �� %SECOND% �b��

echo %SHUTDOWN_SECONDS%

shutdown.exe -s -f -t %SHUTDOWN_SECONDS% -c "Windows will  shutdown in %HOURS% ���� %MINUTES% �� %SECOND% �b"
