import QtQuick 2.15

Item {
    anchors.fill: parent


    Rectangle {
        id: dateController
        width: parent.width
        height: parent.height*0.15
        anchors.left: parent.left
        anchors.top: parent.top
        color: "transparent"
    }

    Rectangle {

        width: parent.width
        height: parent.height*0.85
        anchors.left: parent.left
        anchors.top: dateController.bottom
        color: "transparent"
        
        CustomChart{

        }
    }

   
}
