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
    property var recentOrder: []

    Component.onCompleted: {

        let cmdData = {
            command: "GET",
            target: "PRODUCT",
            infoKind: "GENERAL",
            filters: {
                numofproduct: ""
            }

        }
        controller.requestProductList(cmdData);

        let today = new Date();
        let sevenDaysAgo = new Date();
        sevenDaysAgo.setDate(today.getDate() - 7);

        let dateBegin = Qt.formatDate(sevenDaysAgo, "dd-MM-yyyy");
        let dateEnd = Qt.formatDate(today, "dd-MM-yyyy");

        let cmdData1 = {
            command: "GET",
            target: "ORDER",
            infoKind: "FIELD",
            mode: "MULTIPLE",
            getType: "LIST",
            filters: {
                profit: "",
                revenue: "",
                daybegin: dateBegin,
                dayend: dateEnd
            }
        }

        controller.requestOrderList(cmdData1);

        let cmdData2 = {
            command: "GET",
            target: "ORDER",
            infoKind: "OBJECT",
            mode: "MULTIPLE",
            getType: "LIST",
            sortField: "EXPORTDATE",
            sortOrder: "DESCENDING",
            page: 0,
            pageSize: 3
        }

        controller.requestOrderList(cmdData2);
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

    Connections {
        target: controller
        function onProductListReady(result, cmd){
            rootDashboard.numOfTypeProduct = result
        }
    }

    Connections {
        target: controller
        function onOrderListReady(list, cmd){
            if(cmd.getType === "LIST"){
                if(cmd.infoKind === "FIELD"){
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
                }else if(cmd.infoKind === "OBJECT"){
                    rootDashboard.recentOrder = list
                }
            }
        }
    }

    function formatNumberWithCommas(n) {
        return Number(n).toLocaleString("en-US", {minimumFractionDigits: 0});
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
                    spacing: mainorderlist.height*0.02
                    Repeater {
                        model: rootDashboard.recentOrder 

                        delegate: Rectangle {
                            width: mainorderlist.width
                            height: mainorderlist.height*0.32
                            color: "white"
                            radius: 10
                            Rectangle{
                                anchors.left: parent.left
                                anchors.top: parent.top
                                width: parent.width
                                height: parent.height*0.5
                                color: "transparent"
                                Text {
                                    anchors.left: parent.left
                                    anchors.leftMargin: parent.width*0.05
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: modelData.customer_name
                                    font.pixelSize: parent.height*0.4
                                }
                            }

                            Rectangle{
                                anchors.left: parent.left
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: parent.height*0.5
                                color: "transparent"
                                Text {
                                    anchors.left: parent.left
                                    anchors.leftMargin: parent.width*0.05
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: rootDashboard.formatMoney(modelData.total_price) + "VNĐ"
                                    font.pixelSize: parent.height*0.4
                                }
                                
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    pageLoader.setSource("OrderForm.qml", {
                                        orderId: modelData.id
                                    })
                                }
                            }

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
                    return maxVal === 0 ? 1 : maxVal ;
                }

                ValueAxis {
                    id: axisY
                    min: 0
                    max: chartView.maxY
                    labelFormat: "%'d"
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
