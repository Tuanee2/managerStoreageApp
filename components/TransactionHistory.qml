import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Effects

Item {

    anchors.fill: parent
    id: rootTransactionHistory

    property var orders: []
    property var customFilter: ({})
    property int currentPage: 0
    property real heightOrder: Math.min(80, rootTransactionHistory.height*0.1)
    property int numOfPage: rootTransactionHistory.height*0.7/rootTransactionHistory.heightOrder
    property bool isLeft: false
    property bool isRight: false
    property string command: "LIST"
    property string dateBegin: ""
    property string dateEnd: ""
    property bool orderExist: true
    property string sortOrder: "DESCENDING"
    property string sortField: "EXPORTDATE"
    property string modeQuery: "ALL"
    property string textMode: "Tất cả"
    property string customerPhoneNumber: ""


    Component.onCompleted: {
        console.log(rootTransactionHistory.numOfPage)
        let cmdData = {
            command: "GET",
            target: "ORDER",
            infoKind: "OBJECT",
            mode: "MULTIPLE",
            getType: "LIST",
            sortField: rootTransactionHistory.sortField,
            sortOrder: rootTransactionHistory.sortOrder,
            page: rootTransactionHistory.currentPage,
            pageSize: rootTransactionHistory.numOfPage
        }
        controller.requestOrderList(cmdData)
    }

    Connections {
        target: controller
        function onOrderListReady(list, cmd){
            if(cmd.getType === "LIST"){
                orders = list;
                updatePageFlags(list.length)
                orderExist = (list.length > 0)
            }
        }
    }

    function updatePageFlags(orderListSize) {
        rootTransactionHistory.isLeft = rootTransactionHistory.currentPage > 0
        rootTransactionHistory.isRight = orderListSize >= rootTransactionHistory.numOfPage
    }

    Rectangle {
        anchors.fill:parent
        color: "transparent"

        Rectangle{
            id: historyController
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.96
            height: parent.height*0.12
            radius: 10
            color: "white"
            border.width: 1
            border.color: Qt.rgba(0, 0, 0, 0.2)

            Rectangle{
                id: typeQuerry
                width: parent.width*0.1
                height: parent.height*0.7
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.01
                anchors.verticalCenter: parent.verticalCenter
                radius: 10
                border.width: 1
                border.color: ma4typeQuerry.containsMouse ? "#80bfff" : Qt.rgba(0, 0, 0, 0.2)
                color: ma4typeQuerry.containsMouse ?  "#e6f0ff" : "transparent"

                Text{
                    anchors.centerIn: parent
                    text: rootTransactionHistory.textMode
                    font.pixelSize: parent.height*0.3

                }

                MouseArea {
                    id: ma4typeQuerry
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        menuTypeQuerry.open()
                    }

                }

                Menu {
                    id: menuTypeQuerry
                    y: typeQuerry.height

                    MenuItem {
                        text: "Tất cả"
                        onTriggered: {
                            rootTransactionHistory.modeQuery = "ALL"
                            rootTransactionHistory.textMode = "Tất cả"
                            daybegin.text = ""
                            dayfinish.text = ""
                            customerInfo.text = ""
                        }
                    }
                    MenuItem {
                        text: "Tuỳ chỉnh"
                        onTriggered: {
                            rootTransactionHistory.modeQuery = "CUSTOM"
                            rootTransactionHistory.textMode = "Tuỳ chỉnh"
                        }
                    }

                }

            }

            CustomSearchTextField{
                id: customerInfo
                width: parent.width*0.25
                height: parent.height*0.7
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: typeQuerry.right
                anchors.leftMargin: parent.width*0.01
                enabled: (rootTransactionHistory.modeQuery === "CUSTOM")
                color: Qt.rgba( 1, 1, 1, 0.5)
                placeholderText: "Nhập số điện thoại"
                //text: rootWindow.customerName
                color4placeholder: "black"
                onSuggestionSelected: (data) => {
                    rootTransactionHistory.customerPhoneNumber = data.phoneNumber
                }
                target: "CUSTOMER"
                targetExtension: "PHONENUMBER"
            }


            TextField {
                id: daybegin
                width: parent.width*0.2
                height: parent.height*0.7
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: customerInfo.right
                anchors.leftMargin: parent.width*0.01
                enabled: (rootTransactionHistory.modeQuery === "CUSTOM")
                placeholderText: "Từ ngày"
                font.pixelSize: parent.height*0.3
                inputMask: "00-00-0000;_"
                background: Rectangle {
                    color: "transparent"
                    radius: 4
                    border.width: 1
                    border.color: (rootTransactionHistory.modeQuery === "CUSTOM") ? "#80bfff" : Qt.rgba(0, 0, 0, 0.2)
                }
            }

            TextField {
                id: dayfinish
                width: parent.width*0.2
                height: parent.height*0.7
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: daybegin.right
                anchors.leftMargin: parent.width*0.01
                enabled: (rootTransactionHistory.modeQuery === "CUSTOM")
                placeholderText: "Đến ngày"
                font.pixelSize: parent.height*0.3
                inputMask: "00-00-0000;_"
                background: Rectangle {
                    color: "transparent"
                    radius: 4
                    border.width: 1
                    border.color: (rootTransactionHistory.modeQuery === "CUSTOM") ? "#80bfff" : Qt.rgba(0, 0, 0, 0.2)
                }
            }

            Rectangle {
                id: queryButton
                width: parent.width*0.18
                height:parent.height*0.7
                radius:10
                anchors.right: parent.right
                anchors.rightMargin: parent.width*0.01
                anchors.verticalCenter: parent.verticalCenter
                border.width: 1
                border.color: ma4queryButton.containsMouse ? "#80bfff" : Qt.rgba(0, 0, 0, 0.2)
                color: ma4queryButton.containsMouse ?  "#e6f0ff" : "transparent"

                Text{
                    anchors.centerIn: parent
                    text: "Truy vấn"
                    font.pixelSize: parent.height*0.3
                }

                MouseArea {
                    id: ma4queryButton
                    anchors.fill:parent
                    hoverEnabled: true
                    onClicked: {
                        let cmdData
                        if(rootTransactionHistory.modeQuery === "CUSTOM"){
                            let daybegintext = daybegin.text.trim();
                            console.log(daybegintext)
                            let dayfinishtext = dayfinish.text.trim();
                            let phoneNumber = rootTransactionHistory.customerPhoneNumber.trim();

                            let filters = {};
                            if (/^\d{2}-\d{2}-\d{4}$/.test(daybegintext)) {
                                filters.daybegin = daybegintext;
                            }
                            if (/^\d{2}-\d{2}-\d{4}$/.test(dayfinishtext)) {
                                filters.dayend = dayfinishtext;
                            }
                            if (phoneNumber.length > 0) {
                                filters.phonenumber = phoneNumber;
                            }

                            if (filters.daybegin && filters.dayend) {
                                let partsbegin = filters.daybegin.split("-");
                                let partsfinish = filters.dayend.split("-");
                                let datebegin = new Date(partsbegin[2], partsbegin[1] - 1, partsbegin[0]);
                                let datefinish = new Date(partsfinish[2], partsfinish[1] - 1, partsfinish[0]);
                                if (datebegin > datefinish) {
                                    rootWindow.notification.showNotification("⚠️ ngày bắt đầu phải trước ngày kết thúc");
                                    return;
                                }
                            }

                            rootTransactionHistory.customFilter = filters

                            cmdData = {
                                command: "GET",
                                target: "ORDER",
                                infoKind: "OBJECT",
                                mode: "MULTIPLE",
                                getType: "LIST",
                                sortField: rootTransactionHistory.sortField,
                                sortOrder: rootTransactionHistory.sortOrder,
                                filters: filters,
                                page: rootTransactionHistory.currentPage,
                                pageSize: rootTransactionHistory.numOfPage
                            }
                        }else{
                            cmdData = {
                                command: "GET",
                                target: "ORDER",
                                infoKind: "OBJECT",
                                mode: "MULTIPLE",
                                getType: "LIST",
                                sortField: rootTransactionHistory.sortField,
                                sortOrder: rootTransactionHistory.sortOrder,
                                page: rootTransactionHistory.currentPage,
                                pageSize: rootTransactionHistory.numOfPage
                            }
                        }
                        console.log(transactionList.height*0.15)
                        controller.requestOrderList(cmdData)
                    }
                }
            }
        }

        Rectangle{

        }

        Rectangle{
            id: transactionList
            anchors.top: historyController.bottom
            anchors.topMargin: parent.height*0.01
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.96
            height: parent.height*0.7
            color: "transparent"

            Text {
                visible: !rootTransactionHistory.orderExist
                anchors.centerIn: parent
                text: "Không tồn tại đơn hàng nào"
                font.pixelSize: parent.height*0.15
                color: "white"
            }

            Column{
                id: orderList
                anchors.fill: parent
                visible: rootTransactionHistory.orderExist
                spacing: transactionList.height*0.01
                Repeater {
                    model: rootTransactionHistory.orders

                    delegate: Rectangle{
                        width: transactionList.width
                        height: rootTransactionHistory.heightOrder
                        radius: 10
                        color: (modelData.debt === "NO_DEBT") ? "#e6f0ff" : Qt.rgba(255/255, 100/255, 100/255, 0.25)
                        border.width: 1
                        border.color: Qt.rgba(0, 0, 0, 0.2)

                        Button{
                            id: iconName
                            anchors.left: parent.left
                            height: parent.height
                            width: parent.height
                            background: Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                            }
                            icon.source: "qrc:/images/Icon/id-card.svg"
                            icon.color: "#007bff"
                        }

                        Rectangle{
                            id: cusName
                            anchors.left: iconName.right
                            height: parent.height
                            width: parent.width*0.3
                            radius: 10
                            color: "transparent"

                            Text{
                                anchors.left: parent.left
                                //anchors.leftMargin: transactionList.width*0.01
                                anchors.verticalCenter: parent.verticalCenter
                                text: (modelData.customer_name === "") ? "Vô danh" : modelData.customer_name
                                color: "#003366"
                                font.pixelSize: parent.height*0.3
                            }
                        }

                        Button{
                            id: iconPhonenumber
                            anchors.left: cusName.right
                            height: parent.height
                            width: parent.height
                            background: Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                            }
                            icon.source: "qrc:/images/Icon/phone-rotary.svg"
                            icon.color: "#007bff"
                        }

                        Rectangle{
                            id: cusPhonenumber
                            anchors.left: iconPhonenumber.right
                            height: parent.height
                            width: parent.width*0.2
                            radius: 10
                            visible: !(modelData.customer_name === "")
                            color: "transparent"

                            Text{
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                text: modelData.phone_number
                                color: "#003366"
                                font.pixelSize: parent.height*0.3
                            }
                        }

                        Button{
                            id: iconPurchaseTime
                            anchors.left: cusPhonenumber.right
                            height: parent.height
                            width: parent.height
                            background: Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                            }
                            icon.source: "qrc:/images/Icon/calendar-lines-pen.svg"
                            icon.color: "#007bff"
                        }

                        Rectangle{
                            anchors.left: iconPurchaseTime.right
                            height: parent.height
                            width: parent.width*0.2
                            radius: 10
                            color: "transparent"

                            Text{
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                text: Qt.formatDate(new Date(modelData.purchase_time), "dd-MM-yyyy")
                                color: "#003366"
                                font.pixelSize: parent.height*0.3
                            }
                        }

                        Rectangle{
                            id: orderDetail
                            width: parent.height
                            height: parent.height
                            anchors.right: parent.right
                            anchors.rightMargin: parent.height
                            radius: 10
                            color: maorderDetail.containsMouse ? Qt.rgba(200/255, 180/255, 80/255, 0.4) : "transparent"

                            Button{
                                anchors.fill:parent
                                background: Rectangle{
                                    color: "transparent"
                                }

                                icon.source: "qrc:/images/Icon/file-circle-info.svg"
                                icon.color: maorderDetail.containsMouse ? Qt.rgba(240/255, 200/255, 100/255, 1) : "white"
                            }

                            MouseArea{
                                id: maorderDetail
                                anchors.fill: parent
                                hoverEnabled:true

                                onClicked: {
                                    pageLoader.setSource("OrderForm.qml", {
                                        orderId: modelData.id
                                    })
                                }

                            }
                        }

                        Rectangle{
                            id: orderDelete
                            width: parent.height
                            height: parent.height
                            anchors.right: parent.right
                            radius: 10
                            color: maorderDelete.containsMouse ? Qt.rgba(200/255, 20/255, 20/255, 0.2) : "transparent"

                            Button{
                                anchors.fill:parent
                                background: Rectangle{
                                    color: "transparent"
                                }

                                icon.source: "qrc:/images/Icon/cross-circle.svg"
                                icon.color: maorderDelete.containsMouse ? Qt.rgba(250/255, 20/255, 20/255, 0.5) : "white"
                            }

                            MouseArea{
                                id: maorderDelete
                                anchors.fill: parent
                                hoverEnabled:true
                                onClicked: {

                                }

                            }
                        }
                    }
                }
            }
            
        }

        Rectangle{
            id: pageController
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.02
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
                enabled: rootTransactionHistory.isLeft
                background: Rectangle{
                    anchors.fill: parent
                    radius: 8
                    //color: "transparent"
                    color: rootTransactionHistory.isLeft  ? "#80bfff" : "transparent"
                }
                Text {
                    text: "<"
                    color: "white"
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        rootTransactionHistory.currentPage--
                        let cmdData = {
                            command: "GET",
                            target: "ORDER",
                            infoKind: "OBJECT",
                            mode: "MULTIPLE",
                            getType: "LIST",
                            sortField: rootTransactionHistory.sortField,
                            sortOrder: rootTransactionHistory.sortOrder,
                            filters: (rootTransactionHistory.modeQuery === "CUSTOM") ? rootTransactionHistory.customFilter : undefined,
                            page: rootTransactionHistory.currentPage,
                            pageSize: rootTransactionHistory.numOfPage
                        }
                        controller.requestOrderList(cmdData)
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
                    text: rootTransactionHistory.currentPage
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

                enabled: rootTransactionHistory.isRight
                background: Rectangle{

                    anchors.fill: parent
                    radius: 8
                    color: rootTransactionHistory.isRight  ? "#80bfff" : "transparent"
                }

                Text {
                    text: ">"
                    color: "white"
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        rootTransactionHistory.currentPage++
                        let cmdData = {
                            command: "GET",
                            target: "ORDER",
                            infoKind: "OBJECT",
                            mode: "MULTIPLE",
                            getType: "LIST",
                            sortField: rootTransactionHistory.sortField,
                            sortOrder: rootTransactionHistory.sortOrder,
                            filters: (rootTransactionHistory.modeQuery === "CUSTOM") ? rootTransactionHistory.customFilter : undefined,
                            page: rootTransactionHistory.currentPage,
                            pageSize: rootTransactionHistory.numOfPage
                        }
                        controller.requestOrderList(cmdData)
                    }
                }
            }

        }
    }

}
