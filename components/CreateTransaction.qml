import QtQuick 2.15

Item {
    property string customerName: ""
    property string customerPhoneNumber: ""

    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(1, 1, 1, 0.2)
        CustomerSearchTextField {
            id: productSearch
            width: parent.width*0.5
            height: parent.height*0.1
            color: "transparent"
            placeholderText: "Nhập tên khách hàng"
            onSuggestionSelected: (text) => {
                console.log("Đã chọn khách hàng:", text)
            }
            target: "PRODUCT"
        }
    }
}
