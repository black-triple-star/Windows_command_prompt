rem 管理者として実行すること
rem DHCP に変更する。

rem runas コマンドで管理者権限で実行しようとするとパスワードを求められるので、実行不可能。毎回、右クリックで管理者として実行するしかない。


rem 構成の表示
netsh interface ip show config

rem https://www.losttechnology.jp/Win7/specialfolder.html
rem http://pasofaq.jp/windows/mycomputer/shellfolder7.htm
rem start shell:ConnectionsFolder
rem explorer shell:::{7007ACC7-3202-11D1-AAD2-00805FC1270E}
rem explorer shell:::{992CFFA0-F557-101A-88EC-00DD010CCC48}
rem で表示されるデバイス名を入力する
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
