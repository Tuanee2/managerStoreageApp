import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material

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

    Component.onCompleted: {
        let cmdData = {
            cmd: "LIST",
            typelist: ""
        }
        controller.requestCustomerList(cmdData, "", rootCustomerList.peoplePerPage, currentPage);
    }

    function updatePageFlags(customerListSize) {
        rootCustomerList.isLeft = currentPage > 0
        rootCustomerList.isRight = customerListSize >= rootCustomerList.peoplePerPage  // bạn nên định nghĩa `itemsPerPage`
    }

    Connections {
        target: controller
        function onCustomerListReady(list, cmd) {
            if(filterType === "LIST" || cmd === "LIST"){
                customers = list;
            }else if(filterType === "SEARCH" || cmd === "SEARCH"){
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
                            cmd: "LIST",
                            typelist: ""
                        }
                        controller.requestProductList(cmdData, "", 0)
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
                    height: customerList.height * 0.1
                    radius: 8
                    color: Qt.rgba( 1, 1, 1, 0.3)
                    border.color: Qt.rgba( 1, 1, 1, 0.5)
                    border.width: 1
                    Layout.fillWidth: true

                    Rectangle{
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        width: parent.width - 4*parent.height
                        color: "transparent"
                        clip: true

                        Column {
                            spacing: 4
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width*0.05
                            Text {
                                text: "Tên: " + modelData["name"]
                                font.pixelSize: rootWindow.baseFontSize*0.9
                                color: "white"
                            }

                            Text {
                                text: "SĐT: " + modelData["phone_number"]
                                font.pixelSize: rootWindow.baseFontSize*0.9
                                color: "white"
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
                        icon.color: "white"

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
                        icon.color: "white"

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
                        icon.color: "white"
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
                color: Qt.rgba(1, 1, 1, 0.3)
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
                        cmd: "LIST",
                        typelist: ""
                    }
                    controller.requestCustomerList(cmdData, "", rootCustomerList.peoplePerPage, rootCustomerList.currentPage)
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
                //color: "transparent"
                color: Qt.rgba(1, 1, 1, 0.3)
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
                        cmd: "LIST",
                        typelist: ""
                    }
                    controller.requestCustomerList(cmdData, "", rootCustomerList.peoplePerPage, rootCustomerList.currentPage)
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
            controller.requestCustomerCommand("DELETE", rootCustomerList.selectedCustomerName, "", "", rootCustomerList.selectedCustomerPhoneNumber)
            rootCustomerList.selectedCustomerName = ""
            rootCustomerList.selectedCustomerPhoneNumber = ""
            let cmdData = {
                cmd: "LIST",
                typelist: ""
            }
            controller.requestCustomerList(cmdData, "", rootCustomerList.peoplePerPage, rootCustomerList.currentPage)
        }
    }

}
