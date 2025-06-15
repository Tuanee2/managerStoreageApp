import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Item {
    id: rootAddNewProduct
    anchors.fill: parent
    property string unit: ""


    Rectangle {
        id: addNewProduct
        anchors.fill: parent
        color: "transparent"

        Column {
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.05

            spacing: parent.height*0.03

            TextField {
                id: idtextfield
                placeholderText: "ID sản phẩm (KHÔNG BẮT BUỘC)"
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(0, 0, 0, 0.4)
                    border.width: 1
                    border.color: Qt.rgba(1,1,1,0.5)
                }
                width: addNewProduct.width*0.6
                height: addNewProduct.height*0.1
                color: "white"
            }

            TextField {
                id: nametextfield
                placeholderText: "Tên sản phẩm (BẮT BUỘC)"
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(0, 0, 0, 0.4)
                    border.width: 1
                    border.color: Qt.rgba(1,1,1,0.5)
                }
                width: addNewProduct.width*0.6
                height: addNewProduct.height*0.1
                color: "white"
            }

            TextField {
                id: pricetextfield
                placeholderText: "Giá nhập sản phẩm (BẮT BUỘC)"
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(0, 0, 0, 0.4)
                    border.width: 1
                    border.color: Qt.rgba(1,1,1,0.5)
                }
                width: addNewProduct.width*0.6
                height: addNewProduct.height*0.1
                color: "white"
            }

            TextField {
                id: destextfield
                placeholderText: "Mô tả hoặc ghi chú sản phẩm (KHÔNG BẮT BUỘC)"
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(0, 0, 0, 0.4)
                    border.width: 1
                    border.color: Qt.rgba(1,1,1,0.5)
                }
                width: addNewProduct.width*0.6
                height: addNewProduct.height*0.1
                color: "white"
            }

            Rectangle {
                id: unitfield
                width: addNewProduct.width*0.4
                height: addNewProduct.height*0.1
                radius: 10
                color: Qt.rgba(0, 0, 0, 0.4)
                border.width: 1
                border.color: Qt.rgba(1,1,1,0.5)

                Rectangle {
                    height: parent.height
                    width: parent.width*0.4
                    anchors.left:parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"
                    Text {
                        anchors.centerIn: parent
                        text: "ĐƠN VỊ : "
                        color: "white"
                        font.pixelSize: parent.height*0.4
                    }

                }

                Rectangle {
                    id: unitContent
                    height: parent.height
                    width: parent.width*0.6
                    anchors.right:parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"
                    Text {
                        id: unittextcontent
                        anchors.centerIn: parent
                        text: "KHÔNG XÁC ĐỊNH"
                        color: "white"
                        font.pixelSize: parent.height*0.4
                    }
                }

                Menu {
                    id: unitMenu
                    y: unitfield.height
                    x: parent.width*0.5
                    MenuItem{
                        text: "Chai"
                        onTriggered: {
                            unittextcontent.text = "Chai"
                            rootAddNewProduct.unit = "BOTTLE"
                        }
                    }
                    MenuItem{
                        text: "Bao"
                        onTriggered: {
                            unittextcontent.text = "Bao"
                            rootAddNewProduct.unit = "BAG"
                        }
                    }
                    MenuItem{
                        text: "Gói"
                        onTriggered: {
                            unittextcontent.text = "Gói"
                            rootAddNewProduct.unit = "PACK"
                        }
                    }
                    MenuItem{
                        text: "Thùng"
                        onTriggered: {
                            unittextcontent.text = "Thùng"
                            rootAddNewProduct.unit = "BOX"
                        }
                    }
                    MenuItem{
                        text: "KG"
                        onTriggered: {
                            unittextcontent.text = "Kg"
                            rootAddNewProduct.unit = "KG"
                        }
                    }
                    MenuItem{
                        text: "Lít"
                        onTriggered: {
                            unittextcontent.text = "Lít"
                            rootAddNewProduct.unit = "LITER"
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        unitMenu.open()
                    }
                }

            }

            Rectangle {
                id: button4add
                width: addNewProduct.width*0.3
                height: addNewProduct.height*0.1
                radius: 10
                color: ma4button4add.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)

                Text {
                    anchors.centerIn: parent
                    text: "Xác nhận thêm sản phẩm mới"
                    font.pixelSize: 24
                    color: "white"
                }

                MouseArea {
                    id: ma4button4add
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        let name = nametextfield.text.trim();
                        let price = parseFloat(pricetextfield.text);

                        if (name === "") {
                            console.log("⚠️ Tên sản phẩm bắt buộc");
                            rootWindow.notification.showNotification("⚠️ Tên sản phẩm bắt buộc")
                            return;
                        }


                        if (isNaN(price) || price <= 0) {
                            console.log("⚠️ Giá sản phẩm không hợp lệ");
                            rootWindow.notification.showNotification("⚠️ Giá sản phẩm không hợp lệ")
                            return;
                        }

                        if(unittextcontent.text == "KHÔNG XÁC ĐỊNH") {
                            rootWindow.notification.showNotification("⚠️ Sản phẩm chưa có đơn vị")
                            return;
                        }

                        // if (!/\d{2}-\d{2}-\d{4}/.test(date)) {
                        //     console.log("⚠️ Ngày không đúng định dạng dd-MM-yyyy");
                        //     rootWindow.notification.showNotification("⚠️ Ngày không đúng định dạng dd-MM-yyyy")
                        //     return;
                        // }

                        // kiểm tra trùng tên
                        let cmdData = {
                            command: "CHECK",
                            target: "PRODUCT",
                            data: {
                                name: name
                            }
                        }

                        controller.requestProductCommand(cmdData);
                    }

                }

            }
        }
    }

    Dialog {
        id: confirmDialog
        title: "Bạn đồng ý xác nhận thêm sản phẩm mới?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: rootWindow
        // Yes = thêm tiếp, No = trở về
        visible: false
        onAccepted: {
            // code gọi api thêm vào database
            let id = idtextfield.text.trim();
            let name = nametextfield.text.trim();
            let price = parseFloat(pricetextfield.text);
            let description = destextfield.text.trim();
            let cmdData = {
                command: "ADD",
                target: "PRODUCT",
                data: {
                    id: id,
                    name: name,
                    price: price,
                    unit: rootAddNewProduct.unit,
                    des: description
                }
            }

            controller.requestProductCommand(cmdData);
        }
        onRejected: {
            followupDialog.open()
        }
    }

    function clearFields() {
        idtextfield.text = ""
        nametextfield.text = ""
        pricetextfield.text = ""
        destextfield.text = ""
    }

    Dialog {
        id: followupDialog
        title: "Bạn muốn thực hiện thêm sản phẩm mới tiếp không?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: rootWindow
        visible: false
        onAccepted: {
            clearFields() // Xoá nội dung textfield để nhập mới
        }
        onRejected: {
            pageLoader.source = "components/Dashboard.qml" // Quay lại trang chính
        }
    }

    Connections {
        target: controller
        function onProductCommandResult(done, cmd) {
            if(cmd.command === "ADD"){
                if(done){
                    followupDialog.open()
                }else{
                    clearFields()
                    rootWindow.notification.showNotification("⚠️ Thêm sản phẩm thất bại");
                }
            }else if(cmd.command === "CHECK"){
                if (done) {
                    rootWindow.notification.showNotification("⚠️ Tên sản phẩm đã tồn tại");
                } else {
                    // Tiếp tục thêm sản phẩm
                    rootWindow.notification.showNotification("Thêm sản phẩm");
                    confirmDialog.open()
                }
            }
        }
    }


}
