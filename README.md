Pi PADD HAB Chase App
=====================

This is an all-in-one program for receiving LoRa HAB telemetry and showing the balloon on a Google map.

Its for Raspberry Pi only, ideally with a touchscreen (the official 7" touchscreen works very well).

This application performs the most important functions needed when chasing a balloon:

- Receives local (GPS) location from a serial GPS receiver, and uploads to Habitat server
- Receives tracker telemetry via LoRa SPI receiver, and uploads to Habitat server
- Shows distance and direction to balloon
- Shows balloon and Pi on a map
- Provides driving directions to the balloon
- Uploads received image data (SSDV)
- Support for up to 3 payloads



LoRa Receiver
===========

For this you will need to a suitable LoRa expansion board or USB serial LoRa device, for example:

- [Uputronics LoRa board](https://store.uputronics.com/index.php?route=product/product&product_id=68)
- [Uputronics LoRaGo Adapter](https://store.uputronics.com/index.php?route=product/product&product_id=111&search=lorago)



GPS Receiver
===========

Any GPS HAT for the Pi should work fine.




Installation
============

- Create SD containing the latest Pi OS  (full, 32-bit)
- Connect the Pi to the display, USB keyboard and (if not using a touchscreen) a mouse
- Connect the Pi to power
- Follow the Pi configuration wizard
- After reboot, run Raspberry Pi Configuration:
  - Set the hostname
  - Enable these interfaces: SSH, VNC, SPI, Serial (no console)
- Disable bluetooth:
  - edit /boot/config.txt
  - append this line: dtoverlay=pi3-disable-bt
  - save the file
  - Run this command: sudo systemctl disable hciuartsudo
- Run this command: sudo apt install libwebkit2gtk-4.0-dev
- Run this command: sudo apt install samba
- Set up a SAMBA share to by running the command sudo vi /etc/samba/smb.conf
- and then appending the following
  - comment = Pi Home Folder
    path = /home/pi
    writeable = Yes
    only guest = Yes
    create mask = 0777
    directory mask = 0777
    browseable = Yes
    public = yes
- Copy the 2 supplied font files to the  /home/pi/.fonts folder
- Copy the supplied binary to the /home/pi folder
- (optional) Install text-to-speech with this command:  sudo apt install espeak



Configuration
=============

Start the app, then touch the Settings button.  You will then see ....

### General Settings ###

Enter your ham radio callsign or other unique name, as one word.  This is used for uploading telemetry to habhub.

If you want a beep for each new position, click "Position Beeps"

If you want an alarm sound at significant evens, e.g. balloon burst, click "Alarm Beeps"

If you want spoken announcements at significant evens, e.g. balloon burst, click "Speech"

### GPS Settings ###

Enter chase car ID - a unique name for your vehicle when chasing the balloon.  This is used to place your position on the habhub map.

Set the period between chase car uploads e.g. 30 (seconds)

Click "Enable Upload" to enable upload of your position.

### LoRa HAT Settings ###

This has settings for Ch0 and Ch1 (CE0 and CE1 on the LoRa HAT).

Frequency:	This sets the frequency for LoRa module.

AFC enables Automatic frequency Control

Mode: Sets the "mode" for the LoRa module, which is one of:
				
	0 = (normal for telemetry)	Explicit mode, Error coding 4:8, Bandwidth 20.8kHz, SF 11, Low data rate optimize on
	1 = (normal for SSDV) 		Implicit mode, Error coding 4:5, Bandwidth 20.8kHz,  SF 6, Low data rate optimize off
	2 = (normal for repeater)	Explicit mode, Error coding 4:8, Bandwidth 62.5kHz,  SF 8, Low data rate optimize off
	3 = (normal for fast SSDV)	Explicit mode, Error coding 4:6, Bandwidth 250kHz,   SF 7, Low data rate optimize off
	4 = Test mode not for normal use.
	5 = (normal for calling mode)	Explicit mode, Error coding 4:8, Bandwidth 41.7kHz, SF 11, Low data rate optimize off.  Calling mode not currently supported.
	6 =
	7 = (normal for Telnet mode)

Click "Enable Telemetry Upload" to upload balloon telemetry to habhub.

Click "Enable SSDV Upload" to upload balloon imagery to habhub.

### LoRa USB Settings ###

Device:  The device name e.g. /dev/ttyUSB0 for the LoRaGo device.

Frequency:	This sets the frequency for LoRa module.

AFC enables Automatic frequency Control

Mode: Sets the "mode" for the LoRa module.

Click "Enable Telemetry Upload" to upload balloon telemetry to habhub.

Click "Enable SSDV Upload" to upload balloon imagery to habhub.

Payloads Screen

Web Download Settings
================

Enter a white list of payloads to download from the web, whether they are received locally or not.  If you are receiving locally at all, then this is not needed as the software will automatically check on the web for payloads that you have received locally.

Click Habitat to download from habhub.org

Click hablink to download from hab.link



Web Upload Settings
================

Click Habitat to upload telemetry to habhub.org

Click Habitat to upload telemetry to hab.link

Click Habitat to upload SSDV to habhub.org



