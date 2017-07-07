@echo off

set PythonRegKey=
set PythonRegKey27Machine=HKLM\SOFTWARE\Python\PythonCore\2.7
set PythonRegKey27User=HKCU\SOFTWARE\Python\PythonCore\2.7

reg query %PythonRegKey27Machine%\InstallPath /ve >nul 2>&1 && set PythonRegKey=%PythonRegKey27Machine%
reg query %PythonRegKey27User%\InstallPath /ve >nul 2>&1 && set PythonRegKey=%PythonRegKey27User%

if not defined PythonRegKey (echo Cannot find Windows Python >&2 & exit /b 1)

for /f "tokens=2,*" %%i in ('reg query %PythonRegKey%\InstallPath /ve') do (
    set PythonInstallPath=%%j
)

set PYTHONPATH=%~dp0
"%PythonInstallPath%\python.exe" %~dp0simpletap.py %~dp0\%1 %2 %3
