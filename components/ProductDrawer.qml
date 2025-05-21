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
                text: "Danh sách sản phẩm"
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
                    rootWindow.currentNavigation = "Danh sách sản phẩm"
                    pageLoader.source = "components/ProductList.qml"
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
                text: "Thêm sản phẩm mới"
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
                    console.log("Click: Bảng thông tin")
                    rootWindow.currentNavigation = "Thêm sản phẩm mới"
                    pageLoader.source = "components/AddNewProduct.qml"
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
                text: "Nhập kho"
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
                    rootWindow.currentNavigation = "Nhập kho"
                    pageLoader.source = "components/ImportBatch.qml"
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

                icon.source: "qrc:/images/Icon/leave.svg"
                icon.color: "white"

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon04.right
                text: "Quay lại"
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
                    drawerLoader.source = "components/MainDrawer.qml"
                    pageLoader.source = "components/Dashboard.qml"
                }
            }
        }

    }

}
