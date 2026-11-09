@echo off
setlocal
set "ROOT=%~dp0"
cd /d "%ROOT%"
if not exist "backend-MotoPRO\.env" (
 echo Configure backend-MotoPRO\.env usando CONFIGURAR_WINDOWS.bat.
 pause
 exit /b 1
)
if not exist "frontend-MotoPRO\.env.local" (
 echo Configure frontend-MotoPRO\.env.local usando CONFIGURAR_WINDOWS.bat.
 pause
 exit /b 1
)
if not exist "node_modules" (
 echo Execute INSTALAR_WINDOWS.bat antes de iniciar.
 pause
 exit /b 1
)
start "MotoPRO - API" cmd /k "cd /d ""%ROOT%"" && npm run dev:backend"
start "MotoPRO - WEB" cmd /k "cd /d ""%ROOT%"" && npm run dev:frontend"
echo.
echo MotoPRO backend: http://localhost:4000/api/health
echo MotoPRO frontend: http://localhost:3000
echo As janelas abertas devem permanecer ativas.
pause
