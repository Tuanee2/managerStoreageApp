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

    // Ảnh nền
    Image {
        id: background
        width: parent.width + 40
        height: parent.height + 40
        source: "qrc:/images/fix.jpg"
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
            width: parent.width*0.2
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
            width: parent.width*0.8
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
                color: Qt.rgba( 1, 1, 1, 0.2)
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

                    icon.source: "qrc:/images/search.svg"
                    icon.color: "white"

                }

                TextField {
                    id: searchField
                    width: parent.width - parent.height
                    height: parent.height
                    anchors.right: parent.right
                    placeholderText: "Tìm kiếm sản phẩm..."
                    color: "white"
                    font.pixelSize: rootWindow.baseFontSize
                    
                    onTextChanged: {
                        if(text.length > 0){
                            controller.requestProductList("SEARCH", text, 0)
                            
                        }else{
                            
                        }
                    }
                }

                SuggestionBox {
                    id: suggestionPopup
                    x: 0
                    y: searchBar.height
                    width: searchBar.width
                    model: suggestionModel
                    visible: false  // không cần vì dùng open()
                    onSuggestionSelected: (text) => {
                        searchField.text = text
                        close()
                    }
                }

                // Rectangle {
                //     id: suggestionBox
                //     width: searchBar.width
                //     color: Qt.rgba(1, 1, 1, 1)
                //     radius: 6
                //     anchors.top: searchBar.bottom
                //     anchors.left: searchBar.left
                //     visible: false
                //     z: 999

                //     ListView {
                //         width: parent.width
                //         height: Math.min(200, suggestionModel.count * 40)
                //         model: suggestionModel
                //         clip: true

                //         delegate: Item {
                //             width: suggestionBox.width
                //             height: 40

                //             Rectangle {
                //                 anchors.fill: parent
                //                 color: "white"
                //             }

                //             MouseArea {
                //                 anchors.fill: parent
                //                 onClicked: {
                //                     searchField.text = model.name
                //                     suggestionBox.visible = false
                //                     //controller.requestProductList("SEARCH", model.name, 0)
                //                 }

                //                 Text {
                //                     anchors.verticalCenter: parent.verticalCenter
                //                     anchors.left: parent.left
                //                     anchors.leftMargin: 10
                //                     text: model.name
                //                     font.pixelSize: rootWindow.baseFontSize * 0.9
                //                     color: "black"
                //                 }
                //             }
                //         }
                //     }
                // }
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
                        pageLoader.source = "components/AddNewProduct.qml"
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

                icon.source: "qrc:/images/bell-notification-social-media.svg"
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

    Connections {
        target: controller
        function onProductListReady(list, cmd) {
            if(cmd === "SEARCH"){
                suggestionModel.clear()
                for (var i = 0; i < list.length; ++i) {
                    suggestionModel.append({ name: list[i]["productName"] })
                }
                //suggestionBox.visible = suggestionModel.count > 0
                if (suggestionModel.count > 0) {
                    suggestionPopup.x = 0
                    suggestionPopup.y = searchBar.height
                    suggestionPopup.open()
                } else {
                    suggestionPopup.close()
                }
            }
        }
    }
}
