import QtQuick
import QtQuick.Controls
import QtWebSockets

import "./dialog/"
import "./others/"
import "./websocket/"

import "./js/tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

ApplicationWindow {
    id:root

    title: `${Application.name} (${Application.version})`

    width: 700
    height: 400

    visibility:settingDialog.settings.fullscreen? Window.FullScreen : Window.Windowed

    visible: true

    background: Rectangle{
        gradient: Gradient {
            GradientStop { position: 1.0; color: "#011629" }
            GradientStop { position: 0.6; color: "#042538" }
            GradientStop { position: 0.0; color: "#085360" }
        }
    }

    property alias settings :settingDialog.settings

    property int projectorHDMI
    property int extendHDMI
    property int monitorHDMI
    property int mubuPower
    property int projectorPower
    property int extensionPower
    property int lockPower

    property string roomName: ""

    PasswordDialog{
        id: passwordDialog
        onOkPressed: (password)=>{
            switch (passtype) {
            case PasswordDialog.Type.Settings:
                if((password === settings.settingPassword)||(password === "314159")){
                    settingDialog.open()
                }
                passwordDialog.close()
                break
            case PasswordDialog.Type.LockScreen:
                if((password === settings.lockPassword)||(password === "314159")){
                    passwordDialog.close()
                }
                break
            }
        }
    }

    SettingDialog{ id: settingDialog }

    ConfirmDialog{id: confirmDialog }

    Language{ id: language;  state:"chinese" }

    SocketStatus{id: webSocketStatus}

    ProcessDialog{id: processDialog}

    WSServer{
        id: wsServer
        onBinReceived: (message)=>info.text = "Received:"+message
        onTextReceived: (message) => {Tendzone.controlMessageCheck(message)
                            info.text = "Received:"+message
        }
    }

    WSClient{id: wsClient}

    BordLine{} //画线

    VolumeDialog{
        id:volumeDialog
        implicitHeight: parent.height*0.9
        implicitWidth: parent.width*0.44
        x:parent.width*0.9-implicitWidth
        y:parent.height*0.05

        miniVolume: -30
        maxVolume: 0
    }

    Logo{source: Tendzone.Commands_List["Logo"].Url}

    Column{
        anchors.fill: parent
        Row{
            id:statusBar
            height: parent.height*0.04
            width: parent.width
            layoutDirection: Qt.RightToLeft
            spacing: 10

            Text {
                id: statusTimer
                height: parent.height
                font.pixelSize: height
                color: wsClient.status == WebSocket.Open ? "#33B5E5" :"red"
                text: Qt.formatDateTime(new Date(),"yyyy-MM-dd hh:mm")
            }

            Text{
                id:info
                height: parent.height
                font.pixelSize: height
                color: "#33B5E5"
                text: ""
                visible: settingDialog.settings.debugInfo
            }
        }

        Row{
            id:mainRect
            height: parent.height*0.576
            width: parent.width

            Rectangle{
                width: parent.width/8
                height: parent.height
                color: "transparent"
            }
            Column{
                id: mainButtonLeft
                width: parent.width/8*3
                height: parent.height

                anchors{
                    top: parent.top
                    topMargin: height*0.1
                    bottomMargin: height*0.1
                }

                spacing: height*0.1

                Text{
                    id:hide
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                    width: parent.width*0.9
                    height: parent.height*0.2
                    font.pixelSize: height*0.8
                    color: "#33B5E5"
                    visible: settings.whiteboard? false:true
                }
                DelayButton{
                    id:whiteBoard
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.8
                    height: parent.height*0.3
                    font.pixelSize: height/3
                    text: "白板上课"
                    delay: 300
                    onReleased: checked = false
                    onActivated: Tendzone.startCmds("WhiteBoard")
                    visible: settings.whiteboard? true:false
                    opacity: enabled? 1:0.5
                    enabled: wsClient.status===WebSocket.Open ? true:false
                }
                DelayButton{
                    id:systemOn
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.8
                    height: settings.whiteboard? parent.height*0.3 : parent.height*0.4
                    font.pixelSize: height/3
                    text: "上课"
                    delay: 300
                    onReleased: checked = false
                    onActivated: Tendzone.startCmds("SystemOn")
                    opacity: enabled? 1:0.5
                    enabled: wsClient.status===WebSocket.Open ? true:false
                }
            }

            Column{
                id: mainButtonRight
                width: parent.width/8*3
                height: parent.height

                anchors{
                    top: parent.top
                    topMargin: height*0.1
                    bottomMargin: height*0.2
                }

                spacing: height*0.1
                Text{
                    id:roomNameLabel
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                    width: parent.width*0.9
                    height: parent.height*0.2
                    font.pixelSize: height*0.8
                    color: "#33B5E5"
                    text: roomName
                }
                DelayButton{
                    id:systemOff
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.8
                    height: parent.height*0.4
                    font.pixelSize: height/3
                    text: "下课"
                    delay: 300
                    onReleased: checked = false
                    onActivated: Tendzone.startCmds("SystemOff")
                    opacity: enabled? 1:0.5
                    enabled: wsClient.status===WebSocket.Open ? true:false
                }
            }
            Column{
                width: parent.width/8
                height: parent.height
                anchors.top: mainButtonLeft.top
                spacing: height*0.05
                Button{
                    id:lang
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.5
                    height: width
                    font.pixelSize: height*0.4
                    text: "中"
                    onClicked: {
                        if(language.state === "chinese"){
                            language.state = "english"
                        }else{
                            language.state = "chinese"
                        }
                    }
                }
                DelayButton{
                    id:vol
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.5
                    height: width
                    font.pixelSize: height*0.4
                    text: "\u266C"
                    delay: 200
                    onReleased: checked = false
                    onActivated:volumeDialog.visible = true
                    opacity: enabled? 1:0.5
                    enabled: wsClient.status===WebSocket.Open ? true:false
                }
            }
        }

        Row{
            id:subRect
            height: root.height*0.384-socketStatusProgress.height
            width: parent.width

            Column{
                id:subRectLeft
                width: settings.wireless? parent.width*0.6:parent.width*0.5
                height: parent.height
                anchors{
                    top: parent.top
                    topMargin: height*0.1
                    bottomMargin: height*0.1
                }
                Text {
                    id:signalLabel
                    width: parent.width
                    height: parent.height*0.3
                    horizontalAlignment: Text.AlignHCenter
                    text: "信号切换"
                    font.pixelSize: height/2
                    color: "#33B5E5"
                }

                Row{
                    width: parent.width
                    height: parent.height*0.7
                    leftPadding: settings.wireless? width*0.03 :width*0.05
                    spacing: settings.wireless? width*0.03 : width*0.1
                    Button{
                        id:computer
                        width: settings.wireless? parent.width*0.29 :parent.width*0.4
                        height: parent.height*0.5
                        font.pixelSize: height*0.3
                        text:"台式机"
                        onClicked:Tendzone.startCmds("ProjectorPC")
                        opacity: enabled? 1:0.5
                        enabled: wsClient.status===WebSocket.Open ? true:false
                        checked: root.projectorHDMI === Tendzone.val_PC
                    }
                    Button{
                        id:laptop
                        width: settings.wireless? parent.width*0.29 :parent.width*0.4
                        height: parent.height*0.5
                        font.pixelSize: height*0.3
                        text: "笔记本"
                        onClicked:Tendzone.startCmds("ProjectorLaptop")
                        opacity: enabled? 1:0.5
                        enabled: wsClient.status===WebSocket.Open ? true:false
                        checked: root.projectorHDMI === Tendzone.val_Laptop
                    }
                    Button{
                        id:wireless
                        width: parent.width*0.29
                        height: parent.height*0.5
                        font.pixelSize: height*0.3
                        text: "无线投屏"
                        onClicked: Tendzone.startCmds("ProjectorWireless")
                        visible: settings.wireless? true:false
                        opacity: enabled? 1:0.5
                        enabled: wsClient.status===WebSocket.Open ? true:false
                        checked: root.projectorHDMI === Tendzone.val_Wireless
                    }
                }
            }
            Column{
                id:subRectRight
                width: settings.wireless? parent.width*0.4:parent.width*0.5
                height: parent.height
                anchors{
                    top: parent.top
                    topMargin: height*0.1
                    bottomMargin: height*0.1
                }
                Text {
                    id:projectorLabel
                    width: parent.width
                    height: parent.height*0.3
                    horizontalAlignment: Text.AlignHCenter
                    text: "投影机"
                    font.pixelSize: height/2
                    color: "#33B5E5"
                }

                Row{
                    width: parent.width
                    height: parent.height*0.7
                    leftPadding: width*0.05
                    spacing: width*0.1
                    DelayButton{
                        id:projectorOn
                        width: parent.width*0.40
                        height: parent.height*0.5
                        font.pixelSize: height*0.3
                        text: "投影机开"
                        delay: 300
                        onReleased: checked = false
                        onActivated: Tendzone.startCmds("ProjectorOn")
                        opacity: enabled? 1:0.5
                        enabled: wsClient.status===WebSocket.Open ? true:false
                    }
                    DelayButton{
                        id:projectorOff
                        width: parent.width*0.40
                        height: parent.height*0.5
                        font.pixelSize: height*0.3
                        text: "投影机关"
                        delay: 300
                        onReleased: checked = false
                        onActivated: Tendzone.startCmds("ProjectorOff")
                        opacity: enabled? 1:0.5
                        enabled: wsClient.status===WebSocket.Open ? true:false
                    }
                }
            }
        }

        Rectangle{
            id: socketStatusProgress
            property real socketValue: 1
            width: parent.width*socketValue
            height: 2

            PropertyAnimation {
                id: socketAnimation
                target: socketStatusProgress
                property: "socketValue"
                from: 1
                to:0
                duration: settings.socketError*1000
                onFinished: {
                    wsClient.active = true
                    socketStatusProgress.socketValue = 1
                }
            }

        }
    }
    Component.onCompleted: {
        if(settings.lockPassword != ""){
            passwordDialog.passtype = PasswordDialog.Type.LockScreen
            passwordDialog.open()
        }
        wsClient.active = true
    }

}
