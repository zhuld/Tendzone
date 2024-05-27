import QtQuick
import QtQuick.Controls
import QtWebSockets
import QtQuick.Layouts

import "../button/"

import QtQuick.Controls.Fusion

Drawer{
    id:drawerRoot
    width: root.width/8
    height: root.height
    edge: Qt.LeftEdge
    dragMargin: width*0.5

    background: Rectangle{
        anchors.fill: parent
        color: "transparent"
    }

    property alias setting: setting.text
    property alias language: language.text
    property alias vol: vol.text
    property alias help: help.text
    property alias guide: guide.text
    property alias languageLabel: language.label

    Overlay.modal: Rectangle{
        color:"#A0000000"
    }

    ScrollView{
        height: parent.height
        width: parent.width
        contentWidth: width
        contentHeight: Grid.height

        Column{
            width:parent.width
            MenuButton{
                id:setting
                width: parent.width
                height: parent.width
                label: "\u2699"
                text: "设置"
                onClicked: {
                    if(settings.settingPassword ===""){
                        settingDialog.open()
                    }else{
                        passwordDialog.passtype = PasswordDialog.Type.Settings
                        passwordDialog.open()
                    }
                    drawerRoot.close()
                }
            }
            MenuButton{
                id:language
                width: parent.width
                height: parent.width
                label: "中"
                text: "语言"
                onClicked: {
                    if(languageStates.state === "zh_CN"){
                        languageStates.state = "en_US"
                    }else{
                        languageStates.state = "zh_CN"
                    }
                }
            }
            MenuButton{
                id:vol
                width: parent.width
                height: parent.width
                label: "\u266C"
                text: "音量"
                onClicked: {
                    volumeDialog.open()
                    drawerRoot.close()
                }
            }
            MenuButton{
                id:help
                width: parent.width
                height: parent.width
                label: "?"
                text: "帮助"
            }
            MenuButton{
                id:guide
                width: parent.width
                height: parent.width
                label: "\u261E"
                text: "指引"
            }
        }
    }
}
