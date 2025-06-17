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
    property string targetExtension: ""
    property int itemsPerPage: 6
    property color color4placeholder: "white"

    property bool isClick: false 
    property bool isEnable: false

    property bool isCreateTransaction: false

    signal suggestionSelected(var data)

    ListModel {
        id: suggestionModel
    }

    TextField {
        id: input
        anchors.fill:parent
        font.pixelSize: parent.height*0.4
        placeholderTextColor: root.color4placeholder
        onTextChanged: {
            //console.log(root.isClick)
            if (text.length > 0 && root.isClick === false && input.focus) {
                // Giả sử controller xử lý gợi ý theo target
                if(target === "PRODUCT"){
                    let cmdData;
                    if(root.targetExtension === "NAME"){
                        cmdData = {
                            command: "GET",
                            target: "PRODUCT",
                            infoKind: "OBJECT",
                            mode: "MULTIPLE",
                            getType: "SEARCH",
                            filters: {
                                name: text
                            },
                            page: 0,
                            pageSize: 5
                        }
                    }else if(root.targetExtension === "PRICE"){
                        cmdData = {
                            command: "GET",
                            target: "PRODUCT",
                            infoKind: "OBJECT",
                            mode: "MULTIPLE",
                            getType: "SEARCH",
                            filters: {
                                price: text
                            },
                            page: 0,
                            pageSize: 5
                        }
                    }
                    controller.requestProductList(cmdData)
        
                }else if(target === "CUSTOMER"){
                    let cmdData;
                    if(root.targetExtension === "NAME"){
                        cmdData = {
                            command: "GET",
                            target: "CUSTOMER",
                            infoKind: "OBJECT",
                            getType: "SEARCH",
                            mode: "MULTIPLE",
                            filters: {
                                name: text
                            },
                            page: 0,
                            pageSize: 5
                        }
                    }else if(root.targetExtension === "PHONENUMBER"){
                        cmdData = {
                            command: "GET",
                            target: "CUSTOMER",
                            infoKind: "OBJECT",
                            getType: "SEARCH",
                            mode: "MULTIPLE",
                            filters: {
                                phonenumber: text
                            },
                            page: 0,
                            pageSize: 5
                        }
                    }else if(root.targetExtension === "YEAROFBIRTH"){
                        cmdData = {
                            command: "GET",
                            target: "CUSTOMER",
                            infoKind: "OBJECT",
                            getType: "SEARCH",
                            mode: "MULTIPLE",
                            filters: {
                                yearofbirth: text
                            },
                            page: 0,
                            pageSize: 5
                        }
                    }
    
                    controller.requestCustomerList(cmdData)
                    
                }else if(target === "BATCH"){
                    let cmdData = {
                        cmd: "SEARCH",
                        typelist: "",
                        duration: ""
                    }
                    controller.requestBatchList(cmdData, text, "", root.itemsPerPage, 0)

                }else if(target === "ORDER"){

                }else{
                    console.log("The target for main search textfield is invalue !!!!!")
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
        height: parent.height*5
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
                        suggestionPopup.close()
                        if(root.target === "PRODUCT"){
                            if(!root.isCreateTransaction){
                                pageLoader.setSource("ProductFormForTransaction.qml", {
                                    productName: model.name
                                })
                                drawerLoader.source = "components/TransactionDrawer.qml"
                            }else {
                                if(root.taretExtension === "NAME"){
                                    input.text = model.productName
                                }else if(root.targetExtension === "PRICE"){
                                    input.text = model.cost
                                }
                                pageLoader.setSource("ProductForm.qml", {
                                    productName: model.name
                                })
                                drawerLoader.source = "components/ProductDrawer.qml"
                            }

                        } else if (root.target === "CUSTOMER"){
                            if(!root.isCreateTransaction){
                                if(root.targetExtension === "NAME"){
                                    root.suggestionSelected({name: model.name, phoneNumber: model.phone, yearOfBirth: model.year})
                                
                                }else if(root.targetExtension === "PHONENUMBER"){
                                    root.suggestionSelected({name: model.name, phoneNumber: model.phone, yearOfBirth: model.year})
                                    input.text = model.phone
                                    
                                }else if(root.targetExtension === "YEAROFBIRTH"){
                                    root.suggestionSelected({name: model.name, phoneNumber: model.phone, yearOfBirth: model.year})
                                    input.text = model.year
                                    
                                }
                            }else{
                                if(root.targetExtension === "NAME"){
                                    root.suggestionSelected({name: model.name, phoneNumber: model.phone, yearOfBirth: model.year})
                                    pageLoader.setSource("CustomerForm.qml", {
                                        customerPhoneNumber: model.phone
                                    })

                                }else if(root.targetExtension === "PHONENUMBER"){
                                    root.suggestionSelected({name: model.name, phoneNumber: model.phone, yearOfBirth: model.year})
                                    input.text = model.phone
                                    pageLoader.setSource("CustomerForm.qml", {
                                        customerPhoneNumber: model.phone
                                    })
                                }else if(root.targetExtension === "YEAROFBIRTH"){
                                    root.suggestionSelected({name: model.name, phoneNumber: model.phone, yearOfBirth: model.year})
                                    input.text = model.year
                                    pageLoader.setSource("CustomerForm.qml", {
                                        customerPhoneNumber: model.phone
                                    })
                                }
                            }
                        } else if (root.target === "BATCH"){
                            if(root.isCreateTransaction){

                            }else{
                            }
                        } else if (root.target === "ORDER"){
                            if(root.isCreateTransaction){

                            }else{
                            }
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

            if (cmd.getType === "SEARCH" && input.focus) {
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
            if (cmd.getType === "SEARCH" && input.focus) {
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
