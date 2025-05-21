import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Item {
    id: batchlist4trans
    property string productName: ""

    property var batches: []

    property int currentPage: 0
    property int itemsPerPage: 6
    property bool isLeft: false
    property bool isRight: false

    Component.onCompleted: {
        controller.requestBatchList("LIST", batchlist4trans.productName, batchlist4trans.currentPage)
    }

    function updatePageFlags(batchListSize) {
        isLeft = currentPage > 0
        isRight = batchListSize >= itemsPerPage  // bạn nên định nghĩa `itemsPerPage`
    }

    Connections {
        target: controller
        function onBatchListReady(list, cmd) {
            if(cmd === "LIST"){
                batchlist4trans.batches = list
                batchlist4trans.updatePageFlags(list.length)
            }
        }
    }


    Rectangle{
        anchors.fill: parent
        color: "transparent"

        Rectangle{
            id: baseInfo
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.9
            height: parent.height*0.2
            color: "transparent"
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
                    
                    SpinBox {
                        from: 0
                        to: modelData.quantity
                        stepSize: 10
                        value: 0
                        editable: true
                        width: parent.width*0.3
                        height: parent.height 
                        anchors.left: parent.left
                        anchors.top: parent.top
                    }


                    Rectangle {
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.3
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
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.6
                        width: parent.width*0.3
                        height: parent.height
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
                enabled: batchlist4trans.isLeft
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
                        batchlist4trans.currentPage--
                        controller.requestBatchList("LIST", productName, batchlist4trans.currentPage)
                    }
                    
                }
            }

            Button{
                id: next
                width: parent.height
                height: parent.height
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                enabled: batchlist4trans.isRight
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
                        batchlist4trans.currentPage++
                        controller.requestBatchList("LIST", productName, batchlist4trans.currentPage)
                        console.log("Received batch list. Size:")
                    }

                }
            }

        }
    }

}
