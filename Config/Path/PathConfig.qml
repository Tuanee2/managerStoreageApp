pragma Singleton
import QtQuick 2.15

QtObject {
    property var drawer : QtObject{
        property var icon : QtObject{
            property string dashboard: "qrc:/images/Icon/cuida--clipboard-text-outline.svg" 
            property string product: "qrc:/images/Icon/cuida--package-outline.svg"
            property string customer: "qrc:/images/Icon/users01.svg"
            property string revenue: "qrc:/images/Icon/coins.svg"
            property string transactionHistory: "qrc:/images/Icon/cuida--chart-column-outline.svg"
            property string setting: "qrc:/images/Icon/settings01.svg"
            property string quit: "qrc:/images/Icon/leave.svg"
        }

        property var type : QtObject{
            property string main: "components/MainDrawer.qml"
            property string product: "components/ProductDrawer.qml"
            property string customer: "components/CustomerDrawer.qml"
        }
    }

    property var page : QtObject {
        property string dashboard: "components/Dashboard.qml"
        property string productList: "components/ProductList.qml"
        property string customerList: "components/CustomerList.qml"
        property string revenue: "components/Sales.qml"
        property string transactionHistory: "components/TransactionHistory.qml"
        property string setting: "components/Setting.qml"


    
    }

    
}
