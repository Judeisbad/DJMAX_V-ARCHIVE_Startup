@echo off

REM V-아카이브 파일 ""바로가기"" 위치
set VArchiveLocation="E:\Software\v-archive_v0.4\v-archive.lnk"

REM 프로그램이 닫힌지 확인하는 주기
set /A checkTime=10

REM 프로그램이 시작할때까지의 시간
set /A startupTime=20

REM 디맥 위치 (웬만하면 바꾸지 않아도 될거같음)
set DJMAXLocation=steam://rungameid/960170

REM 디맥과 V-아카이브 실행
start /b "" %VArchiveLocation% > NUL 2>&1
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
