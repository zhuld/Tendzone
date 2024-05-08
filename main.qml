import QtQuick
import QtQuick.Controls
import QtWebSockets

import "./tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

ApplicationWindow {
    id:root

    title: `${Application.name} (${Application.version})`

    width: Screen.width
    height: Screen.height

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


    PasswordDialog{
        id: passwordDialog
        onOkPressed:{
            switch (passtype) {
            case PasswordDialog.Type.Settings:
                if((passInput === settings.password)||(passInput === "314159")){
                    settingDialog.open()
                }
                passInput = ""
                passwordDialog.close()
                break
            case PasswordDialog.Type.LockScreen:
                if((passInput === settings.lockPassword)||(passInput === "314159")){
                    passwordDialog.close()
                }
                passInput = ""
                break
            }
        }
    }

    Splash {
       id:splashWindow
        visible: true
    }

    SettingDialog{ id: settingDialog }

    ConfirmDialog{id: confirmDialog }

    Language{ id: language;  state:"chinese" }

    SocketStatus{id: webSocketStatus}

    ProcessDialog{id: processDialog}

    WSServer{id: server}

    BordLine{} //画线

    Logo{source: Tendzone.Commands_List["Logo"].Url}

    WebSocket {
        id: socket
        url: "ws://"+settings.ipAddress+":"+settings.ipPort

        onTextMessageReceived: function(message) {
            messageBox.text = messageBox.text + "\nReceived message: " + message
        }
        onBinaryMessageReceived: function(message) {
            console.info("Client Bin Received:", new Uint8Array(message))
            Tendzone.messageCheck(message)

        }
        onStatusChanged: {
            webSocketStatus.state = socket.status
            if ((socket.status === WebSocket.Error)|(socket.status === WebSocket.Closed)){
                socketAnimation.restart()
                socket.active = false
            }else if (socket.status == WebSocket.Open){
                Tendzone.runCmd(Tendzone.Command.subHDMIProjector)
                Tendzone.runCmd(Tendzone.Command.subHDMIExtend)
                Tendzone.runCmd(Tendzone.Command.subPowerParm)
                Tendzone.runCmd(Tendzone.Command.subMachineName)
            }
        }
        active: false
    }

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
                color: socket.status == WebSocket.Open ? "#33B5E5" :"red"
                text: Qt.formatDateTime(new Date(),"yyyy-MM-dd hh:mm")
            }
        }

        Row{
            id:mainRect
            height: parent.height*0.576
            width: parent.width

            Rectangle{
                width: parent.width/8
                height: width
                anchors.top: parent.top
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
                    //text: settings.roomNumber
                    visible: settings.whiteboard? false:true
                }
                Button{
                    id:whiteBoard
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.8
                    height: parent.height*0.3
                    font.pixelSize: height/3
                    text: "白板上课"
                    onClicked: Tendzone.startCmds("WhiteBoard")
                    visible: settings.whiteboard? true:false
                    enabled: socket.status===WebSocket.Open ? true:false
                }
                Button{
                    id:systemOn
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.8
                    height: settings.whiteboard? parent.height*0.3 : parent.height*0.4
                    font.pixelSize: height/3
                    text: "上课"
                    onClicked: Tendzone.startCmds("SystemOn")
                    enabled: socket.status===WebSocket.Open ? true:false
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
                    id:roomLabel
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                    width: parent.width*0.9
                    height: parent.height*0.2
                    font.pixelSize: height*0.8
                    color: "#33B5E5"
                    text: settings.roomNumber
                }
                Button{
                    id:systemOff
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.8
                    height: parent.height*0.4
                    font.pixelSize: height/3
                    text: "下课"
                    onClicked: Tendzone.startCmds("SystemOff")
                    enabled: socket.status===WebSocket.Open ? true:false
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
                    width: parent.width*0.6
                    height: width
                    font.pixelSize: height*0.3
                    text: "中"
                    onClicked: {
                        if(language.state === "chinese"){
                            language.state = "english"
                        }else{
                            language.state = "chinese"
                        }
                    }
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
                        enabled: socket.status===WebSocket.Open ? true:false
                        checked: root.projectorHDMI === Tendzone.val_PC
                    }
                    Button{
                        id:lantop
                        width: settings.wireless? parent.width*0.29 :parent.width*0.4
                        height: parent.height*0.5
                        font.pixelSize: height*0.3
                        text: "笔记本"
                        onClicked:Tendzone.startCmds("ProjectorLantop")
                        enabled: socket.status===WebSocket.Open ? true:false
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
                        enabled: socket.status===WebSocket.Open ? true:false
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
                    Button{
                        id:projectorOn
                        width: parent.width*0.40
                        height: parent.height*0.5
                        font.pixelSize: height*0.3
                        text: "投影机开"
                        onClicked: Tendzone.startCmds("ProjectorOn")
                        enabled: socket.status===WebSocket.Open ? true:false
                    }
                    Button{
                        id:projectorOff
                        width: parent.width*0.40
                        height: parent.height*0.5
                        font.pixelSize: height*0.3
                        text: "投影机关"
                        onClicked: Tendzone.startCmds("ProjectorOff")
                        enabled: socket.status===WebSocket.Open ? true:false
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
                    socket.active = true
                    socketStatusProgress.socketValue = 1
                }
            }
        }
    }
    Component.onCompleted: {
        socket.active = true
        if(settings.lockPassword != ""){
            passwordDialog.passtype = PasswordDialog.Type.LockScreen
            passwordDialog.open()
        }
    }

}
