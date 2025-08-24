import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects

Item {
    id: rootOrderForm
    anchors.fill: parent

    property string orderId: ""
    property var orderObject: {}

    Component.onCompleted: {
        var cmdData = {
            command: "GET",
            target: "ORDER",
            infoKind: "OBJECT",
            mode: "SINGLE",
            getType: "LIST",
            filters: {
                id: rootOrderForm.orderId
            }
        }
        controller.requestOrderList(cmdData)
    }

    Connections {
        target: controller
        function onOrderListReady(object, cmd){
            if(cmd.getType === "LIST"){
                rootOrderForm.orderObject = object[0];
            }
        }
    }

    function formatMoney(n) {
        let str = n.toString();
        let result = "";
        while (str.length > 3) {
            result = "," + str.slice(-3) + result;
            str = str.slice(0, -3);
        }
        result = str + result;
        return result;
    }

    Rectangle{
        id: rootContentOrderInfo
        width: parent.width*0.98
        height: parent.height*0.98
        radius: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 1
        border.color: Qt.rgba(0, 0, 0, 0.2)
        clip: true

        Rectangle {
            id: mainContentOrderInfo
            width: parent.width
            height: parent.height
            color: "transparent"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            Flickable {
                anchors.fill: parent
                contentHeight: orderInfoColumn.height
                interactive: true

                Column {
                    id: orderInfoColumn
                    width: parent.width
                    spacing: parent.height*0.01

                    
                    Rectangle {
                        id: orderInfoNameId
                        height: mainContentOrderInfo.height*0.08
                        width: mainContentOrderInfo.width
                        border.width: 1
                        border.color: Qt.rgba(0, 0, 0, 0.3)
                        topRightRadius: 10
                        topLeftRadius: 10
                        Text{
                            anchors.left: parent.left
                            anchors.leftMargin: mainContentOrderInfo.width*0.01
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: parent.height*0.4
                            text: "ID : " + rootOrderForm.orderId

                        }

                        Rectangle{
                            id: debtStatus
                            width: parent.width*0.2
                            height: parent.height*0.9
                            color: (rootOrderForm.orderObject["debt"] == "NO_DEBT") ? Qt.rgba(0.6, 1.0, 0.6, 1.0) : Qt.rgba(1.0, 0.6, 0.6, 1.0)
                            radius: 8
                            anchors.right: parent.right
                            anchors.rightMargin: parent.width*0.01
                            anchors.verticalCenter: parent.verticalCenter

                            Text {
                                text: (rootOrderForm.orderObject["debt"] == "NO_DEBT") ? "Đã thanh toán" : (rootOrderForm.orderObject["debt"] === "DEBT_BY_DATE") ? "Nợ ngày" : "Nợ mùa"
                                font.pixelSize: parent.height * 0.4
                                color: "white"
                                anchors.centerIn: parent
                                font.bold: true
                            }

                            MouseArea {
                                anchors.fill: parent
                                enabled: rootOrderForm.orderObject["debt"] != "NO_DEBT"
                                onClicked:{
                                    debtPaymentDialog.open()
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: customerInfo
                        width: mainContentOrderInfo.width
                        height: mainContentOrderInfo.height*0.14
                        color: "transparent"
                        Rectangle {
                            id: titleCustomerInfo
                            height: parent.height*0.5
                            width: parent.width
                            anchors.top: parent.top
                            anchors.left: parent.left
                            color: "transparent"
                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: mainContentOrderInfo.width*0.01
                                anchors.verticalCenter: parent.verticalCenter
                                text: "THÔNG TIN KHÁCH HÀNG"
                                font.pixelSize: parent.height*0.4
                                font.bold: true
                            }
                        }

                        Button {
                            id: iconName
                            anchors.top: titleCustomerInfo.bottom
                            anchors.left: customerInfo.left
                            height: customerInfo.height/2
                            width: customerInfo.height/2
                            background: Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                            }
                            icon.source: "qrc:/images/Icon/id-card.svg"
                            icon.color: "#007bff"
                        }

                        Rectangle {
                            id: cusname
                            anchors.top: titleCustomerInfo.bottom
                            anchors.left: iconName.right
                            width: customerInfo.width*0.39
                            height: customerInfo.height/2
                            color: "transparent"
                            Text {
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: parent.height*0.4
                                text: "Tên khách hàng: " + rootOrderForm.orderObject["customer_name"]
                            }
                        }

                        Button{
                            id: iconPhonenumber
                            anchors.top: titleCustomerInfo.bottom
                            anchors.left: cusname.right
                            height: customerInfo.height/2
                            width: customerInfo.height/2
                            background: Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                            }
                            icon.source: "qrc:/images/Icon/phone-rotary.svg"
                            icon.color: "#007bff"
                        }

                        Rectangle {
                            anchors.top: titleCustomerInfo.bottom
                            anchors.left: iconPhonenumber.right
                            width: customerInfo.width*0.29
                            height: customerInfo.height/2
                            color: Qt.rgba( 1, 1, 1, 0.5)
                            Text {
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: parent.height*0.4
                                text: "Số điện thoại: " + rootOrderForm.orderObject["phone_number"]
                            }
                        }
                    }

                    Rectangle {
                        id: orderInfo
                        width: mainContentOrderInfo.width
                        height: mainContentOrderInfo.height*0.21
                        color: "transparent"

                        Rectangle {
                            id: titleOrderInfo
                            height: parent.height/3
                            width: parent.width
                            anchors.top: parent.top
                            anchors.left: parent.left
                            color: "transparent"
                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: mainContentOrderInfo.width*0.01
                                anchors.verticalCenter: parent.verticalCenter
                                text: "THÔNG TIN ĐƠN HÀNG"
                                font.pixelSize: parent.height*0.4
                                font.bold: true
                            }
                        }

                        Rectangle{
                            id: mainOrderInfo
                            height: parent.height*2/3
                            width: parent.width
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            color: "transparent"
                            Rectangle {
                                id: numOfTypeProduct
                                width:parent.width*0.3
                                height: parent.height*0.5
                                anchors.left:parent.left
                                anchors.top: parent.top
                                color: "transparent"
                                Text {
                                    anchors.left: parent.left
                                    anchors.leftMargin: mainContentOrderInfo.width*0.01
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "Số loại sản phẩm: " + rootOrderForm.orderObject["data"].length
                                    verticalAlignment: Text.AlignVCenter
                                    font.pixelSize: parent.height*0.4
                                }

                            }

                            Rectangle {
                                id: numOfItem
                                width:parent.width*0.3
                                height: parent.height*0.5
                                anchors.left:parent.left
                                anchors.bottom: parent.bottom
                                color: "transparent"
                                Text {
                                    anchors.left: parent.left
                                    anchors.leftMargin: mainContentOrderInfo.width*0.01
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "Số sản phẩm: " 
                                    verticalAlignment: Text.AlignVCenter
                                    font.pixelSize: parent.height*0.4
                                }
                            }

                            Rectangle{
                                id: totalPrice
                                width:parent.width*0.3
                                height: parent.height*0.5
                                anchors.left: numOfTypeProduct.right
                                anchors.top: parent.top
                                color: "transparent"
                                Text {
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "Tổng số tiền: " + rootOrderForm.formatMoney(rootOrderForm.orderObject["total_price"]) + " VNĐ"
                                    verticalAlignment: Text.AlignVCenter
                                    font.pixelSize: parent.height*0.4
                                }
                            }

                            Rectangle {
                                id: purchaseTime
                                width:parent.width*0.3
                                height: parent.height*0.5
                                anchors.left: numOfItem.right
                                anchors.bottom: parent.bottom
                                color: "transparent"
                                Text {
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "Ngày bán: " + Qt.formatDate(rootOrderForm.orderObject["purchase_time"], "dd-MM-yyyy")
                                    verticalAlignment: Text.AlignVCenter
                                    font.pixelSize: parent.height*0.4
                                }
                            }

                        }
                    }
                    Rectangle {
                        id: orderInfoDetail
                        width: mainContentOrderInfo.width
                        height: mainContentOrderInfo.height*0.07
                        color: "transparent"

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: mainContentOrderInfo.width*0.01
                            anchors.verticalCenter: parent.verticalCenter
                            text: "CHI TIẾT ĐƠN HÀNG"
                            font.pixelSize: parent.height*0.4
                            font.bold: true
                        }

                    }

                    Repeater {
                        model: rootOrderForm.orderObject["data"]
                        delegate: Rectangle {
                            width: mainContentOrderInfo.width*0.98
                            height: mainContentOrderInfo.height*0.1
                            anchors.horizontalCenter: orderInfo.horizontalCenter
                            color: "#e6f0ff"
                            radius: 8
                            border.width: 1
                            border.color: Qt.rgba(0, 0, 0, 0.5)
                            
                            Rectangle{
                                id: productName
                                width: parent.width*0.4
                                height: parent.height
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                Text{
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.leftMargin: parent.width*0.01
                                    text: "Tên sản phẩm: " + modelData.product_name
                                    font.pixelSize: parent.height*0.3
                                }
                            }

                            Rectangle{
                                id: productQuantity
                                width: parent.width*0.25
                                height: parent.height
                                anchors.left: productName.right
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                Text{
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.leftMargin: parent.width*0.01
                                    text: "| Số sản phẩm: " + modelData.batches[0].quantity
                                    font.pixelSize: parent.height*0.3
                                }

                            }

                            Rectangle{
                                id: productCost
                                width: parent.width*0.25
                                height: parent.height
                                anchors.left: productQuantity.right
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                Text{
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.leftMargin: parent.width*0.01
                                    text: "| Giá sản phẩm: " +rootOrderForm.formatMoney(modelData.cost) + " VNĐ" + "/" + modelData.unit
                                    font.pixelSize: parent.height*0.3
                                }

                            }

                        }
                    }

                    Rectangle {
                        id: saleInfoDetal
                        width: mainContentOrderInfo.width
                        height: mainContentOrderInfo.height*0.07
                        color: "transparent"

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: mainContentOrderInfo.width*0.01
                            anchors.verticalCenter: parent.verticalCenter
                            text: "THÔNG TIN KHUYẾN MÃI"
                            font.pixelSize: parent.height*0.4
                            font.bold: true
                        }

                    }

                    Rectangle {
                        width: mainContentOrderInfo.width
                        height: mainContentOrderInfo.height*0.07
                        color: "transparent"
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: mainContentOrderInfo.width*0.01
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Giảm giá: " + rootOrderForm.formatMoney(rootOrderForm.orderObject["discount"]) + " VNĐ"
                            font.pixelSize: parent.height*0.4
                        }
                    }

                    Rectangle {
                        id: noteInfoDetal
                        width: mainContentOrderInfo.width
                        height: mainContentOrderInfo.height*0.07
                        color: "transparent"

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: mainContentOrderInfo.width*0.01
                            anchors.verticalCenter: parent.verticalCenter
                            text: "GHI CHÚ"
                            font.pixelSize: parent.height*0.4
                            font.bold: true
                        }

                    }
                }
            }
        }
    }

    Dialog {
        id: debtPaymentDialog
        title: "Xác nhận thanh toán công nợ"
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel
        visible: false
        width: parent.width * 0.4
        height: parent.height * 0.5

        property real totalDebt: rootOrderForm.orderObject["total_price"] // Hoặc phần còn nợ
        property real paymentAmount: 0

        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 10

            CheckBox {
                id: payAllCheck
                text: "Trả toàn bộ số tiền còn lại (" + rootOrderForm.formatMoney(debtPaymentDialog.totalDebt) + " VNĐ)"
                onCheckedChanged: {
                    if (checked) {
                        amountField.text = rootOrderForm.formatMoney(debtPaymentDialog.totalDebt);
                        amountField.enabled = false;
                        percentField.text = "100"
                        percentField.enabled = false;
                        paymentAmount = debtPaymentDialog.totalDebt
                    } else {
                        amountField.enabled = true;
                        amountField.text = ""
                        percentField.enabled = true;
                        percentField.text = ""
                    }
                }
            }

            TextField {
                id: amountField
                width: parent.width*0.8
                height: parent.height*0.35
                font.pixelSize: height*0.3
                placeholderText: "Nhập số tiền muốn trả (VNĐ)"
                inputMethodHints: Qt.ImhDigitsOnly
                enabled: true
                onTextChanged: {
                    if (!payAllCheck.checked) {
                        debtPaymentDialog.paymentAmount = parseFloat(text) || 0
                    }
                }
            }

            TextField {
                id: percentField
                width: parent.width*0.8
                height: parent.height*0.35
                font.pixelSize: height*0.3
                placeholderText: "Nhập phần trăm muốn trả (%)"
                inputMethodHints: Qt.ImhDigitsOnly
                enabled: true
                onTextChanged: {
                    if (!payAllCheck.checked) {
                        let percent = parseFloat(text)
                        if (percent >= 0 && percent <= 100) {
                            debtPaymentDialog.paymentAmount = debtPaymentDialog.totalDebt * percent / 100
                        }
                    }
                }
            }

            Text {
                text: "→ Số tiền sẽ thanh toán: " + rootOrderForm.formatMoney(paymentAmount) + " VNĐ"
                font.pixelSize: 16
                color: "blue"
            }
        }

        onAccepted: {
            // Gửi paymentAmount đi
            console.log("Sẽ trả: " + paymentAmount)
            // controller.payDebt(orderId, paymentAmount)
        }
    }
}
