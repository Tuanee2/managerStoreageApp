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

    Component.onCompleted: {
        controller.requestProductList("LIST", "", productListTransaction.currentPage);
    }

    Connections {
        target: controller
        function onProductListReady(list, cmd) {
            if (cmd === "LIST") {
                productListTransaction.products = list
            }
        }
    }

    Rectangle {
        id: productList
        anchors.fill: parent
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
                    color: Qt.rgba( 1, 1, 1, 0.3)
                    border.color: Qt.rgba( 1, 1, 1, 0.5)
                    border.width: 1
                    Layout.fillWidth: true

                    Rectangle{
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        width: parent.width - 4*parent.height
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

                    Button{
                        id: addBatchButton
                        width: parent.height
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 2*parent.height

                        background: Rectangle{
                            anchors.fill: parent
                            color: maaddBatchButton.containsMouse ? Qt.rgba(1, 1, 1, 0.3) : "transparent"
                            radius: 8
                        }

                        icon.source: "qrc:/images/add.svg"
                        icon.color: "white"

                        MouseArea{
                            id: maaddBatchButton
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                rootWindow.productListOfOrder.push({
                                    productName: modelData["productName"]
                                })
                                pageLoader.source = "components/CreateTransaction.qml"
                            }

                        }

                    }
                }
            }
        }
    }

}
