@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0CONFIGURAR_WINDOWS.ps1"
if errorlevel 1 (
 echo.
 echo Falha na configuracao. Veja a mensagem acima.
 pause
 exit /b 1
)
echo.
echo Configuracao local finalizada.
pause
