pragma Singleton
import QtQuick 2.15

QtObject {
    property int corner: 12

    property var button :QtObject {
        property int corner: 12
        property color background: "transparent"
        property color hoverBackground: "#e6f0ff"
        property color textColor: "#6c757d"
        property color textHoverColor: "#003366"
    }

    property var drawer : QtObject{
        property var icon: QtObject {
            property color background: "#6c757d"
            property color hoverBackground: "#007bff"
        }

        property var title: QtObject {
            property color background: "#6c757d"
            property color hoverBackground: "#003366"

        }
    }


}