rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem Windows time サービスが自動起動するように設定する。（一回実行すればいい）
rem Windows Time サービスは Active Directory に参加してない場合、起動しない。よってコマンドで自動起動するように設定する
@echo off
cls

rem 管理者権限で実行すること

set Act=reg add

rem [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient]
rem "SpecialPollInterval"=dword:00000e10

rem ntpサーバーに問い合わせる間隔を秒で記入
set INTERVAL_SECOND=3600
%Act% "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient" /v SpecialPollInterval /t REG_DWORD /d %INTERVAL_SECOND% /f > %TEMP%\NULL

rem 通知領域の時計に秒時刻を追加する
rem https://news.mynavi.jp/article/win10tips-288/
%Act% "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 1 /f > %TEMP%\NULL



rem Windows Time サービスは Active Directory に参加してない場合、起動しない。
sc config w32time start=auto

rem 起動状況を調べる
rem sc query w32time

rem 起動状況を調べ、起動のみか、終了してから起動するかを分ける
sc query w32time | %systemroot%\SysWOW64\find /i "STOPPED"  >NUL
rem errorlevelで判別しているため、ここに新たなコマンドを入れてはいけない
if not errorlevel 1 (
	echo w32time は起動していなかった
	net start w32time
) else (
	echo w32time は起動済みなので、終了してから再度起動する
	net stop w32time
	net start w32time
)

rem NTP設定を確認する
w32tm /query /configuration

echo 終了します
pause>nul
