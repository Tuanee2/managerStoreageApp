import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects


Window {
    id: rootWindow
    width: Screen.width * 0.99
    height: Screen.height * 0.99
    visible: true
    title: qsTr("App quản lý")


    property string currentNavigation: "Bảng thông tin"
    property alias notification: notificationHost
    property real baseFontSize: Screen.height * 0.022

    property bool productSearch: false
    property bool cutomerSearch:false

    property var productListOfOrder: []
    property var batchListOfOrder: []

    // Ảnh nền
    Image {
        id: background
        width: parent.width + 40
        height: parent.height + 40
        source: "qrc:/images/Backgrounds/fix.jpg"
        fillMode: Image.PreserveAspectCrop  // Crop đẹp hơn để phủ toàn bộ
        visible: true  // Ẩn để tránh ảnh gốc lộ ra
    }

    MultiEffect {
        source: background
        anchors.fill: parent
        blurEnabled: true
        blurMax: 50
        blur: 1
        brightness: -0.15
    }

    Rectangle {
        id: blurBackground
        width: parent.width*0.96
        height: parent.height*0.96
        anchors.centerIn: parent
        radius: 30
        // border.width: 1
        // border.color: Qt.rgba( 1, 1, 1, 0.5)
        color: Qt.rgba( 1, 1, 1, 0.1)
    }

    MultiEffect {
        width: parent.width*0.96
        height: parent.height*0.96
        anchors.centerIn: parent
        source: blurBackground
        blurEnabled: true
        blurMax: 20
        blur: 1
        brightness: -0.1
    }

    Rectangle{
        id: mainWindow
        width: parent.width*0.96
        height: parent.height*0.96
        anchors.centerIn: parent
        radius: 30
        border.width: 1
        border.color: Qt.rgba( 1, 1, 1, 0.3)
        color: "transparent"
        clip: true

        Rectangle {
            id: navigationDrawer
            width: Math.min(parent.width*0.2, 300)
            height: parent.height
            anchors.left: parent.left
            anchors.top: parent.top
            topLeftRadius: 30
            bottomLeftRadius: 30
            color: "transparent"
            Loader {
                id: drawerLoader
                source: "components/MainDrawer.qml"
                anchors.fill: parent
            }
        }


        Rectangle {
            id: contentArea
            width: parent.width - navigationDrawer.width
            height: parent.height
            anchors.top: parent.top
            anchors.right: parent.right
            topRightRadius: 30
            bottomRightRadius: 30
            color: Qt.rgba( 1, 1, 1, 0.05)

            Rectangle {
                id: content
                width: parent.width
                height: parent.height*0.8
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                bottomRightRadius: 30
                color: "transparent"
                clip: true
                //

                Loader {
                    id: pageLoader
                    source: "components/Dashboard.qml"
                    anchors.fill: parent
                }
            }

            ListModel {
                id: suggestionModel
            }

            Rectangle {
                id: searchBar
                width: parent.width*0.54
                height: parent.width*0.05
                radius: 10
                color: Qt.rgba(1, 1, 1, 0.1)
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.075
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.05

                Button {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: parent.height
                    height: parent.height
                    background: Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                    }

                    icon.source: "qrc:/images/Icon/search.svg"
                    icon.color: "white"

                }

                CustomerSearchTextField {
                    id: mainSearch
                    width: parent.width - parent.height
                    height: parent.height
                    anchors.right: parent.right
                    color: Qt.rgba( 1, 1, 1, 0.2)
                    placeholderText: "Nhập tên sản phẩm"
                    onSuggestionSelected: (text) => {
                        console.log("Đã chọn khách hàng:", text)
                    }
                    target: "PRODUCT"
                }
            }

            Rectangle {
                id: addNewProduct
                height: parent.width*0.05
                width: parent.width*0.14
                anchors.left: searchBar.right
                anchors.leftMargin: parent.width*0.01
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.075
                radius: 10
                color: ma4add.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    // anchors.top: parent.top
                    // anchors.topMargin: 8
                    text: "Tạo giao dịch"
                    color: "white"
                    font.pixelSize: rootWindow.baseFontSize
                    wrapMode: Text.WordWrap
                    width: parent.width * 0.9  // Cần có để cho phép wrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                }

                MouseArea {
                    id: ma4add
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked:{
                        pageLoader.source = "components/CreateTransaction.qml"
                        drawerLoader.source = "components/TransactionDrawer.qml"
                        rootWindow.currentNavigation = "Tạo giao dịch"
                    }
                }
            }

            Rectangle {
                id: importProduct
                height: parent.width*0.05
                width: parent.width*0.14
                radius: 10
                anchors.left: addNewProduct.right
                anchors.leftMargin: parent.width*0.01
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.075
                color: ma4im.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)

                Text {
                    anchors.centerIn: parent
                    text: "Nhập kho"
                    color: "white"
                    font.pixelSize: rootWindow.baseFontSize
                }

                MouseArea {
                    id: ma4im
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked:{
                        pageLoader.source = "components/ImportBatch.qml"
                        drawerLoader.source = "components/ProductDrawer.qml"
                    }
                }
            }

            Button {
                width: parent.width*0.05
                height: parent.width*0.05
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.075
                anchors.right: parent.right
                anchors.rightMargin: parent.width*0.05
                background: Rectangle{
                    anchors.fill: parent
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.3)
                }

                icon.source: "qrc:/images/Icon/bell-notification-social-media.svg"
                icon.color: "white"
            }
        }
    }

    Item {
        id: notificationHost
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.03
        anchors.left: parent.left
        anchors.right: parent.right
        width: parent.width
        z: 9999  // Đảm bảo luôn nằm trên các thành phần khác

        Column {
            id: notificationColumn
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8
        }

        function showNotification(message) {
            let comp = Qt.createComponent("components/Toast.qml")
            if (comp.status === Component.Ready) {
                let note = comp.createObject(notificationColumn, { "text": message });
            }
        }
    }

    Dialog {
        id: quitProgram
        title: "Bạn muốn thoát chương trình đúng ko?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: parent
        visible: false
        onAccepted: {
            Qt.quit()
        }
    }
}
