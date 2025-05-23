import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material

Item {
    id: productListTransaction
    anchors.fill: parent
    property var selectedProduct: null
    property var selectedBatch: null
    property int currentPage: 0

    property var products: []

    property bool isLeft: false
    property bool isRight: false


    Component.onCompleted: {
        controller.requestProductList("LIST", "", productListTransaction.currentPage);
    }

    Connections {
        target: controller
        function onProductListReady(list, cmd) {
            productListTransaction.products = list
            updatePageFlags(list.length)
        }
    }

    function updatePageFlags(productListSize) {
        isLeft = currentPage > 0
        isRight = productListSize >= 12  // bạn nên định nghĩa `itemsPerPage`
    }

    Rectangle {
        id: productList
        width: parent.width
        height: parent.height * 0.9
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"

        Grid {
            id: productGrid
            columns: 2
            anchors.fill: parent
            anchors.margins: productList.width * 0.05
            rowSpacing: productList.height * 0.03
            columnSpacing: productList.width * 0.05

            Repeater {
                model: productListTransaction.products

                delegate: Rectangle {
                    width: productList.width*0.85/2
                    height: productList.height * 0.1
                    radius: 8
                    color: ma4choice.containsMouse ? Qt.rgba( 1, 1, 1, 0.6) : Qt.rgba(1, 1, 1, 0.3)
                    border.color: Qt.rgba( 1, 1, 1, 0.5)
                    border.width: 1
                    Layout.fillWidth: true

                    Rectangle{
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        width: parent.width * 0.4
                        color: "transparent"
                        clip: true

                        Column {
                            spacing: 4
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.05
                            Text {
                                text: "Tên: " + modelData["productName"]
                                font.pixelSize: rootWindow.baseFontSize*0.9
                                color: "white"
                            }

                            Text {
                                text: "Giá: " + modelData["cost"] + " VND"
                                font.pixelSize: rootWindow.baseFontSize*0.9
                                color: "white"
                            }
                        }
                    }

                    Rectangle {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        width: parent.width * 0.6
                        color: "transparent"
                        Text{
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "số hàng còn trong kho: " + modelData["numOfProduct"]
                            font.pixelSize: rootWindow.baseFontSize*0.9
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    MouseArea {
                        id: ma4choice
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            rootWindow.isTransactionBatchSelect = true
                            rootWindow.isTransactionProductSelect = false
                            rootWindow.productListOfOrder.push({
                                productName: modelData["productName"]
                            })
                            pageLoader.setSource("ProductFormForTransaction.qml", {
                                productName: modelData["productName"]
                            })
                        }
                    }
                }
            }
        }

        Rectangle{
            id: pageController
            anchors.top: productList.bottom
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
                enabled: productListTransaction.isLeft
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
                        productListTransaction.currentPage--
                        controller.requestProductList("LIST", "", productListTransaction.currentPage);
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
                    text: productListTransaction.currentPage
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

                enabled: productListTransaction.isRight
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
                        productListTransaction.currentPage++
                        controller.requestProductList("LIST", "", productListTransaction.currentPage);
                    }

                }
            }

        }
    }

}
