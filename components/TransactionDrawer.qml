import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects

Item {
    id: transDrawer
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
            id: button04
            width: transDrawer.width*0.9
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
                    if(drawerLoader.source === "components/ProductFormForTransaction.qml"){
                        pageLoader.source = "components/ProductListForTransaction.qml"
                    }else if(pageLoader.source === "components/ProductListForTransaction.qml"){
                        pageLoader.source = "components/CreateTransaction.qml"
                    }
                    drawerLoader.source = "components/MainDrawer.qml"
                    pageLoader.source = "components/Dashboard.qml"
                }
            }
        }

    }

}
