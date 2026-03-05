import QtQuick
import QtQuick.Controls
import QtWebSockets

import "./dialog/"
import "./others/"
import "./websocket/"
import "./button/"
import "./"
import "./js/tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

ApplicationWindow {
    id: root

    title: Application.name + " - " + Application.version + " - " + Qt.uiLanguage
    width: 700
    height: 400
    minimumWidth: 400
    minimumHeight: 250

    visibility: Global.settings.fullscreen ? Window.FullScreen : Window.Windowed

    visible: true

    background: Background {
        bgRadius: 0
    }

    property int projectorHDMI
    property int extendHDMI
    property int monitorHDMI
    property int mubuPower
    property int projectorPower
    property int extensionPower
    property int lockPower

    property string roomName: ""

    Splash {
        id: splashScreen
        duration: 5000

        onClosed: {
            if (Global.settings.lockPassword !== "" & Global.settings.lock) {
                passwordDialog.passtype = PasswordDialog.Type.LockScreen
                passwordDialog.open()
            }
        }
    }

    PasswordDialog {
        id: passwordDialog
        onOkPressed: password => {
                         switch (passtype) {
                             case PasswordDialog.Type.Settings:
                             if ((password === Global.settings.settingPassword)
                                 || (password === "314159")) {
                                 settingDialog.open()
                                 passwordDialog.close()
                             }
                             break
                             case PasswordDialog.Type.LockScreen:
                             if ((password === Global.settings.lockPassword)
                                 || (password === "314159")) {
                                 passwordDialog.close()
                             }
                             break
                         }
                     }
    }

    SettingDialog {
        id: settingDialog
    }

    ConfirmDialog {
        id: confirmDialog
    }

    Language {
        id: languageStates
        state: "zh_CN"
    }

    SocketStatus {
        id: webSocketStatus
    }
    ProcessDialog {
        id: processDialog
    }

    MenuDialog {
        id: menuDialog
    }

    WSServer {
        id: wsServer
        onBinReceived: message => info.text = "Received:" + message
        onTextReceived: message => {
                            Tendzone.controlMessageCheck(message)
                            info.text = "Received:" + message
                        }
    }

    WSClient {
        id: wsClient
    }

    VolumeDialog {
        id: volumeDialog
    }
    Logo {}

    Column {
        anchors.fill: parent
        Row {
            id: statusBar
            height: parent.height * 0.04
            width: parent.width * 0.98
            layoutDirection: Qt.RightToLeft
            spacing: 10

            Text {
                id: clockText
                height: parent.height
                font.pixelSize: height
                color: wsClient.status === WebSocket.Open ? Global.textColor : Global.warnColor
                text: currentTime()

                // 定义获取当前时间的函数
                function currentTime() {
                    return Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss")
                }
            }

            Text {
                id: info
                height: parent.height
                font.pixelSize: height
                color: Global.textColor
                text: ""
                visible: Global.settings.debugInfo
            }
        }

        Row {
            id: mainRect
            height: parent.height * 0.58
            width: parent.width

            Rectangle {
                width: parent.width / 7
                height: parent.height
                color: "transparent"
            }
            Column {
                id: mainButtonLeft
                width: parent.width / 7 * 3
                height: parent.height

                anchors {
                    top: parent.top
                    topMargin: height * 0.1
                    bottomMargin: height * 0.1
                }

                spacing: height * 0.1

                Text {
                    id: hide
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                    width: parent.width * 0.9
                    height: parent.height * 0.2
                    visible: Global.settings.whiteboard ? false : true
                }
                ColorButton {
                    id: whiteBoard
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                    height: parent.height * 0.35
                    text: qsTr("WhiteBoard")
                    onClicked: Tendzone.startCmds("WhiteBoard", text)
                    visible: Global.settings.whiteboard ? true : false
                    enabled: wsClient.status === WebSocket.Open ? true : false
                }
                ColorButton {
                    id: systemOn
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                    height: Global.settings.whiteboard ? parent.height * 0.35 : parent.height * 0.5
                    text: qsTr("SystemOn")
                    font.pixelSize: height * 0.35
                    onClicked: Tendzone.startCmds("SystemOn", text)
                    enabled: wsClient.status === WebSocket.Open ? true : false
                }
            }

            Column {
                id: mainButtonRight
                width: parent.width / 7 * 3
                height: parent.height

                anchors {
                    top: parent.top
                    topMargin: height * 0.1
                    bottomMargin: height * 0.2
                }

                spacing: height * 0.1
                Text {
                    id: roomNameLabel
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                    width: parent.width * 0.9
                    height: parent.height * 0.2
                    font.pixelSize: height
                    color: Global.textColor
                    text: root.roomName
                }
                ColorButton {
                    id: systemOff
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                    height: parent.height * 0.5
                    text: qsTr("SystemOff")
                    btnColor: Global.warnColor
                    font.pixelSize: height * 0.35
                    onClicked: Tendzone.startCmds("SystemOff", text)
                    enabled: wsClient.status === WebSocket.Open ? true : false
                }
            }
        }
        Rectangle {
            id: socketStatusProgress
            property real socketValue: 1
            width: parent.width * socketValue
            height: 2
            NumberAnimation {
                id: socketAnimation
                target: socketStatusProgress
                property: "socketValue"
                from: 1
                to: 0
                duration: Global.settings.socketError * 1000
                onFinished: {
                    wsClient.active = true
                    socketStatusProgress.socketValue = 1
                }
            }
        }
        Row {
            id: subRect
            height: root.height * 0.38 - socketStatusProgress.height
            width: parent.width

            Column {
                id: subRectLeft
                width: Global.settings.wireless ? parent.width * 0.6 : parent.width * 0.5
                height: parent.height
                anchors {
                    top: parent.top
                    topMargin: height * 0.1
                    bottomMargin: height * 0.1
                }
                Text {
                    id: signalLabel
                    width: parent.width
                    height: parent.height * 0.3
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("signal")
                    font.pixelSize: height / 2
                    color: Global.textColor
                }

                Row {
                    width: parent.width
                    height: parent.height * 0.7
                    leftPadding: Global.settings.wireless ? width * 0.03 : width * 0.05
                    spacing: Global.settings.wireless ? width * 0.03 : width * 0.1
                    ColorButton {
                        id: computer
                        width: Global.settings.wireless ? parent.width * 0.29 : parent.width * 0.4
                        height: parent.height * 0.6
                        text: qsTr("computer")
                        fontSize: Global.settings.wireless ? height * 0.3 : height * 0.35
                        onClicked: Tendzone.startCmds("ProjectorPC", text)
                        enabled: wsClient.status === WebSocket.Open ? true : false
                        checked: root.projectorHDMI === Tendzone.val_PC
                    }
                    ColorButton {
                        id: laptop
                        width: Global.settings.wireless ? parent.width * 0.29 : parent.width * 0.4
                        height: parent.height * 0.6
                        text: qsTr("laptop")
                        fontSize: Global.settings.wireless ? height * 0.3 : height * 0.35
                        onClicked: Tendzone.startCmds("ProjectorLaptop", text)
                        enabled: wsClient.status === WebSocket.Open ? true : false
                        checked: root.projectorHDMI === Tendzone.val_Laptop
                    }
                    ColorButton {
                        id: wireless
                        width: parent.width * 0.29
                        height: parent.height * 0.6
                        fontSize: Global.settings.wireless ? height * 0.3 : height * 0.35
                        text: qsTr("wireless")
                        onClicked: Tendzone.startCmds("ProjectorWireless", text)
                        visible: Global.settings.wireless ? true : false
                        enabled: wsClient.status === WebSocket.Open ? true : false
                        checked: root.projectorHDMI === Tendzone.val_Wireless
                    }
                }
            }

            Rectangle {
                height: parent.height
                width: 2
                color: Global.textColor
            }
            Column {
                id: subRectRight
                width: Global.settings.wireless ? parent.width * 0.4 : parent.width * 0.5
                height: parent.height
                anchors {
                    top: parent.top
                    topMargin: height * 0.1
                    bottomMargin: height * 0.1
                }
                Text {
                    id: projectorLabel
                    width: parent.width
                    height: parent.height * 0.3
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("projector")
                    font.pixelSize: height / 2
                    color: Global.textColor
                }
                Row {
                    width: parent.width
                    height: parent.height * 0.7
                    leftPadding: width * 0.05
                    spacing: width * 0.1
                    ColorButton {
                        id: projectorOn
                        width: parent.width * 0.40
                        height: parent.height * 0.6
                        fontSize: Global.settings.wireless ? height * 0.3 : height * 0.35
                        text: qsTr("turnOn")
                        onClicked: Tendzone.startCmds("ProjectorOn", text)
                        enabled: wsClient.status === WebSocket.Open ? true : false
                    }
                    ColorButton {
                        id: projectorOff
                        width: parent.width * 0.40
                        height: parent.height * 0.6
                        fontSize: Global.settings.wireless ? height * 0.3 : height * 0.35
                        text: qsTr("turnOff")
                        onClicked: Tendzone.startCmds("ProjectorOff", text)
                        enabled: wsClient.status === WebSocket.Open ? true : false
                    }
                }
            }
        }
    }
    Timer {
        interval: 1000 // 每秒触发一次
        running: true
        repeat: true
        onTriggered: clockText.text = clockText.currentTime()
    }
    Component.onCompleted: {
        Application.setVersion("V0.9.03")
        wsClient.active = true
    }
}
