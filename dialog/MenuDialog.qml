import QtQuick
import QtQuick.Controls

import "../button/"
import "../"
import "../dialog"

Dialog {
    id: menuDialog

    implicitHeight: parent.height * 0.3
    implicitWidth: height * 2.6
    anchors.centerIn: parent
    padding: height * 0.2

    modal: true
    focus: true

    parent: Overlay.overlay
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Background {}

    property alias language: language.text

    enter: Transition {
        NumberAnimation {
            property: "scale"
            from: 0
            to: 1.0
            duration: 500
            easing.type: Easing.OutBack
        }
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 500
        }
    }
    contentItem: Row {
        id: row
        spacing: parent.height * 0.2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        MyButton {
            id: setting
            height: parent.height
            width: height
            text: "\u2699"
            onClicked: {
                if (Global.settings.settingPassword === "") {
                    settingDialog.open();
                } else {
                    passwordDialog.passtype = PasswordDialog.Type.Settings;
                    passwordDialog.open();
                }
                menuDialog.close();
            }
        }

        MyButton {
            id: vol
            height: parent.height
            width: height
            text: "\u266C"
            onClicked: {
                volumeDialog.open();
                menuDialog.close();
            }
        }
        MyButton {
            id: language
            height: parent.height
            width: height
            text: "语言"
            onClicked: {
                if (Global.settings.language === "zh_CN") {
                    Global.settings.language = "en_US";
                } else {
                    Global.settings.language = "zh_CN";
                }
                Global.settings.sync();
            }
        }
    }
}
