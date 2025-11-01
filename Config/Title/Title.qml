pragma Singleton
import QtQuick 2.15

QtObject {
    property var drawer: QtObject {
        property var element: QtObject{
            property string dashboard: "Bảng thông tin"
            property string product: "Sản phẩm"
            property string customer: "Khách hàng"
            property string revenue: "Doanh thu"
            property string transactionHistory: "Lịch sử giao dịch"
            property string setting: "Cài đặt"
            property string quit: "Thoát"
        }

        property var main: QtObject{
        }
    }
}
