rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem Windows time �T�[�r�X�������N������悤�ɐݒ肷��B�i�����s����΂����j
rem Windows Time �T�[�r�X�� Active Directory �ɎQ�����ĂȂ��ꍇ�A�N�����Ȃ��B����ăR�}���h�Ŏ����N������悤�ɐݒ肷��
@echo off
cls

rem �Ǘ��Ҍ����Ŏ��s���邱��

set Act=reg add

rem [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient]
rem "SpecialPollInterval"=dword:00000e10

rem ntp�T�[�o�[�ɖ₢���킹��Ԋu��b�ŋL��
set INTERVAL_SECOND=3600
%Act% "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient" /v SpecialPollInterval /t REG_DWORD /d %INTERVAL_SECOND% /f > %TEMP%\NULL

rem �ʒm�̈�̎��v�ɕb������ǉ�����
rem https://news.mynavi.jp/article/win10tips-288/
%Act% "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 1 /f > %TEMP%\NULL



rem Windows Time �T�[�r�X�� Active Directory �ɎQ�����ĂȂ��ꍇ�A�N�����Ȃ��B
sc config w32time start=auto

rem �N���󋵂𒲂ׂ�
rem sc query w32time

rem �N���󋵂𒲂ׁA�N���݂̂��A�I�����Ă���N�����邩�𕪂���
sc query w32time | %systemroot%\SysWOW64\find /i "STOPPED"  >NUL
rem errorlevel�Ŕ��ʂ��Ă��邽�߁A�����ɐV���ȃR�}���h�����Ă͂����Ȃ�
if not errorlevel 1 (
	echo w32time �͋N�����Ă��Ȃ�����
	net start w32time
) else (
	echo w32time �͋N���ς݂Ȃ̂ŁA�I�����Ă���ēx�N������
	net stop w32time
	net start w32time
)

rem NTP�ݒ���m�F����
w32tm /query /configuration

echo �I�����܂�
pause>nul
