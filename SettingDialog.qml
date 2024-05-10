import QtQuick
import QtQuick.Controls
import QtCore

import "./tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

Dialog {
    id:rootSetting
    anchors.centerIn: parent
    implicitWidth: parent.width*0.9
    implicitHeight: parent.height*0.9

    modal: true;
    closePolicy: Popup.NoAutoClose

    property alias settings: settings
    property alias settingTitle: settingTitle.text

    property alias settingOK: settingOK.text
    property alias settingCancel: settingCancel.text
    property alias settingApply: settingApply.text

    Settings{
        id:settings
        property string roomNumber: "101"
        property bool autoRoomNumber:true
        property string ipAddress: "192.168.1.1"
        property string ipPort: "9880"
        property int projector: 0
        property bool whiteboard: true
        property bool wireless: true
        property bool fullscreen: true
        property string password: ""
        property string lockPassword: "123"
        property int socketError: 30
        property bool webSocketServer: false
        property bool debugInfo: false
        property string phoneNumber: ""
        property int volume: -10
    }

    Overlay.modal: Rectangle{
        color:"#A0000000"
    }

    enter: Transition {
        NumberAnimation{
            from: 0
            to: 1
            property: "opacity"
            duration: 200
        }
    }
    exit: Transition {
        NumberAnimation{
            from: 1
            to: 0
            property: "opacity"
            duration: 200
        }
    }

    Column{
        anchors.fill: parent
        anchors.margins: height*0.05
        spacing: height*0.05
        Text {
            id:settingTitle
            width: parent.width
            height: parent.height*0.1
            text: "系统设置"
            font.pixelSize: height*0.8
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            color: "#33B5E5"
        }
        ScrollView{
            width: parent.width
            height: parent.height*0.7
            contentWidth: parent.width*0.9
            contentHeight: Grid.height
            anchors.margins: height/20
            Grid{
                width: parent.width
                columns:  2
                spacing: parent.parent.height*0.05

                Text {
                    text: "房间名称"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }
                TextField{
                    id:roomNumber
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    text: settings.roomNumber
                    enabled: !autoRoomNumber.checked
                }
                Text {
                    text: "自动获取"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }
                Switch{
                    id:autoRoomNumber
                    checked: settings.autoRoomNumber
                }
                Text {
                    text: "中控IP地址"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }

                TextField{
                    id:ipAddress
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    text: settings.ipAddress
                    //color: "#33B5E5"
                }
                Text {
                    text: "中控端口"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }

                TextField{
                    id:ipPort
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    text: settings.ipPort
                }

                Text {
                    text: "投影机品牌"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }
                ComboBox{
                    id:projector
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    model: Tendzone.Projectors
                    currentIndex: settings.projector
                    popup: Popup {
                        y: projector.height
                        width: projector.width
                        font.pixelSize: parent.font.pixelSize
                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight
                            model: projector.popup.visible ? projector.delegateModel : null
                            currentIndex: settings.projector
                        }
                    }
                }
                Text {
                    text: "显示白板上课按钮"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }
                Switch{
                    id:whiteBoardSwitch
                    checked: settings.whiteboard
                }

                Text {
                    text: "显示无线投屏按钮"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }
                Switch{
                    id:wirelessSwitch
                    checked: settings.wireless
                }
                Text {
                    text: "全屏显示"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }
                Switch{
                    id:fullscreen
                    checked: settings.fullscreen
                }

                Text {
                    text: "报修电话"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }

                TextField{
                    id:phoneNumber
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    text: settings.phoneNumber
                    //color: "#33B5E5"
                }
                Text {
                    text: "系统设置密码"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }

                TextField{
                    id:password
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    text: settings.password
                    //color: "#33B5E5"
                }
                Text {
                    text: "系统锁屏密码"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }

                TextField{
                    id:lockPassword
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    text: settings.lockPassword
                    //color: "#33B5E5"
                }
                Text {
                    text: "网络重连时间"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }

                TextField{
                    id:socketError
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    text: settings.socketError
                    //color: "#33B5E5"
                    validator: IntValidator {bottom: 5; top: 2000;}
                }
                Text {
                    text: "自带WebSocket服务器"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }
                Switch{
                    id:webSocketServer
                    checked: settings.webSocketServer
                }
                Text {
                    text: "显示调试信息"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }
                Switch{
                    id:debugInfo
                    checked: settings.debugInfo
                }
                Text {
                    text: "控制指令测试"
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                    color: "#33B5E5"
                }
                Text {
                    width: parent.width*0.5
                    height: settingDialog.height/12
                    font.pixelSize: height*0.7
                }
                Grid{
                    width: parent.width*0.5
                    columns: 2
                    spacing: width*0.05
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "投影开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector, Tendzone.val_On)
                        font.pixelSize: height*0.4
                        checked: root.projectorPower === Tendzone.val_On
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "投影关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector, Tendzone.val_Off)
                        font.pixelSize: height*0.4
                        checked: root.projectorPower === Tendzone.val_Off
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "外接开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extension, Tendzone.val_On)
                        font.pixelSize: height*0.4
                        checked: root.extensionPower === Tendzone.val_On
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "外接关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extension, Tendzone.val_Off)
                        font.pixelSize: height*0.4
                        checked: root.extensionPower === Tendzone.val_Off
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "电锁开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Lock, Tendzone.val_On)
                        font.pixelSize: height*0.4
                        checked: root.lockPower === Tendzone.val_On
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "电锁关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Lock, Tendzone.val_Off)
                        font.pixelSize: height*0.4
                        checked: root.lockPower === Tendzone.val_Off
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "功放开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Amp, Tendzone.val_On)
                        font.pixelSize: height*0.4
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "功放关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Amp, Tendzone.val_Off)
                        font.pixelSize: height*0.4
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "幕布升"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Mubu, Tendzone.val_Up)
                        font.pixelSize: height*0.4
                        checked: root.mubuPower === Tendzone.val_Up
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "幕布降"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Mubu, Tendzone.val_Down)
                        font.pixelSize: height*0.4
                        checked: root.mubuPower === Tendzone.val_Down
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "幕布停"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Mubu, Tendzone.val_Stop)
                        font.pixelSize: height*0.4
                        checked: root.mubuPower === Tendzone.val_Stop
                    }
                    DelayButton{
                        width: parent.width*0.45
                        height: width*0.4
                        delay: 1000
                        Text {
                            text: "系统重启"
                            color: "red"
                            font.pixelSize: parent.height*0.4
                            anchors.centerIn: parent
                        }
                        onActivated: Tendzone.runCmd(Tendzone.Command.reboot, null)
                        onReleased: checked = false
                    }
                }

                Grid{
                    width: parent.width*0.5
                    columns: 2
                    spacing: width*0.05
                    Text {
                        width: parent.width*0.45
                        height: width*0.4
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "#33B5E5"
                        text: "串口1"
                        font.pixelSize: height*0.5
                    }
                    Text {
                        width: parent.width*0.45
                        height: width*0.4
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "#33B5E5"
                        text: "串口2"
                        font.pixelSize: height*0.5
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "投影开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Uart_1_Projector, Tendzone.val_On)
                        font.pixelSize: height*0.4
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "投影开"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Uart_2_Projector, Tendzone.val_On)
                        font.pixelSize: height*0.4
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "投影关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Uart_1_Projector, Tendzone.val_Off)
                        font.pixelSize: height*0.4
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "投影关"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Uart_2_Projector, Tendzone.val_Off)
                        font.pixelSize: height*0.4
                    }
                    Text {
                        width: parent.width*0.45
                        height: width*0.4
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "#33B5E5"
                        text: "投影机信号"
                        font.pixelSize: height*0.5
                    }
                    Text {
                        width: parent.width*0.45
                        height: width*0.4
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "#33B5E5"
                        text: "扩展信号"
                        font.pixelSize: height*0.5
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "电脑"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector_HDMI, Tendzone.val_PC)
                        font.pixelSize: height*0.4
                        checked: root.projectorHDMI === Tendzone.val_PC
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "电脑"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extender_HDMI, Tendzone.val_PC)
                        font.pixelSize: height*0.4
                        checked: root.extendHDMI === Tendzone.val_PC
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "输入1"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector_HDMI, Tendzone.val_Laptop)
                        font.pixelSize: height*0.4
                        checked: root.projectorHDMI === Tendzone.val_Laptop
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "输入1"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extender_HDMI, Tendzone.val_Laptop)
                        font.pixelSize: height*0.4
                        checked: root.extendHDMI === Tendzone.val_Laptop
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "输入2"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector_HDMI, Tendzone.val_Wireless)
                        font.pixelSize: height*0.4
                        checked: root.projectorHDMI === Tendzone.val_Wireless
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "输入2"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extender_HDMI, Tendzone.val_Wireless)
                        font.pixelSize: height*0.4
                        checked: root.extendHDMI === Tendzone.val_Wireless
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "Camera"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Projector_HDMI, Tendzone.val_Camera)
                        font.pixelSize: height*0.4
                        checked: root.projectorHDMI === Tendzone.val_Camera
                    }
                    Button{
                        width: parent.width*0.45
                        height: width*0.4
                        text: "Camera"
                        onClicked: Tendzone.runCmd(Tendzone.Command.Extender_HDMI, Tendzone.val_Camera)
                        font.pixelSize: height*0.4
                        checked: root.extendHDMI === Tendzone.val_Camera
                    }
                }
            }
        }

        Row{
            id:settingButtons
            width: parent.width
            height: parent.height*0.15
            spacing: width*0.01
            layoutDirection: Qt.RightToLeft
            Button{
                id:settingApply
                width: parent.width*0.2
                height: parent.height
                text: "应用"
                font.pixelSize: height*0.4
                onClicked: apply()
            }
            Button{
                id:settingCancel
                width: parent.width*0.2
                height: parent.height
                text: "取消"
                font.pixelSize: height*0.4
                onClicked: rootSetting.reject()
            }
            Button{
                id:settingOK
                width: parent.width*0.2
                height: parent.height
                text: "确定"
                font.pixelSize: height*0.4
                onClicked: rootSetting.accept()
            }
        }
    }
    onAccepted:{
        settings.roomNumber = roomNumber.text
        settings.autoRoomNumber = autoRoomNumber.checked
        settings.ipAddress = ipAddress.text
        settings.ipPort = ipPort.text
        settings.projector = projector.currentIndex
        settings.whiteboard = whiteBoardSwitch.checked
        settings.wireless = wirelessSwitch.checked
        settings.fullscreen = fullscreen.checked
        settings.password = password.text
        settings.lockPassword = lockPassword.text
        settings.socketError = socketError.text
        settings.webSocketServer = webSocketServer.checked
        settings.debugInfo = debugInfo.checked
        settings.phoneNumber = phoneNumber.text
        settings.sync()
    }

    onRejected: {
        roomNumber.text = settings.roomNumber
        autoRoomNumber.checked = settings.autoRoomNumber
        ipAddress.text = settings.ipAddress
        ipPort.text = settings.ipPort
        projector.currentIndex = settings.projector
        whiteBoardSwitch.checked = settings.whiteboard
        wirelessSwitch.checked = settings.wireless
        fullscreen.checked = settings.fullscreen
        password.text = settings.password
        lockPassword.text = settings.lockPassword
        socketError.text = settings.socketError
        webSocketServer.checked = settings.webSocketServer
        debugInfo.checked = settings.debugInfo
        phoneNumber.text = settings.phoneNumber
        settings.sync()
    }
    function apply(){
        settings.roomNumber = roomNumber.text
        settings.autoRoomNumber = autoRoomNumber.checked
        settings.ipAddress = ipAddress.text
        settings.ipPort = ipPort.text
        settings.projector = projector.currentIndex
        settings.whiteboard = whiteBoardSwitch.checked
        settings.wireless = wirelessSwitch.checked
        settings.fullscreen = fullscreen.checked
        settings.password = password.text
        settings.lockPassword = lockPassword.text
        settings.socketError = socketError.text
        settings.webSocketServer = webSocketServer.checked
        settings.debugInfo = debugInfo.checked
        settings.phoneNumber = phoneNumber.text
        settings.sync()
    }

}
