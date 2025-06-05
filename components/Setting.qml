import QtQuick 2.15

Item {
    id: rootSetting
    anchors.fill: parent

    property bool updateAvailable: false
    property string newVersion: ""

    Component.onCompleted: {
        updater.checkForUpdate()
    }

    Connections {
        target: updater
        function onUpdateAvailable(version){
            console.log(version)
            rootSetting.updateAvailable = true
            rootSetting.newVersion = version
        }

    }



    Rectangle{
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.01
        anchors.left: parent.left
        anchors.leftMargin: parent.width*0.01
        width: parent.width*0.38
        height: parent.height*0.13
        radius: 10
        color: !rootSetting.updateAvailable ? "gray" : Qt.rgba( 53/255, 125/255, 210/255, 1)

        Text {
            anchors.centerIn: parent
            text: !rootSetting.updateAvailable ? "Không có bản cập nhật mới" : "Phiên bản " + rootSetting.newVersion + " có sẵn"
            color: "white"
            font.pixelSize: parent.height*0.2
        }

        MouseArea {
            anchors.fill: parent
            enabled:rootSetting.updateAvailable
            onClicked: {
                updater.downloadUpdate()
            }
        }
    }

}
