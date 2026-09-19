@echo off
chcp 65001 >nul
title Antigravity 恢复官方英文原版工具
echo ======================================================
echo          Antigravity 恢复官方英文原版工具
echo ======================================================
echo.
setlocal
set "TARGET_DIR=%LOCALAPPDATA%\Programs\antigravity\resources"
set "RESTORE_FILE="
if exist "%~dp0app_en.asar" set "RESTORE_FILE=%~dp0app_en.asar"
if "%RESTORE_FILE%"=="" if exist "%~dp0Antigravity汉化迁移包\app_en.asar" set "RESTORE_FILE=%~dp0Antigravity汉化迁移包\app_en.asar"
if "%RESTORE_FILE%"=="" if exist "%USERPROFILE%\Desktop\Antigravity汉化迁移包\app_en.asar" set "RESTORE_FILE=%USERPROFILE%\Desktop\Antigravity汉化迁移包\app_en.asar"
if "%RESTORE_FILE%"=="" if exist "%TARGET_DIR%\app.asar.bak" set "RESTORE_FILE=%TARGET_DIR%\app.asar.bak"
if "%RESTORE_FILE%"=="" (
    echo [错误] 未找到官方英文原版包（app_en.asar 或 app.asar.bak）！
    pause
    exit /b 1
)
echo [1/3] 正在彻底结束运行中的 Antigravity 进程...
taskkill /f /im Antigravity.exe >nul 2>&1
taskkill /f /im language_server.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo [2/3] 正在还原官方英文原版核心包: %RESTORE_FILE%
copy /y "%RESTORE_FILE%" "%TARGET_DIR%\app.asar" >nul
if errorlevel 1 (
    echo [错误] 还原失败！请检查文件是否被占用。
    pause
    exit /b 1
)
echo [3/3] 正在在独立进程中启动官方英文版 Antigravity...
powershell -NoProfile -Command Start-Process -FilePath '%LOCALAPPDATA%\Programs\antigravity\Antigravity.exe'
echo.
echo ======================================================
echo   已成功恢复官方英文原版！已在独立进程中启动。
echo.
echo   【终端关闭说明】
echo   - Antigravity 进程已完全脱钩独立运行，
echo     您可以随时关闭本窗口，绝不会影响 Antigravity！
echo ======================================================
echo.
echo 按任意键退出本窗口 (或直接点击右上角关闭)...
pause >nul
endlocal
