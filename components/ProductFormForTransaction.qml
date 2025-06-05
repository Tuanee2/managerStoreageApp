import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Item {
    id: batchlist4trans
    property string productName: ""
    property int costOfProduct: 0

    property var batches: []
    property var batchesSelected: []
    property var selectedQuantitiesMap: ({})

    property int currentPage: 0
    property int itemsPerPage: 6
    property bool isLeft: false
    property bool isRight: false

    property int total: 0

    Component.onCompleted: {
        let cmdData = {
            cmd: "LIST",
            typelist: "",
            duration: ""
        }
        controller.requestBatchList(cmdData, batchlist4trans.productName, "", batchlist4trans.itemsPerPage, batchlist4trans.currentPage)
        rootWindow.isTransactionProductSelect = false
        rootWindow.isTransactionBatchSelect = true
    }

    function updatePageFlags(batchListSize) {
        isLeft = currentPage > 0
        isRight = batchListSize >= itemsPerPage  // bạn nên định nghĩa `itemsPerPage`
    }

    function updateTotal() {
        var sum = 0;
        for (var key in selectedQuantitiesMap) {
            sum += selectedQuantitiesMap[key];
        }
        total = sum;
    }

    Connections {
        target: controller
        function onBatchListReady(list, cmd) {
            if(cmd === "LIST"){
                batchlist4trans.batches = list
                batchlist4trans.updatePageFlags(list.length)
            }
        }
    }

    Connections {
        target: controller 
        function onRequestCommandBatchToOrderResult_UI(result, cmd){
            if(cmd === "ADD"){
                if(result){
                    rootWindow.isTransactionProductSelect = false
                    rootWindow.isTransactionBatchSelect = false
                    pageLoader.source = "components/CreateTransaction.qml"
                }
            }
        }
    }


    Rectangle{
        anchors.fill: parent
        color: "transparent"

        Rectangle{
            id: buttonControl
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.9
            height: parent.height*0.1
            color: "transparent"

            Rectangle{
                width: parent.width*0.3
                height: parent.height *0.8
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                radius: 6
                color: "white" 
                Text {
                    anchors.fill: parent
                    text: "Số lượng:" + batchlist4trans.total
                    color: "black"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle{
                id: confirmButton
                width: parent.width * 0.3
                height: parent.height * 0.8
                anchors.right: parent.right
                anchors.rightMargin: parent.width*0.35
                anchors.verticalCenter: parent.verticalCenter
                radius: 10
                color: maconfirmButton.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)

                Text {
                    anchors.fill: parent
                    text: "Xác nhận lựa chọn"
                    font.pixelSize: parent.height*0.3
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    id: maconfirmButton
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        confirmToAcceptAllQuantitiesChoice.open()
                    }
                }

            }

            Rectangle {
                id: clearAllchoices
                width: parent.width * 0.3
                height: parent.height * 0.8
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                radius: 10
                color: maclearAllchoices.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)

                Text {
                    anchors.fill: parent
                    text: "Xoá toàn bộ các lựa chọn"
                    font.pixelSize: parent.height*0.3
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    id: maclearAllchoices
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        confirmToDeleteAllQuantitiesChoice.open()
                    }
                }

            }

        }

        Rectangle{
            id: batchInfo
            anchors.top: buttonControl.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.9
            height: parent.height*0.85
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
                    
                    SpinBox {
                        from: 0
                        to: modelData.quantity
                        stepSize: 10
                        value: selectedQuantitiesMap[modelData.importdate + "_" + modelData.expireddate] !== undefined
                               ? selectedQuantitiesMap[modelData.importdate + "_" + modelData.expireddate]
                               : 0
                        editable: true
                        width: parent.width*0.3
                        height: parent.height 
                        anchors.left: parent.left
                        anchors.top: parent.top
                        font.pixelSize: parent.height*0.3

                        onValueChanged: {
                            const key = modelData.importdate + "_" + modelData.expireddate;
                            batchlist4trans.selectedQuantitiesMap[key] = value;
                            batchlist4trans.updateTotal();
                        }
                    }


                    Rectangle {
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.3
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
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.6
                        width: parent.width*0.3
                        height: parent.height
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "| Ngày hết hạn: " + Qt.formatDate(new Date(modelData.expireddate), "dd-MM-yyyy")
                            color: "white"
                            font.pixelSize: 18
                        }
                    }
                }

                ScrollBar.vertical: ScrollBar {
                    active: true
                    policy: ScrollBar.AsNeeded
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
                enabled: batchlist4trans.isLeft
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
                        batchlist4trans.currentPage--
                        let cmdData = {
                            cmd: "LIST",
                            typelist: "",
                            duration: ""
                        }
                        controller.requestBatchList(cmdData, batchlist4trans.productName, "", batchlist4trans.itemsPerPage, batchlist4trans.currentPage)
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
                    text: batchlist4trans.currentPage
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

                enabled: batchlist4trans.isRight
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
                        batchlist4trans.currentPage++
                        let cmdData = {
                            cmd: "LIST",
                            typelist: "",
                            duration: ""
                        }
                        controller.requestBatchList(cmdData, batchlist4trans.productName, "", batchlist4trans.itemsPerPage, batchlist4trans.currentPage)

                    }

                }
            }

        }
    }

    Dialog {
        id: confirmToDeleteAllQuantitiesChoice
        title: "Bạn muốn xoá toàn bộ lựa chọn đúng ko?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: parent
        visible: false
        onAccepted: {
            selectedQuantitiesMap = {};
            batchlist4trans.updateTotal();
        }
    }

    Dialog {
        id: confirmToAcceptAllQuantitiesChoice
        title: "Bạn chắc chắn xác nhận lựa chọn đúng ko?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: parent
        visible: false
        onAccepted: {
            
            var batchlist = []
            for (var key in selectedQuantitiesMap) {
                var quan = selectedQuantitiesMap[key];
                if (quan > 0) {
                    // Tách lại importdate và expireddate từ key
                    var parts = key.split("_");
                    var importdate = parts[0];
                    var expireddate = parts[1];

                    // Tìm batch tương ứng để lấy cost
                    var cost = 0;
                    for (var j = 0; j < batches.length; j++) {
                        var b = batches[j];
                        if (b.importdate === importdate && b.expireddate === expireddate) {
                            cost = b.cost;
                            break;
                        }
                    }

                    batchlist.push({
                        "quantity": quan,
                        "cost": cost,
                        "importdate": Qt.formatDate(new Date(importdate), "dd-MM-yyyy"),
                        "expireddate": Qt.formatDate(new Date(expireddate), "dd-MM-yyyy")
                    })
                }
            }
            controller.requestCommandBatchToOrder_UI("ADD", batchlist4trans.productName, batchlist4trans.costOfProduct, batchlist)
            
        }
    }

}
