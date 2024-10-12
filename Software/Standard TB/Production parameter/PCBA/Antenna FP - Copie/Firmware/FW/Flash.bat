
rem @echo off 
rem parameter 1 is signed bootloader hex
rem parameter 2 is GBL signed firmware .gbl
rem parameter 3 is Security txt files Path
rem parameter 4 is Serial number
rem parameter 5 is Path commander.exe

echo %1
echo %2
echo %3
echo %4
echo %5

rem %5 convert --secureboot %PROGRAM_BOOT% --keyfile %SECURITY%\app-sign-key.pem -o %PROGRAM_BOOT_SIGNED%
rem %5 convert --secureboot %PROGRAM% --keyfile %SECURITY%\app-sign-key.pem -o %PROGRAM_SIGNED%

rem %5 gbl create %GBL_PROGRAM_SIGNED% --app %PROGRAM_SIGNED% --sign %SECURITY%\app-sign-key.pem

%5 flash --masserase  %3\s2c1_se_fw_upgrade_app_1v2p1.hex --device=EFR32MG21A010F1024IM32

%5 flash --device=EFR32MG21A010F1024IM32 %1
%5 flash --device=EFR32MG21A010F1024IM32 %2
rem %5 security writekey --sign %3\app-sign-key-pub.pem --device=EFR32MG21A010F1024IM32 --noprompt
rem %5 security readkey --sign --device=EFR32MG21A010F1024IM32
rem %5 security writekey --command %3\app-sign-key-pub.pem --device=EFR32MG21A010F1024IM32 --noprompt
rem %5 security writeconfig --configfile %3\efr32mg21_security.json --device=EFR32MG21A010F1024IM32 --noprompt
%5 flash --tokengroup znet --tokenfile %3\app-encrypt-key.txt --tokenfile %3\app-sign-key.pem-tokens.txt --device=EFR32MG21A010F1024IM32 
%5 flash --tokengroup znet --token "TOKEN_MFG_STRING:\"%4\"" --device=EFR32MG21A010F1024IM32
%5 flash --tokengroup znet --tokenfile %3\install-code.txt --device=EFR32MG21A010F1024IM32
rem %5 security lockconfig --secure-debug-unlock enable --device=EFR32MG21A010F1024IM32
rem %5 security lock --device EFR32MG21A010F1024 --device=EFR32MG21A010F1024IM32

rem %5 security status --device=EFR32MG21A010F1024IM32