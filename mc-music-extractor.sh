#!/bin/bash
#
# Description: Minecraft Music Extractor

echo -e "Enter your Windows username:"
read winusername
echo

USER_DIR="/mnt/c/Users/$winusername"

# Windows Profile doesn't exist = Can't run
if [ ! $(ls /mnt/c/Users/ | grep $winusername) ]; then
    echo -e "Unable to run, you entered an invalid user."
    echo -e "Make sure you entered everything correctly, spelled right with caps and lower case.\n"
    read -p "Press [Enter] key to continue..." && exit
fi

MINECRAFT_ASSETS_DIR="$USER_DIR/AppData/Roaming/PrismLauncher/assets"
OUTPUT_DIR="$USER_DIR/Desktop/Minecraft Music"

echo -e "Enter the Minecraft version you want to extract from:"
read version
echo

JSON_FILE=$(echo $MINECRAFT_ASSETS_DIR/indexes/$version.json | grep "/")

# Version doesn't exist = Can't run
if [ ! -f $JSON_FILE ]; then
    echo -e "Unable to extract because that version isn't downloaded or doesn't exist."
    echo -e "Make sure to open the launcher and download the version you need to create a pack for.\n"
    read -p "Press [Enter] key to continue..." && exit
fi

# for ENTRY in `cat "$JSON_FILE" | python -c 'import sys,json; from pprint import pprint; data = json.load(sys.stdin); pprint(data);' | grep music | awk -F\' '{print $2 "," $6}'`
# cat "$JSON_FILE" | python -c 'import sys,json; from pprint import pprint; data = json.load(sys.stdin); pprint(data);'
# cat "$JSON_FILE" | python -c 'import sys,json; from pprint import pprint; data = json.load(sys.stdin); pprint(data);' | grep sounds
# cat "$JSON_FILE" | python -c 'import sys,json; from pprint import pprint; data = json.load(sys.stdin); pprint(data);' | grep records

for ENTRY in $(cat "$JSON_FILE" | python -c 'import sys,json; from pprint import pprint; data = json.load(sys.stdin); pprint(data);' | grep music | awk -F\' '{print $2 "," $6}'); do
    echo "Processing $ENTRY..."
    echo $ENTRY | cut -d, -f1
    FILENAME=$(echo $ENTRY | cut -d, -f1)
    FILEHASH=$(echo $ENTRY | cut -d, -f2)

    #Locate the file in the assets directory structure
    FULLPATH_HASHFILE=$(find "$MINECRAFT_ASSETS_DIR" -name $FILEHASH)

    #Copy the file

    mkdir -p "$OUTPUT_DIR/$(echo "$FILENAME" | sed -E 's/\/[a-z0-9_]+\..+//')"
    cp "$FULLPATH_HASHFILE" "$OUTPUT_DIR/$FILENAME"

    echo "Outputted song to $OUTPUT_DIR/$FILENAME"

done
