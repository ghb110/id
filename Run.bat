@echo off
setlocal enabledelayedexpansion

:: 设置文件夹路径
set "folderPath=%AppData%\RustDesk\config"
if not exist "%folderPath%" (
    echo [错误] 配置文件夹不存在，正在创建...
    mkdir "%folderPath%"
    if errorlevel 1 (
        echo [失败] 无法创建文件夹：%folderPath%
        goto end
    ) else (
        echo [成功] 文件夹已创建：%folderPath%
    )
)

:: 设置配置文件路径
set "outputFile=%folderPath%\RustDesk2.toml"

:: 写入配置内容
(
    echo [options]
    echo verification-method = 'use-both-passwords'
    echo relay-server = 'rustdesk.118558.xyz'
    echo key = '700413'
    echo access-mode = 'full'
    echo custom-rendezvous-server = 'rustdesk.118558.xyz'
) > "%outputFile%"

:: 检查文件是否成功创建
if exist "%outputFile%" (
    echo [成功] 配置文件已创建：%outputFile%
) else (
    echo [失败] 配置文件创建失败！
    goto end
)

:: 启动 RustDesk
echo 正在启动 RustDesk...
start "" "rustdesk-64.exe"
goto end

:end

:: 检查并等待 RustDesk 退出
echo 正在等待 RustDesk安装完成退出...

:waitLoop
tasklist | find /i "rustdesk-64.exe" >nul
if errorlevel 1 (
    echo RustDesk 已退出，准备删除文件...
    goto deleteRustDesk
) else (
    timeout /t 7 >nul
    goto waitLoop
)

:deleteRustDesk
cmd /c del "%~dp0..\rustdesk-64.zip"
cmd /c del "%~dp0\rustdesk-64.exe"
cmd /c del "%~f0"

:: 检查删除结果
if exist "%~dp0\rustdesk-64.exe" (
    echo [失败] rustdesk-64.exe 删除失败！
) else (
    echo [成功] rustdesk-64.exe 已成功删除。
)

if exist "%~dp0..\rustdesk-64.zip" (
    echo [失败] rustdesk-64.zip 删除失败！
) else (
    echo [成功] rustdesk-64.zip 已成功删除。
)
