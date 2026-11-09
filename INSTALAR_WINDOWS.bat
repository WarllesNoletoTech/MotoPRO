@echo off
setlocal
set "ROOT=%~dp0"
echo Instalando dependencias do backend...
cd /d "%ROOT%backend"
call npm install
if errorlevel 1 (echo Falha ao instalar o backend.&pause&exit /b 1)
echo Instalando dependencias do frontend...
cd /d "%ROOT%frontend"
call npm install
if errorlevel 1 (echo Falha ao instalar o frontend.&pause&exit /b 1)
echo.
echo Dependencias instaladas. Configure os arquivos .env e .env.local.
pause
