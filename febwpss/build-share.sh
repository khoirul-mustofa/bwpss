#!/bin/bash
clear
echo "Enter the message you want to send to Discord:"
read USER_INPUT_MESSAGE
fvm flutter clean
fvm flutter pub get
WEBHOOK_DISCORD_URL="https://discord.com/api/webhooks/1296352208798875788/9KuLb6aFzNg8jhsMmbpGR7C4U1rbl808qFb1Zeq-YeuMHONpDhRbGdxRfCh0ZkNXlS47"

flutter build apk --split-per-abi

CURRENT_TIME=$(date +"%Y-%m-%d %H:%M:%S")

FILE_PATH="$PWD/build/app/outputs/flutter-apk/"
ORIGINAL_APK_NAME="app-armeabi-v7a-release.apk"
NEW_APK="app-bwpss-release-$CURRENT_TIME.apk"

mv "$FILE_PATH$ORIGINAL_APK_NAME" "$FILE_PATH$NEW_APK"

echo "APK renamed to $NEW_APK"

MESSAGE="New release build of BWPSS app available: $NEW_APK\n\n$USER_INPUT_MESSAGE"

curl -X POST \
  -H "Content-Type: multipart/form-data" \
  -F "content=$(printf "$MESSAGE")" \
  -F "file=@$FILE_PATH$NEW_APK" \
  $WEBHOOK_DISCORD_URL

echo "APK sent to Discord: $NEW_APK"