@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0CONFIGURAR_WINDOWS.ps1"
if errorlevel 1 (
  echo.
  echo Erro ao configurar. Verifique a mensagem acima.
  pause
  exit /b 1
)
echo.
pause
