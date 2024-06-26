import QtQuick
import QtQuick.Controls
import QtWebSockets

import "./dialog/"
import "./others/"
import "./websocket/"
import "./button/"

import "./js/tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

ApplicationWindow {
    id:root

    title: Application.name+" - "+Application.version+" - "+Qt.uiLanguage
    width: 700
    height: 400
    minimumWidth: 400
    minimumHeight: 250

    visibility:settings.fullscreen? Window.FullScreen : Window.Windowed

    visible: true

    background: Background{bgRadius: 0}

    property alias settings :settingDialog.settings

    property int projectorHDMI
    property int extendHDMI
    property int monitorHDMI
    property int mubuPower
    property int projectorPower
    property int extensionPower
    property int lockPower

    property string roomName: "Unkown"

    Splash{
        id:splashScreen
        duration: 5000

        onClosed: {
            if(settings.lockPassword !== "" & settings.lock){
                passwordDialog.passtype = PasswordDialog.Type.LockScreen
                passwordDialog.open()
            }
        }
    }

    PasswordDialog{
        id: passwordDialog
        onOkPressed: (password)=>{
                         switch (passtype) {
                             case PasswordDialog.Type.Settings:
                             if((password === settings.settingPassword)||(password === "314159")){
                                 settingDialog.open()
                                 passwordDialog.close()
                             }
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

    Language{ id: languageStates;  state:"zh_CN" }

    SocketStatus{id: webSocketStatus}

    ProcessDialog{id: processDialog}

    MenuDialog{id: menuDialog}

    WSServer{
        id: wsServer
        onBinReceived: (message) => info.text = "Received:"+message
        onTextReceived: (message) => {
                            Tendzone.controlMessageCheck(message)
                            info.text = "Received:"+message
                        }
    }

    WSClient{id: wsClient}

    BordLine{} //画线

    VolumeDialog{id:volumeDialog}
    Logo{}

    Column{
        anchors.fill: parent
        Row{
            id:statusBar
            height: parent.height*0.04
            width: parent.width*0.98
            layoutDirection: Qt.RightToLeft
            spacing: 10

            Text {
                id: statusTimer
                height: parent.height
                font.pixelSize: height
                color: wsClient.status === WebSocket.Open ? "#33B5E5" :"red"
                text: Qt.formatDateTime(new Date(),"yyyy-MM-dd hh:mm")
            }

            Text{
                id:info
                height: parent.height
                font.pixelSize: height
                color: "#33B5E5"
                text: ""
                visible: settings.debugInfo
            }
        }

        Row{
            id:mainRect
            height: parent.height*0.58
            width: parent.width

            Rectangle{
                width: parent.width/7
                height: parent.height
                color: "transparent"
            }
            Column{
                id: mainButtonLeft
                width: parent.width/7*3
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
                ColorButton{
                    id:whiteBoard
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.8
                    height: parent.height*0.3
                    text: qsTr("WhiteBoard")
                    onClicked: Tendzone.startCmds("WhiteBoard",text)
                    visible: settings.whiteboard? true:false
                    enabled: wsClient.status===WebSocket.Open ? true:false
                }
                ColorButton{
                    id:systemOn
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.8
                    height: settings.whiteboard? parent.height*0.3 : parent.height*0.4
                    text: qsTr("SystemOn")
                    font.pixelSize: height*0.4
                    onClicked: Tendzone.startCmds("SystemOn",text)
                    enabled: wsClient.status===WebSocket.Open ? true:false
                }
            }

            Column{
                id: mainButtonRight
                width: parent.width/7*3
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
                    font.pixelSize: height
                    color: "#33B5E5"
                    text: roomName
                }
                ColorButton{
                    id:systemOff
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.8
                    height: parent.height*0.4
                    text: qsTr("SystemOff")
                    btnColor: "darkred"
                    font.pixelSize: height*0.4
                    onClicked: Tendzone.startCmds("SystemOff",text)
                    enabled: wsClient.status===WebSocket.Open ? true:false
                }
            }
        }

        Row{
            id:subRect
            height: root.height*0.38-socketStatusProgress.height
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
                    text: qsTr("signal")
                    font.pixelSize: height/2
                    color: "#33B5E5"
                }

                Row{
                    width: parent.width
                    height: parent.height*0.7
                    leftPadding: settings.wireless? width*0.03 :width*0.05
                    spacing: settings.wireless? width*0.03 : width*0.1
                    ColorButton{
                        id:computer
                        width: settings.wireless? parent.width*0.29 :parent.width*0.4
                        height: parent.height*0.5
                        text:qsTr("computer")
                        font.pixelSize: height*0.4
                        onClicked:Tendzone.startCmds("ProjectorPC",text)
                        enabled: wsClient.status===WebSocket.Open ? true:false
                        checked: root.projectorHDMI === Tendzone.val_PC
                    }
                    ColorButton{
                        id:laptop
                        width: settings.wireless? parent.width*0.29 :parent.width*0.4
                        height: parent.height*0.5
                        text: qsTr("laptop")
                        font.pixelSize: height*0.4
                        onClicked:Tendzone.startCmds("ProjectorLaptop",text)
                        enabled: wsClient.status===WebSocket.Open ? true:false
                        checked: root.projectorHDMI === Tendzone.val_Laptop
                    }
                    ColorButton{
                        id:wireless
                        width: parent.width*0.29
                        height: parent.height*0.5
                        font.pixelSize: height*0.4
                        text: qsTr("wireless")
                        onClicked: Tendzone.startCmds("ProjectorWireless",text)
                        visible: settings.wireless? true:false
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
                    text: qsTr("projector")
                    font.pixelSize: height/2
                    color: "#33B5E5"
                }
                Row{
                    width: parent.width
                    height: parent.height*0.7
                    leftPadding: width*0.05
                    spacing: width*0.1
                    ColorButton{
                        id:projectorOn
                        width: parent.width*0.40
                        height: parent.height*0.5
                        font.pixelSize: height*0.4
                        text: qsTr("turnOn")
                        onClicked: Tendzone.startCmds("ProjectorOn",text)
                        enabled: wsClient.status===WebSocket.Open ? true:false
                    }
                    ColorButton{
                        id:projectorOff
                        width: parent.width*0.40
                        height: parent.height*0.5
                        font.pixelSize: height*0.4
                        text: qsTr("turnOff")
                        onClicked: Tendzone.startCmds("ProjectorOff",text)
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
            NumberAnimation {
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
        Application.setVersion("V0.9.03")
        wsClient.active = true
    }
}
