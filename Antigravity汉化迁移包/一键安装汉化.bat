@echo off
chcp 65001 >nul
title Antigravity 一键安装汉化工具
echo ======================================================
echo          Antigravity 客户端一键汉化部署工具
echo ======================================================
echo.
setlocal
set "TARGET_DIR=%LOCALAPPDATA%\Programs\antigravity\resources"
set "ASAR_SRC="
if exist "%~dp0app.asar" set "ASAR_SRC=%~dp0app.asar"
if "%ASAR_SRC%"=="" if exist "%~dp0Antigravity汉化迁移包\app.asar" set "ASAR_SRC=%~dp0Antigravity汉化迁移包\app.asar"
if "%ASAR_SRC%"=="" if exist "%USERPROFILE%\Desktop\Antigravity汉化迁移包\app.asar" set "ASAR_SRC=%USERPROFILE%\Desktop\Antigravity汉化迁移包\app.asar"
if "%ASAR_SRC%"=="" if exist "C:\Users\赵江\.gemini\antigravity\scratch\final_app.asar" set "ASAR_SRC=C:\Users\赵江\.gemini\antigravity\scratch\final_app.asar"
if "%ASAR_SRC%"=="" (
    echo [错误] 未在当前目录或迁移包中找到 app.asar 汉化文件！
    pause
    exit /b 1
)
if not exist "%TARGET_DIR%" (
    echo [错误] 未检测到 Antigravity 安装目录：%TARGET_DIR%
    echo 请确认本机已安装 Antigravity 客户端。
    pause
    exit /b 1
)
echo [1/4] 正在关闭运行中的 Antigravity 进程...
taskkill /f /im Antigravity.exe >nul 2>&1
taskkill /f /im language_server.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo [2/4] 备份官方原始文件 (仅首次自动备份)...
if not exist "%TARGET_DIR%\app.asar.bak" if exist "%TARGET_DIR%\app.asar" copy /y "%TARGET_DIR%\app.asar" "%TARGET_DIR%\app.asar.bak" >nul
echo [3/4] 清理自动更新缓存并阻断官方覆盖...
if exist "%LOCALAPPDATA%\antigravity-updater" rd /s /q "%LOCALAPPDATA%\antigravity-updater" >nul 2>&1
echo [4/4] 正在安装全新汉化包: %ASAR_SRC%
copy /y "%ASAR_SRC%" "%TARGET_DIR%\app.asar" >nul
if errorlevel 1 (
    echo [错误] 替换汉化包失败！请以管理员身份运行或检查文件占用。
    pause
    exit /b 1
)
echo [5/5] 正在在独立进程中启动 Antigravity...
powershell -NoProfile -Command Start-Process -FilePath '%LOCALAPPDATA%\Programs\antigravity\Antigravity.exe'
echo.
echo ======================================================
echo   汉化安装成功！已在独立进程中启动 Antigravity。
echo.
echo   【终端关闭说明】
echo   - Antigravity 进程已完全脱钩独立运行，
echo     您可以随时关闭本窗口，绝不会影响 Antigravity！
echo ======================================================
echo.
echo 按任意键退出本窗口 (或直接点击右上角关闭)...
pause >nul
endlocal
