import QtQuick
import QtQuick.Controls

import "../button/"
import "../"

Popup {
    id: menuDialog

    implicitHeight: parent.height
    implicitWidth: parent.width * 0.12
    modal: true
    focus: true

    parent: Overlay.overlay
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Background {}

    signal openDialog(var type)

    enter: Transition {
        NumberAnimation {
            property: "x"
            easing.type: Easing.OutBack
            from: -menuDialog.width
            to: 0
            duration: Global.durationDelay
        }
    }
    exit: Transition {
        NumberAnimation {
            property: "x"
            easing.type: Easing.InQuad
            from: 0
            to: -menuDialog.width
            duration: Global.durationDelay
        }
    }
    Overlay.modal: Rectangle {
        color: Global.overlayColor
    }

    property alias language: language.text

    property int during: 30

    Timer {
        id: countDownTimer
        interval: 1000
        repeat: true
        triggeredOnStart: false
        onTriggered: {
            menuDialog.during--;
            if (menuDialog.during === 0) {
                menuDialog.close();
            }
        }
    }
    contentItem: Column {
        id: row
        spacing: menuDialog.width * 0.2
        padding: menuDialog.width * 0.05
        MyButton {
            width: parent.width * 0.7
            anchors.horizontalCenter: parent.horizontalCenter
            height: width
            icon.source: "qrc:/icons/config.svg"
            onClicked: {
                if (Global.settings.settingPassword === "") {
                    //settingDialog.open();
                    menuDialog.openDialog(Global.DialogType.Settings);
                } else {
                    //passwordDialog.passtype = Global.DialogType.PassWordSettings;
                    //passwordDialog.open();
                    menuDialog.openDialog(Global.DialogType.PassWordSettings);
                }
                menuDialog.close();
            }
        }
        MyButton {
            width: parent.width * 0.7
            anchors.horizontalCenter: parent.horizontalCenter
            height: width
            icon.source: "qrc:/icons/volume.svg"
            onClicked: {
                //volumeDialog.open();
                menuDialog.openDialog(Global.DialogType.Volume);
                menuDialog.close();
            }
        }
        MyButton {
            id: language
            width: parent.width * 0.7
            anchors.horizontalCenter: parent.horizontalCenter
            height: width
            onClicked: {
                if (Global.settings.language === "zh_CN") {
                    Global.settings.language = "en_US";
                } else {
                    Global.settings.language = "zh_CN";
                }
                Global.settings.sync();
            }
        }

        MyButton {
            width: parent.width * 0.7
            anchors.horizontalCenter: parent.horizontalCenter
            height: width
            icon.source: "qrc:/icons/dark.svg"
            onClicked: {
                Global.settings.darkTheme = !Global.settings.darkTheme;
                Global.settings.sync();
            }
        }
    }
    onOpened: countDownTimer.start()

    onClosed: {
        countDownTimer.stop();
        during = 30;
    }
}
