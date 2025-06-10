import QtQuick 2.15
import QtCharts

Item {
    anchors.fill: parent


    Rectangle {
        id: dateController
        width: parent.width
        height: parent.height*0.15
        anchors.left: parent.left
        anchors.top: parent.top
        color: "transparent"
    }

    Rectangle {

        width: parent.width
        height: parent.height*0.85
        anchors.left: parent.left
        anchors.top: dateController.bottom
        color: "transparent"

        ChartView {
            title: "Bar Chart"
            anchors.fill: parent
            legend.alignment: Qt.AlignBottom
            antialiasing: true

            BarSeries {
                id: mySeries
                axisX: BarCategoryAxis { categories: ["2007", "2008", "2009", "2010", "2011", "2012" ] }
                BarSet { label: "Bob"; values: [2, 2, 3, 4, 5, 6] }
                BarSet { label: "Susan"; values: [5, 1, 2, 4, 1, 7] }
                BarSet { label: "James"; values: [3, 5, 8, 13, 5, 8] }
            }
        }
        

    }

   
}
