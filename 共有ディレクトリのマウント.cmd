rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

@echo off
cls
rem ���L�f�B���N�g���̃h���C�u�����Œ�I�ɐݒ肷��
rem http://www.rimesene.co.jp/mesene/contents/tipsnt/setw04.htm


title ���L�f�B���N�g���̐ݒ�

rem ���[�U�[���̎w��͕K�{�ł͂Ȃ�
set USER_NM=%USERNAME%
set USER_NM=hoge


rem �ڑ����鎞�A1�B�ؒf����Ƃ��A1�ȊO�B
set CONNECT_FLG=%1
rem MacOS X ���쐬�����s���t�@�C�����폜���鎞�A1�B
set DEL_FLG=%2


rem ========================================================================
rem ���p���ł������Ă͂����Ȃ��B
call :CONNECT T:   \\192.168.0.12\data
rem call :CONNECT U:   \\192.168.0.7\ears-00mvwb0
rem call :CONNECT V:   \\192.168.0.7\home

goto :EOF

rem ========================================================================
:CONNECT

set SHARE_NM=%2
if %SHARE_NM:~-1%==\ (set SHARE_NM=%SHARE_NM:~0,-1%)

echo %SHARE_NM%


rem NET USE <�h���C�u��> <���L��> <�p�X���[�h> /USER:<���[�U�[��>
rem NET USE T: \\192.168.0.10\data hohoho /USER:takashi
rem NET USE T: /DELETE

if [%CONNECT_FLG%] == [] (
	rem �������Ȃ��ꍇ�i�P�̂Ŏ��s�����ꍇ�Ȃǁj�A��������ʉ�
	rem �}�E���g��؂�ւ�
	if not exist %1\nul (
		if DEFINED USER_NM (
			rem NET USE t: \\192.68.0.10\data /user:takashi �𔭍s����
			NET USE %1 %SHARE_NM% /USER:%USER_NM% /PERSISTENT:NO
		) ELSE (
			NET USE %1 %SHARE_NM% /PERSISTENT:NO
		)
	) else (
		echo %1 �̓}�E���g���ł��B
		NET USE %1 /DELETE /Y
	)
) else (
	rem ����������ꍇ�A��������ʉ�
	rem �}�E���g�ς݂��`�F�b�N
rem 	if not exist %DRIVE_LETTER%:\nul (
rem 		set CONNECT_FLG=1
rem 	) else (
rem 		set CONNECT_FLG=0
rem 	)
	IF [%CONNECT_FLG%] == [1] (
		if not exist %1\nul (
			if DEFINED USER_NM (
				rem NET USE t: \\192.68.0.10\data /user:takashi �𔭍s����
				NET USE %1 %SHARE_NM% /USER:%USER_NM% /PERSISTENT:NO
			) ELSE (
				NET USE %1 %SHARE_NM% /PERSISTENT:NO
			)
		) else (
			echo %1 �̓}�E���g���ł��B
			NET USE %1 /DELETE /Y
		)
		if [%DEL_FLG%] == [1] (
			echo DS_Store �̍폜��
			for /f "delims=" %%I in ('dir /s /a /b "%1\.DS_Store"') do (
				del /f /q /a "%%I"
			)
			
			echo 2EDS_~!3 �̍폜��
			for /f "delims=" %%I in ('dir /s /a /b "%1\2EDS_~!3"') do (
				del /f /q /a "%%I"
			)
		)
	) ELSE (
		if not exist %1\nul (
			echo %1 �̓}�E���g����Ă��܂���B
		) else (
	rem		NET USE %1 /DELETE
			NET USE %1 /DELETE /Y
		)
	)
)
goto :EOF

rem MacOS X ���쐬�����s���t�@�C�����폜
rem attrib /s -h ".DS_Store"
rem del /f /s /q ".DS_Store"
rem attrib /s -h "2EDS_~!3"
rem del /f /s /q "2EDS_~!3"
