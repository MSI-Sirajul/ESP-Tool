#!/data/data/com.termux/files/usr/bin/bash

echo "M.S.I | Starting ESP8266 Setup on Termux..."

# Update & Upgrade
echo "Updating packages..."
pkg update -y && pkg upgrade -y

# Install Required Packages
echo "Installing essential packages..."
pkg install -y git python wget unzip curl termux-api libusb

# Install pip and esptool
echo "Installing esptool via pip..."
pip install --upgrade pip
pip install esptool

# Create workspace
mkdir -p ~/esp
cd ~/esp

# Download latest MicroPython firmware for ESP8266
echo "Downloading MicroPython firmware..."
wget https://micropython.org/resources/firmware/esp8266-20230426-v1.21.0.bin -O esp8266-micropython.bin

# Display completion message
echo
echo "-------------------------------------------"
echo "Setup Complete!"
echo "Now connect your NodeMCU via OTG."
echo
echo "To flash firmware (if /dev/ttyUSB0 is accessible):"
echo "  esptool.py --port /dev/ttyUSB0 erase_flash"
echo "  esptool.py --port /dev/ttyUSB0 --baud 460800 write_flash --flash_size=detect 0 esp8266-micropython.bin"
echo
echo "Note:"
echo " - If Termux cannot access USB directly, use Serial USB Terminal app to flash the .bin file manually."
echo " - Firmware is saved in: ~/esp/esp8266-micropython.bin"
echo "-------------------------------------------"
