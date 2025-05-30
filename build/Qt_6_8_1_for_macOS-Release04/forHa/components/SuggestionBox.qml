import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects


Popup {
    id: root
    property alias model: suggestionView.model

    background: Rectangle {
        color: "transparent"
    }

    property int rowHeight: 100
    property int maxHeight: 200

    signal suggestionSelected(string text)
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    ListView {
        id: suggestionView
        anchors.fill: parent
        width: parent.width
        height: Math.min(root.maxHeight, model.count * root.rowHeight)
        delegate: Rectangle {
            width: root.width
            height: 50
            color: "white"
            radius: 10
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.suggestionSelected(model.name)
                    root.close()
                }
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width*0.1
                    anchors.verticalCenter: parent.verticalCenter
                    text: model.name
                    font.pixelSize: 16 
                }
            }
        }
    }
}
