@echo off
setlocal
cd /d "%~dp0backend-MotoPRO"
if not exist ".env" (
 echo backend-MotoPRO\.env nao existe. Execute CONFIGURAR_WINDOWS.bat.
 pause
 exit /b 1
)
if not exist "scripts\diagnostico.mjs" (
 echo O diagnostico nao foi encontrado no backend.
 pause
 exit /b 1
)
node scripts/diagnostico.mjs
if errorlevel 1 (
 echo A verificacao identificou falha na conexao. Confirme host, senha e IP no Atlas.
 pause
 exit /b 1
)
pause
