rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem IME���ċN������o�b�`�t�@�C��
rem �Ǘ��Ҍ����œ���������
rem https://qwerty.work/blog/2020/09/ime-ctfmonexe.php

@echo off
@setlocal enabledelayedexpansion
 
echo.
echo IME���ċN�����܂��B

echo.
echo �v���Z�XID�𒲂ׂĂ��܂��B
rem for /f "tokens=1,2" %%i in ('tasklist /fi "imagename eq ctfmon.exe"') do @set PID=%%j
for /f "tokens=1,2" %%i in ('tasklist /fi "imagename eq ctfmon.exe"') do (@set PID=%%j)
echo "!PID!"

tasklist /fi "imagename eq ctfmon.exe"

rem �]�v�ȃX�y�[�X���폜
rem call :Trim !PID!

rem echo �v���Z�XID��"!PID!"���擾���܂����B

echo IME���I�������Ă��܂��B
taskkill /pid !PID!

echo IME���N�����Ă��܂��B
ctfmon.exe

echo IME�̍ċN�����������܂����B

rem goto End
rem 
rem 
rem :End
rem rem *************************************************************************************************
rem 
rem endlocal
rem pause
rem exit
rem  
rem :Trim
rem set PID=%*
