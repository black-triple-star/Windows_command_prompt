rem #####################################
rem ���s�R�[�h��CR+LF�łȂ��Ɠ��삵�܂���
rem #####################################
chcp 65001
chcp 932

@echo off
cls

rem �������蓮�œ�������
rem �Ǘ��Ҍ����Ŏ��s���邱��


rem https://go-journey.club/archives/9494

rem Windows Time �T�[�r�X�̐ݒ���e���m�F����
w32tm /query /configuration

rem ���݂ǂ� NTP �T�[�o�[���Q�Ƃ��Ă���̂��m�F
w32tm /query /source

rem NTP�T�[�o�[���̏�Ԃ��m�F����
rem �upeers�v�I�v�V������t���邱�Ƃ� �ǂ� NTP �T�[�o�[�Ɠ������Ƃ��Ă���̂��ANTP �T�[�o�[���̏�Ԃ͂ǂ��Ȃ��Ă���̂����m�F���邱�Ƃ��ł��܂��B

w32tm /query /peers

rem NTP�T�[�o�[�ƒʐM���o���Ă��邩�R�}���h�Ŋm�F����
rem w32tm /monitor /computers:ntp.nict.jp
rem w32tm /monitor /computers:time.windows.com

rem ���� NTP �T�[�o�[�Ƃ̎��������̏�Ԃ��m�F�������ꍇ�́ustatus�v�I�v�V������t���܂��B
w32tm /query /status /verbose

rem �蓮�œ�������R�}���h
w32tm /resync

echo ####################################################################
echo �����������s���Ȃ��ꍇ�AWindows Time �T�[�r�X���N�����Ă�������
echo Windows Time�T�[�r�X�� ActiveDirectory�h���C���ɑ����Ă��Ȃ��ꍇ����
echo �N�����Ȃ��悤�ɂȂ��Ă܂��B
echo ####################################################################
echo �I�����܂����B���̃E�B���h�E����Ă��������B
pause>nul
