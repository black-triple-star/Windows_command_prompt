rem #####################################
rem 改行コードがCR+LFでないと動作しません
rem #####################################
chcp 65001
chcp 932

rem 単語登録の方法

rem windows 10 64bit の場合（OSによってパスが代わる）
start /d  C:\Windows\SysWOW64\IME\IMEJP    /b IMJPDCT.EXE

rem alt + T を押して、ユーザー辞書ツールを起動し
rem alt + T T を押して、「テキストファイルからの登録」を選択
rem 単語登録_imeのユーザー辞書.txt を選択してエンター
