import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Item {
    id: productDetail
    anchors.fill: parent

    property string productName: ""

    property var products: []
    property var batches: []

    property int currentPage: 0
    property int itemsPerPage: 6
    property bool isLeft: false
    property bool isRight: false
    property string updateName: ""
    property int updatecost: 0

    Component.onCompleted: {
        let cmdData = {
            command: "GET",
            target: "PRODUCT",
            infoKind: "OBJECT",
            mode: "SINGLE",
            filters: {
                name: productName
            }
        }
        controller.requestProductList(cmdData)
        let cmdData1 = {
            cmd: "LIST",
            typelist: "",
            duration: ""
        }
        controller.requestBatchList(cmdData1, productName, "", productDetail.itemsPerPage, productDetail.currentPage)
    }

    function updatePageFlags(batchListSize) {
        isLeft = currentPage > 0
        isRight = batchListSize >= itemsPerPage  // bạn nên định nghĩa `itemsPerPage`
    }

    Connections {
        target: controller
        function onProductListReady(list, cmd) {
            if(cmd.mode === "SINGLE"){
                console.log(list.length)
                productDetail.products = list
                productDetail.updateName = list[0].productName
                productDetail.updatecost = list[0].cost
            }
        }
    }

    Connections {
        target: controller
        function onBatchListReady(list, cmd) {
            if(cmd === "LIST"){
                productDetail.batches = list
                productDetail.updatePageFlags(list.length)
            }
        }
    }

    Rectangle{
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: baseInfo
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.9
            height: parent.height * 0.2
            color: "transparent"

            property bool editEnabled: false

            Rectangle{
                width: parent.width*0.3
                height: parent.height*0.4
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: parent.height*0.05
                radius: 10
                color: "white"

                Text {
                    width: parent.width*0.3
                    height: parent.height
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    text: "Tên :"
                    font.pixelSize: parent.height*0.4
                }

                TextField {
                    id: nameField
                    width: parent.width*0.7
                    height: parent.height
                    anchors.right: parent.right
                    text: productDetail.updateName
                    readOnly: !baseInfo.editEnabled
                    color: "black"
                    font.pixelSize: parent.height*0.4
                }

            }

            Rectangle{
                width: parent.width*0.3
                height: parent.height*0.4
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height*0.05
                radius: 10
                color: "white"

                Text {
                    width: parent.width*0.3
                    height: parent.height
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    text: "Giá :"
                    font.pixelSize: parent.height*0.4
                }

                TextField {
                    id: costField
                    width: parent.width*0.7
                    height: parent.height
                    anchors.right: parent.right
                    text: productDetail.updatecost
                    readOnly: !baseInfo.editEnabled
                    color: "black"
                    font.pixelSize: parent.height*0.4
                }

            }

            Rectangle{

            }

            // 
            Rectangle{
                id: lockUpdateInfo
                width: parent.width*0.15
                height:parent.height*0.4
                anchors.right: parent.right
                anchors.top : parent.top
                anchors.topMargin: parent.height*0.05
                radius: 8
                color: baseInfo.editEnabled ? 
                    (malockUpdateInfo.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1) ) : 
                    (malockUpdateInfo.containsMouse ? Qt.rgba(1, 1, 1, 0.5) : Qt.rgba(1, 1, 1, 0.2))

                Text {
                    anchors.centerIn: parent
                    text: baseInfo.editEnabled ? "Khoá" : "Mở khoá"
                    color: "white" 
                    font.pixelSize: parent.height*0.4

                }

                MouseArea{
                    id:malockUpdateInfo
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        productDetail.updateName = productDetail.products[0].productName
                        productDetail.updatecost = productDetail.products[0].cost
                        nameField.text = productDetail.products[0].productName
                        costField.text = productDetail.products[0].cost
                        baseInfo.editEnabled = !baseInfo.editEnabled
                    }
                }
            }

            Rectangle{
                id: updateInfo
                width: parent.width*0.15
                height:parent.height*0.4
                anchors.right: parent.right
                anchors.bottom : parent.bottom
                anchors.bottomMargin: parent.height*0.05
                radius: 8
                color: baseInfo.editEnabled ? 
                    (maupdateInfo.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1) ) : 
                    Qt.rgba(1, 1, 1, 0.2)

                Text {
                    anchors.centerIn: parent
                    text: "Cập nhật"
                    color: baseInfo.editEnabled ? "white" : "black"
                    font.pixelSize: parent.height*0.4

                }

                MouseArea{
                    id:maupdateInfo
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        if(baseInfo.editEnabled){
                            baseInfo.editEnabled = !baseInfo.editEnabled
                        }else{
                             rootWindow.notification.showNotification("⚠️ Nhấn mở khoá để cập nhật !!!");
                        }
                    }
                }
            }
        }

        Rectangle{
            id: batchInfo
            anchors.top: baseInfo.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.9
            height: parent.height*0.75
            // liệt kê các lô sản phẩm 
            color: "transparent"
            clip: true

            ListView {
                id: batchListView
                anchors.fill: parent
                spacing: 10
                model: batches
 
                delegate: Rectangle{
                    width: batchInfo.width
                    height: batchInfo.height*0.18
                    color: Qt.rgba(1, 1, 1, 0.3)
                    radius: 8
                    Rectangle {
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.01
                        width: parent.width*0.15
                        height: parent.height
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Số lượng: " + modelData.quantity
                            color: "white"
                            font.pixelSize: 20
                        }

                    }
                    

                    Rectangle {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.20
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "| Giá 1 sản phẩm: " + Number(modelData.cost).toLocaleString(Qt.locale(), 'f', 0) + " VND"
                            color: "white"
                            font.pixelSize: 18
                        }
                    }
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.20
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "| Giá lô hàng: " + Number(modelData.cost * modelData.quantity).toLocaleString(Qt.locale(), 'f', 0) + " VND"
                            color: "white"
                            font.pixelSize: 18
                        }
                    }
                    

                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: parent.width*0.5
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "| Ngày nhập hàng: " + Qt.formatDate(new Date(modelData.importdate), "dd-MM-yyyy")
                            color: "white"
                            font.pixelSize: 18
                        }
                    }
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.5
                        width: parent.width*0.3
                        height: parent.height*0.5
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "| Ngày hết hạn: " + Qt.formatDate(new Date(modelData.expireddate), "dd-MM-yyyy")
                            color: "white"
                            font.pixelSize: 18
                        }
                    }
                }
            }
        }

        Rectangle{
            id: pageController
            anchors.top: batchInfo.bottom
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
                enabled: productDetail.isLeft
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
                        productDetail.currentPage--
                        let cmdData = {
                            cmd: "LIST",
                            typelist: "",
                            duration: ""
                        }
                        controller.requestBatchList(cmdData, productName, "", productDetail.itemsPerPage, productDetail.currentPage)
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
                    text: productDetail.currentPage
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

                enabled: productDetail.isRight
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
                        productDetail.currentPage++
                        let cmdData = {
                            cmd: "LIST",
                            typelist: "",
                            duration: ""
                        }
                        controller.requestBatchList(cmdData, productName, "", productDetail.itemsPerPage, productDetail.currentPage)

                    }

                }
            }

        }
    }

}
