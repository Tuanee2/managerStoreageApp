import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects

Item {
    id: rootDrawer
    anchors.fill: parent


    Rectangle{
        width: parent.width
        height: parent.height*0.2
        anchors.left: parent.left
        anchors.right: parent.right
        color: "transparent"

        Text{
            anchors.fill: parent
            width: parent.width
            height: parent.height*0.2
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text : rootWindow.currentNavigation
            font.bold: true
            font.pixelSize: rootWindow.baseFontSize*1.2
            color: "white"
        }
    }

    Column {

        spacing: parent.height*0.02
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.2  // Cách đỉnh một khoảng

        Rectangle {
            id: button01
            width: navigationDrawer.width*0.9
            height: width/4
            radius: 4
            color: mouseArea01.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent"

            // Button {
            //     id: icon01
            //     width: parent.width/4
            //     height: parent.height
            //     anchors.left: parent.left
            //     anchors.top: parent.QObject
            //     icon.source: "qrc:/images/Icon/cuida--clipboard-text-outline.svg"
            //     icon.color: "white"
            //     icon.width: icon01.width*0.8
            //     icon.height: icon01.height*0.8

            // }

            Button {
                id: icon01
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: "qrc:/images/Icon/cuida--clipboard-text-outline.svg"
                icon.color: "white"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon01.right
                text: "Bảng thông tin"
                color: "white"
                font.pixelSize: rootWindow.baseFontSize
            }

            MouseArea {
                id: mouseArea01
                anchors.fill: parent
                hoverEnabled: true

                onEntered:{

                }

                onExited:{

                }

                onReleased:{

                }

                onClicked: {

                    rootWindow.currentNavigation = "Bảng thông tin"
                    pageLoader.source = "components/Dashboard.qml"
                }
            }
        }


        Rectangle {
            id: button02
            width: navigationDrawer.width*0.9
            height: width/4
            radius: 4
            color: mouseArea02.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent"

            Button {
                id: icon02
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: "qrc:/images/Icon/cuida--package-outline.svg"
                icon.color: "white"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon02.right
                text: "Sản phẩm"
                color: "white"
                font.pixelSize: rootWindow.baseFontSize
            }

            MouseArea {
                id: mouseArea02
                anchors.fill: parent
                hoverEnabled: true

                onEntered:{

                }

                onExited:{

                }

                onReleased:{

                }

                onClicked: {

                    rootWindow.currentNavigation = "Sản phẩm"
                    pageLoader.source = "components/ProductList.qml"
                    drawerLoader.source = "components/ProductDrawer.qml"
                }
            }
        }

        Rectangle {
            id: button03
            width: navigationDrawer.width*0.9
            height: width/4
            radius: 4
            color: mouseArea03.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent"

            Button {
                id: icon03
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: "qrc:/images/Icon/users01.svg"
                icon.color: "white"

            }


            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon03.right
                text: "Khách hàng"
                color: "white"
                font.pixelSize: rootWindow.baseFontSize
            }

            MouseArea {
                id: mouseArea03
                anchors.fill: parent
                hoverEnabled: true

                onEntered:{

                }

                onExited:{

                }

                onReleased:{

                }

                onClicked: {
                    rootWindow.currentNavigation = "Khách hàng"
                    pageLoader.source = "components/CustomerList.qml"
                    drawerLoader.source = "components/CustomerDrawer.qml"
                }
            }
        }

        Rectangle {
            id: button04
            width: navigationDrawer.width*0.9
            height: width/4
            radius: 4
            color: mouseArea04.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent"

            Button {
                id: icon04
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: "qrc:/images/Icon/coins.svg"
                icon.color: "white"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon04.right
                text: "Doanh thu"
                color: "white"
                font.pixelSize: rootWindow.baseFontSize
            }

            MouseArea {
                id: mouseArea04
                anchors.fill: parent
                hoverEnabled: true

                onEntered:{

                }

                onExited:{

                }

                onReleased:{

                }

                onClicked: {

                    rootWindow.currentNavigation = "Doanh thu"
                    pageLoader.source = "components/Sales.qml"

                }
            }
        }

        Rectangle {
            id: button05
            width: navigationDrawer.width*0.9
            height: width/4
            radius: 4
            color: mouseArea05.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent"

            Button {
                id: icon05
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: "qrc:/images/Icon/cuida--chart-column-outline.svg"
                icon.color: "white"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon05.right
                text: "Lịch sử giao dịch"
                color: "white"
                font.pixelSize: rootWindow.baseFontSize
            }

            MouseArea {
                id: mouseArea05
                anchors.fill: parent
                hoverEnabled: true

                onEntered:{

                }

                onExited:{

                }

                onReleased:{

                }

                onClicked: {
                    rootWindow.currentNavigation = "Lịch sử giao dịch"

                }
            }
        }

        Rectangle {
            id: button06
            width: navigationDrawer.width*0.9
            height: width/4
            radius: 4
            color: mouseArea06.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent"

            Button {
                id: icon06
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: "qrc:/images/Icon/settings01.svg"
                icon.color: "white"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon06.right
                text: "Cài đặt"
                color: "white"
                font.pixelSize: rootWindow.baseFontSize
            }

            MouseArea {
                id: mouseArea06
                anchors.fill: parent
                hoverEnabled: true

                onEntered:{

                }

                onExited:{

                }

                onReleased:{

                }

                onClicked: {
                    rootWindow.currentNavigation = "Cài đặt"
                    pageLoader.source = "components/Setting.qml"
                }
            }
        }

        Rectangle {
            id: button07
            width: navigationDrawer.width*0.9
            height: width/4
            radius: 4
            color: mouseArea07.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent"

            Button {
                id: icon07
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: "qrc:/images/Icon/leave.svg"
                icon.color: "white"


            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon07.right
                text: "Thoát"
                color: "white"
                font.pixelSize: rootWindow.baseFontSize
            }

            MouseArea {
                id: mouseArea07
                anchors.fill: parent
                hoverEnabled: true

                onEntered:{

                }

                onExited:{

                }

                onReleased:{

                }

                onClicked: {
                    quitProgram.open()
                }
            }
        }
    }


}
