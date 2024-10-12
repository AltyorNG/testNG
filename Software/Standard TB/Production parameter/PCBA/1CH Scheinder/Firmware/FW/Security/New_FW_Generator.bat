
set Commander_path="E:\Dev\1899 - SIN 4-1\1873 - Gateway Main Board
echo 
@echo off %Commander_path%\Commander\commander.exe"
rem parameter 1 is signed bootloader hex
rem parameter 2 is GBL signed firmware .gbl
rem parameter 3 is Security txt files Path
rem parameter 4 is Serial number

commander.exe convert --secureboot %PROGRAM_BOOT% --keyfile %SECURITY%\app-sign-key.pem -o %PROGRAM_BOOT_SIGNED%
commander.exe convert --secureboot %PROGRAM% --keyfile %SECURITY%\app-sign-key.pem -o %PROGRAM_SIGNED%

commander.exe gbl create %GBL_PROGRAM_SIGNED% --app %PROGRAM_SIGNED% --sign %SECURITY%\app-sign-key.pem

