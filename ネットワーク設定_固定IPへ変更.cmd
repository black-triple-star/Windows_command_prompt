rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem 管理者として実行すること
rem 固定ipに変更する。社内LANにアクセスする場合、これを使う



rem https://www.losttechnology.jp/Win7/specialfolder.html
rem http://pasofaq.jp/windows/mycomputer/shellfolder7.htm
rem start shell:ConnectionsFolder
rem explorer shell:::{7007ACC7-3202-11D1-AAD2-00805FC1270E}
rem explorer shell:::{992CFFA0-F557-101A-88EC-00DD010CCC48}
rem で表示されるデバイス名を入力する
set INTERFACE_NAME=イーサネット

rem 共通の設定
set DNS_ADRESS1=202.238.95.24
set DNS_ADRESS2=202.238.95.26

set WINS_ADRESS1=
set WINS_ADRESS2=

rem 家の設定
rem IPアドレスが重複すると大変なことになるので気を付ける。
set IP_ADRESS=192.168.0.18
set SUBNET_MASK=255.255.255.0
set DEFAULT_GATEWAY=192.168.0.1


if not defined IP_ADRESS (
	echo off
	cls
	echo #####################################################3
	echo IP_ADRESS を設定してください。
	echo 終了します。
	echo #####################################################3
	pause>nul
)

rem 構成の表示
netsh interface ip show config

rem netsh -c interface dump > %userprofile%net_conf.txt

rem rem https://automationlabo.com/wat/enc/net/setipaddress/

rem ipアドレス
netsh interface ipv4 set add name="%INTERFACE_NAME%" source=static addr="%IP_ADRESS%" mask="%SUBNET_MASK%" gateway="%DEFAULT_GATEWAY%" gwmetric=1

rem DNSサーバー
netsh interface ipv4 set dns name="%INTERFACE_NAME%" source=static addr="%DNS_ADRESS1%" register=non validate=no
netsh interface ipv4 add dns name="%INTERFACE_NAME%" addr="%DNS_ADRESS2%" index=2 validate=no

rem rem WINSサーバー
rem rem 「パラメーターが間違っています。」と言われるが、設定は出来ている。
rem netsh interface ipv4 set winsservers name="%INTERFACE_NAME%" source=static addr="%WINS_ADRESS1%"
rem netsh interface ipv4 add winsservers name="%INTERFACE_NAME%" addr="%WINS_ADRESS2%" index=2
rem rem 簡略版でも「パラメーターが間違っています。」と言われるが、設定は出来ている。
rem rem netsh interface ipv4 set winsservers "%INTERFACE_NAME%" static 10.3.1.124
rem rem netsh interface ipv4 add winsservers "%INTERFACE_NAME%" 172.16.1.50 index=2

cls
ipconfig
netsh interface ip show config name="%INTERFACE_NAME%"
pause>nul

