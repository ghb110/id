@echo off
setlocal enabledelayedexpansion

:: �����ļ���·��
set "folderPath=%AppData%\RustDesk\config"
if not exist "%folderPath%" (
    echo [����] �����ļ��в����ڣ����ڴ���...
    mkdir "%folderPath%"
    if errorlevel 1 (
        echo [ʧ��] �޷������ļ��У�%folderPath%
        goto end
    ) else (
        echo [�ɹ�] �ļ����Ѵ�����%folderPath%
    )
)

:: ���������ļ�·��
set "outputFile=%folderPath%\RustDesk2.toml"

:: д����������
(
    echo [options]
    echo verification-method = 'use-both-passwords'
    echo relay-server = 'rustdesk.118558.xyz'
    echo key = '700413'
    echo access-mode = 'full'
    echo custom-rendezvous-server = 'rustdesk.118558.xyz'
) > "%outputFile%"

:: ����ļ��Ƿ�ɹ�����
if exist "%outputFile%" (
    echo [�ɹ�] �����ļ��Ѵ�����%outputFile%
) else (
    echo [ʧ��] �����ļ�����ʧ�ܣ�
    goto end
)

:: ���� RustDesk
echo �������� RustDesk...
start "" "rustdesk-64.exe"
goto end

:end

:: ��鲢�ȴ� RustDesk �˳�
echo ���ڵȴ� RustDesk��װ����˳�...

:waitLoop
tasklist | find /i "rustdesk-64.exe" >nul
if errorlevel 1 (
    echo RustDesk ���˳���׼��ɾ���ļ�...
    goto deleteRustDesk
) else (
    timeout /t 7 >nul
    goto waitLoop
)

:deleteRustDesk
cmd /c del "%~dp0..\rustdesk-64.zip"
cmd /c del "%~dp0\rustdesk-64.exe"
cmd /c del "%~f0"

:: ���ɾ�����
if exist "%~dp0\rustdesk-64.exe" (
    echo [ʧ��] rustdesk-64.exe ɾ��ʧ�ܣ�
) else (
    echo [�ɹ�] rustdesk-64.exe �ѳɹ�ɾ����
)

if exist "%~dp0..\rustdesk-64.zip" (
    echo [ʧ��] rustdesk-64.zip ɾ��ʧ�ܣ�
) else (
    echo [�ɹ�] rustdesk-64.zip �ѳɹ�ɾ����
)
