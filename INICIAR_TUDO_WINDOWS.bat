@echo off
setlocal
set "ROOT=%~dp0"
if not exist "%ROOT%backend\.env" (
 echo Primeiro execute CONFIGURAR_WINDOWS.bat para configurar MongoDB e JWT.
 pause
 exit /b 1
)
if not exist "%ROOT%frontend\.env.local" (
 echo Arquivo frontend\.env.local ausente. Execute CONFIGURAR_WINDOWS.bat.
 pause
 exit /b 1
)
if not exist "%ROOT%backend\node_modules" (
 echo Dependencias do backend ausentes. Execute INSTALAR_WINDOWS.bat.
 pause
 exit /b 1
)
if not exist "%ROOT%frontend\node_modules" (
 echo Dependencias do frontend ausentes. Execute INSTALAR_WINDOWS.bat.
 pause
 exit /b 1
)
pushd "%ROOT%backend"
node scripts/diagnostico.mjs
if errorlevel 1 (
 echo A conexao MongoDB falhou. Corrija a configuracao e tente novamente.
 popd
 pause
 exit /b 1
)
popd
start "MotoPRO API" cmd /k "cd /d ""%ROOT%backend"" && npm run dev"
start "MotoPRO Web" cmd /k "cd /d ""%ROOT%frontend"" && npm run dev"
echo Abrindo backend na porta 4000 e frontend na porta 3000.
echo Confira o terminal do backend antes de testar o cadastro.
pause
