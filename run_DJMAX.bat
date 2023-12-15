@echo off
chcp 65001 > nul

REM V-아카이브 파일 ""바로가기"" 위치 ("" 포함)
set VArchiveLocation="FOLDER/NAME.lnk"

REM 프로그램이 꺼져있는지 확인하는 정수 주기 (초)
set /A checkTime=10

REM 프로그램 확인 주기 시작 시간 | 디맥 실행이 보장되는 정수 시간 (초)
set /A startupTime=20

REM 디맥 위치 (웬만하면 바꾸지 않아도 될거같음)
set DJMAXLocation=steam://rungameid/960170

if "%VArchiveLocation:~1,-1%" equ "FOLDER/NAME.lnk" (
    echo __________ V-아카이브 폴더 위치를 변경해주세요 __________
    pause
    exit
)

if %checkTime% lss 1 (
    echo __________ 프로그램 확인 주기가 너무 빠릅니다 ^(최소 1, 현재 %checkTime%^) __________
    pause
    exit
)

if %startupTime% lss 0 (
    echo __________ 프로그램 시작시간이 너무 짧습니다 ^(최소 0, 현재 %startupTime%^) __________
    pause
    exit
)

REM 디맥과 V-아카이브 실행
start /b "" "%VArchiveLocation%" > NUL 2>&1
start /b "" %DJMAXLocation% > NUL 2>&1
timeout /nobreak /t %startupTime% > NUL

REM 디맥 닫힐때까지 기다리기
:wait
timeout /nobreak /t %checkTime% > NUL

tasklist /fi "imagename eq DJMAX RESPECT V.exe" | find ":" > NUL
set djmaxClosed=%errorlevel%

if %djmaxClosed% equ 0 (
    goto :closed
)

goto :wait

:closed
echo 디맥 종료 확인. V-아카이브를 종료합니다.
taskkill /f /im "v-archive.exe" /t > NUL
echo V-아카이브 종료.
