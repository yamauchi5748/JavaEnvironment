@echo off
setlocal
pushd "%~dp0"

set selfname=%~n0
set prfix=docker-compose
set ret_success=echo successed!
set ret_fail=echo error! %~n0

if "%1"=="up" (
    docker-compose up -d
    exit /b %ret_success%
)

if "%1"=="down" (
    docker-compose down
    exit /b %ret_success%
)

if "%1"=="ps" (
    docker-compose ps
    exit /b %ret_success%
)

if "%1"=="build" (
    if "%2"=="--no-cache" (
        %prfix% build --no-cache
    ) else (
        %prfix% build
    )
    exit /b %ret_success%
)

if "%1"=="login" (
    docker-compose exec java bash
    exit /b %ret_success%
)

if "%1"=="help" (
    call :usage
    exit /b %ret_success%
)

if "%2"=="" (
    call :abort Parameter `op2` required. you should command 'cmd help'.
    exit /b %ret_fail%
)

exit /b %ret_fail%

rem ----------
rem subrootins
rem ----------

:usage
echo [Usage]
echo %selfname% help            : Show the usage.
echo %selfname% up              : Docker containers start and up.
echo %selfname% down            : Docker containers down. If you stop working, you should command this. 
echo %selfname% ps              : Check docker container configuration.
echo %selfname% login           : Login to Java container.
exit /b

:abort
echo (%selfname%) Error! %*
exit /b