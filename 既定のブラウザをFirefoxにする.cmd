chcp 65001
chcp 932


@echo off
cls

rem https://www.ipentec.com/document/windows-default-program-registry-unknown

rem Sleipnir2	Sleipnir2.HTTP
rem IE	IE.HTTP
rem Firefox	FirefoxURL
rem edge MSEdgeHTM
rem windows 10 20H2 Ç≈ÇÃèâä˙ê›íË
rem edge http	AppXq0fevzme2pys62n3e0fbqa7peapykr8v
rem edge https	AppX90nv6nhay5n6a98fnetv7tpk64pp35es

set ShellFolders=HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice
reg ADD %ShellFolders% /f /v ProgId /t REG_SZ /d "FirefoxURL"

set ShellFolders=HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice
reg ADD %ShellFolders% /f /v ProgId /t REG_SZ /d "FirefoxURL"

