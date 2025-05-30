import QtQuick 2.15
import QtQuick.Effects
import QtQuick.Controls

Item {
    anchors.fill: parent
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Grid {
            id: gridLayout
            anchors {
                top: parent.top
                topMargin: parent.height * 0.05
                left: parent.left
                leftMargin: parent.width * 0.05
                right: parent.right
                rightMargin: parent.width * 0.05
                bottom: parent.bottom
                bottomMargin: parent.height * 0.05
            }

            columns: 2
            rowSpacing: parent.height * 0.05
            columnSpacing: parent.width * 0.05

            Repeater {
                model: 4
                Rectangle {
                    width: (gridLayout.width - gridLayout.columnSpacing) / 2
                    height: (gridLayout.height  - gridLayout.rowSpacing) / 2
                    radius: 20
                    color: Qt.rgba(1, 1, 1, 0.2)
                    border.color: Qt.rgba(1, 1, 1, 0.3)
                    border.width: 1
                }
            }
        }
    }
}
