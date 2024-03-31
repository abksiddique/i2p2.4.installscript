#!/bin/bash

# Update the package list
sudo apt update

# Install Git if it's not already installed
if ! command -v git &> /dev/null; then
    sudo apt install -y git
fi

# Clone the I2P source code and rename the folder
git clone https://github.com/i2p/i2p.i2p.git
mv i2p.i2p i2p

# Download the launch4j folder from the i2pscript1 repository
mkdir -p temp_launch4j
cd temp_launch4j
git init
git remote add origin https://github.com/abksiddique/i2pscript1.git
git config core.sparseCheckout true
echo "launch4j/*" > .git/info/sparse-checkout
git pull --depth=1 origin main
cd ..

# Remove the existing Launch4J folder in the I2P installation
rm -rf i2p/installer/lib/launch4j

# Move the downloaded Launch4J folder into the I2P installation
mv temp_launch4j/launch4j i2p/installer/lib/

# Clean up the temporary folder
rm -rf temp_launch4j

# Navigate to the I2P directory
cd i2p

# Install necessary packages for building the I2P installer
sudo apt install -y ant gettext mingw-w64

# Update the package list again
sudo apt update

# Build the I2P installer
ant pkg