import QtQuick
import QtQuick.Controls
import QtWebSockets
import QtQuick.Layouts

import QtQuick.Controls.Fusion

Drawer{
    id:drawerRoot
    width: parent.width*0.1
    height: parent.height
    edge: Qt.LeftEdge
    dragMargin: width*0.5

    property alias settingLable: settingLable.text
    property alias languageLable: languageLable.text
    property alias volLabel: volLabel.text
    property alias cameraLabel: cameraLabel.text
    property alias language: language.text

    Overlay.modal: Rectangle{
        color:"#A0000000"
    }


    Grid{
        width:parent.width
        height: parent.height
        spacing: width*0.1

        horizontalItemAlignment : Grid.AlignHCenter
        columns:  1
        topPadding: height*0.02

        Button{
            id:setting
            width: parent.width*0.6
            height: parent.height*0.18 > width ? width:parent.height*0.18
            font.pixelSize: height*0.4
            text: "\u2699"
            onClicked: {
                if(settings.settingPassword ===""){
                    settingDialog.open()
                }else{
                    passwordDialog.passtype = PasswordDialog.Type.Settings
                    passwordDialog.open()
                }
            }
        }
        Text {
            id: settingLable
            text: "设置"
            width: parent.width
            height: width*0.4
            color: "#33B5E5"
            font.pixelSize: height*0.5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
        }
        Button{
            id:language
            //anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.6
            height: parent.height*0.18 > width ? width:parent.height*0.18
            font.pixelSize: height*0.4
            text: "中"
            onClicked: {
                if(languageStates.state === "chinese"){
                    languageStates.state = "english"
                }else{
                    languageStates.state = "chinese"
                }
            }
        }
        Text {
            id:languageLable
            text: "语言"
            width: parent.width
            height: width*0.4
            color: "#33B5E5"
            font.pixelSize: height*0.5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
        }
        Button{
            id:vol
            //anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.6
            height: parent.height*0.18 > width ? width:parent.height*0.18
            font.pixelSize: height*0.4
            text: "\u266C"
            onClicked :volumeDialog.visible = true
            opacity: enabled? 1:0.5
            enabled: wsClient.status===WebSocket.Open ? true:false
        }
        Text {
            id:volLabel
            text: "音量"
            width: parent.width
            height: width*0.4
            color: "#33B5E5"
            font.pixelSize: height*0.5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
        }
        Button{
            id:camera
            //anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.6
            height: parent.height*0.18 > width ? width:parent.height*0.18
            font.pixelSize: height*0.4
            text: "\u26F6"
            onClicked :cameraDialog.visible = true
            opacity: enabled? 1:0.5
            enabled: wsClient.status===WebSocket.Open ? true:false
        }
        Text {
            id:cameraLabel
            text: "视频"
            width: parent.width
            height: width*0.4
            color: "#33B5E5"
            font.pixelSize: height*0.5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
        }
    }
}


