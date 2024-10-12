
rem parameter 1 is Path commander.exe

REM Lock the device
%1 security lock --device EFR32MG21A010F1024 --device=EFR32MG21A010F1024IM32
REM Check status
%1 security status --device=EFR32MG21A010F1024IM32