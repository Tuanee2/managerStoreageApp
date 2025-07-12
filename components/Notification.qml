import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material

Item {
    id: rootNotification
    anchors.fill: parent

    property int currentPage: 0
    property int itemPerPage: 6
    property bool isLeft: false
    property bool isRight: false
    property int pointer: 0

    property var batches: []

    Component.onCompleted: {
        let cmdData = {
            cmd: "LIST",
            typelist: "EXPIREDDATE",
            duration: "AMONTH"
        }
        controller.requestBatchList(cmdData, "", "", rootNotification.itemPerPage, rootNotification.currentPage)

    }

    Connections {
        target: controller
        function onBatchListReady(list, cmd){
            rootNotification.batches = list;
            updatePageFlags(list.length)
        }
    }

    function updatePageFlags(batchListSize) {
        rootNotification.isLeft = currentPage > 0
        rootNotification.isRight = batchListSize >= rootNotification.itemPerPage  // bạn nên định nghĩa `itemsPerPage`
    }

    Rectangle{
        id: notificationController
        width: parent.width*0.96
        height: parent.height*0.1
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        border.width: 1
        border.color: Qt.rgba(0, 0, 0, 0.3)
        radius: 8 

        Rectangle{
            id: invalidDate
            width: parent.width*0.2
            height: parent.height*0.8
            radius: 8
            anchors.right: parent.right
            anchors.rightMargin: parent.width*0.01
            anchors.verticalCenter: parent.verticalCenter
            color: (maInvalidDate.containsMouse) || (rootNotification.pointer === 0) ? "#e6f0ff" : "transparent"
            border.width: 1
            border.color: maInvalidDate.containsMouse ? "#80bfff" : Qt.rgba(0, 0, 0, 0.2)

            Text {
                text: "Hết Hạn"
                font.pixelSize: parent.height*0.4
                anchors.centerIn: parent
                color: "black"
            }

            MouseArea {
                id: maInvalidDate
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    if(rootNotification.pointer != 0){
                        rootNotification.pointer = 0
                        rootNotification.currentPage = 0
                        let cmdData = {
                            cmd: "LIST",
                            typelist: "EXPIREDDATE",
                            duration: "AMONTH"
                        }
                        controller.requestBatchList(cmdData, "", "", rootNotification.itemPerPage, rootNotification.currentPage)
                    }
                }
            }
        }

        Rectangle{
            id: debt
            width: parent.width*0.2
            height: parent.height*0.8
            radius: 8
            anchors.right: invalidDate.left
            anchors.rightMargin: parent.width*0.01
            anchors.verticalCenter: parent.verticalCenter
            color: maDebt.containsMouse ? "#e6f0ff" : "transparent"
            border.width: 1
            border.color: maDebt.containsMouse || (rootNotification.pointer === 1) ? "#80bfff" : Qt.rgba(0, 0, 0, 0.2)

            Text {
                text: "Nợ"
                font.pixelSize: parent.height*0.4
                anchors.centerIn: parent
                color: "black"
            }

            MouseArea {
                id: maDebt
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    if(rootNotification.pointer != 1){
                        rootNotification.pointer = 1
                        rootNotification.currentPage = 0
                        let cmdData = {
                            command: "GET",
                            target: "ORDER",
                            infoKind: "OBJECT",
                            mode: "MULTIPLE",
                            getType: "LIST",
                            filters: {
                                debt: ""
                            },
                            page: rootNotification.currentPage,
                            pageSize: rootNotification.itemPerPage
                        }
                        controller.requestOrderList(cmdData)
                    }
                    
                }
            }
        }
    }

    Rectangle{
        id: notificationList
        width: parent.width*0.96
        height: parent.height*0.83
        anchors.top: notificationController.bottom
        anchors.topMargin: parent.height*0.01
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"

        Column{
            anchors.fill: parent
            spacing: notificationList.height*0.01

            Repeater{
                model: rootNotification.batches

                delegate: Loader {
                    property var itemData: modelData 
                    sourceComponent: (rootNotification.pointer === 0) ? expiredDelegate : debtDelegate
                }
            }

            Component {
                id: expiredDelegate
                Rectangle {
                    width: notificationList.width
                    height: notificationList.height*0.15
                    radius: 8
                    color: "white"
                    border.width: 1
                    border.color: Qt.rgba(0, 0, 0, 0.2)

                    Rectangle {
                        id: nameProductNoti
                        width: parent.width*0.3
                        height: parent.height*0.5
                        anchors.top: parent.top
                        anchors.left: parent.left
                        color: "transparent"
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.1
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Tên sản phẩm: " + itemData.productName
                            font.pixelSize: parent.height*0.4
                        }

                    }
                    Rectangle {
                        id: numOfItemNoti
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.1
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Số sản phẩm: " + itemData.quantity
                            font.pixelSize: parent.height*0.4
                        }

                    }
                    Rectangle {
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.3
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.1
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Ngày nhập: " +  itemData.expireddate
                            font.pixelSize: parent.height*0.4
                        }

                    }
                    Rectangle {
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.3
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.1
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Ngày hết hạn: " + itemData.expireddate
                            font.pixelSize: parent.height*0.4
                        }

                    }
                    Rectangle {
                        width: parent.width*0.4
                        height: parent.height
                        color: "transparent"
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.1
                            anchors.verticalCenter: parent.verticalCenter
                            text: (itemData.quantity === -1) ? "Đã hết hạn" : "Hết hạn sau " + itemData.days_left + " ngày"
                            font.pixelSize: parent.height*0.4
                        }


                    }
                }
            }

            Component {
                id: debtDelegate
                Rectangle {
                    width: notificationList.width
                    height: notificationList.height*0.15
                    radius: 8
                    color: "white"
                    border.width: 1
                    border.color: Qt.rgba(0, 0, 0, 0.2)
                }
            }
        }
    }

    Rectangle{
        id: pageController
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height*0.01
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.height*0.4
        height: parent.height*0.04
        color: "transparent"

        Button{
            id: back
            width: parent.height
            height: parent.height
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            enabled: rootNotification.isLeft
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
                    rootNotification.currentPage--
                    let cmdData = {
                        cmd: "LIST",
                        typelist: "EXPIREDDATE",
                        duration: "AMONTH"
                    }
                    controller.requestBatchList(cmdData, "", "", rootNotification.itemPerPage, rootNotification.currentPage)
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
                text: rootNotification.currentPage
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

            enabled: rootNotification.isRight
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
                    rootNotification.currentPage++
                    let cmdData = {
                        cmd: "LIST",
                        typelist: "EXPIREDDATE",
                        duration: "AMONTH"
                    }
                    controller.requestBatchList(cmdData, "", "", rootNotification.itemPerPage, rootNotification.currentPage)
                }

            }
        }

    }

}
