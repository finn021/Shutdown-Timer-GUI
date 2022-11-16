@ECHO OFF
SET CUR_DIR=%~dp0
powershell -NoProfile -ExecutionPolicy Bypass -File "%CUR_DIR%\src\main.ps1"
EXIT
