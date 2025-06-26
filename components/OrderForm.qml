import QtQuick 2.15

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
        clip: true

        Rectangle {
            id: mainContentOrderInfo
            width: parent.width*0.98
            height: parent.height*0.98
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
                        width: mainContentOrderInfo.width*0.5
                        border.width: 1
                        border.color: "black"
                        radius: 8
                        Text{
                            anchors.left: parent.left
                            anchors.leftMargin: mainContentOrderInfo.width*0.01
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: parent.height*0.4
                            text: "Id : " + rootOrderForm.orderId

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
                                anchors.verticalCenter: parent.verticalCenter
                                text: "THÔNG TIN KHÁCH HÀNG"
                                font.pixelSize: parent.height*0.4
                            }
                        }

                        Rectangle {
                            anchors.top: titleCustomerInfo.bottom
                            anchors.left: customerInfo.left
                            width: customerInfo.width*0.39
                            height: customerInfo.height/2
                            color: Qt.rgba( 1, 1, 1, 0.5)
                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: mainContentOrderInfo.width*0.01
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: parent.height*0.4
                                text: "Tên khách hàng: " + rootOrderForm.orderObject["customer_name"]
                            }
                        }

                        Rectangle {
                            anchors.top: titleCustomerInfo.bottom
                            anchors.left: customerInfo.left
                            anchors.leftMargin: parent.width*0.4
                            width: customerInfo.width*0.29
                            height: customerInfo.height/2
                            color: Qt.rgba( 1, 1, 1, 0.5)
                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: mainContentOrderInfo.width*0.01
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
                                anchors.verticalCenter: parent.verticalCenter
                                text: "THÔNG TIN ĐƠN HÀNG"
                                font.pixelSize: parent.height*0.4
                            }
                        }

                        Rectangle{
                            id: mainOrderInfo
                            height: parent.height*2/3
                            width: parent.width
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            Rectangle {
                                id: numOfTypeProduct
                                width:parent.width*0.3
                                height: parent.height*0.5
                                anchors.left:parent.left
                                anchors.top: parent.top
                                Text {
                                    anchors.left: parent.left
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
                                Text {
                                    anchors.left: parent.left
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
                                Text {
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "Tổng số tiền: " + rootOrderForm.formatMoney(rootOrderForm.orderObject["total_price"]) + " VND"
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
                            anchors.verticalCenter: parent.verticalCenter
                            text: "CHI TIẾT ĐƠN HÀNG"
                            font.pixelSize: parent.height*0.4
                        }

                    }

                    Repeater {
                        model: rootOrderForm.orderObject["data"]
                        delegate: Rectangle {
                            width: mainContentOrderInfo.width
                            height: mainContentOrderInfo.height*0.1
                            color: Qt.rgba(0, 0, 0, 0.2)
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
                                    text: "| Giá sản phẩm: " + modelData.cost + "/" + modelData.unit
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
                            anchors.verticalCenter: parent.verticalCenter
                            text: "THÔNG TIN KHUYẾN MÃI"
                            font.pixelSize: parent.height*0.4
                        }

                    }
                }
            }
        }

        
        
    }

}
