import QtQuick 2.15

Item {
    id: rootSetting
    anchors.fill: parent

    property bool isCheckingpdate: false
    property bool updateAvailable: false
    property string newVersion: ""


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
        color: !rootSetting.isCheckingpdate ? Qt.rgba( 53/255, 125/255, 210/255, 1) : !rootSetting.updateAvailable ? "gray" : Qt.rgba( 53/255, 125/255, 210/255, 1)

        Text {
            anchors.centerIn: parent
            text: !rootSetting.isCheckingpdate ? "Kiểm tra phiên bản mới nhất" : !rootSetting.updateAvailable ? "Không có bản cập nhật mới" : "Phiên bản " + rootSetting.newVersion + " có sẵn"
            color: "white"
            font.pixelSize: parent.height*0.2
        }

        MouseArea {
            id: buttoncheckversion
            enabled: !((rootSetting.isCheckingpdate === true) && (rootSetting.updateAvailable === false))
            anchors.fill: parent
            onClicked: {
                if(rootSetting.isCheckingpdate === false){
                    updater.checkForUpdate()
                    rootSetting.isCheckingpdate = true
                }else{
                     updater.downloadUpdate()
                }
            }
        }
    }

}
