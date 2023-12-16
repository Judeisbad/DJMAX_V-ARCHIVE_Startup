@echo off
chcp 65001 > nul

REM V-아카이브 파일 ""바로가기"" 위치 ("" 포함)
set VArchiveLocation="FOLDER/NAME.lnk"

REM 디맥 위치 ("" 포함)
set DJMAXLocation="C:\Program Files (x86)\Steam\steamapps\common\DJMAX RESPECT V\DJMAX RESPECT V.exe"

if "%VArchiveLocation:~1,-1%" equ "FOLDER/NAME.lnk" (
    echo __________ 오류: V-아카이브 폴더 위치를 변경해주세요 __________
    pause
    exit
)

REM 디맥과 V-아카이브 실행
start /b "" "%VArchiveLocation:~1,-1%" > NUL 2>&1
start /b /wait "" "%DJMAXLocation:~1,-1%" > NUL 2>&1

echo 디맥 종료 확인. V-아카이브를 종료합니다.
taskkill /f /im "v-archive.exe" /t > NUL
echo V-아카이브 종료.
