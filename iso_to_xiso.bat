@echo off
setlocal enabledelayedexpansion

:: =====================================================
::    XBOX ISO EXTRACTION AND ORGANIZATION SCRIPT
:: =====================================================

echo.
echo ===============================================
echo     XBOX ISO EXTRACTOR (by Shiro)
echo ===============================================
echo.

:: Create folders if they don't exist
if not exist "XISO" (
    mkdir "XISO"
    echo [+] Folder XISO created.
) else (
    echo [=] Folder XISO already exists.
)

if not exist "REDUMP" (
    mkdir "REDUMP"
    echo [+] Folder REDUMP created.
) else (
    echo [=] Folder REDUMP already exists.
)

echo.
echo === Starting ISO extraction... ===
echo.

:: Process each ISO in the current directory
for %%a in (*.iso) do (
    echo [*] Extracting: %%a
    extract-xiso -r "%%a" >nul 2>&1

    if !errorlevel! == 0 (
        echo     [OK] %%a extracted successfully.
    ) else (
        echo     [ERROR] Failed to extract %%a
    )
    echo.
)

echo.
echo === Moving processed ISOs to ./XISO ===
echo.
for %%a in (*.iso) do (
    move /Y "%%a" "XISO\\%%a" >nul 2>&1
    if !errorlevel! == 0 (
        echo     [OK] %%a moved to XISO
    ) else (
        echo     [ERROR] Could not move %%a
    )
)

echo.
echo === Moving redumps to ./REDUMP ===
echo.
for %%a in (*.iso.old) do (
    move /Y "%%a" "REDUMP\\%%~na" >nul 2>&1
    if !errorlevel! == 0 (
        echo     [OK] %%a moved to REDUMP as %%~na
    ) else (
        echo     [ERROR] Could not move %%a
    )
)

echo.
echo ===============================================
echo         PROCESS COMPLETED 🎮
echo ===============================================
echo.
pause
