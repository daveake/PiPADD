Pi PADD HAB Chase App
=====================

Soleyly for use on Raspberry Pi, ideally with the official touchscreen.use on phones, this is a native app that performs the most important functions needed when chasing a balloon:

- Receives GPS location from serial GPS receiver, and uploads to Habitat server
- Receives tracker telemetry via LoRa SPI receiver, and uploads to Habitat server
- Shows distance and direction to balloon
- Shows balloon and phone on a map
- Provides driving directions to the balloon
- Uploads received image data (SSDV)
- Support for up to 3 payloads

Currently, the software can receive telemetry from these sources:
 
- LoRa Pi expansion board
- Habitat (requires internet connection)


LoRa Receiver
===========

For this you will need to a suitable LoRa expansion board, for example:

- Uputronics LoRa board


Installation
============



Configuration
=============

Start the app, then touch the Settings button.  You will then see ....

	
### General Settings ###

### GPS Settings ###

### LoRa Settings ###

Frequency:	This sets the frequency for LoRa module.

Mode: Sets the "mode" for the LoRa module, which is one of:
				
	0 = (normal for telemetry)	Explicit mode, Error coding 4:8, Bandwidth 20.8kHz, SF 11, Low data rate optimize on
	1 = (normal for SSDV) 		Implicit mode, Error coding 4:5, Bandwidth 20.8kHz,  SF 6, Low data rate optimize off
	2 = (normal for repeater)	Explicit mode, Error coding 4:8, Bandwidth 62.5kHz,  SF 8, Low data rate optimize off
	3 = (normal for fast SSDV)	Explicit mode, Error coding 4:6, Bandwidth 250kHz,   SF 7, Low data rate optimize off
	4 = Test mode not for normal use.
	5 = (normal for calling mode)	Explicit mode, Error coding 4:8, Bandwidth 41.7kHz, SF 11, Low data rate optimize off.  Calling mode not currently supported.
	6 =
	7 = (normal for Telnet mode)
				
 

Payloads Screen
===============


Direction Screen
================


Map Screen
==========


Sources Screen
==============


Change History
==============

