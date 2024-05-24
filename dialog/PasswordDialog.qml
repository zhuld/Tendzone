import QtQuick
import QtQuick.Controls

import "../button/"
import "../others/"

import QtQuick.Controls.Fusion

Dialog {
    id:rootPassword

    readonly property real ratio: 0.9
    property int passtype

    property alias passwordTitle: passwordTitle.text
    property alias passwordLabel: passwordLabel.text

    implicitWidth: parent.width / parent.height < ratio ? parent.width*0.9:parent.height*0.9*ratio
    implicitHeight: implicitWidth/ratio

    signal okPressed (var password)

    enum Type{
        Settings,
        LockScreen
    }

    anchors.centerIn: parent

    modal: true;
    closePolicy: passtype === PasswordDialog.Type.Settings ? Popup.CloseOnPressOutside : Popup.NoAutoClose

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

    onClosed: password.text = ""

    background: Background{}

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
            height: parent.height*0.2
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment : Text.AlignHCenter
            font.pixelSize: height*0.4
            color: "#33B5E5"
            enabled: false
            focus: true
            echoMode: TextInput.Password
            passwordMaskDelay: 500
        }

        GridView {
            id:numberPad
            width: parent.width*0.8
            height: parent.height*0.60
            anchors.margins: parent.width*0.1
            anchors.horizontalCenter: parent.horizontalCenter

            cellWidth: width*0.25
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
                ListElement { name: "0" }
                ListElement { name: "\u21E6" }
                ListElement { name: "\u23CE" }
            }
            delegate: ColorButton{
                width: parent.width*0.25
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
                    case "\u21E6":
                        password.text = password.text.slice(0,password.text.length-1);
                        break;
                    case "\u23CE":
                        okPressed(password.text)
                        password.text = "";
                        break
                    }
                }
            }
        }
    }
}
