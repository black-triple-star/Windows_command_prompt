rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

@echo off
cls

rem 時刻を手動で同期する
rem 管理者権限で実行すること


rem https://go-journey.club/archives/9494

rem Windows Time サービスの設定内容を確認する
w32tm /query /configuration

rem 現在どの NTP サーバーを参照しているのか確認
w32tm /query /source

rem NTPサーバー側の状態を確認する
rem 「peers」オプションを付けることで どの NTP サーバーと同期をとっているのか、NTP サーバー側の状態はどうなっているのかを確認することができます。

w32tm /query /peers

rem NTPサーバーと通信が出来ているかコマンドで確認する
rem w32tm /monitor /computers:ntp.nict.jp
rem w32tm /monitor /computers:time.windows.com

rem 現在 NTP サーバーとの時刻同期の状態を確認したい場合は「status」オプションを付けます。
w32tm /query /status /verbose

rem 手動で同期するコマンド
w32tm /resync

echo ####################################################################
echo 時刻同期が行えない場合、Windows Time サービスを起動してください
echo Windows Timeサービスは ActiveDirectoryドメインに属していない場合だと
echo 起動しないようになってます。
echo ####################################################################
echo 終了しました。このウィンドウを閉じてください。
pause>nul
