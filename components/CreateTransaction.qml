import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects

Item {
    id: transaction
    // property string customerName: ""
    // property string customerPhoneNumber: ""
    // property string customerYearOfBirth: ""
    property string dataItems : ""
    property int numOfProduct: 0
    property int numOfItem: 0
    property int totalPrice: 0
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
            transaction.numOfItem = 0
            for(var i = 0; i< list.length; i++){
                transaction.numOfItem += list[i].numOfItem
                transaction.totalPrice += list[i].numOfItem * list[i].price
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

    Rectangle {
        id: mainTransaction
        width: parent.width * 0.96
        height: parent.height * 0.96
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 10
        Rectangle {
            id: mainContentTransaction
            width: parent.width*0.98
            height: parent.height
            color: "transparent"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true

            Flickable {

                anchors.fill: parent
                contentHeight: column.height
                interactive: true

                Column {
                    id: column
                    width: parent.width
                    spacing: 10

                    Rectangle {
                        id: customerInfo
                        width: mainTransaction.width
                        height: mainTransaction.height*0.14
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
                            CustomSearchTextField {
                                id: customerSearch
                                width: parent.width
                                height: parent.height
                                color: Qt.rgba( 1, 1, 1, 0.5)
                                placeholderText: "Nhập tên khách hàng"
                                text: rootWindow.customerName
                                color4placeholder: "black"
                                onSuggestionSelected: (data) => {
                                    rootWindow.customerName = data.name
                                    rootWindow.customerPhoneNumber = data.phoneNumber
                                    rootWindow.customerYearOfBirth = data.yearOfBirth
                                }
                                target: "CUSTOMER"
                                targetExtension: "NAME"
                            }
                        }

                        Rectangle {
                            anchors.top: titleCustomerInfo.bottom
                            anchors.left: customerInfo.left
                            anchors.leftMargin: parent.width*0.4
                            width: customerInfo.width*0.29
                            height: customerInfo.height/2
                            color: Qt.rgba( 1, 1, 1, 0.5)
                            CustomSearchTextField {
                                id: phoneSearch
                                width: parent.width
                                height: parent.height
                                color: Qt.rgba( 1, 1, 1, 0.5)
                                placeholderText: "Nhập số điện khách hàng"
                                text: rootWindow.customerPhoneNumber
                                color4placeholder: "black"
                                onSuggestionSelected: (data) => {
                                    rootWindow.customerName = data.name
                                    rootWindow.customerPhoneNumber = data.phoneNumber
                                    rootWindow.customerYearOfBirth = data.yearOfBirth
                                }
                                target: "CUSTOMER"
                                targetExtension: "PHONENUMBER"
                            }
                        }

                        Rectangle {
                            anchors.top: titleCustomerInfo.bottom
                            anchors.left: customerInfo.left
                            anchors.leftMargin: parent.width*0.7
                            width: customerInfo.width*0.2
                            height: customerInfo.height/2
                            color: Qt.rgba( 1, 1, 1, 0.5)
                            CustomSearchTextField {
                                id: yearSearch
                                width: parent.width
                                height: parent.height
                                color: Qt.rgba( 1, 1, 1, 0.5)
                                placeholderText: "Nhập năm sinh"
                                text: rootWindow.customerYearOfBirth
                                color4placeholder: "black"
                                onSuggestionSelected: (data) => {
                                    rootWindow.customerName = data.name
                                    rootWindow.customerPhoneNumber = data.phoneNumber
                                    rootWindow.customerYearOfBirth = data.yearOfBirth
                                }
                                target: "CUSTOMER"
                                targetExtension: "YEAROFBIRTH"
                            }
                        }

                    }

                    Rectangle {
                        id: orderInfo
                        width: mainTransaction.width
                        height: mainTransaction.height*0.21
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
                                width:parent.width*0.2
                                height: parent.height*0.5
                                anchors.left:parent.left
                                anchors.top: parent.top
                                Text {
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "Số loại sản phẩm: " + transaction.order.length
                                    verticalAlignment: Text.AlignVCenter
                                }

                            }
                            Rectangle {
                                id: numOfItem
                                width:parent.width*0.2
                                height: parent.height*0.5
                                anchors.left:parent.left
                                anchors.bottom: parent.bottom
                                Text {
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "Số sản phẩm: " + transaction.numOfItem
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                            Rectangle{
                                id: totalPrice
                                width:parent.width*0.25
                                height: parent.height*0.5
                                anchors.left: numOfTypeProduct.right
                                anchors.top: parent.top
                                Text {
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "Tổng số tiền: " + transaction.formatMoney(transaction.totalPrice) + " VND"
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                            Rectangle {
                                id: purchaseTime
                                width:parent.width*0.25
                                height: parent.height*0.5
                                anchors.left: numOfItem.right
                                anchors.bottom: parent.bottom
                                TextField {
                                    anchors.fill: parent
                                    id: purchaseTimeTextField
                                    text: Qt.formatDate(new Date(), "dd-MM-yyyy")
                                }
                            }

                        }
                    }

                    Rectangle {
                        id: orderInfoDetail
                        width: mainTransaction.width
                        height: mainTransaction.height*0.07
                        color: "transparent"

                        Text {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "CHI TIẾT ĐƠN HÀNG"
                            font.pixelSize: parent.height*0.4
                        }

                    }

                    Repeater {
                        model: transaction.order
                        delegate: Rectangle {
                            width: mainContentTransaction.width
                            height: mainContentTransaction.height*0.14
                            color: Qt.rgba(0, 0, 0, 0.2)
                            radius: 10
                            
                            Rectangle {
                                id: nameOfProduct
                                width: parent.width * 0.5
                                height: parent.height 
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                Rectangle {
                                    id: pName
                                    width: parent.width*0.4
                                    height: parent.height*0.5
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    color: "transparent"
                                    Text {
                                        anchors.left: parent.left
                                        anchors.leftMargin: parent.width*0.01
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "Tên sản phẩm: " + modelData.productName
                                        color: "black"
                                        font.pixelSize: parent.height*0.4
                                    }
                                }

                                Rectangle {
                                    id: pQuantity
                                    width: parent.width*0.4
                                    height: parent.height*0.5
                                    anchors.bottom: parent.bottom
                                    anchors.left: anchors.left
                                    color: "transparent"

                                    Text {
                                        anchors.left: parent.left
                                        anchors.leftMargin: parent.width*0.01
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "Số sản phẩm: " + modelData.numOfItem
                                        color: "black"
                                        font.pixelSize: parent.height*0.4
                                    }
                                }

                                Rectangle {
                                    id: pCost
                                    anchors.bottom: parent.bottom
                                    anchors.left: pName.right
                                    width: parent.width*0.6
                                    height: parent.height*0.5
                                    color: "transparent"

                                    Text {
                                        anchors.left: parent.left
                                        anchors.leftMargin: parent.width*0.01
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "Giá: " + transaction.formatMoney(modelData.price * modelData.numOfItem) + " VNĐ"
                                        color: "black"
                                        font.pixelSize: parent.height*0.4
                                    }
                                }

                            }

                            Rectangle {
                                id: forSale
                                anchors.right: parent.right
                                anchors.rightMargin: parent.height*2
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width*0.5 - parent.height*2
                                height: parent.height
                                color: "transparent"
                            }

                            Rectangle {
                                id: updateBatch
                                width: parent.height
                                height: parent.height
                                radius: 8
                                anchors.right: parent.right
                                anchors.rightMargin: parent.height
                                color: "transparent"

                                Button{
                                    anchors.fill: parent
                                    background: Rectangle{
                                        anchors.fill: parent
                                        radius: 8

                                    }
                                    icon.source: "qrc:/images/Icon/refresh.svg"


                                }

                                MouseArea {
                                    id: maupdateBatch
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {

                                    }
                                }
                                
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
                                    onClicked: {

                                    }

                                }
                            }

                        }
                    }

                    Rectangle {
                        id: button
                        width: mainTransaction.width
                        height: mainTransaction.height*0.06
                        color: "transparent"

                        Rectangle {
                            id: addPro
                            width: parent.width*0.2
                            height: parent.height
                            anchors.left: parent.left
                            color: Qt.rgba( 73/255, 145/255, 230/255, 1)
                            radius: 10
                            Text {
                                anchors.centerIn: parent
                                text: " + Thêm sản phẩm"
                                font.pixelSize: parent.height*0.4
                                color: "white"
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

                        Rectangle {
                            id: deleteAllPro
                            width: parent.width*0.2
                            height: parent.height
                            anchors.left: addPro.right
                            anchors.leftMargin: mainTransaction.width*0.01
                            color: Qt.rgba( 73/255, 145/255, 230/255, 1)
                            radius: 10
                            Text {
                                anchors.centerIn: parent
                                text: " Xoá toàn bộ sản phẩm"
                                font.pixelSize: parent.height*0.4
                                color: "white"
                            }

                            MouseArea {
                                id:maDeleteAllPro
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
                    }

                    Rectangle {
                        width: mainTransaction.width
                        height: mainTransaction.height*0.07
                        color: "transparent" 

                        Text {
                            id: title4promotion
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Khuyến mại:    "
                            font.pixelSize: parent.height*0.4
                        }

                        TextField {
                            id: tf4promotion
                            width: parent.width*0.3
                            height: parent.height
                            anchors.left: title4promotion.right 
                        }

                        Text {
                            anchors.left: tf4promotion.right
                            anchors.verticalCenter: parent.verticalCenter
                            text: "   VNĐ "
                            font.pixelSize: parent.height*0.4
                        }

                    }

                    Rectangle {
                        id: orderNote
                        width: mainTransaction.width
                        height: mainTransaction.height*0.07
                        color: "transparent"

                        Text {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "GHI CHÚ"
                            font.pixelSize: parent.height*0.4
                        }

                    }


                    TextArea {
                        id: forNote
                        width:  mainTransaction.width*0.96
                        height:  mainTransaction.height*0.2
                        wrapMode: Text.Wrap
                    }

                    Rectangle {
                        id: comfirmOrder
                        width: mainTransaction.width*0.2
                        height: mainTransaction.height*0.06
                        anchors.left: parent.left
                        color: Qt.rgba( 73/255, 145/255, 230/255, 1)
                        radius: 10
                        Text {
                            anchors.centerIn: parent
                            text: "Xác nhận đơn hàng"
                            font.pixelSize: parent.height*0.4
                            color: "white"
                        }

                        MouseArea {
                            id:maComfirmOrder
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked:{
                                if(transaction.order.length === 0){
                                    rootWindow.notification.showNotification("Đơn hàng rỗng")
                                }else{
                                    orderComfirm.open()
                                }
                            }
                        }
                    }
                }
            }

        }
    }


    // Rectangle {
    //     id: customerInfo
    //     width: parent.width*0.425
    //     anchors.left: parent.left
    //     anchors.leftMargin: parent.width*0.05
    //     height: parent.height*0.2
    //     radius: 8
    //     color: Qt.rgba(1, 1, 1, 0.3)
    //     border.width: 2
    //     border.color: Qt.rgba(0, 0, 0, 1)

    //     Text {
    //         text: "THÔNG TIN KHÁCH HÀNG"
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         anchors.top: parent.top
    //         width: parent.width
    //         height: parent.height / 3
    //         horizontalAlignment: Text.AlignHCenter
    //         verticalAlignment: Text.AlignVCenter
    //         font.pixelSize: 20
    //         color: "white"
    //     }

    //     Rectangle {
    //         anchors.top: customerInfo.top
    //         anchors.topMargin: customerInfo.height/3
    //         anchors.left: customerInfo.left
    //         width: customerInfo.width
    //         height: customerInfo.height/3
    //         color: "transparent"
    //         CustomSearchTextField {
    //             id: customerSearch
    //             width: parent.width
    //             height: parent.height
    //             color: Qt.rgba( 1, 1, 1, 0.2)
    //             placeholderText: "Nhập tên khách hàng"
    //             text: rootWindow.customerName
    //             onSuggestionSelected: (data) => {
    //                 rootWindow.customerName = data.name
    //                 rootWindow.customerPhoneNumber = data.phoneNumber
    //                 rootWindow.customerYearOfBirth = data.yearOfBirth 
    //             }
    //             target: "CUSTOMER"
    //             targetExtension: "NAME"
    //         }
    //     }

    //     Rectangle {
    //         anchors.bottom: customerInfo.bottom
    //         anchors.left: customerInfo.left
    //         width: customerInfo.width*0.5
    //         height: customerInfo.height/3
    //         color: "transparent"
    //         CustomSearchTextField {
    //             id: phoneSearch
    //             width: parent.width
    //             height: parent.height
    //             color: Qt.rgba( 1, 1, 1, 0.2)
    //             placeholderText: "Nhập số điện khách hàng"
    //             text: rootWindow.customerPhoneNumber
    //             onSuggestionSelected: (data) => {
    //                 rootWindow.customerName = data.name
    //                 rootWindow.customerPhoneNumber = data.phoneNumber
    //                 rootWindow.customerYearOfBirth = data.yearOfBirth
    //             }
    //             target: "CUSTOMER"
    //             targetExtension: "PHONENUMBER"
    //         }
    //     }

    //     Rectangle {
    //         anchors.bottom: customerInfo.bottom
    //         anchors.right: customerInfo.right
    //         width: customerInfo.width*0.5
    //         height: customerInfo.height/3
    //         color: "transparent"
    //         CustomSearchTextField {
    //             id: yearSearch
    //             width: parent.width
    //             height: parent.height
    //             color: Qt.rgba( 1, 1, 1, 0.2)
    //             placeholderText: "Nhập năm sinh"
    //             text: rootWindow.customerYearOfBirth
    //             onSuggestionSelected: (data) => {
    //                 rootWindow.customerName = data.name
    //                 rootWindow.customerPhoneNumber = data.phoneNumber
    //                 rootWindow.customerYearOfBirth = data.yearOfBirth
    //             }
    //             target: "CUSTOMER"
    //             targetExtension: "YEAROFBIRTH"
    //         }
    //     }

    // }

    // Rectangle{
    //     id: titleofProductInfo
    //     width: parent.width*0.425
    //     height: parent.height*0.2
    //     anchors.top: parent.top
    //     anchors.right: parent.right
    //     anchors.rightMargin: parent.width*0.05
    //     radius: 8
    //     color: Qt.rgba(1, 1, 1, 0.3)
    //     border.width: 2
    //     border.color: Qt.rgba(0, 0, 0, 1)
    //     clip: true

    //     Text {
    //         text: "THÔNG TIN ĐƠN HÀNG"
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         anchors.top: parent.top
    //         width: parent.width
    //         height: parent.height / 3
    //         horizontalAlignment: Text.AlignHCenter
    //         verticalAlignment: Text.AlignVCenter
    //         font.pixelSize: 20
    //         color: "white"
    //     }

    //     Rectangle {
    //         id: numOfTypeProduct
    //         width:parent.width*0.5
    //         height: parent.height/3
    //         anchors.left:parent.left
    //         anchors.top: parent.top
    //         anchors.topMargin: parent.height/3
    //         radius: 8
    //         Text {
    //             anchors.left: parent.left
    //             anchors.verticalCenter: parent.verticalCenter
    //             text: "Số loại sản phẩm: " + transaction.order.length
    //             verticalAlignment: Text.AlignVCenter
    //         }

    //     }
    //     Rectangle {
    //         id: numOfItem
    //         width:parent.width*0.5
    //         height: parent.height/3
    //         anchors.left:parent.left
    //         anchors.bottom: parent.bottom
    //         radius: 8
    //         Text {
    //             anchors.left: parent.left
    //             anchors.verticalCenter: parent.verticalCenter
    //             text: "Số sản phẩm: " + transaction.numOfItem
    //             verticalAlignment: Text.AlignVCenter
    //         }
    //     }
    //     Rectangle{
    //         id: totalPrice
    //         width:parent.width*0.5
    //         height: parent.height/3
    //         anchors.right: parent.right
    //         anchors.top: parent.top
    //         anchors.topMargin: parent.height/3
    //         radius: 8
    //         Text {
    //             anchors.left: parent.left
    //             anchors.verticalCenter: parent.verticalCenter
    //             text: "Tổng số tiền: " + transaction.formatMoney(transaction.totalPrice) + " VND"
    //             verticalAlignment: Text.AlignVCenter
    //         }
    //     }
    //     Rectangle {
    //         id: purchaseTime
    //         width:parent.width*0.5
    //         height: parent.height/3
    //         anchors.right: parent.right
    //         anchors.bottom: parent.bottom
    //         TextField {
    //             anchors.fill: parent
    //             id: purchaseTimeTextField
    //             text: Qt.formatDate(new Date(), "dd-MM-yyyy")
    //         }
    //     }
    // }

    // Rectangle {
    //     id: productInformation
    //     width: parent.width*0.9
    //     height: parent.height*0.7
    //     anchors.top: titleofProductInfo.bottom
    //     anchors.topMargin: parent.height*0.01
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     color: "transparent"
    //     clip: true
    //     border.width: 2
    //     border.color: "white"
    //     radius: 8

    //     Flickable {
    //         id: scrollArea
    //         anchors.fill: parent
    //         contentHeight: columnContent.height

    //         Column {
    //             id: columnContent
    //             width: scrollArea.width
    //             spacing: 16
                
    //             Repeater {

    //                 model : transaction.order
    //                 Rectangle {
    //                     width: productInformation.width
    //                     height: Math.min(transaction.height*0.2, 100)
    //                     radius: 8
    //                     color: Qt.rgba(1, 1, 1, 0.6)
    //                     border.color: "white"
    //                     border.width: 1

    //                     Rectangle {
    //                         width: parent.width*0.3
    //                         height: parent.height
    //                         anchors.left: parent.left
    //                         anchors.leftMargin: parent.width*0.05
    //                         anchors.verticalCenter: parent.verticalCenter
    //                         color: "transparent"

    //                         Column {
    //                             spacing: 10
    //                             anchors.verticalCenter: parent.verticalCenter
                                
    //                             Text {
                                    
    //                                 text: "Sản phẩm: " +  modelData.productName
    //                                 color: "black"
    //                                 font.pixelSize: 16
    //                             }

    //                             Text {
                                    
    //                                 text: "Số lượng: " +  modelData.numOfItem
    //                                 color: "black"
    //                                 font.pixelSize:  16
    //                             }

    //                         }

    //                     }

    //                     Rectangle {
    //                         width: parent.width*0.3
    //                         height: parent.height
    //                         anchors.left: parent.left
    //                         anchors.leftMargin: parent.width*0.35
    //                         anchors.verticalCenter: parent.verticalCenter
    //                         color: "transparent"
    //                     }


    //                     Rectangle{
    //                         id: deleteProductChoice
    //                         width: parent.height
    //                         height: parent.height
    //                         radius: 8
    //                         anchors.right: parent.right
    //                         color: "transparent"
    //                         Button{
    //                             anchors.fill: parent
    //                             background: Rectangle {
    //                                 anchors.fill: parent
    //                                 radius: 8
    //                                 color: madeleteProductChoice.containsMouse ? Qt.rgba(200/255, 20/255, 20/255, 0.2) : "transparent"
    //                             }

    //                             icon.source: "qrc:/images/Icon/cross-circle.svg"
    //                             icon.color: madeleteProductChoice.containsMouse ? Qt.rgba(250/255, 20/255, 20/255, 0.5) : "white"

    //                         }

    //                         MouseArea {
    //                             id: madeleteProductChoice
    //                             anchors.fill: parent
    //                             hoverEnabled: true

    //                         }


    //                     }
    //                 }
    //             }
    //         }
    //     }
    // }

    // Rectangle{
    //     id: buttonDeleteAllPro
    //     width: parent.width*0.2
    //     height: parent.height*0.08
    //     anchors.top: productInformation.bottom
    //     anchors.topMargin: parent.height*0.01
    //     anchors.left: parent.left
    //     anchors.leftMargin: parent.width*0.1
    //     radius: 10
    //     color: mabuttonDeleteAllPro.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1): Qt.rgba(1, 1, 1, 0.5)

    //     Text {
    //         anchors.centerIn: parent
    //         text: "Xoá toàn bộ lô hàng"
    //         font.pixelSize: 18
    //         color: "white"
    //         horizontalAlignment: Text.AlignHCenter
    //         verticalAlignment: Text.AlignVCenter
    //     }

    //     MouseArea {
    //         id:mabuttonDeleteAllPro
    //         anchors.fill: parent
    //         hoverEnabled: true
    //         onClicked:{
    //             if(transaction.order.length === 0){
    //                 rootWindow.notification.showNotification("Đơn hàng rỗng")
    //             }else{
    //                 deleteOrder.open()
    //             }
    //         }
    //     }
    // }

    // Rectangle{
    //     id: buttonAddPro
    //     width: parent.width*0.2
    //     height: parent.height*0.08
    //     anchors.top: productInformation.bottom
    //     anchors.topMargin: parent.height*0.01
    //     anchors.left: buttonDeleteAllPro.right
    //     anchors.leftMargin: parent.width*0.1
    //     radius: 10
    //     color: mabuttonAddPro.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1): Qt.rgba(1, 1, 1, 0.5)

    //     Text {
    //         anchors.centerIn: parent
    //         text: "Thêm sản phẩm"
    //         font.pixelSize: 18
    //         color: "white"
    //         horizontalAlignment: Text.AlignHCenter
    //         verticalAlignment: Text.AlignVCenter
    //     }

    //     MouseArea {
    //         id:mabuttonAddPro
    //         anchors.fill: parent
    //         hoverEnabled: true
    //         onClicked:{
    //             pageLoader.source = "components/ProductListForTransaction.qml"
    //             rootWindow.isTransactionProductSelect = true
    //         }
    //     }
    // }

    // Rectangle{
    //     id: buttonComfirm
    //     width: parent.width*0.2
    //     height: parent.height*0.08
    //     anchors.top: productInformation.bottom
    //     anchors.topMargin: parent.height*0.01
    //     anchors.right: parent.right
    //     anchors.rightMargin: parent.width*0.1
    //     radius: 10
    //     color: mabuttonComfirm.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1): Qt.rgba(1, 1, 1, 0.5)

    //     Text {
    //         anchors.centerIn: parent
    //         text: "Xác nhận đơn hàng"
    //         font.pixelSize: 20
    //         color: "white"
    //         horizontalAlignment: Text.AlignHCenter
    //         verticalAlignment: Text.AlignVCenter
    //     }

    //     MouseArea {
    //         id:mabuttonComfirm
    //         anchors.fill: parent
    //         hoverEnabled: true
    //         onClicked: {
    //             if(transaction.order.length === 0){
    //                 rootWindow.notification.showNotification("Đơn hàng rỗng")
    //             }else{
    //                 orderComfirm.open()
    //             }
    //         }
    //     }
    // }

    Dialog {
        id: orderComfirm
        title: "Bạn có chắc chắn xác nhận đơn hàng ko?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: parent
        visible: false
        onAccepted: {
            controller.requestOrderCommand("ADD", phoneSearch.text, purchaseTimeTextField.text, forNote.text);
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
