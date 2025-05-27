import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Item {
    id: importBatch
    anchors.fill: parent

    property string productName: ""

    Rectangle{
        id: importBatchBG
        anchors.fill: parent
        color: "transparent"

        Column {
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.05

            spacing: parent.height*0.03

            TextField {
                id: nametextfield
                placeholderText: "Tên sản phẩm (BẮT BUỘC)"
                text: importBatch.productName
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.5)      // màu nền của TextField
                }
                width: importBatchBG.width*0.6
                height: importBatchBG.height*0.1
                color: "white"
            }

            TextField {
                id: numtextfield
                placeholderText: "số lượng sản phẩm của lô (BẮT BUỘC)"
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.5)      // màu nền của TextField
                }
                width: importBatchBG.width*0.6
                height: importBatchBG.height*0.1
                color: "white"
            }

            TextField {
                id: costtextfield
                placeholderText: "Giá 1 sản phẩm của lô (BẮT BUỘC)"
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.5)      // màu nền của TextField
                }
                width: importBatchBG.width*0.6
                height: importBatchBG.height*0.1
                color: "white"
            }

            TextField {
                id: importdatetextfield
                placeholderText: "ngày nhập kho sản phẩm (định dạng DD-MM-YYYY)(BẮT BUỘC)"
                font.pixelSize: 24
                text: Qt.formatDate(new Date(), "dd-MM-yyyy")
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.5)      // màu nền của TextField
                }
                width: importBatchBG.width*0.6
                height: importBatchBG.height*0.1
                color: "white"
            }

            TextField {
                id: expireddatetextfield
                placeholderText: "Hạn sử dụng sản phẩm (định dạng DD-MM-YYYY)(BẮT BUỘC)"
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.5)      // màu nền của TextField
                }
                width: importBatchBG.width*0.6
                height: importBatchBG.height*0.1
                color: "white"
            }

            Rectangle {
                id: button4addBatch
                width: importBatchBG.width*0.3
                height: importBatchBG.height*0.1
                radius: 10
                color: mabutton4addBatch.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)

                Text {
                    anchors.centerIn: parent
                    text: "Xác nhận thêm lô mới"
                    font.pixelSize: 24
                    color: "white"
                }

                MouseArea {
                    id: mabutton4addBatch
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        let name = nametextfield.text.trim();
                        let num = parseInt(numtextfield.text);
                        let cost = parseFloat(costtextfield.text);
                        let importDate = importdatetextfield.text.trim();
                        let expiredDate = expireddatetextfield.text.trim();

                        if (name === "") {
                            console.log("⚠️ Tên sản phẩm bắt buộc");
                            rootWindow.notification.showNotification("⚠️ Tên sản phẩm bắt buộc")
                            return;
                        }
                        if (isNaN(num) || num <= 0){
                            rootWindow.notification.showNotification("⚠️ Số lượng sản phẩm của lô không hợp lệ")
                            return;
                        }

                        if (isNaN(cost) || cost <= 0){
                            rootWindow.notification.showNotification("⚠️ Giá 1 sản phẩm của lô không hợp lệ")
                            return;
                        }

                        if (!/\d{2}-\d{2}-\d{4}/.test(importDate)) {
                            console.log("⚠️ Ngày không đúng định dạng dd-MM-yyyy");
                            rootWindow.notification.showNotification("⚠️ Ngày không đúng định dạng dd-MM-yyyy")
                            return;
                        }

                        if (!/\d{2}-\d{2}-\d{4}/.test(expiredDate)) {
                            console.log("⚠️ Ngày không đúng định dạng dd-MM-yyyy");
                            rootWindow.notification.showNotification("⚠️ Ngày không đúng định dạng dd-MM-yyyy")
                            return;
                        }

                        // So sánh ngày nhập và hạn sử dụng
                        let partsImport = importDate.split("-");
                        let partsExpired = expiredDate.split("-");
                        let dateImport = new Date(partsImport[2], partsImport[1] - 1, partsImport[0]);
                        let dateExpired = new Date(partsExpired[2], partsExpired[1] - 1, partsExpired[0]);

                        if (dateImport >= dateExpired) {
                            rootWindow.notification.showNotification("⚠️ Ngày nhập phải trước ngày hết hạn")
                            return;
                        }

                        controller.checkProductNameConflict(name);
                    }

                }
            }


        }

    }

    Connections {
        target: controller
        function onProductNameChecked(exists) {
            if(exists){
                rootWindow.notification.showNotification("Tên sản phẩm hợp lệ");
                comfirmAddNewBatch.open();
            }else{
                rootWindow.notification.showNotification("⚠️ sản phẩm không tồn tại");
            }
        }
    }

    function clearFields() {
        numtextfield.text = ""
        expireddatetextfield.text = ""
    }

    Dialog {
        id: comfirmAddNewBatch
        title: "Bạn có chắc chắn muốn thêm lô sản phẩm mới?"
        standardButtons: Dialog.Yes | Dialog.No
        visible: false
        onAccepted: {
            // code gọi api thêm vào database
            let name = nametextfield.text.trim();
            let num = parseInt(numtextfield.text);
            let cost = parseFloat(costtextfield.text);
            let importDate = importdatetextfield.text.trim();
            let expiredDate = expireddatetextfield.text.trim();

            controller.requestBatchCommand("ADD", name, num, cost, importDate, expiredDate);
            controller.requestBatchInformation("", "EXPIREDDATE", "AMONTH", "")
            followupDialog.open()
        }
        onRejected: {
            followupDialog.open()
        }
    }


    Dialog {
        id: followupDialog
        title: "Bạn muốn thực hiện thêm lô sản phẩm mới tiếp không?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: parent
        visible: false
        onAccepted: {
            clearFields() // Xoá nội dung textfield để nhập mới
        }
        onRejected: {
            pageLoader.source = "components/ProductList.qml" // Quay lại trang chính
        }
    }



}
