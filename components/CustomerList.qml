import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Effects

Item {
    id: rootCustomerList
    anchors.fill: parent

    property var customers: []
    property string selectedCustomerName: ""
    property string selectedCustomerPhoneNumber: ""
    property string filterType: "SREACH"
    property string filterText: "Tìm kiếm"
    property bool isRight: false
    property bool isLeft: false
    property int currentPage: 0
    property int peoplePerPage: 12
    property int productPerPage: 12

    Component.onCompleted: {
        let cmdData = {
            command: "GET",
            target: "CUSTOMER",
            infoKind: "OBJECT",
            mode: "MULTIPLE",
            getType: "LIST",
            page: rootCustomerList.currentPage,
            pageSize: rootCustomerList.peoplePerPage
        }
        controller.requestCustomerList(cmdData);
    }

    function updatePageFlags(customerListSize) {
        rootCustomerList.isLeft = currentPage > 0
        rootCustomerList.isRight = customerListSize >= rootCustomerList.peoplePerPage  // bạn nên định nghĩa `itemsPerPage`
    }

    Connections {
        target: controller
        function onCustomerListReady(list, cmd) {
            if(filterType === "LIST" || cmd.getType === "LIST"){
                customers = list;
            }else if(filterType === "SEARCH" || cmd.getType === "SEARCH"){
                customers = list;
            }
            updatePageFlags(list.length)
        }
    }

    Rectangle {
        id: customerList
        width: parent.width
        height: parent.height*0.9
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"

        Rectangle{
            id: filter
            height: parent.height*0.07
            width: parent.width*0.15
            radius: 8
            anchors.right: parent.right
            anchors.rightMargin:  parent.width*0.05
            anchors.top: parent.top
            color: Qt.rgba(1, 1, 1, 0.3)

            Button{
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.height
                height: parent.height

                background: Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }

                icon.source: "qrc:/images/Icon/filter.svg"
                icon.color: "white"
                onClicked: filterMenu.open()
            }

            Text {
                text: filterText
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.height
                font.pixelSize: rootWindow.baseFontSize*0.9
            }

            Menu {
                id: filterMenu
                y: filter.height
                width: filter.width

                MenuItem {
                    text: "Tất cả"
                    onTriggered: {
                        filterType = "LIST"
                        filterText = "Tất cả"
                        let cmdData = {
                            command: "GET",
                            target: "PRODUCT",
                            infoKind: "OBJECT",
                            mode: "MULTIPLE",
                            sortField: "NONE",
                            page: 0,
                            pageSize: productPerPage
                        }
                        controller.requestProductList(cmdData)
                    }
                }

                MenuItem {
                    text: "Tìm kiếm"
                    onTriggered: {
                        filterType = "SEARCH"
                        filterText = "Tìm kiếm"
                        // Gọi hàm tìm kiếm nếu cần
                    }
                }
            }
        }


        Grid {
            id: customerGrid
            columns: 2
            anchors.fill: parent
            anchors.margins: customerList.width * 0.05
            rowSpacing: customerList.height * 0.03
            columnSpacing: customerList.width * 0.05

            Repeater {
                model: customers

                delegate: Rectangle {
                    width: customerList.width*0.85/2
                    height: customerList.height * 0.12
                    radius: 8
                    color: "white"
                    border.color: Qt.rgba( 0, 0, 0, 0.1)
                    border.width: 1
                    Layout.fillWidth: true

                    Rectangle{
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        width: parent.width - 3*parent.height
                        color: "transparent"

                        Button{
                            id: iconName
                            anchors.left: parent.left
                            anchors.top: parent.top
                            height: parent.height/2
                            width: parent.height/2
                            background: Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                            }
                            icon.source: "qrc:/images/Icon/id-card.svg"
                            icon.color: "#007bff"
                            icon.width: 100
                            icon.height: 100
                        }

                        Rectangle {
                            id: cusName
                            anchors.left: iconName.right
                            anchors.top: parent.top
                            width: parent.width*0.5
                            height: parent.height/2
                            color: "transparent"
                            Text {
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Tên: " + modelData["name"]
                                font.pixelSize: parent.height * 0.4
                                color: "black"
                            }
                        }

                        Button{
                            id: iconPhonenumber
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            height: parent.height/2
                            width: parent.height/2
                            background: Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                            }
                            icon.source: "qrc:/images/Icon/phone-rotary.svg"
                            icon.color: "#007bff"
                        }

                        Rectangle {
                            id: cusPhonenumber
                            anchors.left: iconPhonenumber.right
                            anchors.bottom: parent.bottom
                            width: parent.width*0.5
                            height: parent.height/2
                            color: "transparent"
                            Text {
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                text: "SĐT: " + modelData["phone_number"]
                                font.pixelSize: parent.height * 0.4
                                color: "black"
                            }
                        }

                    }

                    Button{
                        id: detailhButton
                        width: parent.height
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 2*parent.height

                        background: Rectangle{
                            anchors.fill: parent
                            color: madetailhButton.containsMouse ? Qt.rgba(1, 1, 1, 0.3) : "transparent"
                            radius: 8
                        }

                        icon.source: "qrc:/images/Icon/file-circle-info.svg"
                        icon.color: "black"

                        MouseArea{
                            id: madetailhButton
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                pageLoader.setSource("CustomerForm.qml", {
                                    customerPhoneNumber: modelData["phone_number"]
                                })
                            }

                        }

                    }

                    Button{
                        id: addBatchButton
                        width: parent.height
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 1*parent.height

                        background: Rectangle{
                            anchors.fill: parent
                            color: maaddBatchButton.containsMouse ? Qt.rgba(1, 1, 1, 0.3) : "transparent"
                            radius: 8
                        }

                        icon.source: "qrc:/images/Icon/add.svg"
                        icon.color: "black"

                        MouseArea{
                            id: maaddBatchButton
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                rootWindow.customerName =  modelData["name"]
                                rootWindow.customerPhoneNumber = modelData["phone_number"]
                                rootWindow.customerYearOfBirth = modelData["year_of_birth"]
                                pageLoader.source = "components/CreateTransaction.qml"
                                drawerLoader.source = "components/TransactionDrawer.qml"
                                rootWindow.currentNavigation = "Tạo giao dịch"

                            }

                        }

                    }

                    Button{
                        id: deleteProductButton
                        width: parent.height
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        background: Rectangle{
                            anchors.fill: parent
                            color: madeleteProductButton.containsMouse ? Qt.rgba(1, 1, 1, 0.3) : "transparent"
                            radius: 8
                        }

                        icon.source: "qrc:/images/Icon/cross-circle.svg"
                        icon.color: "#007bff"
                        MouseArea{
                            id: madeleteProductButton
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                selectedCustomerName = modelData["name"]
                                selectedCustomerPhoneNumber = modelData["phone_number"]
                                deleteCustomerConfirmDialog.open()
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle{
        id: pageController
        anchors.top: customerList.bottom
        anchors.topMargin: parent.height*0.025
        anchors.horizontalCenter: parent.horizontalCenter
        
        width: parent.height*0.4
        height: parent.height*0.05
        color: "transparent"
        
        Button{
            id: back
            width: parent.height
            height: parent.height
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            enabled: rootCustomerList.isLeft
            background: Rectangle{
                anchors.fill: parent
                radius: 8
                //color: "transparent"
                color: rootCustomerList.isLeft ?  "#80bfff" : "transparent"
            }
            Text {
                text: "<"
                color: "white"
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    rootCustomerList.currentPage--
                    let cmdData = {
                        command: "GET",
                        target: "CUSTOMER",
                        infoKind: "OBJECT",
                        mode: "MULTIPLE",
                        getType: "LIST",
                        page: rootCustomerList.currentPage,
                        pageSize: rootCustomerList.peoplePerPage
                    }
                    controller.requestCustomerList(cmdData)
                }
                
            }
        }

        Rectangle{
            width: parent.width*0.5
            height: parent.height
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            radius: 8
            border.width: 1
            border.color: "#80bfff"
            Text {
                anchors.centerIn: parent
                text: rootCustomerList.currentPage
                font.pixelSize: parent.height*0.5
                color: "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

        }

        Button{
            id: next
            width: parent.height
            height: parent.height
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            enabled: rootCustomerList.isRight
            background: Rectangle{

                anchors.fill: parent
                radius: 8
                color: rootCustomerList.isRight ?  "#80bfff" : "transparent"
            }

            Text {
                text: ">"
                color: "white"
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    rootCustomerList.currentPage++
                    let cmdData = {
                        command: "GET",
                        target: "CUSTOMER",
                        infoKind: "OBJECT",
                        mode: "MULTIPLE",
                        getType: "LIST",
                        page: rootCustomerList.currentPage,
                        pageSize: rootCustomerList.peoplePerPage
                    }
                    controller.requestCustomerList(cmdData)
                }

            }
        }

    }

    Dialog{
        id: deleteCustomerConfirmDialog
        title: "Bạn có chắc chắn muốn xoá khách hàng?\nToàn bộ thông tin khách hàng bao gồm cả lịch sử đơn hàng sẽ bị xoá"
        
        standardButtons: Dialog.Yes | Dialog.No
        visible: false
        onAccepted: {
            let cmdData = {
                command: "DELETE",
                data: {
                    phonenumber: rootCustomerList.selectedCustomerPhoneNumber
                }
            }

            controller.requestCustomerCommand(cmdData)
            rootCustomerList.selectedCustomerName = ""
            rootCustomerList.selectedCustomerPhoneNumber = ""
            let cmdData1 = {
                command: "GET",
                target: "CUSTOMER",
                infoKind: "OBJECT",
                mode: "MULTIPLE",
                getType: "LIST",
                page: rootCustomerList.currentPage,
                pageSize: rootCustomerList.peoplePerPage
            }
            controller.requestCustomerList(cmdData1)
        }
    }

}
