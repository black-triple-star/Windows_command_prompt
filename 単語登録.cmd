rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932



rem C:\Program Files\Common Files\Microsoft Shared\IME14\IMEJP\
rem start /d C:\Progra~1\Common~1\Micros~1\IME14\IMEJP   /b IMJPDCT.EXE

rem windows 10 64bit の場合
start /d  C:\Windows\SysWOW64\IME\IMEJP    /b IMJPDCT.EXE

