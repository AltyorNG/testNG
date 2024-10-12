Generate security keys
In order to use the security features of the Gecko Bootloader, encryption and signing keys need to be generated. These keys must be then written to the EFR32 device. The encryption key is used with the GBL file for secure firmware update. The signing keys are used both with the GBL file for secure firmware update and to sign the application image for Secure Boot.

You can create security keys with Simplicity Commander:

For ease of use add the Commander path (C:\SiliconLabs\SimplicityStudio\v4\developer\adapter_packs\commander) to the Path environment variable in your OS
Generate signing keys with the following command in command line
 
commander gbl keygen --type ecc-p256 --outfile app-sign-key.pem
This creates three files: app-sign-key.pem, app-sign-key.pem.pub, and app-sign-key.pem-token.txt. The first contains the private key (keep it secret), the other two contain the public key which has to be flashed to the device.

Generate encryption key with the following command in command line
 
commander gbl keygen --type aes-ccm --outfile app-encrypt-key.txt
This creates one file named app-encrypt-key.txt

Flash security keys
Write the two token files containing the encryption key and public key as manufacturing tokens to the device

Issue the following command:
commander flash --tokengroup znet --tokenfile app-encrypt-key.txt --tokenfile app-sign-key.pem-tokens.txt --device EFR32MG13P632F512GM48
