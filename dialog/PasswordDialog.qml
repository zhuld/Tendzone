import QtQuick
import QtQuick.Controls

import QtQuick.Controls.Fusion

Dialog {
    id:rootPassword
    anchors.centerIn: parent

    readonly property real ratio: 0.7
    property var passtype

    property alias passwordTitle: passwordTitle.text
    property alias passwordLabel: passwordLabel.text

    implicitWidth: parent.width / parent.height < ratio ? parent.width*0.9:parent.height*0.9*ratio
    implicitHeight: implicitWidth/ratio

    signal okPressed (var password)

    enum Type{
        Settings = 1,
        LockScreen = 2
    }

    modal: true;
    closePolicy: Popup.NoAutoClose

    Overlay.modal: Rectangle{
        color:"#A0000000"
    }

    enter: Transition {
        NumberAnimation{
            from: 0
            to: 1
            property: "opacity"
            duration: 200
        }
    }
    exit: Transition {
        NumberAnimation{
            from: 1
            to: 0
            property: "opacity"
            duration: 200
        }
    }

    Column{
        id:base
        anchors.fill: parent
        anchors.margins: width*0.02

        Text {
            id:passwordTitle
            width: parent.width
            height: parent.height*0.1
            text: "输入密码"
            font.pixelSize: height*0.5
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            color: "#33B5E5"
        }
        Text {
            id:passwordLabel
            width: parent.width
            height: parent.height*0.1
            text: "输入密码"
            font.pixelSize: height*0.5
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            color: settings.phoneNumber ==="" ? "transparent":"#33B5E5"
        }
        TextInput {
            id: password
            width: parent.width
            height: parent.height*0.1
            verticalAlignment: Text.AlignBottom
            horizontalAlignment : Text.AlignHCenter
            font.pixelSize: height
            color: "#33B5E5"
            enabled: false
            echoMode: TextInput.PasswordEchoOnEdit
            passwordMaskDelay: 500
        }
        GridView {
            id:numberPad
            width: parent.width*0.7
            height: parent.height
            anchors.margins: parent.width*0.1
            anchors.horizontalCenter: parent.horizontalCenter

            cellWidth: width*0.33
            cellHeight: cellWidth

            model:ListModel {
                id:numberModel
                ListElement { name: "1" }
                ListElement { name: "2" }
                ListElement { name: "3" }
                ListElement { name: "4" }
                ListElement { name: "5" }
                ListElement { name: "6" }
                ListElement { name: "7" }
                ListElement { name: "8" }
                ListElement { name: "9" }
                ListElement { name: "\u2190" }
                ListElement { name: "0" }
                ListElement { name: "\u2714" }
            }
            delegate: Button{
                width: parent.width*0.33
                height: width
                font.pixelSize: width*0.4
                text: name
                onClicked: {
                    switch (name){
                    case "1":
                    case "2":
                    case "3":
                    case "4":
                    case "5":
                    case "6":
                    case "7":
                    case "8":
                    case "9":
                    case "0":
                        if(password.text.length<6){
                            password.text += name;
                        }
                        break
                    case "\u2190":
                        password.text = password.text.slice(0,password.text.length-1);
                        break;
                    case "\u2714":
                        okPressed(password.text)
                        password.text = "";
                        break
                    }
                }
            }
        }
    }
}
