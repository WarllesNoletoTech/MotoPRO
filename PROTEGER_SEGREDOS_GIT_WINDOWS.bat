@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0PROTEGER_SEGREDOS_GIT_WINDOWS.ps1"
if errorlevel 1 (
 echo Falha ao verificar arquivos ignorados.
 pause
 exit /b 1
)
pause
