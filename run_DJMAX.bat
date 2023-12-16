@echo off
chcp 65001 > nul

REM V-아카이브 파일 ""바로가기"" 위치 ("" 포함)
set VArchiveLocation="FOLDER/NAME.lnk"

REM 프로그램이 꺼져있는지 확인하는 주기 (정수, 초)
set /A checkTime=10

REM 프로그램 확인 주기 시작 시간 / 디맥 실행이 보장되는 시간 (정수, 초)
set /A startupTime=5

REM 디맥 위치
set DJMAXLocation="E:\Software\Steam\steamapps\common\DJMAX RESPECT V\DJMAX RESPECT V.exe"

if "%VArchiveLocation:~1,-1%" equ "FOLDER/NAME.lnk" (
    echo __________ 오류: V-아카이브 폴더 위치를 변경해주세요 __________
    pause
    exit
)

if %checkTime% lss 1 (
    echo __________ 오류: 프로그램 확인 주기가 너무 빠릅니다 ^(최소 1, 현재 %checkTime%^) __________
    pause
    exit
)

if %startupTime% lss 0 (
    echo __________ 오류: 프로그램 시작시간이 너무 짧습니다 ^(최소 0, 현재 %startupTime%^) __________
    pause
    exit
)

REM 디맥과 V-아카이브 실행
start /b "" "%VArchiveLocation:~1,-1%" > NUL 2>&1
start /b "" "%DJMAXLocation:~1,-1%" > NUL 2>&1

REM 디맥 실행까지 기다리기
timeout /nobreak /t %startupTime% > NUL

echo 디맥 닫힘 여부 확인을 시작합니다

REM 디맥이 닫힐때까지 기다리기
:wait
tasklist /fi "imagename eq DJMAX RESPECT V.exe" | find ":" > NUL
set djmaxRunning=%errorlevel%

if %djmaxRunning% equ 0 (
    goto :closed
)

timeout /nobreak /t %checkTime% > NUL
goto :wait

:closed
echo 디맥 종료 확인. V-아카이브를 종료합니다.
taskkill /f /im "v-archive.exe" /t > NUL
echo V-아카이브 종료.
