#!/bin/bash

# Đường dẫn tới Qt Installer Framework
IFW_BIN="/Users/tuan/Qt/QtIFW-4.8.1/bin"

# Thư mục hiện tại (gốc script)
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Tạo thư mục output nếu chưa có
mkdir -p "$BASE_DIR/output/repository"

# Tạo file cài đặt đầu ra
echo "🔧 Đang tạo bản cài đặt App..."
"$IFW_BIN/binarycreator" \
    --config "$BASE_DIR/installer/config/config.xml" \
    --packages "$BASE_DIR/installer/packages" \
    "$BASE_DIR/output/MyAppInstaller.app"

# Tạo repository cập nhật
echo "🔧 Đang tạo repository cập nhật..."
"$IFW_BIN/repogen" \
    --update-new-components \
    -p "$BASE_DIR/installer/packages" \
    "$BASE_DIR/output/repository"

echo "✅ Hoàn tất! Bản cài đặt nằm trong output/, repository đã sẵn sàng."