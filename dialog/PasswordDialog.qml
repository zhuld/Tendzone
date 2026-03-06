pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import "../button/"
import "../others/"
import "../"

Dialog {
    id: rootPassword

    property int passtype

    property alias passwordTitle: passwordTitle.text
    property alias passwordLabel: passwordLabel.text

    property int during: 30

    implicitWidth: parent.width * 0.9
    implicitHeight: parent.height * 0.9

    signal okPressed(var password)

    enum Type {
        Settings,
        LockScreen
    }

    anchors.centerIn: parent

    modal: true
    closePolicy: passtype
                 === PasswordDialog.Type.Settings ? Popup.CloseOnPressOutside : Popup.NoAutoClose

    Overlay.modal: Rectangle {
        color: Global.overlayColor
    }

    enter: Transition {
        NumberAnimation {
            from: 0
            to: 1
            property: "opacity"
            duration: 200
        }
    }
    exit: Transition {
        NumberAnimation {
            from: 1
            to: 0
            property: "opacity"
            duration: 200
        }
    }

    Timer {
        id: countDownTimer
        interval: 1000
        repeat: true
        triggeredOnStart: false
        onTriggered: {
            rootPassword.during--
            if (rootPassword.during === 0) {
                rootPassword.close()
            }
        }
    }
    onOpened: {
        if (passtype === PasswordDialog.Type.Settings) {
            countDownTimer.start()
        }
    }

    onClosed: {
        password.text = ""
        countDownTimer.stop()
        during = 30
    }

    background: Background {}

    Column {
        id: base
        anchors.fill: parent
        anchors.margins: width * 0.02

        Text {
            id: passwordTitle
            width: parent.width
            height: parent.height * 0.15
            font.pixelSize: height * 0.5
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            color: Global.textColor
        }
        Text {
            id: passwordLabel
            width: parent.width
            height: parent.height * 0.15
            font.pixelSize: height * 0.5
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            color: Global.settings.phoneNumber === "" ? "transparent" : Global.textColor
        }
        TextInput {
            id: password
            width: parent.width
            height: parent.height * 0.15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: height * 0.4
            color: Global.textColor
            enabled: false
            focus: true
            echoMode: TextInput.Password
            passwordMaskDelay: 500
        }

        GridView {
            id: numberPad
            height: parent.height * 0.55
            width: height * 4 / 3
            anchors.margins: parent.width * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            cellWidth: width * 0.25
            cellHeight: cellWidth

            model: ListModel {
                id: numberModel
                ListElement {
                    name: "1"
                }
                ListElement {
                    name: "2"
                }
                ListElement {
                    name: "3"
                }
                ListElement {
                    name: "4"
                }
                ListElement {
                    name: "5"
                }
                ListElement {
                    name: "6"
                }
                ListElement {
                    name: "7"
                }
                ListElement {
                    name: "8"
                }
                ListElement {
                    name: "9"
                }
                ListElement {
                    name: "0"
                }
                ListElement {
                    name: "\u21E6"
                }
                ListElement {
                    name: "\u23CE"
                }
            }
            delegate: ColorButton {
                required property string name
                width: parent.width * 0.25
                height: width
                font.pixelSize: width * 0.4
                text: name
                onClicked: {
                    switch (name) {
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
                        if (password.text.length < 6) {
                            password.text += name
                        }
                        break
                        case "\u21E6":
                        password.text = password.text.slice(
                            0, password.text.length - 1)
                        break
                        case "\u23CE":
                        rootPassword.okPressed(password.text)
                        password.text = ""
                        break
                    }
                }
            }
        }
    }
}
