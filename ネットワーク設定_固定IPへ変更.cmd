rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

rem �Ǘ��҂Ƃ��Ď��s���邱��
rem �Œ�ip�ɕύX����B�Г�LAN�ɃA�N�Z�X����ꍇ�A������g��



rem https://www.losttechnology.jp/Win7/specialfolder.html
rem http://pasofaq.jp/windows/mycomputer/shellfolder7.htm
rem start shell:ConnectionsFolder
rem explorer shell:::{7007ACC7-3202-11D1-AAD2-00805FC1270E}
rem explorer shell:::{992CFFA0-F557-101A-88EC-00DD010CCC48}
rem �ŕ\�������f�o�C�X������͂���
set INTERFACE_NAME=�C�[�T�l�b�g

rem ���ʂ̐ݒ�
set DNS_ADRESS1=202.238.95.24
set DNS_ADRESS2=202.238.95.26

set WINS_ADRESS1=
set WINS_ADRESS2=

rem �Ƃ̐ݒ�
rem IP�A�h���X���d������Ƒ�ςȂ��ƂɂȂ�̂ŋC��t����B
set IP_ADRESS=192.168.0.18
set SUBNET_MASK=255.255.255.0
set DEFAULT_GATEWAY=192.168.0.1


if not defined IP_ADRESS (
	echo off
	cls
	echo #####################################################3
	echo IP_ADRESS ��ݒ肵�Ă��������B
	echo �I�����܂��B
	echo #####################################################3
	pause>nul
)

rem �\���̕\��
netsh interface ip show config

rem netsh -c interface dump > %userprofile%net_conf.txt

rem rem https://automationlabo.com/wat/enc/net/setipaddress/

rem ip�A�h���X
netsh interface ipv4 set add name="%INTERFACE_NAME%" source=static addr="%IP_ADRESS%" mask="%SUBNET_MASK%" gateway="%DEFAULT_GATEWAY%" gwmetric=1

rem DNS�T�[�o�[
netsh interface ipv4 set dns name="%INTERFACE_NAME%" source=static addr="%DNS_ADRESS1%" register=non validate=no
netsh interface ipv4 add dns name="%INTERFACE_NAME%" addr="%DNS_ADRESS2%" index=2 validate=no

rem rem WINS�T�[�o�[
rem rem �u�p�����[�^�[���Ԉ���Ă��܂��B�v�ƌ����邪�A�ݒ�͏o���Ă���B
rem netsh interface ipv4 set winsservers name="%INTERFACE_NAME%" source=static addr="%WINS_ADRESS1%"
rem netsh interface ipv4 add winsservers name="%INTERFACE_NAME%" addr="%WINS_ADRESS2%" index=2
rem rem �ȗ��łł��u�p�����[�^�[���Ԉ���Ă��܂��B�v�ƌ����邪�A�ݒ�͏o���Ă���B
rem rem netsh interface ipv4 set winsservers "%INTERFACE_NAME%" static 10.3.1.124
rem rem netsh interface ipv4 add winsservers "%INTERFACE_NAME%" 172.16.1.50 index=2

cls
ipconfig
netsh interface ip show config name="%INTERFACE_NAME%"
pause>nul

