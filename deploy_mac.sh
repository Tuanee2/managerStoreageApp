#!/bin/bash

# Đường dẫn đến thư mục chứa .app
APP_NAME="appforHa"
BUILD_DIR="./build/Qt_6_8_1_for_macOS-Release04"
APP_PATH="$BUILD_DIR/$APP_NAME.app"
EXEC_PATH="$APP_PATH/Contents/MacOS/$APP_NAME"

# Đường dẫn plugin Qt cần thiết
QT_PATH="$HOME/Qt/6.8.1/macos"
PLUGIN_DEST="$APP_PATH/Contents/PlugIns/virtualkeyboard"
PLUGIN_SRC="$QT_PATH/plugins/virtualkeyboard"

# Triển khai macdeployqt
echo "▶️ Running macdeployqt..."
$QT_PATH/bin/macdeployqt "$APP_PATH" \
    -verbose=3 \
    -executable="$EXEC_PATH" \
    -qmldir=./components \
    -always-overwrite

echo "✅ Done deploying $APP_NAME"