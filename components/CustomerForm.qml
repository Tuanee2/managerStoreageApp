import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material

Item {

    id: rootCustomerForm

    property string customerPhoneNumber: ""
    property int orderPerPage: 6
    property int currentPage: 0
    property bool isLeft: false
    property bool isRight: false

    property var orderList: []




    Component.onCompleted: {
        let cmdData = {
            cmd: "LIST",
            typelist: "PHONENUMBER"
        }

        controller.requestOrderList(cmdData, customerPhoneNumber, "", "", rootCustomerForm.orderPerPage, rootCustomerForm.currentPage)
    }

    Connections {
        target: controller
        function onOrderListReady(list, cmd){
            if( cmd === "LIST" ){
                rootCustomerForm.orderList = list
                updatePageFlags(list.length)
            }
        }
    }

    function updatePageFlags(orderListSize) {
        rootCustomerForm.isLeft = rootCustomerForm.currentPage > 0
        rootCustomerForm.isRight = orderListSize >= rootCustomerForm.orderPerPage  // bạn nên định nghĩa `itemsPerPage`
    }

    function formatMoney(n) {
        let str = n.toString();
        let result = "";
        while (str.length > 3) {
            result = "," + str.slice(-3) + result;
            str = str.slice(0, -3);
        }
        result = str + result;
        return result;
    }

    Rectangle {
        id: customerBaseInfo
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.01
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.96
        height:parent.height*0.185
        color: Qt.rgba(1, 1, 1, 0.2)
    }

    Rectangle {
        id: mainCustomerForm
        anchors.top: customerBaseInfo.bottom
        anchors.topMargin: parent.height*0.01
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height*0.69
        width: parent.width*0.96
        color: "transparent"
        Column {
            anchors.fill: parent
            spacing: mainCustomerForm.height*0.01

            Repeater {
                model: rootCustomerForm.orderList

                delegate: Rectangle{
                    //anchors.horizontalCenter: mainCustomerForm.horizontalCenter
                    width: mainCustomerForm.width
                    height: mainCustomerForm.height*0.15
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.5)

                    Rectangle {
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.01
                        width: parent.width*0.25
                        height: parent.height
                        color: "transparent"
                        Text{
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Ngày bán: " + Qt.formatDate(new Date(modelData.purchase_time), "dd-MM-yyyy")
                            font.pixelSize: parent.height*0.3
                            color: "white"
                        }
                    }

                    Rectangle {
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.26
                        width: parent.width*0.25
                        height: parent.height
                        color: "transparent"
                        Text{
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Giá trị đơn hàng: " +  rootCustomerForm.formatMoney(modelData.total_price) + " VNĐ"
                            font.pixelSize: parent.height*0.3
                            color: "white"
                        }
                    }

                    Rectangle {
                        id:buttonDetailOrder
                        anchors.right: parent.right
                        anchors.rightMargin: parent.width*0.01
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.5
                        width: parent.width*0.2
                        radius:10
                        color: mabuttonDetailOrder.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)

                        Text{
                            anchors.centerIn: parent
                            text: "Chi tiết"
                            font.pixelSize: parent.height*0.4
                            color: "white"
                        }

                        MouseArea {
                            id: mabuttonDetailOrder
                            anchors.fill: parent
                            hoverEnabled: true

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
        anchors.top: mainCustomerForm.bottom
        anchors.topMargin: parent.height*0.01
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
            enabled: rootCustomerForm.isLeft
            background: Rectangle{
                anchors.fill: parent
                radius: 8
                //color: "transparent"
                color: !rootCustomerForm.isLeft ? Qt.rgba(1, 1, 1, 0.3) :
                        maback.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)
            }
            Text {
                text: "<"
                color: "white"
                anchors.centerIn: parent
            }

            MouseArea {
                id: maback
                anchors.fill: parent
                onClicked: {
                    rootCustomerForm.currentPage--
                    let cmdData = {
                        cmd: "LIST",
                        typelist: "PHONENUMBER"
                    }

                    controller.requestOrderList(cmdData, customerPhoneNumber, "", "", rootCustomerForm.orderPerPage, rootCustomerForm.currentPage)
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
                text: rootCustomerForm.currentPage
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

            enabled: rootCustomerForm.isRight
            background: Rectangle{

                anchors.fill: parent
                radius: 8
                //color: "transparent"
                color: !rootCustomerForm.isRight ? Qt.rgba(1, 1, 1, 0.3) :
                        manext.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)
            }

            Text {
                text: ">"
                color: "white"
                anchors.centerIn: parent
            }

            MouseArea {
                id: manext
                anchors.fill: parent
                onClicked: {
                    rootCustomerForm.currentPage++
                    let cmdData = {
                        cmd: "LIST",
                        typelist: "PHONENUMBER"
                    }
                    controller.requestOrderList(cmdData, customerPhoneNumber, "", "", rootCustomerForm.orderPerPage, rootCustomerForm.currentPage)
                }

            }
        }

    }

}
