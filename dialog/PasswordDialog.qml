pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import "../button/"
import "../others/"
import "../"

Popup {
    id: rootPassword

    property int passtype

    property alias passwordTitle: passwordTitle.text
    property alias passwordLabel: passwordLabel.text

    property int during: 30

    implicitWidth: parent.width * 0.8
    implicitHeight: parent.height * 0.9
    anchors.centerIn: parent

    signal passwordEnter(string password)

    modal: true
    focus: true

    parent: Overlay.overlay
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    Overlay.modal: Rectangle {
        color: Global.overlayColor
    }

    enter: Transition {
        NumberAnimation {
            from: 0
            to: 1
            property: "opacity"
            duration: Global.durationDelay
        }
    }
    exit: Transition {
        NumberAnimation {
            from: 1
            to: 0
            property: "opacity"
            duration: Global.durationDelay
        }
    }

    Timer {
        id: countDownTimer
        interval: 1000
        repeat: true
        triggeredOnStart: false
        onTriggered: {
            rootPassword.during--;
            if (rootPassword.during === 0) {
                rootPassword.close();
            }
        }
    }
    onOpened: {
        if (passtype === Global.DialogType.PassWordSettings) {
            countDownTimer.start();
        }
    }

    onClosed: {
        password.text = "";
        countDownTimer.stop();
        during = 30;
    }

    background: DialogBackground {
        titleHeight: 0.18
    }

    Column {
        id: base
        anchors.fill: parent
        anchors.margins: width * 0.02
        spacing: height * 0.05
        Text {
            id: passwordTitle
            width: parent.width
            height: parent.height * 0.1
            font.pixelSize: height * 0.8
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            color: Global.textColor
        }
        TextInput {
            id: password
            width: parent.width
            height: parent.height * 0.1
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: height * 0.6
            color: Global.textColor
            enabled: false
            focus: true
            echoMode: TextInput.Password
            passwordMaskDelay: 500
        }

        Grid {
            id: numberPad
            height: parent.height * 0.6
            width: height * 4 / 3
            spacing: width * 0.03
            anchors.margins: parent.width * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            columns: 4
            Repeater {
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
                delegate: MyButton {
                    required property string name
                    width: (numberPad.width + numberPad.spacing) / numberPad.columns - numberPad.spacing
                    height: width
                    radius: width / 2
                    font.pixelSize: height * 0.4
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
                                password.text += name;
                            }
                            break;
                        case "\u21E6":
                            password.text = password.text.slice(0, password.text.length - 1);
                            break;
                        case "\u23CE":
                            rootPassword.passwordEnter(password.text);
                            password.text = "";
                            break;
                        }
                    }
                }
            }
        }

        Text {
            id: passwordLabel
            width: parent.width
            height: parent.height * 0.1
            font.pixelSize: height * 0.6
            wrapMode: Text.Wrap
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignRight
            color: Global.settings.phoneNumber === "" ? "transparent" : Global.textColor
        }
    }
}
