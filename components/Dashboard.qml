import QtQuick 2.15
import QtQuick.Effects
import QtQuick.Controls
import QtCharts

Item {
    id: rootDashboard
    anchors.fill: parent

    property int numOfTypeProduct: 0
    property var orderlistdb: []
    property var profitAndRevenue: []

    Component.onCompleted: {
        let cmdPro = {
            type: "NUMOFITEM"
        }
        controller.requestProductParam(cmdPro, "");

        let cmdorder = {
            cmd: "LIST",
            typelist: "ORDER_PROFIT_REVENUE",
            order: "DESCENDING",
            typeorder: "",
            durian: "ADAY"
        }
        let today = new Date();
        let sevenDaysAgo = new Date();
        sevenDaysAgo.setDate(today.getDate() - 7);

        let dateBegin = Qt.formatDate(sevenDaysAgo, "dd-MM-yyyy");
        let dateEnd = Qt.formatDate(today, "dd-MM-yyyy");

        controller.requestOrderList(cmdorder, "", dateBegin, dateEnd, 0, 0);

        let cmdorder01 = {
            cmd: "LIST",
            typelist: "",
            order: "DESCENDING",
            typeorder: "",
            durian: "ADAY"
        }

        //controller.requestOrderList(cmdorder01, "", "", "", 3, 0);

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
                let today = new Date();
                let fullList = [];
                for (let i = 6; i >= 0; --i) {
                    let d = new Date();
                    d.setDate(today.getDate() - i);
                    let key = Qt.formatDate(d, "dd-MM-yyyy");

                    let found = list.find(item => item.date === key);
                    if (found) {
                        fullList.push(found);
                    } else {
                        fullList.push({
                            date: key,
                            total_price: 0,
                            profit: 0
                        });
                    }
                }
                rootDashboard.profitAndRevenue = fullList;
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Rectangle {
            id: infoOfLastestOrder
            width: parent.width*0.325
            height: parent.height*0.45
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
                clip: true

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
            width: parent.width*0.525
            height: parent.height*0.45
            anchors.top : parent.top
            anchors.topMargin: parent.height*0.05
            anchors.right: parent.right
            anchors.rightMargin: parent.width*0.05
            color: Qt.rgba(0, 0, 0, 0.4)
            radius: 10

            ChartView {
                id: chartView
                anchors.fill: parent
                legend.alignment: Qt.AlignBottom
                antialiasing: true

                property var dateLabels: rootDashboard.profitAndRevenue.map(item => item.date)
                property var revenueValues: rootDashboard.profitAndRevenue.map(item => item.total_price)
                property var profitValues: rootDashboard.profitAndRevenue.map(item => item.profit)
                property real maxY: {
                    let allValues = revenueValues.concat(profitValues);
                    let maxVal = Math.max(...allValues);
                    return maxVal === 0 ? 1 : maxVal * 1.2;
                }

                ValueAxis {
                    id: axisY
                    min: 0
                    max: chartView.maxY
                }

                BarCategoryAxis {
                    id: axisX
                    categories: chartView.dateLabels
                }

                BarSeries {
                    axisX: axisX
                    axisY: axisY

                    BarSet {
                        label: "Doanh thu"
                        values: chartView.revenueValues
                    }

                    BarSet {
                        label: "Lợi nhuận"
                        values: chartView.profitValues
                    }
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
            width: parent.width*0.325
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
            width: parent.width*0.525
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
