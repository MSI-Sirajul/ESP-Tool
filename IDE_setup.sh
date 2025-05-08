#!/data/data/com.termux/files/usr/bin/bash

# Color Variables for Better Readability
NC='\033[0m'           # No Color
RED='\033[0;31m'       # Red
GREEN='\033[0;32m'     # Green
YELLOW='\033[1;33m'    # Yellow
BLUE='\033[0;34m'      # Blue
CYAN='\033[0;36m'      # Cyan
MAGENTA='\033[0;35m'   # Magenta
BOLD='\033[1m'         # Bold

echo -e "${CYAN}${BOLD}M.S.I | Starting Arduino CLI Setup for ESP8266...${NC}"

# Step 1: Update & Install Required Packages
echo -e "${GREEN}${BOLD}Step 1: Updating & Installing Required Packages...${NC}"
pkg update -y && pkg upgrade -y
pkg install -y git curl wget unzip nano

# Step 2: Download and Install Arduino CLI
echo -e "${GREEN}${BOLD}Step 2: Downloading Arduino CLI...${NC}"
wget https://downloads.arduino.cc/arduino-cli/arduino-cli_latest_Linux_ARM64.tar.gz
echo -e "${YELLOW}${BOLD}Extracting Arduino CLI...${NC}"
tar -xvf arduino-cli_latest_Linux_ARM64.tar.gz
mv arduino-cli /data/data/com.termux/files/usr/bin/
chmod +x /data/data/com.termux/files/usr/bin/arduino-cli

# Step 3: Initialize Arduino CLI Config
echo -e "${GREEN}${BOLD}Step 3: Initializing Arduino CLI Configuration...${NC}"
arduino-cli config init

# Step 4: Add ESP8266 Board Support
echo -e "${GREEN}${BOLD}Step 4: Installing ESP8266 Board Support...${NC}"
arduino-cli core update-index
arduino-cli core install esp8266:esp8266

# Step 5: Create Example Sketch Folder
echo -e "${GREEN}${BOLD}Step 5: Creating Example Sketch...${NC}"
mkdir -p ~/Arduino/MySketch
cat <<EOF > ~/Arduino/MySketch/sketch.ino
void setup() {
  pinMode(2, OUTPUT);
}

void loop() {
  digitalWrite(2, HIGH);
  delay(1000);
  digitalWrite(2, LOW);
  delay(1000);
}
EOF

# Step 6: Compile Example Sketch
echo -e "${GREEN}${BOLD}Step 6: Compiling Sketch...${NC}"
arduino-cli compile --fqbn esp8266:esp8266:nodemcuv2 ~/Arduino/MySketch --output-dir ~/Arduino/MySketch/build

# Done
echo -e "${CYAN}${BOLD}---------------------------------------------${NC}"
echo -e "${GREEN}${BOLD}✅ Setup Complete!${NC}"
echo -e "${YELLOW}Sketch compiled successfully.${NC}"
echo -e "${CYAN}${BOLD}BIN File:${NC} ~/Arduino/MySketch/build/sketch.ino.bin"
echo -e "${MAGENTA}Upload via OTA: ${YELLOW}arduino-cli upload -p esp8266-ota.local --fqbn esp8266:esp8266:nodemcuv2${NC}"
echo -e "${CYAN}${BOLD}---------------------------------------------${NC}"
