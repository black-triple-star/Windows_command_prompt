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


rem �R�}���h�̌�ɃR�����g����ꂽ���ꍇ�A& , && , || �łȂ��΂悢�B| �͎��̃R�}���h�ɂȂ��̂ŁA�G���[�ɂȂ�B
echo �e�X�g1 & rem "�R�����g"
echo �e�X�g2 && rem "�R�����g"
rem echo �e�X�g3 | rem "�R�����g"
echo �e�X�g4 || rem "�R�����g"
echo �e�X�g0 & echo "�R�����g"
pause

rem ���ꂾ�ƁArem�ȍ~�̕�����echo�R�}���h�̈����ɂȂ��Ă��܂��B
echo �e�X�g  rem �R�����g

pause

rem ********************************************************************************

rem �R�����g���� ? ������ƃG���[�ɂȂ邱�Ƃ�����B��d���p���Ŋ���Ƒ��v�ł���B

echo ��d���p���ł�����Ɠ��삷��
rem "htps://www.hogeho.com/?o=98766"

echo �N�G�X�`�����}�[�N��2byte����Γ��삷��B
rem htps://www.hogeho.com/�Ho=777777

echo ^%�͓��삷�邪�Aecho�̍ہA�n�b�g�ŃG�X�P�[�v���Ă��o���Ȃ��B
rem htps://www.hogeho.com/%3D%20


echo �N�G�X�`�����}�[�N���n�b�g�ŃG�X�P�[�v���Ă��_���A����pause�܂ōs�����A�����ŏI�����Ă��܂��B
rem htps://www.hogeho.com/^?o=777777

rem ********************************************************************************


pause
