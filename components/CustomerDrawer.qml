import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects

Item {
    id: rootDrawer4Customer
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
            width: navigationDrawer.width*0.8
            height: width/4
            radius: 4
            color: mouseArea01.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent"

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

                icon.source: "qrc:/images/cuida--clipboard-text-outline.svg"
                icon.color: "white"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon01.right
                text: "Danh sách khách hàng"
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
                    rootWindow.currentNavigation = "Danh sách khác hàng"
                    pageLoader.source = "components/ProductList.qml"
                }
            }
        }

        Rectangle {
            id: button02
            width: navigationDrawer.width*0.8
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

                icon.source: "qrc:/images/cuida--package-outline.svg"
                icon.color: "white"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon02.right
                text: "Thêm khách hàng mới"
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
                    rootWindow.currentNavigation = "Thêm khách hàng mới"
                    pageLoader.source = "components/AddNewProduct.qml"
                }
            }
        }

        Rectangle {
            id: button03
            width: navigationDrawer.width*0.8
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

                icon.source: "qrc:/images/leave.svg"
                icon.color: "white"

            }


            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon03.right
                text: "Quay lại"
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
                    drawerLoader.source = "components/MainDrawer.qml"
                    pageLoader.source = "components/Dashboard.qml"
                }
            }
        }

    }

}
