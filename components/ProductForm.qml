import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Item {
    id: productDetail
    anchors.fill: parent

    property string productName: ""

    property var products: []
    property var batches: []

    property int currentPage: 0
    property int itemsPerPage: 6
    property bool isLeft: false
    property bool isRight: false

    Component.onCompleted: {
        controller.requestProductList("ONE", productName, 0)
        controller.requestBatchList("LIST", productName, "", productDetail.currentPage)
    }

    function updatePageFlags(batchListSize) {
        isLeft = currentPage > 0
        isRight = batchListSize >= itemsPerPage  // bạn nên định nghĩa `itemsPerPage`
    }

    Connections {
        target: controller
        function onProductListReady(list, cmd) {
            if(cmd === "ONE"){
                productDetail.products = list
            }
        }
    }

    Connections {
        target: controller
        function onBatchListReady(list, cmd) {
            if(cmd === "LIST"){
                productDetail.batches = list
                productDetail.updatePageFlags(list.length)
            }
        }
    }

    Rectangle{
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: baseInfo
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.9
            height: parent.height * 0.2
            color: "transparent"

            property bool editEnabled: false

            Row {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 20

                // Left section: Name and Price fields
                Row {
                    spacing: 20
                    width: parent.width * 0.65
                    anchors.verticalCenter: parent.verticalCenter

                    Column {
                        spacing: 4
                        Text {
                            text: "Tên sản phẩm:"
                            color: "white"
                            font.pixelSize: 16
                        }
                        TextField {
                            id: productNameField
                            width: parent.width * 0.4
                            enabled: baseInfo.editEnabled
                            text: productDetail.products.length > 0 ? productDetail.products[0].product_name : ""
                            onTextChanged: {
                                if (productDetail.products.length > 0)
                                    productDetail.products[0].product_name = text
                            }
                        }
                    }

                    Column {
                        spacing: 4
                        Text {
                            text: "Giá:"
                            color: "white"
                            font.pixelSize: 16
                        }
                        TextField {
                            id: productPriceField
                            width: parent.width * 0.3
                            inputMethodHints: Qt.ImhFormattedNumbersOnly
                            validator: DoubleValidator { bottom: 0.0 }
                            enabled: baseInfo.editEnabled
                            text: productDetail.products.length > 0 ? productDetail.products[0].cost.toString() : ""
                            onTextChanged: {
                                if (productDetail.products.length > 0)
                                    productDetail.products[0].cost = parseFloat(text)
                            }
                        }
                    }
                }

                // Right section: Lock/Unlock and Confirm buttons
                Row {
                    spacing: 10
                    width: parent.width * 0.3
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right

                    Button {
                        text: baseInfo.editEnabled ? "Khóa" : "Mở khóa"
                        onClicked: baseInfo.editEnabled = !baseInfo.editEnabled
                    }

                    Button {
                        text: "Xác nhận"
                        enabled: baseInfo.editEnabled
                        onClicked: {
                            console.log("Xác nhận:", productNameField.text, productPriceField.text)
                            baseInfo.editEnabled = false
                        }
                    }
                }
            }
        }

        Rectangle{
            id: batchInfo
            anchors.top: baseInfo.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.9
            height: parent.height*0.75
            // liệt kê các lô sản phẩm 
            color: "transparent"
            clip: true

            ListView {
                id: batchListView
                anchors.fill: parent
                spacing: 10
                model: batches
 
                delegate: Rectangle{
                    width: batchInfo.width
                    height: batchInfo.height*0.18
                    color: Qt.rgba(1, 1, 1, 0.3)
                    radius: 8
                    Rectangle {
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.01
                        width: parent.width*0.15
                        height: parent.height
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Số lượng: " + modelData.quantity
                            color: "white"
                            font.pixelSize: 20
                        }

                    }
                    

                    Rectangle {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.20
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "| Giá 1 sản phẩm: " + Number(modelData.cost).toLocaleString(Qt.locale(), 'f', 0) + " VND"
                            color: "white"
                            font.pixelSize: 18
                        }
                    }
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.20
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "| Giá lô hàng: " + Number(modelData.cost * modelData.quantity).toLocaleString(Qt.locale(), 'f', 0) + " VND"
                            color: "white"
                            font.pixelSize: 18
                        }
                    }
                    

                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: parent.width*0.5
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "| Ngày nhập hàng: " + Qt.formatDate(new Date(modelData.importdate), "dd-MM-yyyy")
                            color: "white"
                            font.pixelSize: 18
                        }
                    }
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.5
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "| Ngày hết hạn: " + Qt.formatDate(new Date(modelData.expireddate), "dd-MM-yyyy")
                            color: "white"
                            font.pixelSize: 18
                        }
                    }
                }
            }
        }

        Rectangle{
            id: pageController
            anchors.top: batchInfo.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.height*0.4
            height: parent.height*0.05
            color: "transparent"
            
            Button{
                id: back
                width: parent.height
                height: parent.height
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                enabled: productDetail.isLeft
                background: Rectangle{
                    anchors.fill: parent
                    radius: 8
                    //color: "transparent"
                    color: Qt.rgba(1, 1, 1, 0.3)
                }
                Text {
                    text: "<"
                    color: "white"
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        productDetail.currentPage--
                        controller.requestBatchList("LIST", productName, "", productDetail.currentPage)
                    }
                    
                }
            }

            Rectangle{
                width: parent.width*0.5
                height: parent.height
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                radius: 8
                Text {
                    anchors.centerIn: parent
                    text: productDetail.currentPage
                    font.pixelSize: parent.height*0.5
                    color: "black"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

            }

            Button{
                id: next
                width: parent.height
                height: parent.height
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                enabled: productDetail.isRight
                background: Rectangle{

                    anchors.fill: parent
                    radius: 8
                    //color: "transparent"
                    color: Qt.rgba(1, 1, 1, 0.3)
                }

                Text {
                    text: ">"
                    color: "white"
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        productDetail.currentPage++
                        controller.requestBatchList("LIST", productName, "", productDetail.currentPage)
                        console.log("Received batch list. Size:")
                    }

                }
            }

        }
    }

}
