import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: toast
    width: 500
    height: 50
    radius: 8
    color: Qt.rgba(0, 0, 0, 1)
    opacity: 0.0
    anchors.horizontalCenter: parent.horizontalCenter

    property alias text: toastText.text

    Text {
        id: toastText
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 25
    }

    Behavior on opacity {
        NumberAnimation { duration: 300 }
    }

    Timer {
        id: destroyTimer
        interval: 4000
        running: false
        repeat: false
        onTriggered: {
            opacity = 0.0
            Qt.callLater(toast.destroy)
        }
    }

    Component.onCompleted: {
        opacity = 1.0
        destroyTimer.start()
    }
}
