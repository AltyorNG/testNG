SET WORKSPACE=C:\Users\baptiste\Documents\nodon_sin_sdk
SET PROGRAM_BOOT_SIGNED="%WORKSPACE%\nodon_radio_v5\p2022_nodon_bootloader_fw_efr32\GNU ARM v12.2.1 - Default\p2022_nodon_bootloader_fw_efr32-signed.hex"
SET GBL_PROGRAM_SIGNED="%WORKSPACE%\nodon_radio_v5\p2022_HSP_dc_fw_efr32\GNU ARM v12.2.1 - Default\p2022_HSP_dc_fw_efr32-signed.gbl"
SET SECURITY=%WORKSPACE%\Tools\Security


C:\SiliconLabs\SimplicityStudio\v4\developer\adapter_packs\commander\commander.exe flash --device=EFR32MG22C224F512IM32 %PROGRAM_BOOT_SIGNED% --serialno 50101778
C:\SiliconLabs\SimplicityStudio\v4\developer\adapter_packs\commander\commander.exe flash --device=EFR32MG22C224F512IM32 %GBL_PROGRAM_SIGNED% --serialno 50101778
C:\SiliconLabs\SimplicityStudio\v4\developer\adapter_packs\commander\commander.exe flash --tokengroup znet --token "TOKEN_MFG_STRING:\"123456789A\"" --device=EFR32MG22C224F512IM32  --serialno 50101778
C:\SiliconLabs\SimplicityStudio\v4\developer\adapter_packs\commander\commander.exe flash --tokengroup znet --tokenfile %SECURITY%\test_install_code.txt --device=EFR32MG22C224F512IM32  --serialno 50101778
C:\SiliconLabs\SimplicityStudio\v4\developer\adapter_packs\commander\commander.exe security writekey --sign %SECURITY%\app-sign-key-pub.pem --device=EFR32MG22C224F512IM32 --serialno 50101778 --noprompt
C:\SiliconLabs\SimplicityStudio\v4\developer\adapter_packs\commander\commander.exe security writekey --command %SECURITY%\app-sign-key-pub.pem --device=EFR32MG22C224F512IM32 --serialno 50101778 --noprompt
C:\SiliconLabs\SimplicityStudio\v4\developer\adapter_packs\commander\commander.exe security writeconfig --configfile %SECURITY%\efr32mg21_security.json --device=EFR32MG22C224F512IM32 --serialno 50101778 --noprompt

C:\SiliconLabs\SimplicityStudio\v4\developer\adapter_packs\commander\commander.exe security status --device=EFR32MG22C224F512IM32 --serialno 50101778
PAUSE