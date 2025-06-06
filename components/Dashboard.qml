import QtQuick 2.15
import QtQuick.Effects
import QtQuick.Controls

Item {
    id: rootDashboard
    anchors.fill: parent

    property int numOfTypeProduct: 0

    Component.onCompleted: {
        let cmdPro = {
            type: "NUMOFITEM"
        }
        controller.requestProductParam(cmdPro, "");
    }

    Connections {
        target: controller
        function onProductParamResult(result, cmd){
            rootDashboard.numOfTypeProduct = result
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Rectangle {
            id: infoOfStorage
            width: parent.width*0.425
            height: parent.height*0.4
            anchors.top : parent.top
            anchors.topMargin: parent.height*0.05
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.05
            color: Qt.rgba(0, 0, 0, 0.4)
            radius: 10

            Text{
                anchors.centerIn: parent
                text: rootDashboard.numOfTypeProduct + " Loại sản phẩm"
                color: "white"
                font.pixelSize: parent.height*0.15
            }

        }

        Rectangle {
            //id: infoOfStorage
            width: parent.width*0.425
            height: parent.height*0.4
            anchors.top : parent.top
            anchors.topMargin: parent.height*0.05
            anchors.right: parent.right
            anchors.rightMargin: parent.width*0.05
            color: Qt.rgba(0, 0, 0, 0.4)
            radius: 10
        }

        Rectangle {
            //id: infoOfStorage
            width: parent.width*0.425
            height: parent.height*0.4
            anchors.bottom : parent.bottom
            anchors.bottomMargin: parent.height*0.05
            anchors.right: parent.right
            anchors.rightMargin: parent.width*0.05
            color: Qt.rgba(0, 0, 0, 0.4)
            radius: 10
        }

        Rectangle {
            //id: infoOfStorage
            width: parent.width*0.425
            height: parent.height*0.4
            anchors.bottom : parent.bottom
            anchors.bottomMargin: parent.height*0.05
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.05
            color: Qt.rgba(0, 0, 0, 0.4)
            radius: 10
        }
    }
}
