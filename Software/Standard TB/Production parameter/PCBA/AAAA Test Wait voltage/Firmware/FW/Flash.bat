
rem @echo off 
rem parameter 1 is signed bootloader hex
rem parameter 2 is GBL signed firmware .gbl
rem parameter 3 is Security txt files Path
rem parameter 4 is Serial number
rem parameter 5 is Path commander.exe

%5 flash --device=EFR32MG22C224F512IM32 %1
%5 flash --device=EFR32MG22C224F512IM32 %2
%5 flash --tokengroup znet --token "TOKEN_MFG_STRING:\"123456789A\"" --device=EFR32MG22C224F512IM32
%5 flash --tokengroup znet --tokenfile %3\install-code.txt --device=EFR32MG22C224F512IM32
%5 security writekey --sign %3\app-sign-key-pub.pem --device=EFR32MG22C224F512IM32 --noprompt
%5 security writekey --command %3\app-sign-key-pub.pem --device=EFR32MG22C224F512IM32 --noprompt
%5 security writeconfig --configfile %3\efr32mg21_security.json --device=EFR32MG22C224F512IM32 --noprompt

%5 security status --device=EFR32MG22C224F512IM32