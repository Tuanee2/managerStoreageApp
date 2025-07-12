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
            font.pixelSize: rootWindow.drawerFontSize*1.2
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
            color: mouseArea01.containsMouse ? "#e6f0ff" : "transparent"
            border.width: 1
            border.color: mouseArea01.containsMouse ? "#80bfff" : "transparent"

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
                icon.color: mouseArea01.containsMouse ? "#007bff" : "#6c757d"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon01.right
                text: "Bảng thông tin"
                color:  mouseArea01.containsMouse ? "#003366" : "#6c757d"
                font.pixelSize: rootWindow.drawerFontSize
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
            color: mouseArea02.containsMouse ? "#e6f0ff" : "transparent"
            border.width: 1
            border.color: mouseArea02.containsMouse ? "#80bfff" : "transparent"

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
                icon.color: mouseArea02.containsMouse ? "#007bff" : "#6c757d"
            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon02.right
                text: "Sản phẩm"
                color:  mouseArea02.containsMouse ? "#003366" : "#6c757d"
                font.pixelSize: rootWindow.drawerFontSize
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

                    rootWindow.currentNavigation = "Danh sách sản phẩm"
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
            color: mouseArea03.containsMouse ? "#e6f0ff" : "transparent"
            border.width: 1
            border.color: mouseArea03.containsMouse ? "#80bfff" : "transparent"

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
                icon.color: mouseArea03.containsMouse ? "#007bff" : "#6c757d"

            }


            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon03.right
                text: "Khách hàng"
                color: mouseArea03.containsMouse ? "#003366" : "#6c757d"
                font.pixelSize: rootWindow.drawerFontSize
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
                    rootWindow.currentNavigation = "Danh sách khách hàng"
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
            color: mouseArea04.containsMouse ? "#e6f0ff" : "transparent"
            border.width: 1
            border.color: mouseArea04.containsMouse ? "#80bfff" : "transparent"

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
                icon.color: mouseArea04.containsMouse ? "#007bff" : "#6c757d"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon04.right
                text: "Doanh thu"
                color: mouseArea04.containsMouse ? "#003366" : "#6c757d"
                font.pixelSize: rootWindow.drawerFontSize
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
            color: mouseArea05.containsMouse ? "#e6f0ff" : "transparent"
            border.width: 1
            border.color: mouseArea05.containsMouse ? "#80bfff" : "transparent"

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
                icon.color: mouseArea05.containsMouse ? "#007bff" : "#6c757d"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon05.right
                text: "Lịch sử giao dịch"
                color: mouseArea05.containsMouse ? "#003366" : "#6c757d"
                font.pixelSize: rootWindow.drawerFontSize
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
                    pageLoader.source = "components/TransactionHistory.qml"

                }
            }
        }

        Rectangle {
            id: button06
            width: navigationDrawer.width*0.9
            height: width/4
            radius: 4
            color: mouseArea06.containsMouse ? "#e6f0ff" : "transparent"
            border.width: 1
            border.color: mouseArea06.containsMouse ? "#80bfff" : "transparent"

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
                icon.color: mouseArea06.containsMouse ? "#007bff" : "#6c757d"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon06.right
                text: "Cài đặt"
                color: mouseArea06.containsMouse ? "#003366" : "#6c757d"
                font.pixelSize: rootWindow.drawerFontSize
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
            color: mouseArea07.containsMouse ? "#e6f0ff" : "transparent"
            border.width: 1
            border.color: mouseArea07.containsMouse ? "#80bfff" : "transparent"

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
                icon.color: mouseArea07.containsMouse ? "#007bff" : "#6c757d"


            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon07.right
                text: "Thoát"
                color: mouseArea07.containsMouse ? "#003366" : "#6c757d"
                font.pixelSize: rootWindow.drawerFontSize
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
