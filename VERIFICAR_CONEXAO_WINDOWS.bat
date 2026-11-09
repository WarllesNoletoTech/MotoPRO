@echo off
setlocal
cd /d "%~dp0backend"
if not exist ".env" (
 echo backend\.env nao existe. Execute CONFIGURAR_WINDOWS.bat na pasta principal.
 pause
 exit /b 1
)
if not exist "node_modules" (
 echo Dependencias nao instaladas. Execute INSTALAR_WINDOWS.bat na pasta principal.
 pause
 exit /b 1
)
node scripts/diagnostico.mjs
pause
