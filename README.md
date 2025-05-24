

# App Quản Lý 

Ứng dụng quản lý bán hàng mini được xây dựng bằng **Qt Quick (QML)**, sử dụng giao diện hiện đại với hiệu ứng mờ nền, hỗ trợ tạo đơn hàng, nhập kho, và quản lý thông tin sản phẩm/khách hàng.

---

## 🚀 Tính năng

- 🧾 Tạo giao dịch: Chọn khách hàng, thêm sản phẩm theo lô, xác nhận đơn hàng
- 📦 Nhập kho: Thêm sản phẩm và lô hàng mới
- 🔍 Tìm kiếm khách hàng và sản phẩm theo tên
- 🧑‍💼 Quản lý khách hàng
- 📈 Xem doanh thu 
- 📜 Lịch sử giao dịch 
- ⚙️ Cài đặt và thoát ứng dụng

---

## 📁 Cấu trúc thư mục

```
forHa/
├── components/             # Các thành phần QML tái sử dụng (Drawer, Form, Toast, ...)
├── images/                 # Ảnh và icon cho UI
├── Main.qml                # Cửa sổ chính
├── CreateTransaction.qml   # Giao diện tạo đơn hàng
├── ImportBatch.qml         # Giao diện nhập kho
├── ProductListForTransaction.qml # Danh sách sản phẩm khi tạo đơn hàng
├── ...
└── README.md               # Tài liệu mô tả
```

---

## 🛠 Yêu cầu

- Qt 6.5 trở lên (đã test với Qt 6.8.1)
- Qt Quick Controls 2
- Qt Quick Layouts
- Qt Graphical Effects (hoặc Qt5Compat nếu dùng Qt 6.5+)

---

## 🔧 Cách chạy ứng dụng

### Qua Qt Creator:
1. Mở dự án trong Qt Creator.
2. Cài cấu hình kit phù hợp (Qt 6.8.1 trở lên).
3. Nhấn Run.

### Qua dòng lệnh:
```bash
qmake
make
./forHa
```

---

## 📌 Ghi chú phát triển

- `pageLoader` dùng để điều hướng giữa các giao diện.
- `Loader + Component` được sử dụng để truyền biến & signal giữa các trang.

---

## 📧 Tác giả

- Tên: **Tuanee2**
- Email: *buiquoctuan18102002@gmail.com*

---

## 📜 Giấy phép

MIT License 