import QtQuick
import QtQuick.Controls
import QtWebSockets
import QtQuick.Effects

import "./dialog/"
import "./others/"
import "./websocket/"
import "./button/"
import "./"
import "./js/tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

ApplicationWindow {
    id: root

    title: Application.name + " - " + Application.version
    width: 700
    height: 400
    minimumWidth: 400
    minimumHeight: 250

    visibility: Global.settings.fullscreen ? Window.FullScreen : Window.Windowed

    visible: true

    background: Background {
        bgRadius: 0
    }

    Splash {
        id: splashScreen
        onClosed: {
            if (Global.settings.lockPassword !== "") {
                passwordDialog.passtype = Global.DialogType.PassWordLockScreen;
                passwordDialog.open();
            }
        }
    }

    PasswordDialog {
        id: passwordDialog
        onPasswordEnter: password => {
            switch (passtype) {
            case Global.DialogType.PassWordSettings:
                if ((password === Global.settings.settingPassword) || (password === Global.password)) {
                    settingDialog.open();
                    passwordDialog.close();
                }
                break;
            case Global.DialogType.PassWordLockScreen:
                if ((password === Global.settings.lockPassword) || (password === Global.password)) {
                    passwordDialog.close();
                }
                break;
            }
        }
    }

    SettingDialog {
        id: settingDialog
    }
    ConfirmDialog {
        id: confirmDialog
        onOpenProcessDialog: (operation, name) => {
            processDialog.name = name;
            processDialog.operation = operation;
            processDialog.open();
        }
    }
    Language {
        state: Global.settings.language
    }
    SocketStatus {
        id: webSocketStatus
    }
    ProcessDialog {
        id: processDialog
    }
    MenuDialog {
        id: menuDialog
        webSocketOpened: wsClient.status === WebSocket.Open
        onOpenDialog: type => {
            switch (type) {
            case Global.DialogType.Settings:
                settingDialog.open();
                break;
            case Global.DialogType.Volume:
                volumeDialog.open();
                break;
            case Global.DialogType.PassWordSettings:
                passwordDialog.passtype = Global.DialogType.PassWordSettings;
                passwordDialog.open();
                break;
            }
        }
    }

    WSServer {
        id: wsServer
        port: Global.settings.webSocketServerPort
        listen: Global.settings.webSocketServer ? true : false

        onBinReceived: message => info.text = "Received:" + message
        onTextReceived: message => {
            Tendzone.controlMessageCheck(message);
        }
    }

    WSClient {
        id: wsClient
        onStatusChanged: status => {
            webSocketStatus.state = status;
            switch (status) {
            case WebSocket.Open:
                info.text = "WebSocket Connected";
                Tendzone.runCmd(Tendzone.Command.subHDMIProjector, true);
                Tendzone.runCmd(Tendzone.Command.subHDMIExtend, true);
                Tendzone.runCmd(Tendzone.Command.subPowerParm, true);
                Tendzone.runCmd(Tendzone.Command.subMachineName, true);
                Tendzone.runCmd(Tendzone.Command.subGlobalVolume, true);
                break;
            case WebSocket.Closed:
            case WebSocket.Error:
                info.text = "WebSocket Disconnected";
                socketAnimation.restart();
                wsClient.active = false;
                Global.roomName = qsTr("Unkown");
                break;
            }
        }
    }

    VolumeDialog {
        id: volumeDialog
    }

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
                    return Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss");
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
            Column {
                width: parent.width / 7
                height: parent.height
                leftPadding: width * 0.1
                Image {
                    width: parent.width
                    height: parent.width
                    fillMode: Image.PreserveAspectFit
                    source: Tendzone.Commands_List["Logo"].Url
                    layer.enabled: true
                    layer.samples: 16
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: Global.buttonShadowColor
                        shadowHorizontalOffset: shadowVerticalOffset
                        shadowVerticalOffset: Global.shadowHeight
                    }
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: menuDialog.open()
                    }
                }
            }
            Column {
                id: mainButtonLeft
                width: parent.width / 7 * 3
                height: parent.height
                topPadding: Global.settings.whiteboard ? height * 0.1 : height * 0.4
                spacing: height * 0.1

                MyButton {
                    id: whiteBoard
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                    height: parent.height * 0.35
                    text: qsTr("WhiteBoard")
                    onClicked: Tendzone.startCmds("WhiteBoard", text)
                    visible: Global.settings.whiteboard ? true : false
                    enabled: wsClient.status === WebSocket.Open ? true : false
                    font.pixelSize: height * 0.3
                    icon.source: "qrc:/icons/heiban.svg"
                }
                MyButton {
                    id: systemOn
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                    height: Global.settings.whiteboard ? parent.height * 0.35 : parent.height * 0.5
                    text: qsTr("SystemOn")
                    onClicked: Tendzone.startCmds("SystemOn", text)
                    enabled: wsClient.status === WebSocket.Open ? true : false
                    font.pixelSize: Global.settings.whiteboard ? height * 0.3 : height * 0.25
                    icon.source: "qrc:/icons/touyingji.svg"
                }
            }

            Column {
                id: mainButtonRight
                width: parent.width / 7 * 3
                height: parent.height
                topPadding: height * 0.1
                spacing: height * 0.1
                Row {
                    width: parent.width * 0.9
                    height: parent.height * 0.2
                    Text {
                        id: roomNameLabel
                        horizontalAlignment: Text.AlignRight
                        elide: Text.ElideRight
                        height: parent.height
                        width: wsClient.status === WebSocket.Open ? parent.width : 0
                        font.pixelSize: height * 0.6
                        color: Global.textColor
                        text: Global.roomName
                    }
                    Text {
                        id: roomNameConnect
                        horizontalAlignment: Text.AlignRight
                        elide: Text.ElideRight
                        height: parent.height
                        width: wsClient.status === WebSocket.Open ? 0 : parent.width
                        font.pixelSize: height * 0.6
                        color: Global.textColor
                    }
                }

                MyButton {
                    id: systemOff
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                    height: parent.height * 0.5
                    text: qsTr("System Off")
                    btnColor: Global.warnColor
                    font.pixelSize: height * 0.25
                    onClicked: Tendzone.startCmds("SystemOff", text)
                    enabled: wsClient.status === WebSocket.Open ? true : false
                    icon.source: "qrc:/icons/xiake.svg"
                }
            }
        }

        Rectangle {
            width: parent.width
            height: 2
            color: Global.splitterColor
            Rectangle {
                id: socketStatusProgress
                property real socketValue: 1
                width: parent.width * socketValue
                height: parent.height
                NumberAnimation {
                    id: socketAnimation
                    target: socketStatusProgress
                    property: "socketValue"
                    from: 1
                    to: 0
                    duration: Global.settings.socketError * 1000
                    onFinished: {
                        wsClient.active = true;
                        socketStatusProgress.socketValue = 1;
                    }
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
                    MyButton {
                        id: computer
                        width: Global.settings.wireless ? parent.width * 0.29 : parent.width * 0.4
                        height: parent.height * 0.6
                        text: qsTr("computer")
                        font.pixelSize: Global.settings.wireless ? height * 0.3 : height * 0.35
                        onClicked: Tendzone.startCmds("ProjectorPC", text)
                        enabled: wsClient.status === WebSocket.Open ? true : false
                        checked: Global.projectorHDMI === Tendzone.val_PC
                    }
                    MyButton {
                        id: laptop
                        width: Global.settings.wireless ? parent.width * 0.29 : parent.width * 0.4
                        height: parent.height * 0.6
                        text: qsTr("laptop")
                        font.pixelSize: Global.settings.wireless ? height * 0.3 : height * 0.35
                        onClicked: Tendzone.startCmds("ProjectorLaptop", text)
                        enabled: wsClient.status === WebSocket.Open ? true : false
                        checked: Global.projectorHDMI === Tendzone.val_Laptop
                    }
                    MyButton {
                        id: wireless
                        width: parent.width * 0.29
                        height: parent.height * 0.6
                        font.pixelSize: Global.settings.wireless ? height * 0.3 : height * 0.35
                        text: qsTr("wireless")
                        onClicked: Tendzone.startCmds("ProjectorWireless", text)
                        visible: Global.settings.wireless ? true : false
                        enabled: wsClient.status === WebSocket.Open ? true : false
                        checked: Global.projectorHDMI === Tendzone.val_Wireless
                    }
                }
            }

            Rectangle {
                height: parent.height
                width: 2
                color: Global.splitterColor
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
                    spacing: Global.settings.wireless ? width * 0.05 : width * 0.1
                    MyButton {
                        id: projectorOn
                        width: Global.settings.wireless ? parent.width * 0.42 : parent.width * 0.4
                        height: parent.height * 0.6
                        font.pixelSize: Global.settings.wireless ? height * 0.3 : height * 0.35
                        text: qsTr("turnOn")
                        onClicked: Tendzone.startCmds("ProjectorOn", text)
                        enabled: wsClient.status === WebSocket.Open ? true : false
                    }
                    MyButton {
                        id: projectorOff
                        width: Global.settings.wireless ? parent.width * 0.42 : parent.width * 0.4
                        height: parent.height * 0.6
                        font.pixelSize: Global.settings.wireless ? height * 0.3 : height * 0.35
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
        Application.setVersion("V1.0");
        wsClient.active = true;
    }
}
