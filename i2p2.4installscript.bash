#!/bin/bash

# Make the script executable
chmod +x "$0"

# Update the package list
sudo apt update

# Install Git if it's not already installed
if ! command -v git &> /dev/null; then
    sudo apt install -y git
fi

# Clone the I2P source code
git clone https://github.com/i2p/i2p.i2p.git i2p

# Clone the i2pscript1 repository
git clone https://github.com/abksiddique/i2pscript1.git temp_i2pscript1

# Remove the existing Launch4J folder in the I2P installation
rm -rf i2p/installer/lib/launch4j

# Move the i2pscript1 folder into the I2P installation as launch4j
mv temp_i2pscript1 i2p/installer/lib/launch4j

# Grant execute permissions to all files in the launch4j directory
chmod -R 755 i2p/installer/lib/launch4j

chmod +x i2p/installer/lib/launch4j/*  - IGNORE THIS

# Navigate to the I2P directory
cd i2p

# Install necessary packages for building the I2P installer
sudo apt install -y ant gettext mingw-w64

# Update the package list again
sudo apt update

# Build the I2P installer
sudo ant pkg
