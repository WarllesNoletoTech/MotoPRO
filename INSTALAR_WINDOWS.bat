@echo off
setlocal
cd /d "%~dp0"
if not exist "backend-MotoPRO\package.json" (
 echo ERRO: backend-MotoPRO nao encontrado.
 pause
 exit /b 1
)
if not exist "frontend-MotoPRO\package.json" (
 echo ERRO: frontend-MotoPRO nao encontrado.
 pause
 exit /b 1
)
echo Instalando dependencias dos dois projetos via npm workspaces...
call npm install
if errorlevel 1 (
 echo Falha na instalacao de dependencias.
 pause
 exit /b 1
)
echo.
echo Instalacao concluida.
pause
