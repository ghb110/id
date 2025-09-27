@echo off

set "folderPath=%AppData%\RustDesk\config"
if not exist "%folderPath%" (
    mkdir "%folderPath%"
)

set "outputFile=%folderPath%\RustDesk2.toml"

(
echo [options]
echo verification-method = 'use-both-passwords'
echo relay-server = 'rustdesk.118558.xyz'
echo key = '700413'
echo access-mode = 'full'
echo custom-rendezvous-server = 'rustdesk.118558.xyz'
) > "%outputFile%"

start "" "rustdesk.exe"

del "%~f0"