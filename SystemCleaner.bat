@echo off
color 0A
title Limpador de Sistema - Substituto Gratuito do IObit
echo.
echo ===============================================
echo    LIMPADOR DE SISTEMA - VERSAO GRATUITA
echo    Substituto do IObit Uninstaller (SEM ADS)
echo ===============================================
echo.

:menu
echo [1] Limpeza Completa (Recomendado)
echo [2] Limpar apenas Arquivos Temporarios
echo [3] Limpar Registro do Windows
echo [4] Mostrar Espaco Liberado
echo [5] Desinstalar Programas (Interface Windows)
echo [6] Sair
echo.
set /p choice=Digite sua opcao (1-6): 

if "%choice%"=="1" goto limpeza_completa
if "%choice%"=="2" goto limpar_temp
if "%choice%"=="3" goto limpar_registro
if "%choice%"=="4" goto mostrar_espaco
if "%choice%"=="5" goto desinstalar
if "%choice%"=="6" goto sair
goto menu

:limpeza_completa
echo.
echo Iniciando limpeza completa...
echo.
echo [1/5] Limpando arquivos temporarios do usuario...
del /q /f /s "%TEMP%\*" 2>nul
rd /s /q "%TEMP%" 2>nul
mkdir "%TEMP%"

echo [2/5] Limpando cache do Windows...  
del /q /f /s "%WINDIR%\Temp\*" 2>nul
del /q /f /s "%WINDIR%\Prefetch\*" 2>nul

echo [3/5] Limpando cache do navegador...
del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\INetCache\*" 2>nul
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*" 2>nul
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*" 2>nul

echo [4/5] Limpando logs do sistema...
del /q /f /s "%WINDIR%\Logs\*" 2>nul
del /q /f /s "%LOCALAPPDATE%\CrashDumps\*" 2>nul

echo [5/5] Executando limpeza de disco nativa do Windows...
cleanmgr /sagerun:1 2>nul

echo.
echo === LIMPEZA COMPLETA FINALIZADA ===
echo.
pause
goto menu

:limpar_temp
echo.
echo Limpando apenas arquivos temporarios...
del /q /f /s "%TEMP%\*" 2>nul
del /q /f /s "%WINDIR%\Temp\*" 2>nul
del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\INetCache\*" 2>nul
echo Arquivos temporarios removidos!
pause
goto menu

:limpar_registro
echo.
echo AVISO: Backup automatico sera criado em C:\backup_registry.reg
reg export HKLM C:\backup_registry.reg /y >nul
powershell -Command "Get-ChildItem 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' | Where-Object { -not (Test-Path $_.GetValue('UninstallString') -ErrorAction SilentlyContinue) } | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue"
echo Registro limpo! Backup em: C:\backup_registry.reg
pause
goto menu

:mostrar_espaco
echo.
powershell -Command "Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | ForEach-Object { Write-Host 'Drive' $_.DeviceID 'Livre:' ([math]::Round($_.FreeSpace/1GB,2)) 'GB de' ([math]::Round($_.Size/1GB,2)) 'GB' }"
pause
goto menu

:desinstalar
appwiz.cpl
goto menu

:sair
echo.
echo Obrigado por usar o Limpador GRATUITO!
echo Muito melhor que IObit e outros pagos! :)
pause
exit