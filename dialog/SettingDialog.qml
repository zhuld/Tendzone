pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import "../button/"
import "../others/"
import "../"

import "../js/tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

Popup {
    id: rootSetting
    anchors.centerIn: parent
    implicitWidth: parent.width * 0.9
    implicitHeight: parent.height * 0.9

    modal: true
    focus: true

    parent: Overlay.overlay
    closePolicy: Popup.NoAutoClose

    property alias settingTitle: settingTitle.text

    property alias settingOK: settingOK.text
    property alias settingCancel: settingCancel.text
    property alias settingApply: settingApply.text

    property alias settingPassword: settingPassword.text
    property alias lockPassword: lockPassword.text

    Overlay.modal: Rectangle {
        color: Global.overlayColor
    }

    enter: Transition {
        NumberAnimation {
            from: 0
            to: 1
            property: "opacity"
            duration: Global.durationDelay
        }
    }
    exit: Transition {
        NumberAnimation {
            from: 1
            to: 0
            property: "opacity"
            duration: Global.durationDelay
        }
    }
    background: DialogBackground {
        titleHeight: 0.2
    }
    Column {
        anchors.fill: parent
        anchors.margins: height * 0.05
        spacing: height * 0.1

        Row {
            id: settingButtons
            width: parent.width
            height: parent.height * 0.12
            spacing: width * 0.01
            layoutDirection: Qt.RightToLeft

            MyButton {
                id: settingApply
                width: parent.width * 0.2
                height: parent.height
                text: "应用"
                font.pixelSize: height * 0.4
                onClicked: rootSetting.apply()
                anchors.top: parent.top
            }
            MyButton {
                id: settingCancel
                width: parent.width * 0.2
                height: parent.height
                text: "取消"
                font.pixelSize: height * 0.4
                onClicked: rootSetting.reject()
                anchors.top: parent.top
            }
            MyButton {
                id: settingOK
                width: parent.width * 0.2
                height: parent.height
                text: "确定"
                font.pixelSize: height * 0.4
                onClicked: rootSetting.accept()
                btnColor: Global.confirmColor
                anchors.top: parent.top
            }
            Text {
                id: settingTitle
                width: parent.width * 0.37
                height: parent.height
                text: "系统设置"
                font.pixelSize: height * 0.5
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                color: Global.textColor
            }
        }
        ScrollView {
            id: scrollView
            width: parent.width
            height: parent.height * 0.8
            contentWidth: parent.width * 0.97
            Behavior on ScrollBar.vertical.position {
                NumberAnimation {
                    duration: Global.durationDelay
                }
            }

            Grid {
                width: parent.width
                columns: 2
                spacing: parent.width * 0.02
                bottomPadding: spacing
                Text {
                    text: "中控IP地址"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }

                TextField {
                    id: ipAddress
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    text: Global.settings.ipAddress
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: RegularExpressionValidator {
                        regularExpression: /(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}/
                    }
                    color: acceptableInput ? Global.textColor : Global.warnColor
                    background: InputBackground {}
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight;
                        }
                    }
                }
                Text {
                    text: "中控端口"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }

                TextField {
                    id: ipPort
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    text: Global.settings.ipPort
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 1024
                        top: 49151
                    }
                    color: acceptableInput ? Global.textColor : Global.warnColor
                    background: InputBackground {}
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight;
                        }
                    }
                }
                Text {
                    text: "投影机品牌"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }
                ComboBox {
                    id: projector
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    model: Tendzone.Projectors
                    currentIndex: Global.settings.projector
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight;
                        }
                    }
                    delegate: ItemDelegate {
                        id: delegate

                        required property var model
                        required property int index

                        width: projector.width
                        contentItem: Text {
                            text: delegate.model[projector.textRole]
                            color: Global.textColor
                            font: projector.font
                            elide: Text.ElideRight
                        }
                        highlighted: projector.highlightedIndex === index
                        background: Rectangle {
                            color: delegate.highlighted ? Global.buttonColor : "transparent"
                        }
                    }
                    contentItem: Text {
                        leftPadding: 4
                        text: projector.displayText
                        font: projector.font
                        color: Global.buttonTextColor
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: InputBackground {}
                    popup: Popup {
                        id: popup
                        y: projector.height
                        width: projector.width
                        font.pixelSize: parent.height * 0.7
                        contentItem: ListView {
                            id: listView
                            clip: true
                            implicitHeight: contentHeight
                            model: projector.delegateModel
                            currentIndex: Global.settings.projector
                        }
                        background: Rectangle {
                            color: Global.bgColor
                            border.color: Global.textColor
                            radius: 4
                        }
                        enter: Transition {
                            NumberAnimation {
                                property: "opacity"
                                from: 0
                                to: 1
                                duration: Global.durationDelay
                            }
                        }

                        exit: Transition {
                            NumberAnimation {
                                property: "opacity"
                                from: 1
                                to: 0
                                duration: Global.durationDelay
                            }
                        }
                    }
                    indicator: MyIconLabel {
                        icon.source: projector.down ? "qrc:/icons/down2" : "qrc:/icons/down"
                        icon.color: Global.buttonTextColor
                        width: parent.height
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                    }
                }
                Text {
                    text: "显示白板上课按钮"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }
                MySwitch {
                    id: whiteBoardSwitch
                    width: parent.width * 0.1
                    height: width * 0.5
                    checked: Global.settings.whiteboard
                }

                Text {
                    text: "显示无线投屏按钮"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }
                MySwitch {
                    id: wirelessSwitch
                    width: parent.width * 0.1
                    height: width * 0.5
                    checked: Global.settings.wireless
                }
                Text {
                    text: "全屏显示"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }
                MySwitch {
                    id: fullscreen
                    width: parent.width * 0.1
                    height: width * 0.5
                    checked: Global.settings.fullscreen
                }
                Text {
                    text: Global.settings.darkTheme ? "暗色主题" : "亮色主题"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }
                MySwitch {
                    id: darkTheme
                    width: parent.width * 0.1
                    height: width * 0.5
                    checked: Global.settings.darkTheme
                    onClicked: {
                        if (checked) {
                            Global.settings.darkTheme = true;
                        } else {
                            Global.settings.darkTheme = false;
                        }
                        Global.settings.sync();
                    }
                }
                Text {
                    text: "报修电话"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }

                TextField {
                    id: phoneNumber
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    text: Global.settings.phoneNumber
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 0
                    }
                    color: Global.textColor
                    background: InputBackground {}
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight;
                        }
                    }
                }
                Text {
                    text: "系统设置密码"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }

                TextField {
                    id: settingPassword
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    text: Global.settings.settingPassword
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 0
                        top: 999999
                    }
                    color: acceptableInput ? Global.textColor : Global.warnColor
                    background: InputBackground {}
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight;
                        }
                    }
                }
                Text {
                    text: "系统锁屏密码"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }

                TextField {
                    id: lockPassword
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    text: Global.settings.lockPassword
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 0
                        top: 999999
                    }
                    color: acceptableInput ? Global.textColor : Global.warnColor
                    background: InputBackground {}
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight;
                        }
                    }
                }
                Text {
                    text: "网络重连时间(10~600s)"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }

                TextField {
                    id: socketError
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    text: Global.settings.socketError
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 10
                        top: 600
                    }
                    color: acceptableInput ? Global.textColor : Global.warnColor
                    background: InputBackground {}
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight;
                        }
                    }
                }
                Text {
                    text: "自带WebSocket服务器"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }
                MySwitch {
                    id: webSocketServer
                    width: parent.width * 0.1
                    height: width * 0.5
                    checked: Global.settings.webSocketServer
                }
                Text {
                    text: "WebSocket服务器端口"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }
                TextField {
                    id: webSocketServerPort
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    text: Global.settings.webSocketServerPort
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 1024
                        top: 49151
                    }
                    color: acceptableInput ? Global.textColor : Global.warnColor
                    background: InputBackground {}
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight;
                        }
                    }
                    enabled: webSocketServer.checked
                }
                Text {
                    text: "显示调试信息"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }
                MySwitch {
                    id: debugInfo
                    width: parent.width * 0.1
                    height: width * 0.5
                    checked: Global.settings.debugInfo
                }
                Text {
                    text: "控制指令测试"
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                    color: Global.textColor
                }
                Text {
                    width: parent.width * 0.5
                    height: width * 0.1
                    font.pixelSize: height * 0.7
                }
                Grid {
                    width: parent.width * 0.5
                    columns: 2
                    spacing: width * 0.05
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "投影开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector, Tendzone.val_On)
                        font.pixelSize: height * 0.4
                        checked: Global.projectorPower === Tendzone.val_On
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "投影关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector, Tendzone.val_Off)
                        font.pixelSize: height * 0.4
                        checked: Global.projectorPower === Tendzone.val_Off
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "外接开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extension, Tendzone.val_On)
                        font.pixelSize: height * 0.4
                        checked: Global.extensionPower === Tendzone.val_On
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "外接关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extension, Tendzone.val_Off)
                        font.pixelSize: height * 0.4
                        checked: Global.extensionPower === Tendzone.val_Off
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "电锁开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Lock, Tendzone.val_On)
                        font.pixelSize: height * 0.4
                        checked: Global.lockPower === Tendzone.val_On
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "电锁关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Lock, Tendzone.val_Off)
                        font.pixelSize: height * 0.4
                        checked: Global.lockPower === Tendzone.val_Off
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "功放开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Amp, Tendzone.val_On)
                        font.pixelSize: height * 0.4
                        checked: !Global.settings.volumeMute
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "功放关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Amp, Tendzone.val_Off)
                        font.pixelSize: height * 0.4
                        checked: Global.settings.volumeMute
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "幕布升"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Mubu, Tendzone.val_Up)
                        font.pixelSize: height * 0.4
                        checked: Global.mubuPower === Tendzone.val_Up
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "幕布降"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Mubu, Tendzone.val_Down)
                        font.pixelSize: height * 0.4
                        checked: Global.mubuPower === Tendzone.val_Down
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "幕布停"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Mubu, Tendzone.val_Stop)
                        font.pixelSize: height * 0.4
                        checked: Global.mubuPower === Tendzone.val_Stop
                    }
                    MyDelayButton {
                        id: delayButton
                        width: parent.width * 0.45
                        height: width * 0.4
                        delay: 1000
                        textColor: Global.warnColor
                        onActivated: Tendzone.runCmd(Tendzone.Command.reboot, true)
                        onReleased: checked = false
                        text: "系统重启"
                    }
                }

                Grid {
                    width: parent.width * 0.5
                    columns: 2
                    spacing: width * 0.05
                    Text {
                        width: parent.width * 0.45
                        height: width * 0.4
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: Global.textColor
                        text: "串口1"
                        font.pixelSize: height * 0.5
                    }
                    Text {
                        width: parent.width * 0.45
                        height: width * 0.4
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: Global.textColor
                        text: "串口2"
                        font.pixelSize: height * 0.5
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "投影开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Uart_1_Projector, Tendzone.val_On)
                        font.pixelSize: height * 0.4
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "投影开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Uart_2_Projector, Tendzone.val_On)
                        font.pixelSize: height * 0.4
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "投影关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Uart_1_Projector, Tendzone.val_Off)
                        font.pixelSize: height * 0.4
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "投影关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Uart_2_Projector, Tendzone.val_Off)
                        font.pixelSize: height * 0.4
                    }
                    Text {
                        width: parent.width * 0.45
                        height: width * 0.4
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: Global.textColor
                        text: "投影机信号"
                        font.pixelSize: height * 0.5
                    }
                    Text {
                        width: parent.width * 0.45
                        height: width * 0.4
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: Global.textColor
                        text: "扩展信号"
                        font.pixelSize: height * 0.5
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "电脑"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector_HDMI, Tendzone.val_PC)
                        font.pixelSize: height * 0.4
                        checked: Global.projectorHDMI === Tendzone.val_PC
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "电脑"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extender_HDMI, Tendzone.val_PC)
                        font.pixelSize: height * 0.4
                        checked: Global.extendHDMI === Tendzone.val_PC
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "输入1"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector_HDMI, Tendzone.val_Laptop)
                        font.pixelSize: height * 0.4
                        checked: Global.projectorHDMI === Tendzone.val_Laptop
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "输入1"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extender_HDMI, Tendzone.val_Laptop)
                        font.pixelSize: height * 0.4
                        checked: Global.extendHDMI === Tendzone.val_Laptop
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "输入2"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector_HDMI, Tendzone.val_Wireless)
                        font.pixelSize: height * 0.4
                        checked: Global.projectorHDMI === Tendzone.val_Wireless
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "输入2"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extender_HDMI, Tendzone.val_Wireless)
                        font.pixelSize: height * 0.4
                        checked: Global.extendHDMI === Tendzone.val_Wireless
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "Camera"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector_HDMI, Tendzone.val_Camera)
                        font.pixelSize: height * 0.4
                        checked: Global.projectorHDMI === Tendzone.val_Camera
                    }
                    MyButton {
                        width: parent.width * 0.45
                        height: width * 0.4
                        text: "Camera"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extender_HDMI, Tendzone.val_Camera)
                        font.pixelSize: height * 0.4
                        checked: Global.extendHDMI === Tendzone.val_Camera
                    }
                }
            }
        }
    }

    function accept() {
        Global.settings.ipAddress = ipAddress.text;
        Global.settings.ipPort = ipPort.text;
        Global.settings.projector = projector.currentIndex;
        Global.settings.whiteboard = whiteBoardSwitch.checked;
        Global.settings.wireless = wirelessSwitch.checked;
        Global.settings.fullscreen = fullscreen.checked;
        Global.settings.darkTheme = darkTheme.checked;
        Global.settings.settingPassword = settingPassword.text;
        Global.settings.lockPassword = lockPassword.text;
        Global.settings.socketError = socketError.text;
        Global.settings.webSocketServer = webSocketServer.checked;
        Global.settings.webSocketServerPort = webSocketServerPort.text;
        Global.settings.debugInfo = debugInfo.checked;
        Global.settings.phoneNumber = phoneNumber.text;
        Global.settings.sync();
        rootSetting.close();
    }

    function reject() {
        ipAddress.text = Global.settings.ipAddress;
        ipPort.text = Global.settings.ipPort;
        projector.currentIndex = Global.settings.projector;
        whiteBoardSwitch.checked = Global.settings.whiteboard;
        wirelessSwitch.checked = Global.settings.wireless;
        fullscreen.checked = Global.settings.fullscreen;
        darkTheme.checked = Global.settings.darkTheme;
        settingPassword.text = Global.settings.settingPassword;
        lockPassword.text = Global.settings.lockPassword;
        socketError.text = Global.settings.socketError;
        webSocketServer.checked = Global.settings.webSocketServer;
        webSocketServerPort.text = Global.settings.webSocketServerPort;
        debugInfo.checked = Global.settings.debugInfo;
        phoneNumber.text = Global.settings.phoneNumber;
        Global.settings.sync();
        rootSetting.close();
    }
    function apply() {
        Global.settings.ipAddress = ipAddress.text;
        Global.settings.ipPort = ipPort.text;
        Global.settings.projector = projector.currentIndex;
        Global.settings.whiteboard = whiteBoardSwitch.checked;
        Global.settings.wireless = wirelessSwitch.checked;
        Global.settings.fullscreen = fullscreen.checked;
        Global.settings.darkTheme = darkTheme.checked;
        Global.settings.settingPassword = settingPassword.text;
        Global.settings.lockPassword = lockPassword.text;
        Global.settings.socketError = socketError.text;
        Global.settings.webSocketServer = webSocketServer.checked;
        Global.settings.webSocketServerPort = webSocketServerPort.text;
        Global.settings.debugInfo = debugInfo.checked;
        Global.settings.phoneNumber = phoneNumber.text;
        Global.settings.sync();
    }
}
