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
    property var order: []

    anchors.fill: parent

    Component.onCompleted: {
        controller.orderUpdate_UI();
    }

    Connections {
        target: controller
        function onOrderUpdateResult_UI(list){
            transaction.order = list;
            rootWindow.isSaveTransaction = !(list.length > 0);
        }
    }

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
            CustomSearchTextField {
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
            CustomSearchTextField {
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

                    model : transaction.order
                    Rectangle {
                        width: customerInfo.width
                        height: Math.min(transaction.height*0.2, 100)
                        radius: 8
                        color: Qt.rgba(1, 1, 1, 0.6)
                        border.color: "white"
                        border.width: 1

                        Rectangle {
                            width: parent.width*0.3
                            height: parent.height
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.05
                            anchors.verticalCenter: parent.verticalCenter
                            color: "transparent"

                            Column {
                                spacing: 10
                                anchors.verticalCenter: parent.verticalCenter
                                
                                Text {
                                    
                                    text: "Sản phẩm: " +  modelData.productName
                                    color: "black"
                                    font.pixelSize: 16
                                }

                                Text {
                                    
                                    text: "Số lượng: " +  modelData.numOfItem
                                    color: "black"
                                    font.pixelSize:  16
                                }

                            }

                        }

                        Rectangle {
                            width: parent.width*0.3
                            height: parent.height
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.35
                            anchors.verticalCenter: parent.verticalCenter
                            color: "transparent"
                        }


                        Rectangle{
                            id: deleteProductChoice
                            width: parent.height
                            height: parent.height
                            radius: 8
                            anchors.right: parent.right
                            color: "transparent"
                            Button{
                                anchors.fill: parent
                                background: Rectangle {
                                    anchors.fill: parent
                                    radius: 8
                                    color: madeleteProductChoice.containsMouse ? Qt.rgba(200/255, 20/255, 20/255, 0.2) : "transparent"
                                }

                                icon.source: "qrc:/images/Icon/cross-circle.svg"
                                icon.color: madeleteProductChoice.containsMouse ? Qt.rgba(250/255, 20/255, 20/255, 0.5) : "white"

                            }

                            MouseArea {
                                id: madeleteProductChoice
                                anchors.fill: parent
                                hoverEnabled: true

                            }


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
                if(transaction.order.length === 0){
                    rootWindow.notification.showNotification("Đơn hàng rỗng")
                }else{
                    deleteOrder.open()
                }
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
                rootWindow.isTransactionProductSelect = true
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
            onClicked: {
                if(transaction.order.length === 0){
                    rootWindow.notification.showNotification("Đơn hàng rỗng")
                }else{
                    orderComfirm.open()
                }
            }
        }
    }

    Dialog {
        id: orderComfirm
        title: "Bạn có chắc chắn xác nhận đơn hàng ko?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: parent
        visible: false
        onAccepted: {
            controller.requestOrderCommand("ADD", "0982181002", "24-05-2025");
        }
    }

    Dialog {
        id: continueCreateTransaction
        title: "Bạn muốn tiếp tục giao dịch?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: parent
        visible: false
        onAccepted: {
            controller.orderUpdate_UI();
        }
        onRejected:{
            drawerLoader.source = "components/MainDrawer.qml"
            pageLoader.source = "components/Dashboard.qml"
            rootWindow.currentNavigation =  "Bảng thông tin"
        }
    }

    Connections {
        target: controller
        function onOrderCommandResult(done, cmd){
            if(cmd === "ADD"){
                rootWindow.notification.showNotification("Thêm đơn hàng thành công")
                continueCreateTransaction.open()
            }

        }
    }

    Dialog {
        id: deleteOrder
        title: "Bạn muốn xoá đơn hàng?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: parent
        visible: false
        onAccepted: {
            controller.requestCommandOrder_UI("DELETE")
            controller.orderUpdate_UI();
        }
    }


    Connections {
        target: controller
        function onRequestCommandOrderResult_UI(result, cmd){
            if(cmd === "DELETE"){
                rootWindow.notification.showNotification("Xoá đơn hàng thành công")
            }
        }
    }
}
