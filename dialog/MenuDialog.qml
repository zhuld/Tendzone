import QtQuick
import QtQuick.Controls
import QtWebSockets
import QtQuick.Layouts

import QtQuick.Controls.Fusion

Drawer{
    id:drawerRoot
    width: root.width/6
    height: root.height
    edge: Qt.LeftEdge
    dragMargin: width*0.5

    background: Rectangle{
        anchors.fill: parent
        color: "transparent"
    }

    property alias settingLable: settingLable.text
    property alias languageLable: languageLable.text
    property alias volLabel: volLabel.text
    property alias helpLabel: helpLabel.text
    property alias guideLabel: guideLabel.text
    property alias language: languageText.text

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

            //columns:  1

            Rectangle{
                width: parent.width
                height: parent.height*0.005
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 1.0; color: "transparent" }
                    GradientStop { position: 0.6; color: "#33B5E5" }
                    GradientStop { position: 0.0; color: "transparent" }
                }
            }
            Button{
                id:setting
                width: parent.width
                height: parent.width*0.6
                background: Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }
                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#33B5E5"
                    font.pixelSize: height*0.8
                    text: "\u2699"
                }
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
            Text {
                id: settingLable
                text: "设置"
                width: parent.width
                height: width*0.3
                color: "#33B5E5"
                font.pixelSize: height*0.7
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
            }
            Rectangle{
                width: parent.width
                height: parent.height*0.005
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 1.0; color: "transparent" }
                    GradientStop { position: 0.6; color: "#33B5E5" }
                    GradientStop { position: 0.0; color: "transparent" }
                }
            }
            Button{
                id:language
                width: parent.width
                height: parent.width*0.6
                background: Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }
                Text {
                    id: languageText
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#33B5E5"
                    font.pixelSize: height*0.6
                    text: "中"
                }
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
                height: width*0.3
                color: "#33B5E5"
                font.pixelSize: height*0.7
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
            }
            Rectangle{
                width: parent.width
                height: parent.height*0.005
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 1.0; color: "transparent" }
                    GradientStop { position: 0.6; color: "#33B5E5" }
                    GradientStop { position: 0.0; color: "transparent" }
                }
            }
            Button{
                id:vol
                width: parent.width
                height: parent.width*0.6
                background: Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }
                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#33B5E5"
                    font.pixelSize: height*0.8
                    text: "\u266C"
                }
                onClicked :{
                    volumeDialog.open()
                    drawerRoot.close()
                }
                opacity: enabled? 1:0.5
                enabled: wsClient.status===WebSocket.Open ? true:false
            }
            Text {
                id:volLabel
                text: "音量"
                width: parent.width
                height: width*0.3
                color: "#33B5E5"
                font.pixelSize: height*0.7
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
            }
            Rectangle{
                width: parent.width
                height: parent.height*0.005
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 1.0; color: "transparent" }
                    GradientStop { position: 0.6; color: "#33B5E5" }
                    GradientStop { position: 0.0; color: "transparent" }
                }
            }
            Button{
                id:help
                width: parent.width
                height: parent.width*0.6
                background: Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }
                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#33B5E5"
                    font.pixelSize: height*0.8
                    text: "?"
                }
            }
            Text {
                id:helpLabel
                text: "帮助"
                width: parent.width
                height: width*0.3
                color: "#33B5E5"
                font.pixelSize: height*0.7
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
            }
            Rectangle{
                width: parent.width
                height: parent.height*0.005
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 1.0; color: "transparent" }
                    GradientStop { position: 0.6; color: "#33B5E5" }
                    GradientStop { position: 0.0; color: "transparent" }
                }
            }
            Button{
                id:guide
                width: parent.width
                height: parent.width*0.6
                background: Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }
                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#33B5E5"
                    font.pixelSize: height*0.8
                    text: "\u261E"
                }
            }
            Text {
                id:guideLabel
                text: "指引"
                width: parent.width
                height: width*0.3
                color: "#33B5E5"
                font.pixelSize: height*0.7
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
            }
            Rectangle{
                width: parent.width
                height: parent.height*0.005
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 1.0; color: "transparent" }
                    GradientStop { position: 0.6; color: "#33B5E5" }
                    GradientStop { position: 0.0; color: "transparent" }
                }
            }
        }
    }
}
