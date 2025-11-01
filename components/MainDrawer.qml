import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects
import LanHuyStore 1.0

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
            font.pixelSize: rootWindow.drawerFontSize*1.2
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
            radius: Style.button.corner
            color: mouseArea01.containsMouse ? Style.button.hoverBackground : Style.button.background

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

                icon.source: PathConfig.drawer.icon.dashboard
                icon.color: mouseArea01.containsMouse ? Style.drawer.icon.hoverBackground : Style.drawer.icon.background

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon01.right
                text: Title.drawer.element.dashboard
                color:  mouseArea01.containsMouse ? Style.drawer.title.hoverBackground : Style.drawer.title.background
                font.pixelSize: rootWindow.drawerFontSize
            }

            MouseArea {
                id: mouseArea01
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    console.log(ThemeApp.corner)
                    rootWindow.currentNavigation = PathConfig.drawer.icon.dashboard
                    pageLoader.source = PathConfig.page.dashboard
                }
            }
        }


        Rectangle {
            id: button02
            width: navigationDrawer.width*0.9
            height: width/4
            radius: Style.corner
            color: mouseArea02.containsMouse ? Style.button.hoverBackground : Style.button.background

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

                icon.source: PathConfig.drawer.icon.product
                icon.color: mouseArea02.containsMouse ? Style.drawer.icon.hoverBackground : Style.drawer.icon.background
            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon02.right
                text: Title.drawer.element.product
                color:  mouseArea02.containsMouse ? Style.drawer.title.hoverBackground : Style.drawer.title.background
                font.pixelSize: rootWindow.drawerFontSize
            }

            MouseArea {
                id: mouseArea02
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {

                    rootWindow.currentNavigation = Title.drawer.element.product
                    pageLoader.source = PathConfig.page.productList
                    drawerLoader.source = PathConfig.drawer.type.product
                }
            }
        }

        Rectangle {
            id: button03
            width: navigationDrawer.width*0.9
            height: width/4
            radius: Style.corner
            color: mouseArea03.containsMouse ? Style.button.hoverBackground : Style.button.background

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

                icon.source: PathConfig.drawer.icon.customer
                icon.color: mouseArea03.containsMouse ? Style.drawer.icon.hoverBackground : Style.drawer.title.background

            }


            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon03.right
                text: Title.drawer.element.customer
                color: mouseArea03.containsMouse ? Style.drawer.title.hoverBackground : Style.drawer.title.background
                font.pixelSize: rootWindow.drawerFontSize
            }

            MouseArea {
                id: mouseArea03
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    rootWindow.currentNavigation = Title.drawer.element.customer
                    pageLoader.source = PathConfig.page.customerList
                    drawerLoader.source = PathConfig.drawer.type.customer
                }
            }
        }

        Rectangle {
            id: button04
            width: navigationDrawer.width*0.9
            height: width/4
            radius: Style.corner
            color: mouseArea04.containsMouse ? Style.button.hoverBackground : Style.button.background

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

                icon.source: PathConfig.drawer.icon.revenue
                icon.color: mouseArea04.containsMouse ? Style.drawer.icon.hoverBackground : Style.drawer.title.background

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon04.right
                text: Title.drawer.element.revenue
                color: mouseArea04.containsMouse ? Style.drawer.title.hoverBackground : Style.drawer.title.background
                font.pixelSize: rootWindow.drawerFontSize
            }

            MouseArea {
                id: mouseArea04
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {

                    rootWindow.currentNavigation = Title.drawer.element.revenue
                    pageLoader.source = PathConfig.page.revenue

                }
            }
        }

        Rectangle {
            id: button05
            width: navigationDrawer.width*0.9
            height: width/4
            radius: Style.corner
            color: mouseArea05.containsMouse ? Style.button.hoverBackground : Style.button.background

            Button {
                id: icon05
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: PathConfig.drawer.icon.transactionHistory
                icon.color: mouseArea05.containsMouse ? Style.drawer.icon.hoverBackground : Style.drawer.title.background

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon05.right
                text: Title.drawer.element.transactionHistory
                color: mouseArea05.containsMouse ? Style.drawer.title.hoverBackground : Style.drawer.title.background
                font.pixelSize: rootWindow.drawerFontSize
            }

            MouseArea {
                id: mouseArea05
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    rootWindow.currentNavigation = Title.drawer.element.transactionHistory
                    pageLoader.source = PathConfig.page.transactionHistory

                }
            }
        }

        Rectangle {
            id: button06
            width: navigationDrawer.width*0.9
            height: width/4
            radius: Style.corner
            color: mouseArea06.containsMouse ? Style.button.hoverBackground : Style.button.background

            Button {
                id: icon06
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: PathConfig.drawer.icon.setting
                icon.color: mouseArea06.containsMouse ? Style.drawer.icon.hoverBackground : Style.drawer.title.background

            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon06.right
                text: Title.drawer.element.setting
                color: mouseArea06.containsMouse ? Style.drawer.title.hoverBackground : Style.drawer.title.background
                font.pixelSize: rootWindow.drawerFontSize
            }

            MouseArea {
                id: mouseArea06
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    rootWindow.currentNavigation = Title.drawer.element.setting
                    pageLoader.source = PathConfig.page.setting
                }
            }
        }

        Rectangle {
            id: button07
            width: navigationDrawer.width*0.9
            height: width/4
            radius: Style.corner
            color: mouseArea07.containsMouse ? Style.button.hoverBackground : Style.button.background


            Button {
                id: icon07
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: PathConfig.drawer.icon.quit
                icon.color: mouseArea07.containsMouse ? Style.drawer.icon.hoverBackground : Style.drawer.title.background


            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon07.right
                text: Title.drawer.element.quit
                color: mouseArea07.containsMouse ? Style.drawer.title.hoverBackground : Style.drawer.title.background
                font.pixelSize: rootWindow.drawerFontSize
            }

            MouseArea {
                id: mouseArea07
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    quitProgram.open()
                }
            }
        }
    }


}
