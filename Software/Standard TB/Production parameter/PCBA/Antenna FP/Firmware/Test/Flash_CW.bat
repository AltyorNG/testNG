
rem @echo off 
rem parameter 1 is CW firmware .hex
rem parameter 2 is folder commander.exe

echo %1 
echo %2

%2 device masserase --device=EFR32MG21A010F1024IM32

%2 flash --device=EFR32MG21A010F1024IM32 %1