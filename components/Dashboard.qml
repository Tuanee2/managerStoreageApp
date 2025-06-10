import QtQuick 2.15
import QtQuick.Effects
import QtQuick.Controls
import QtCharts

Item {
    id: rootDashboard
    anchors.fill: parent

    property int numOfTypeProduct: 0
    property var orderlistdb: []

    Component.onCompleted: {
        let cmdPro = {
            type: "NUMOFITEM"
        }
        controller.requestProductParam(cmdPro, "");

        let cmdorder = {
            cmd: "LIST",
            typelist: "",
            order: "DESCENDING",
            typeorder: "TOPURCHASETIME"
        }
        controller.requestOrderList(cmdorder, "", "", "", 3, 0);

    }

    Connections {
        target: controller
        function onProductParamResult(result, cmd){
            rootDashboard.numOfTypeProduct = result
        }
    }

    Connections {
        target: controller
        function onOrderListReady(list, cmd){
            if(cmd === "LIST"){
                console.log("im here")
                rootDashboard.orderlistdb = list
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Rectangle {
            id: infoOfLastestOrder
            width: parent.width*0.425
            height: parent.height*0.4
            anchors.top : parent.top
            anchors.topMargin: parent.height*0.05
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.05
            color: Qt.rgba(0, 0, 0, 0.4)
            radius: 10

            Rectangle {
                id : mainorderlist
                width: parent.width*0.94
                height: parent.height*0.94
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"

                Column {
                    anchors.fill: parent
                    spacing: mainorderlist.height*0.03
                    Repeater {
                        model: rootDashboard.orderlistdb

                        delegate: Rectangle {
                            width: mainorderlist.width
                            height: mainorderlist.height*0.3
                            color: "white"
                            radius: 10

                        }
                    }
                }
            }
        }

        Rectangle {
            //id: infoOfStorage
            width: parent.width*0.425
            height: parent.height*0.4
            anchors.top : parent.top
            anchors.topMargin: parent.height*0.05
            anchors.right: parent.right
            anchors.rightMargin: parent.width*0.05
            color: Qt.rgba(0, 0, 0, 0.4)
            radius: 10

            ChartView {
                //title: "Bar Chart"
                anchors.fill: parent
                legend.alignment: Qt.AlignBottom
                antialiasing: true

                BarSeries {
                    id: mySeries
                    axisX: BarCategoryAxis { categories: ["Hôm nay", "Hôm qua", "Hôm kia"] }
                    BarSet { label: "Doanh thu"; values: [5, 7, 4] }
                    BarSet { label: "Lợi nhuận"; values: [4, 5, 1] }
                }
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    rootWindow.currentNavigation = "Doanh thu"
                    pageLoader.source = "components/Sales.qml"
                }
            }
        }

        Rectangle {
            //id: infoOfStorage
            width: parent.width*0.425
            height: parent.height*0.4
            anchors.bottom : parent.bottom
            anchors.bottomMargin: parent.height*0.05
            anchors.right: parent.right
            anchors.rightMargin: parent.width*0.05
            color: Qt.rgba(0, 0, 0, 0.4)
            radius: 10

            Text{
                anchors.centerIn: parent
                text: rootDashboard.numOfTypeProduct + " loại sản phẩm"
                color: "white"
                font.pixelSize: parent.height*0.15
            }
        }

        Rectangle {
            id: infoOfStorage
            width: parent.width*0.425
            height: parent.height*0.4
            anchors.bottom : parent.bottom
            anchors.bottomMargin: parent.height*0.05
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.05
            color: Qt.rgba(0, 0, 0, 0.4)
            radius: 10

            ChartView {
                id: chart
                anchors.fill: parent
                legend.alignment: Qt.AlignBottom
                antialiasing: true

                property variant othersSlice: 0

                PieSeries {
                    id: pieSeries
                    PieSlice { label: "Phân Lân"; value: 13.5 }
                    PieSlice { label: "Phân kali"; value: 10.9 }
                    PieSlice { label: "Thuốc trừ sâu"; value: 8.6 }
                    PieSlice { label: "Cám gà"; value: 8.2 }
                    PieSlice { label: "Thuốc cỏ"; value: 6.8 }
                }
            }
        }
    }
}
