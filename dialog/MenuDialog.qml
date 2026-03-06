import QtQuick
import QtQuick.Controls

import "../button/"
import "../"
import "../dialog"

Drawer {
    id: drawerRoot
    implicitWidth: parent.width / 8
    implicitHeight: parent.height
    edge: Qt.LeftEdge
    dragMargin: width * 0.5

    background: Rectangle {
        anchors.fill: parent
        color: "transparent"
    }

    property alias setting: setting.text
    property alias language: language.text
    property alias vol: vol.text
    property alias languageLabel: language.label

    Overlay.modal: Rectangle {
        color: Global.overlayColor
    }

    ScrollView {
        height: parent.height
        width: parent.width
        contentWidth: width

        //contentHeight: Grid.height
        Column {
            width: parent.width
            MenuButton {
                id: setting
                width: parent.width
                height: parent.width
                label: "\u2699"
                text: "设置"
                onClicked: {
                    if (Global.settings.settingPassword === "") {
                        settingDialog.open()
                    } else {
                        passwordDialog.passtype = PasswordDialog.Type.Settings
                        passwordDialog.open()
                    }
                    drawerRoot.close()
                }
            }
            MenuButton {
                id: language
                width: parent.width
                height: parent.width
                label: "中"
                text: "语言"
                onClicked: {
                    if (Global.settings.language === "zh_CN") {
                        Global.settings.language = "en_US"
                    } else {
                        Global.settings.language = "zh_CN"
                    }
                    Global.settings.sync()
                }
            }
            MenuButton {
                id: vol
                width: parent.width
                height: parent.width
                label: "\u266C"
                text: "音量"
                onClicked: {
                    volumeDialog.open()
                    drawerRoot.close()
                }
            }
        }
    }
}
