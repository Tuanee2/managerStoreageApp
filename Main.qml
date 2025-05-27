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

    // parameter for font size
    property real baseFontSize: Screen.height * 0.022
    property real drawerFontSize: Math.min(rootWindow.width*0.2, 300)*0.07

    // *******************************************************************


    // parameter for main search field
    property string targetForMainSearch: "PRODUCT"
    property string targetExtensionForMainSearch: "NAME"
    property string placeholderForMainSearch: "Nhập tên sản phẩm"

    // *******************************************************************

    property bool isTransactionProductSelect: false
    property bool isTransactionBatchSelect: false
    property bool isSaveTransaction: false

    // param for notification
    property int numOfNotification: 0
    property int numOfDateToExpired: 30


    property bool productSearch: false
    property bool cutomerSearch:false

    property var batchListOfOrder: []

    Component.onCompleted: {
        controller.requestBatchInformation("", "EXPIREDDATE", "AMONTH", "")
    }

    Connections {
        target: controller
        function onBatchInfoResult(result, type){
            rootWindow.numOfNotification = result
        }
    }

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
                //focus: true
                width: parent.width
                height: Math.max(parent.height*0.8, parent.height - 120)
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
                height: Math.min(contentArea.width*0.05, 60)
                radius: 10
                color: Qt.rgba(1, 1, 1, 0.1)
                anchors.top: parent.top
                anchors.topMargin: Math.min(parent.height*0.075, 30)
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.05

                Button {
                    id: searchIcon
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

                CustomSearchTextField {
                    id: mainSearch
                    width: parent.width - 2*parent.height
                    height: parent.height
                    anchors.left: searchIcon.right
                    color: Qt.rgba( 1, 1, 1, 0.2)
                    placeholderText: rootWindow.placeholderForMainSearch
                    onSuggestionSelected: (text) => {
                        console.log("Đã chọn khách hàng:", text)
                    }
                    target: rootWindow.targetForMainSearch
                    targetExtension: rootWindow.targetExtensionForMainSearch
                    isCreateTransaction: (!rootWindow.isTransactionBatchSelect)&&(!rootWindow.isTransactionProductSelect)
                }

                Rectangle {
                    id: searchMode
                    height: parent.height
                    width: parent.height
                    anchors.right: parent.right
                    color: Qt.rgba( 1, 1, 1, 0.2)
                    topRightRadius: 10
                    bottomRightRadius: 10

                    Button{
                        anchors.fill: parent

                        background: Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                        }

                        icon.source: "qrc:/images/Icon/list.svg"
                        icon.color: "white"
                        onClicked: mainObjectMenu.open()
                    }

                    Menu{
                        id: mainObjectMenu
                        y: searchMode.height
                        x: - searchMode.width/2
                        width: searchMode.width*2
                        MenuItem {
                            id: itemProduct
                            text: "Sản phẩm"
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered:{
                                    productSearchMenu.y = mainObjectMenu.y + itemProduct.y
                                    productSearchMenu.x = mainObjectMenu.x + mainObjectMenu.width
                                    productSearchMenu.open()
                                    customerSearchMenu.close()
                                    batchSearchMenu.close()
                                    orderSearchMenu.close()
                                }
                                onExited: {

                                }
                            }
                        }
                        MenuItem {
                            id: itemCustomer
                            text: "Khách hàng"
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered:{
                                    customerSearchMenu.y = mainObjectMenu.y + itemCustomer.y
                                    customerSearchMenu.x = mainObjectMenu.x + mainObjectMenu.width
                                    customerSearchMenu.open()
                                    productSearchMenu.close()
                                    batchSearchMenu.close()
                                    orderSearchMenu.close()
                                }
                                onExited: {

                                }
                            }
                        }
                        MenuItem {
                            id: itemBatch
                            text: "Lô sản phẩm"
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered:{
                                    batchSearchMenu.y = mainObjectMenu.y + itemBatch.y
                                    batchSearchMenu.x = mainObjectMenu.x + mainObjectMenu.width
                                    batchSearchMenu.open()
                                    customerSearchMenu.close()
                                    productSearchMenu.close()
                                    orderSearchMenu.close()
                                }
                                onExited: {

                                }
                            }
                        }
                        MenuItem {
                            id: itemOrder
                            text: "Đơn hàng"
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered:{
                                    orderSearchMenu.y = mainObjectMenu.y + itemOrder.y
                                    orderSearchMenu.x = mainObjectMenu.x + mainObjectMenu.width
                                    batchSearchMenu.close()
                                    customerSearchMenu.close()
                                    productSearchMenu.close()
                                    orderSearchMenu.open()
                                }
                                onExited: {

                                }
                            }
                        }
                    }

                    Menu {
                        id: productSearchMenu
                        width: searchMode.width*3
                        MenuItem {
                            text: "Tên sản phẩm"
                            onTriggered: {
                                rootWindow.targetForMainSearch = "PRODUCT"
                                rootWindow.targetExtensionForMainSearch = "NAME"
                                rootWindow.placeholderForMainSearch = "Nhập tên sản phẩm"
                                productSearchMenu.close()
                                mainObjectMenu.close()
                            }
                        }
                        MenuItem {
                            text: "Giá sản phẩm"
                            onTriggered: {
                                rootWindow.targetForMainSearch = "PRODUCT"
                                rootWindow.targetExtensionForMainSearch = "PRICE"
                                rootWindow.placeholderForMainSearch = "Nhập giá sản phẩm"
                                productSearchMenu.close()
                                mainObjectMenu.close()
                            }
                        }
                    }

                    Menu {
                        id: customerSearchMenu
                        width: searchMode.width*3
                        MenuItem {
                            text: "Tên khách hàng"
                            onTriggered: {
                                rootWindow.targetForMainSearch = "CUSTOMER"
                                rootWindow.targetExtensionForMainSearch = "NAME"
                                rootWindow.placeholderForMainSearch = "Nhập tên khách hàng"
                                customerSearchMenu.close()
                                mainObjectMenu.close()
                            }
                        }
                        MenuItem {
                            text: "Số điện thoại"
                            onTriggered: {
                                rootWindow.targetForMainSearch = "CUSTOMER"
                                rootWindow.targetExtensionForMainSearch = "PHONENUMBER"
                                rootWindow.placeholderForMainSearch = "Nhập số điện thoại"
                                customerSearchMenu.close()
                                mainObjectMenu.close()
                            }
                        }
                        MenuItem {
                            text: "Năm sinh"
                            onTriggered: {
                                rootWindow.targetForMainSearch = "CUSTOMER"
                                rootWindow.targetExtensionForMainSearch = "YEAROFBIRTH"
                                rootWindow.placeholderForMainSearch = "Nhập năm sinh khách hàng"
                                customerSearchMenu.close()
                                mainObjectMenu.close()
                            }
                        }
                    }


                    Menu {
                        id: batchSearchMenu
                        width: searchMode.width*3
                        MenuItem {
                            text: "Ngày nhập kho"
                            onTriggered: {
                                rootWindow.targetForMainSearch = "BATCH"
                                rootWindow.targetExtensionForMainSearch = "IMPORTDATE"
                                rootWindow.placeholderForMainSearch = "Nhập ngày nhập kho"
                                batchSearchMenu.close()
                                mainObjectMenu.close()
                            }
                        }
                        MenuItem {
                            text: "Ngày hết hạn"
                            onTriggered: {
                                rootWindow.targetForMainSearch = "BATCH"
                                rootWindow.targetExtensionForMainSearch = "EXPIREDDATE"
                                rootWindow.placeholderForMainSearch = "Nhập ngày hết hạn"
                                batchSearchMenu.close()
                                mainObjectMenu.close()
                            }
                        }

                    }

                    Menu {
                        id: orderSearchMenu
                        width: searchMode.width*3
                        MenuItem {
                            text: "Tên người mua"
                            onTriggered: {
                                rootWindow.targetForMainSearch = "ORDER"
                                rootWindow.targetExtensionForMainSearch = "NAME"
                                rootWindow.placeholderForMainSearch = "Nhập tên người mua đơn hàng"
                                orderSearchMenu.close()
                                mainObjectMenu.close()
                            }
                        }
                        MenuItem {
                            text: "Ngày mua"
                            onTriggered: {
                                rootWindow.targetForMainSearch = "ORDER"
                                rootWindow.targetExtensionForMainSearch = "EXPORTDATE"
                                rootWindow.placeholderForMainSearch = "Nhập ngày mua đơn hàng"
                                orderSearchMenu.close()
                                mainObjectMenu.close()
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: addNewProduct
                height: Math.min(contentArea.width*0.05, 60)
                width: parent.width*0.14
                anchors.left: searchBar.right
                anchors.leftMargin: parent.width*0.01
                anchors.top: parent.top
                anchors.topMargin: Math.min(parent.height*0.075, 30)
                radius: 10
                color: ma4add.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    // anchors.top: parent.top
                    // anchors.topMargin: 8
                    text: "Tạo giao dịch"
                    color: "white"
                    font.pixelSize: rootWindow.drawerFontSize
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
                        controller.requestCommandOrder_UI("ADD")
                    }
                }
            }

            Rectangle {
                id: importProduct
                height: Math.min(contentArea.width*0.05, 60)
                width: parent.width*0.14
                radius: 10
                anchors.left: addNewProduct.right
                anchors.leftMargin: parent.width*0.01
                anchors.top: parent.top
                anchors.topMargin: Math.min(parent.height*0.075, 30)
                color: ma4im.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)

                Text {
                    anchors.centerIn: parent
                    text: "Nhập kho"
                    color: "white"
                    font.pixelSize: rootWindow.drawerFontSize
                }

                MouseArea {
                    id: ma4im
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked:{
                        if(!rootWindow.isTransactionProductSelect && !rootWindow.isTransactionBatchSelect){
                            pageLoader.source = "components/ImportBatch.qml"
                            drawerLoader.source = "components/ProductDrawer.qml"
                        }
                    }
                }
            }

            Rectangle{

                width: Math.min(contentArea.width*0.05, 60)
                height: Math.min(contentArea.width*0.05, 60)
                anchors.top: parent.top
                anchors.topMargin: Math.min(parent.height*0.075, 30)
                anchors.right: parent.right
                anchors.rightMargin: parent.width*0.05
                color: "transparent"

                Button {
                    anchors.fill: parent
                    background: Rectangle{
                        anchors.fill: parent
                        radius: 10
                        color: Qt.rgba(1, 1, 1, 0.3)
                    }

                    icon.source: "qrc:/images/Icon/bell-notification-social-media.svg"
                    icon.color: "white"
                }

                Rectangle{
                    visible: rootWindow.numOfNotification > 0
                    width: parent.height*0.5
                    height: parent.height*0.5
                    radius: parent.height*0.25
                    anchors.top: parent.top
                    anchors.left: parent.left
                    color: "red"

                    Text{
                        anchors.centerIn: parent
                        text: (rootWindow.numOfNotification > 99) ? "99+" : rootWindow.numOfNotification
                        color: "white"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageLoader.source = "components/Notification.qml"

                    }
                }


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

    Connections {
        target: controller
        function onRequestCommandOrderResult_UI(result, cmd){
            if(!rootWindow.isTransactionProductSelect && !rootWindow.isTransactionBatchSelect){
                if(cmd === "ADD"){
                    if(result){
                        pageLoader.source = "components/CreateTransaction.qml"
                        drawerLoader.source = "components/TransactionDrawer.qml"
                        rootWindow.currentNavigation = "Tạo giao dịch"
                        rootWindow.isTransactionProductSelect = false
                        rootWindow.isTransactionBatchSelect = false
                    }else {
                        rootWindow.notification.showNotification("⚠️ Tạo giao dịch thất bại, hãy thử lại");
                    }
                }
            }
        }
    }


}
