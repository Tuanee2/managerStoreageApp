import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects

Item {
    property string customerName: ""
    property string customerPhoneNumber: ""
    property int numOfProduct: 0

    anchors.fill: parent

    Flickable {
        id: scrollArea
        width: parent.width*0.96
        height: parent.height
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.horizontalCenter: parent.horizontalCenter
        contentHeight: columnContent.height
        clip: true

        Column {
            id: columnContent
            width: scrollArea.width
            spacing: 16

            // Các phần nội dung nằm ở đây
            Rectangle {
                id: customerInfo

                width: parent.width
                height: scrollArea.height*0.3
                radius: 8
                color: Qt.rgba(1, 1, 1, 0.3)
                border.width: 2
                border.color: Qt.rgba(0, 0, 0, 1)

                Text {
                    text: "THÔNG TIN KHÁCH HÀNG"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    width: parent.width
                    height: parent.height / 3
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 20
                }

                Rectangle {
                    anchors.top: customerInfo.top
                    anchors.topMargin: customerInfo.height/3
                    anchors.left: customerInfo.left
                    width: customerInfo.width*0.6
                    height: customerInfo.height/3
                    color: "transparent"
                    CustomerSearchTextField {
                        id: customerSearch
                        width: parent.width
                        height: parent.height
                        color: Qt.rgba( 1, 1, 1, 0.2)
                        placeholderText: "Nhập tên khách hàng"
                        onSuggestionSelected: (text) => {
                            console.log("Đã chọn khách hàng:", text)
                        }
                        //target: "PRODUCT"
                        target: "CUSTOMER"
                    }
                }

                Rectangle {
                    anchors.bottom: customerInfo.bottom
                    anchors.left: customerInfo.left
                    width: customerInfo.width*0.6
                    height: customerInfo.height/3
                    color: "transparent"
                    CustomerSearchTextField {
                        id: phoneSearch
                        width: parent.width
                        height: parent.height
                        color: Qt.rgba( 1, 1, 1, 0.2)
                        placeholderText: "Nhập số điện khách hàng"
                        onSuggestionSelected: (text) => {
                            console.log("Đã chọn khách hàng:", text)
                        }
                        target: "CUSTOMER"
                    }
                }

            }

            Text {
                text: "THÔNG TIN ĐƠN HÀNG"
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
            }
        }
    }
}
