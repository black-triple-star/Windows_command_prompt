rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932


@echo off
cls

setlocal ENABLEDELAYEDEXPANSION

rem �}�E���g����

set SERVER_NM=\\192.168.99.3
set SERVER_NM=\\192.168.0.19
rem set SERVER_NM=\\192.168.99.2
set SHARE_NM=%SERVER_NM%\work
set DRIVE_LETTER=U:

rem whoami �̌��ʂ��������A�A�N�e�B�u�f�B���N�g���[�̃��[�U�[�̏ꍇ�A�u�h���C����\���[�U�[���v�ƂȂ�
set USER_NAME=���[�U�[��
set PASSWORD=�p�X���[�h

rem rem �h���C�u���^�[�̃`�F�b�N
rem for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
rem rem	echo %%i
rem 	if exist %%i: (
rem 		echo %%i: �h���C�u�͑��݂���
rem 	) else (
rem 		echo %%i: �h���C�u�͑��݂��Ȃ�
rem 	)
rem )

rem if [%MODE%] == [] (
if not defined MODE (
	rem ������n���ċN�����邽�߂ɂ���if�����t���Ă���
	echo ###############################
	echo �}�E���g����ꍇ	1
	echo �}�E���g����������ꍇ	1�ȊO
	echo ###############################
	set /p MODE=">"
)

IF /i [%MODE%] == [1] (
	rem �}�E���g����
	rem -------------------------------------------------------------------------------------------
rem	set SERVER_NM=\\192.168.99.3
	rem set SERVER_NM=\\192.168.99.2
	set SHARE_NM=!SERVER_NM!\work
	set DRIVE_LETTER=V:
	net use    !DRIVE_LETTER!    !SHARE_NM!    !PASSWORD!    /USER:!USER_NAME!   /PERSISTENT:NO
	rem -------------------------------------------------------------------------------------------
) else (
	rem �}�E���g����������
	set DRIVE_LETTER=V:
	net use !DRIVE_LETTER! /delete
)

explorer shell:::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
