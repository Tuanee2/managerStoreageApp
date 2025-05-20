import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects

Item {
    id: transaction
    property string customerName: ""
    property string customerPhoneNumber: ""
    property string dataItems : ""
    property int numOfProduct: 0

    anchors.fill: parent
    Rectangle {
        id: customerInfo
        width: parent.width*0.9
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height*0.2
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
            color: "white"
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

    Rectangle{
        id: titleofProductInfo
        width: parent.width*0.4
        height: parent.height*0.08
        anchors.top: customerInfo.bottom
        anchors.topMargin: parent.height*0.01
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 10
        color: Qt.rgba(1, 1, 1, 0.5)
        Text {
            anchors.centerIn: parent
            text: "Thông tin sản phẩm"
            font.pixelSize: 22
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: productInformation
        width: parent.width*0.9
        height: parent.height*0.6
        anchors.top: titleofProductInfo.bottom
        anchors.topMargin: parent.height*0.01
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        clip: true
        border.width: 2
        border.color: "white"
        radius: 8

        Flickable {
            id: scrollArea
            anchors.fill: parent
            contentHeight: columnContent.height

            Column {
                id: columnContent
                width: scrollArea.width
                spacing: 16
                
                Repeater {
                    model: rootWindow.productListOfOrder
                    Rectangle {
                        width: customerInfo.width
                        height: transaction.height*0.2
                        radius: 8
                        color: "transparent"
                        border.color: "white"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: "Sản phẩm: " +  modelData.productName
                            color: "white"
                            font.pixelSize: 16
                        }
                    }
                }
            }
        }
    }

    Rectangle{
        id: buttonDeleteAllPro
        width: parent.width*0.2
        height: parent.height*0.08
        anchors.top: productInformation.bottom
        anchors.topMargin: parent.height*0.01
        anchors.left: parent.left
        anchors.leftMargin: parent.width*0.1
        radius: 10
        color: mabuttonDeleteAllPro.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1): Qt.rgba(1, 1, 1, 0.5)

        Text {
            anchors.centerIn: parent
            text: "Xoá toàn bộ lô hàng"
            font.pixelSize: 18
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            id:mabuttonDeleteAllPro
            anchors.fill: parent
            hoverEnabled: true
            onClicked:{
               rootWindow.productListOfOrder = []
            }
        }
    }

    Rectangle{
        id: buttonAddPro
        width: parent.width*0.2
        height: parent.height*0.08
        anchors.top: productInformation.bottom
        anchors.topMargin: parent.height*0.01
        anchors.left: buttonDeleteAllPro.right
        anchors.leftMargin: parent.width*0.1
        radius: 10
        color: mabuttonAddPro.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1): Qt.rgba(1, 1, 1, 0.5)

        Text {
            anchors.centerIn: parent
            text: "Thêm sản phẩm"
            font.pixelSize: 18
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            id:mabuttonAddPro
            anchors.fill: parent
            hoverEnabled: true
            onClicked:{
                pageLoader.source = "components/ProductListForTransaction.qml"
            }
        }
    }

    Rectangle{
        id: buttonComfirm
        width: parent.width*0.2
        height: parent.height*0.08
        anchors.top: productInformation.bottom
        anchors.topMargin: parent.height*0.01
        anchors.right: parent.right
        anchors.rightMargin: parent.width*0.1
        radius: 10
        color: mabuttonComfirm.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1): Qt.rgba(1, 1, 1, 0.5)

        Text {
            anchors.centerIn: parent
            text: "Xác nhận đơn hàng"
            font.pixelSize: 20
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            id:mabuttonComfirm
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    Dialog {
        id: orderComfirm

    }
}
