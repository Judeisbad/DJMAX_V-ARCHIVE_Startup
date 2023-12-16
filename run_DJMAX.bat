@echo off
chcp 65001 > nul

REM V-아카이브 파일 ""바로가기"" 위치 ("" 포함)
set VArchiveLocation="E:\Software\v-archive_v0.4\v-archive.lnk"

REM 프로그램이 꺼져있는지 확인하는 주기 (정수, 초)
set /A checkTime=10

REM 프로그램 확인 주기 시작 시간 / 디맥 실행이 보장되는 시간 (정수, 초)
set /A startupTime=20

REM 디맥 위치
set DJMAXLocation="E:\Software\Steam\steamapps\common\DJMAX RESPECT V\DJMAX RESPECT V.exe"

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
