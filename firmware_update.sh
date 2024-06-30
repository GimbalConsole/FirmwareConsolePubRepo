#! /bin/bash

if ! command -v curl &> /dev/null
then
    echo "curl is not installed. Installing curl..."
    sudo apt update
    sudo apt install -y curl
    echo "curl has been installed"
else
    echo "curl is already installed."
fi

# Get the tag name from GitHub release
# https://github.com/GimbalConsole/FirmwareConsolePubRepo/releases

release_info=$(curl -s https://api.github.com/repos/GimbalConsole/FirmwareConsolePubRepo/releases/latest)
tag_name=$(echo "$release_info" | grep -o '"tag_name": *"[^"]*"' | cut -d '"' -f 4)
download_url="https://github.com/GimbalConsole/FirmwareConsolePubRepo/releases/download/$tag_name/FirmwareConsole.bin"
file_name="FirmwareConsole_$tag_name.bin"

echo $tag_name
echo $download_url
echo $file_name

curl -L "$download_url" -o "$file_name"
chmod 777 $file_name

./GimbalLoader 25 $file_name
