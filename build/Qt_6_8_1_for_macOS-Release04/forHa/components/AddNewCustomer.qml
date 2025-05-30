import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Item {
    anchors.fill: parent

    Rectangle {
        id: addNewCustomer
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
                placeholderText: "Tên khách hàng (BẮT BUỘC)"
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.5)      // màu nền của TextField
                }
                width: addNewCustomer.width*0.6
                height: addNewCustomer.height*0.1
                color: "white"
            }

            TextField {
                id: phonenumbertextfield
                placeholderText: "Số điện thoại (KHÔNG BẮT BUỘC)"
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.5)      // màu nền của TextField
                }
                width: addNewCustomer.width*0.6
                height: addNewCustomer.height*0.1
                color: "white"
            }

            TextField {
                id: agetextfield
                placeholderText: "Năm sinh (KHÔNG BẮT BUỘC)"
                font.pixelSize: 24
                placeholderTextColor: Qt.rgba( 1, 1, 1, 0.8)
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.5)      // màu nền của TextField
                }
                width: addNewCustomer.width*0.6
                height: addNewCustomer.height*0.1
                color: "white"
            }

            ComboBox {
                id: genderComboBox
                model: ["Nam", "Nữ", "Khác"]
                width: addNewCustomer.width * 0.6
                height: addNewCustomer.height * 0.1
                font.pixelSize: 20
                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(1, 1, 1, 0.5)
                }
                contentItem: Text {
                    text: genderComboBox.currentText
                    color: "white"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
            }


            Rectangle {
                id: button4add
                width: addNewCustomer.width*0.3
                height: addNewCustomer.height*0.1
                radius: 10
                color: ma4button4add.containsMouse ? Qt.rgba( 73/255, 145/255, 230/255, 1) : Qt.rgba( 53/255, 125/255, 210/255, 1)

                Text {
                    anchors.centerIn: parent
                    text: "Xác nhận thêm khách hàng mới"
                    font.pixelSize: 24
                    color: "white"
                }

                MouseArea {
                    id: ma4button4add
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        let name = nametextfield.text.trim();
                        let phoneNumber = phonenumbertextfield.text.trim();

                        if (name === "") {
                            rootWindow.notification.showNotification("⚠️ Tên khách hàng bắt buộc")
                            return;
                        }

                        // kiểm tra trùng tên
                        controller.requestCustomerCommand("CHECKPHONENUMBER", "", "", true, phoneNumber);
                    }

                }

            }
        }
    }

    Dialog {
        id: confirmDialog
        title: "Bạn đồng ý xác nhận thêm khách hàng mới?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: rootWindow
        // Yes = thêm tiếp, No = trở về
        visible: false
        onAccepted: {
            // code gọi api thêm vào database
            let name = nametextfield.text.trim();
            let yearofbirth = parseInt(agetextfield.text);
            let phoneNumber = phonenumbertextfield.text.trim();
            let gender = genderComboBox.currentIndex // 0: Nam, 1: Nữ, 2: Khác
            controller.requestCustomerCommand("ADD", name, yearofbirth, gender, phoneNumber);
        }
        onRejected: {
            followupDialog.open()
        }
    }

    function clearFields() {
        nametextfield.text = ""
        agetextfield.text = ""
        phonenumbertextfield.text = ""
    }

    Dialog {
        id: followupDialog
        title: "Bạn muốn thực hiện thêm khách hàng mới tiếp không?"
        standardButtons: Dialog.Yes | Dialog.No
        anchors.centerIn: rootWindow
        visible: false
        onAccepted: {
            clearFields() // Xoá nội dung textfield để nhập mới
        }
        onRejected: {
            pageLoader.source = "components/CustomerList.qml" // Quay lại trang chính
        }
    }

    // Trong cùng QML file
    Connections {
        target: controller
        function onCustomerCommandResult(exists, cmd) {
            if(cmd === "CHECKPHONENUMBER"){
                if (exists) {
                    rootWindow.notification.showNotification("⚠️ Số điện thoại khách hàng đã tồn tại");
                } else {
                    confirmDialog.open()
                }
            }
        }
    }

    Connections {
        target: controller
        function onCustomerCommandResult(done, cmd) {
            if(cmd === "ADD"){
                if(done){
                    followupDialog.open()
                }else{
                    clearFields()
                    rootWindow.notification.showNotification("⚠️ Thêm khách hàng thất bại");
                }
            }
        }
    }


}
