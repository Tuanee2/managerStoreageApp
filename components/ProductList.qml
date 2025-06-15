import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material

Item {
    anchors.fill: parent
    id: rootProductList
    property var products: []
    property string selectedProductName: ""
    property string filterType: "SREACH"
    property string filterText: "Tìm kiếm"
    property int currentPage: 0
    property int productPerPage: 12
    property bool isLeft: false
    property bool isRight: false

    Component.onCompleted: {
        let cmdData = {
            command: "GET",
            target: "PRODUCT",
            infoKind: "OBJECT",
            mode: "MULTIPLE",
            getType: "LIST",
            page: rootProductList.currentPage,
            pageSize: rootProductList.productPerPage
        }
        controller.requestProductList(cmdData);
    }

    Connections {
        target: controller
        function onProductListReady(list, cmd) {
            if(filterType === "LIST" || cmd.getType === "LIST"){
                products = list;
                updatePageFlags(list.length)
            }else if(filterType === "SEARCH" || cmd.getType === "SEARCH"){
                products = list;
            }
        }
    }

    function updatePageFlags(productListSize) {
        rootProductList.isLeft = currentPage > 0
        rootProductList.isRight = productListSize >= 12  // bạn nên định nghĩa `itemsPerPage`
    }


    Rectangle {
        id: productList
        anchors.fill: parent
        color: "transparent"

        Rectangle{
            id: filter
            height: parent.height*0.08
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
                            getType: "LIST",
                            page: rootProductList.currentPage,
                            pageSize: rootProductList.productPerPage
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

                MenuItem {
                    text: "Hết hạn"
                    onTriggered: {
                        filterType = "EXPIRED"
                        filterText = "Hết hạn"
                        let cmdData = {
                            command: "GET",
                            target: "PRODUCT",
                            infoKind: "OBJECT",
                            mode: "MULTIPLE",
                            getType: "LIST",
                            filters: {
                                expired: ""
                            },
                            page: rootProductList.currentPage,
                            pageSize: rootProductList.productPerPage
                        }
                        controller.requestProductList(cmdData)
                    }
                }

                MenuItem {
                    text: "Còn hạn"
                    onTriggered: {
                        filterType = "VALID"
                        filterText = "Còn hạn"
                        let cmdData = {
                            command: "GET",
                            target: "PRODUCT",
                            infoKind: "OBJECT",
                            mode: "MULTIPLE",
                            getType: "LIST",
                            filters: {
                                valid: ""
                            },
                            page: rootProductList.currentPage,
                            pageSize: rootProductList.productPerPage
                        }
                        controller.requestProductList(cmdData)
                    }
                }
            }
        }


        Grid {
            id: productGrid
            columns: 2
            anchors.fill: parent
            anchors.margins: productList.width * 0.05
            rowSpacing: productList.height * 0.03
            columnSpacing: productList.width * 0.05

            Repeater {
                model: products

                delegate: Rectangle {
                    width: productList.width*0.85/2
                    height: productList.height * 0.08
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
                                text: "Tên: " + modelData["productName"]
                                font.pixelSize: rootWindow.baseFontSize*0.9
                                color: "white"
                            }

                            Text {
                                text: "Giá: " + modelData["cost"] + " VND / " + modelData["unit"]
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
                        anchors.rightMargin: 3*parent.height

                        background: Rectangle{
                            anchors.fill: parent
                            color: madetailhButton.containsMouse ? Qt.rgba(200/255, 180/255, 80/255, 0.4) : "transparent"
                            radius: 8
                        }

                        icon.source: "qrc:/images/Icon/file-circle-info.svg"
                        icon.color: madetailhButton.containsMouse ? Qt.rgba(240/255, 200/255, 100/255, 1) : "white"

                        MouseArea{
                            id: madetailhButton
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                pageLoader.setSource("ProductForm.qml", {
                                    productName: modelData["productName"]
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
                        anchors.rightMargin: 2*parent.height

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
                                pageLoader.setSource("ImportBatch.qml", {
                                    productName: modelData["productName"]
                                })

                            }

                        }

                    }

                    Button{
                        id: saleButton
                        width: parent.height
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: parent.height
                        background: Rectangle{
                            anchors.fill: parent
                            color: masaleButton.containsMouse ? Qt.rgba(1, 1, 1, 0.3) : "transparent"
                            radius: 8

                        }
                        icon.source: "qrc:/images/Icon/minus-circle.svg"
                        icon.color: "white"

                        MouseArea{
                            id: masaleButton
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {

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
                                selectedProductName = modelData["productName"]
                                deleteProductConfirmDialog.open()
                            }
                        }
                    }
                }
            }
        }


        Rectangle{
            id: pageController
            anchors.top: productGrid.bottom
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
                enabled: rootProductList.isLeft
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
                        rootProductList.currentPage--
                        let cmdData = {
                            command: "GET",
                            target: "PRODUCT",
                            infoKind: "OBJECT",
                            mode: "MULTIPLE",
                            getType: "LIST",
                            page: rootProductList.currentPage,
                            pageSize: rootProductList.productPerPage
                        }
                        controller.requestProductList(cmdData)
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
                    text: rootProductList.currentPage
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

                enabled: rootProductList.isRight
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
                        rootProductList.currentPage++
                        let cmdData = {
                            command: "GET",
                            target: "PRODUCT",
                            infoKind: "OBJECT",
                            mode: "MULTIPLE",
                            getType: "LIST",
                            page: rootProductList.currentPage,
                            pageSize: rootProductList.productPerPage
                        }
                        controller.requestProductList(cmdData)
                    }

                }
            }

        }
    }

    Dialog{
        id: deleteProductConfirmDialog
        title: "Bạn có chắc chắn muốn xoá sản phẩm?"
        standardButtons: Dialog.Yes | Dialog.No
        visible: false
        onAccepted: {
            let cmdData= {
                command: "DELETE",
                target: "PRODUCT",
                data: {
                    name: selectedProductName
                }
            }
            controller.requestProductCommand(cmdData)

            selectedProductName = ""
            let cmdData1 = {
                command: "GET",
                target: "PRODUCT",
                infoKind: "OBJECT",
                mode: "MULTIPLE",
                getType: "LIST",
                page: rootProductList.currentPage,
                pageSize: rootProductList.productPerPage
            }
            controller.requestProductList(cmdData1)
        }
    }

}
