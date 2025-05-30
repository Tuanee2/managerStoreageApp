import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects

Item {

    anchors.fill: parent
    id: rootTransactionHistory

    property var orders: []
    property int currentPage: 0
    property int numOfPage: 6
    property bool isLeft: false
    property bool isRight: false
    property string command: "LIST"
    property string dateBegin: ""
    property string dateEnd: ""


    Component.onCompleted: {
        controller.requestOrderList(rootTransactionHistory.command, rootTransactionHistory.dateBegin, rootTransactionHistory.dateEnd, rootTransactionHistory.numOfPage, rootTransactionHistory.currentPage)
    }

    Connections {
        target: controller
        function onOrderListReady(list, cmd){
            if(cmd === "LIST"){
                orders = list;
                updatePageFlags(list.length)
            }
        }
    }

    function updatePageFlags(orderListSize) {
        rootTransactionHistory.isLeft = currentPage > 0
        rootTransactionHistory.isRight = orderListSize >= 6  
    }

    Rectangle {
        anchors.fill:parent
        color: "transparent"

        Rectangle{
            id: historyController
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.96
            height: parent.height*0.2
            radius: 10
            color: "white"
        }

        Rectangle{
            id: transactionList
            anchors.top: historyController.bottom
            anchors.topMargin: parent.height*0.01
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.96
            height: parent.height*0.7
            color: "transparent"

            Column{
                id: orderList
                anchors.fill: parent
                spacing: transactionList.height*0.01
                Repeater {
                    model: rootTransactionHistory.orders

                    delegate: Rectangle{
                        width: transactionList.width
                        height: transactionList.height*0.15
                        radius: 10
                        color: Qt.rgba(1, 1, 1, 0.3)

                        Rectangle{
                            anchors.left: parent.left
                            height: parent.height
                            width: parent.width*0.3
                            radius: 10
                            color: "transparent"

                            Text{
                                anchors.centerIn: parent
                                text: (modelData.customer_name === "") ? "Vô danh" : modelData.customer_name
                                color: "white"
                                font.pixelSize: parent.height*0.3
                            }
                        }

                        Rectangle{
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.3
                            height: parent.height
                            width: parent.width*0.2
                            radius: 10
                            visible: modelData.customer_name === ""
                            color: "transparent"

                            Text{
                                anchors.centerIn: parent
                                text: modelData.phone_number
                                color: "white"
                                font.pixelSize: parent.height*0.3
                            }
                        }

                        Rectangle{
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.5
                            height: parent.height
                            width: parent.width*0.2
                            radius: 10
                            color: "transparent"

                            Text{
                                anchors.centerIn: parent
                                text: Qt.formatDate(new Date(modelData.purchase_time), "dd-MM-yyyy")
                                color: "white"
                                font.pixelSize: parent.height*0.3
                            }
                        }

                        Rectangle{
                            id: orderDetail
                            width: parent.height
                            height: parent.height
                            anchors.right: parent.right
                            anchors.rightMargin: parent.height
                            radius: 10
                            color: maorderDetail.containsMouse ? Qt.rgba(200/255, 180/255, 80/255, 0.4) : "transparent"

                            Button{
                                anchors.fill:parent
                                background: Rectangle{
                                    color: "transparent"
                                }

                                icon.source: "qrc:/images/Icon/file-circle-info.svg"
                                icon.color: maorderDetail.containsMouse ? Qt.rgba(240/255, 200/255, 100/255, 1) : "white"
                            }

                            MouseArea{
                                id: maorderDetail
                                anchors.fill: parent
                                hoverEnabled:true

                            }
                        }

                        Rectangle{
                            id: orderDelete
                            width: parent.height
                            height: parent.height
                            anchors.right: parent.right
                            radius: 10
                            color: maorderDelete.containsMouse ? Qt.rgba(200/255, 20/255, 20/255, 0.2) : "transparent"

                            Button{
                                anchors.fill:parent
                                background: Rectangle{
                                    color: "transparent"
                                }

                                icon.source: "qrc:/images/Icon/cross-circle.svg"
                                icon.color: maorderDelete.containsMouse ? Qt.rgba(250/255, 20/255, 20/255, 0.5) : "white"
                            }

                            MouseArea{
                                id: maorderDelete
                                anchors.fill: parent
                                hoverEnabled:true
                                onClicked: {

                                }

                            }
                        }
                    }
                }
            }
            
        }

        Rectangle{
            id: pageController
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
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
                enabled: rootTransactionHistory.isLeft
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
                        rootTransactionHistory.currentPage--
                        controller.requestOrderList(rootTransactionHistory.command, rootTransactionHistory.dateBegin, rootTransactionHistory.dateEnd, rootTransactionHistory.numOfPage, rootTransactionHistory.currentPage)
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
                    text: rootTransactionHistory.currentPage
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

                enabled: rootTransactionHistory.isRight
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
                        rootTransactionHistory.currentPage++
                        controller.requestOrderList(rootTransactionHistory.command, rootTransactionHistory.dateBegin, rootTransactionHistory.dateEnd, rootTransactionHistory.numOfPage, rootTransactionHistory.currentPage)
                    }

                }
            }

        }
    }

}
