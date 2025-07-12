import QtQuick 2.15
import QtCharts

Item {
    anchors.fill: parent


    Rectangle {
        id: saleController
        width: parent.width
        height: parent.height*0.15
        anchors.left: parent.left
        anchors.top: parent.top
        color: "transparent"
    }

    Rectangle {

        width: parent.width*0.7
        height: parent.height*0.83
        anchors.left: parent.left
        anchors.leftMargin: parent.width*0.01
        anchors.top: saleController.bottom
        anchors.topMargin: parent.height*0.01
        color: "white"
        radius: 10
        // ChartView {
        //     title: "Bar Chart"
        //     anchors.fill: parent
        //     legend.alignment: Qt.AlignBottom
        //     antialiasing: true

        //     BarSeries {
        //         id: mySeries
        //         axisX: BarCategoryAxis { categories: ["2007", "2008", "2009", "2010", "2011", "2012" ] }
        //         BarSet { label: "Bob"; values: [2, 2, 3, 4, 5, 6] }
        //         BarSet { label: "Susan"; values: [5, 1, 2, 4, 1, 7] }
        //         BarSet { label: "James"; values: [3, 5, 8, 13, 5, 8] }
        //     }
        // }
    }

    Rectangle {
        id: saleGeneralInfo
        width: parent.width*0.27
        height: parent.height*0.38
        anchors.right: parent.right
        anchors.rightMargin: parent.width*0.01
        anchors.top: saleController.bottom
        anchors.topMargin: parent.height*0.01
        color: "white"
        radius: 10
        Rectangle{
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height/4
            color: "transparent"
            Text {
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.01
                anchors.verticalCenter: parent.verticalCenter
                text: "Tổng doanh thu: "
                font.pixelSize: parent.height*0.3
            }
        }

        Rectangle{
            anchors.top: parent.top
            anchors.topMargin: parent.height/4
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height/4
            color: "transparent"
            Text {
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.01
                anchors.verticalCenter: parent.verticalCenter
                text: "Tổng lợi nhuận: "
                font.pixelSize: parent.height*0.3
            }
        }

        Rectangle{
            anchors.top: parent.top
            anchors.topMargin: parent.height/2
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height/4
            color: "transparent"
            Text {
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.01
                anchors.verticalCenter: parent.verticalCenter
                text: "Ngày có doanh thu cao nhất: "
                font.pixelSize: parent.height*0.3
            }
        }

        Rectangle{
            anchors.top: parent.top
            anchors.topMargin: parent.height*3/4
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height/4
            color: "transparent"
            Text {
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.01
                anchors.verticalCenter: parent.verticalCenter
                text: "Ngày có lợi nhuận cao nhất: "
                font.pixelSize: parent.height*0.3
            }
        }


    }

    Rectangle {
        width: parent.width*0.27
        height: parent.height*0.44
        anchors.right: parent.right
        anchors.rightMargin: parent.width*0.01
        anchors.top: saleGeneralInfo.bottom
        anchors.topMargin: parent.height*0.01
        color: "white"
        radius: 10
    }

   
}
