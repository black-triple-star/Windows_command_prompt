rem �Ǘ��҂Ƃ��Ď��s���邱��
rem DHCP �ɕύX����B

rem runas �R�}���h�ŊǗ��Ҍ����Ŏ��s���悤�Ƃ���ƃp�X���[�h�����߂���̂ŁA���s�s�\�B����A�E�N���b�N�ŊǗ��҂Ƃ��Ď��s���邵���Ȃ��B


rem �\���̕\��
netsh interface ip show config

rem https://www.losttechnology.jp/Win7/specialfolder.html
rem http://pasofaq.jp/windows/mycomputer/shellfolder7.htm
rem start shell:ConnectionsFolder
rem explorer shell:::{7007ACC7-3202-11D1-AAD2-00805FC1270E}
rem explorer shell:::{992CFFA0-F557-101A-88EC-00DD010CCC48}
rem �ŕ\�������f�o�C�X������͂���
set INTERFACE_NAME=Wi-Fi

rem netsh -c interface dump > %userprofile%net_conf.txt

rem https://automationlabo.com/wat/enc/net/setipaddress/
netsh interface ipv4 set add name="%INTERFACE_NAME%" source=dhcp
netsh interface ipv4 set dnsservers name="%INTERFACE_NAME%" source=dhcp
netsh interface ipv4 set winsservers name="%INTERFACE_NAME%" source=dhcp

cls
ipconfig
netsh interface ip show config name="%INTERFACE_NAME%"
pause>nul
