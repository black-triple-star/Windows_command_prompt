
rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

cd /d "%~dp0" && set BASHO=%~dp0
if "%BASHO:~-1%"=="\" (set BASHO=%BASHO:~0,-1%)
echo %CD%
title "%~0"

setlocal enabledelayedexpansion

@echo off
cls
rem ********************************************************************************

rem @echo off
cls

set FILE_NM=D:\Music\���W���[�W-2008-�S�̃����o�C�E�o�C�o�C�u���U�[\01 �S�̃����o�C.mp3
set CURRENT_DIR=D:\Music
set LEN=0


rem �t���p�X����A�J�����g�f�B���N�g�����������o���ׁA�J�����g�f�B���N�g���̕����񒷂𓾂�
echo %CURRENT_DIR%
call :STRLEN   "%CURRENT_DIR%"
echo %LEN%


set /a LEN=%LEN%+1

rem �t���p�X
echo �t���p�X
echo %FILE_NM%

rem ********************************************************************************
rem substring �̗�
rem %[���ϐ�]:~[�I�t�Z�b�g(�ʒu)],[������]%

rem set N=123456789
rem echo %N%
rem echo %N:~2,2%
rem echo %N:~2,5%

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
rem ********************************************************************************


rem SUBSTRING �̌���
echo SUBSTRING �̌���
set FILE_NM=!FILE_NM:~%LEN%!
echo %FILE_NM%

rem \ �� / �ɒu������
echo \ �� / �ɒu������
set FILE_NM=%FILE_NM:\=/%

echo %FILE_NM%

pause>nul
:goto EOF

rem ##########################################################################
rem �����񒷂��擾����
rem http://piyopiyocs.blog115.fc2.com/blog-entry-898.html
rem ##########################################################################
:STRLEN

set str=%~1
rem set LEN=0
echo %str%
:LOOP
if not "%str%"=="" (
	set str=%str:~1%
	set /a LEN=%LEN%+1
	goto :LOOP
)

goto :EOF
rem ##########################################################################
