import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material

Rectangle {
    id: root
    radius: 8
    color: "transparent"
    border.color: "#cccccc"
    //color: "transparent"

    property alias text: input.text
    property alias placeholderText: input.placeholderText
    property alias fontSize: input.font.pixelSize
    property string target: ""

    property bool isClick: false 
    property bool isEnable: false

    signal suggestionSelected(string text)

    ListModel {
        id: suggestionModel
    }

    TextField {
        id: input
        anchors.fill:parent
        font.pixelSize: 16
        onTextChanged: {
            if (text.length > 0 && root.isClick === false) {
                // Giả sử controller xử lý gợi ý theo target
                if(target === "PRODUCT"){
                    controller.requestProductList("SEARCH", text, 0)
        
                }else if(target === "CUSTOMER"){
                    controller.requestCustomerList("SEARCH", text, 0)
                    
                }
            } else {
                suggestionPopup.close()
                isClick = false
            }
        }
    }


    Popup {
        id: suggestionPopup
        width: parent.width
        height: parent.height*3
        y: input.height
        x: 0
        padding: 0

        //anchors.centerIn: parent
        //topMargin: 100
        background: Rectangle { 
            color: "transparent";
            radius: 4 
        }
        closePolicy: Popup.CloseOnPressOutside

        property int rowHeight: input.height
        property int maxHeight: input.height*3
        topMargin: 100

        ListView {
            width: parent.width
            height: Math.min(suggestionPopup.maxHeight, suggestionModel.count * suggestionPopup.rowHeight)
            model: suggestionModel

            delegate: Rectangle {
                width: root.width
                height: suggestionPopup.rowHeight
                border.width: 1
                border.color: "black"
                color: "white"
                radius:4

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.isClick = true;
                        input.text = model.name
                        root.suggestionSelected(model.name)
                        suggestionPopup.close()
                        if(root.target === "PRODUCT"){
                            pageLoader.setSource("ProductForm.qml", {
                                productName: model.name
                            })
                            drawerLoader.source = "components/ProductDrawer.qml"
                        } else {

                        }

                    }

                    Text {
                        visible: root.target === "PRODUCT"
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.1
                        anchors.verticalCenter: parent.verticalCenter
                        text: model.name
                        font.pixelSize: 16
                    }

                    Column {
                        visible: root.target === "CUSTOMER"
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.1
                        anchors.verticalCenter: parent.verticalCenter

                        Text{
                            text: model.name
                        }

                        Text{
                            text: model.phone
                        }
                    }
                }
            }
        }
    }

    Connections {
        target: controller
        function onCustomerListReady(list, cmd) {
            if (cmd === "SEARCH" && input.focus) {
                suggestionModel.clear()
                for (let i = 0; i < list.length; ++i) {
                    suggestionModel.append({
                        name: list[i]["name"],
                        phone: list[i]["phone_number"],
                        year: list[i]["year_of_birth"]
                        })
                }
                if (list.length > 0) {
                    suggestionPopup.open()
                } else {
                    suggestionPopup.close()
                }
            }
        }
    }

    Connections {
        target: controller
        function onProductListReady(list, cmd) {
            if (cmd === "SEARCH" && input.focus) {
                suggestionModel.clear()
                for (let i = 0; i < list.length; ++i) {
                    suggestionModel.append({ name: list[i]["productName"] })
                }
                if (list.length > 0) {
                    suggestionPopup.open()
                } else {
                    suggestionPopup.close()
                }
            }
        }
    }
}
