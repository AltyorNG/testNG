@echo off 
rem parameter 1 is signed bootloader hex
rem parameter 2 is GBL signed firmware .gbl
rem parameter 3 is Security txt files Path
rem parameter 4 is Serial number
rem parameter 5 is Path commander.exe


REM Recover board first in case of rework
%5 device --device  EFR32MG21A010F1024IM32 recover

timeout /t 2 /nobreak

REM update Secure Engine
%5 flash --masserase  %SECURITY%\s2c1_se_fw_upgrade_app_1v2p13.hex --device=EFR32MG21A010F1024IM32
timeout /t 2 /nobreak

REM recover again to allow flash of the customer FW
%5 device --device  EFR32MG21A010F1024IM32 recover
timeout /t 2 /nobreak

REM Write the public key used for the secure boot in the OTP
REM %5 security writekey --sign %3\WISER_POWER_MICROMODULE_Signature-pub.pem --device=EFR32MG21A010F1024IM32 --noprompt
REM timeout /t 1 /nobreak
REM %5 security readkey --sign --device=EFR32MG21A010F1024IM32

REM Write Secure Boot settings and anti-tamper configuration
REM %5 security writeconfig --configfile %3\efr32mg21_security.json --device=EFR32MG21A010F1024IM32 --noprompt
REM timeout /t 2 /nobreak

REM Flash the bootloader + firmware signed.
%5  flash --masserase --device=EFR32MG21A010F1024IM32 %1
%5  flash --masserase --device=EFR32MG21A010F1024IM32 %1
%5  flash --device=EFR32MG21A010F1024IM32  %2
timeout /t 1 /nobreak

REM verify content
%5 verify %1 --device=EFR32MG21A010F1024IM32
%5 verify %2 --device=EFR32MG21A010F1024IM32
timeout /t 1 /nobreak

REM ======= [REQ] ABO 2023/09/26 - Bloc deplace (enlever le masserase). 
REM Flash encryption key used for the OTA Power board firmware check
%5 flash --tokengroup znet --tokenfile %3\app-encrypt-key.txt --device=EFR32MG21A010F1024IM32

REM save the HW version, "AABB" with AA major version and BB the minor version in decimal format
%5 flash --tokengroup znet --token "TOKEN_MFG_BOARD_NAME:\"%4\"" --device=EFR32MG21A010F1024IM32

REM add Install code
%5 flash --tokengroup znet --tokenfile %3\install-code.txt --device=EFR32MG21A010F1024IM32


REM status check
REM %5 security status --device=EFR32MG21A010F1024IM32