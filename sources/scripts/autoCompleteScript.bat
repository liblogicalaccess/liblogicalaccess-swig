@echo off

set PythonRegKey=
set PythonRegKey36Machine=HKLM\SOFTWARE\Python\PythonCore\3.6
set PythonRegKey36User=HKCU\SOFTWARE\Python\PythonCore\3.6

reg query %PythonRegKey36Machine%\InstallPath /ve >nul 2>&1 && set PythonRegKey=%PythonRegKey36Machine%
reg query %PythonRegKey36User%\InstallPath /ve >nul 2>&1 && set PythonRegKey=%PythonRegKey36User%

if not defined PythonRegKey (echo Cannot find Windows Python >&2 & exit /b 1)

for /f "tokens=2,*" %%i in ('reg query %PythonRegKey%\InstallPath /ve') do (
    set PythonInstallPath=%%j
)

set PYTHONPATH=%~dp0

set PYTHONPATH=%~dp0
"%PythonInstallPath%\python.exe" %~dp0\autoComplete.py