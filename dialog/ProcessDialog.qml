import QtQuick
import QtQuick.Controls

import "../others/"
import "../js/tendzone.js" as Tendzone

//导入Global.qml以使用全局设置
import "../"

Dialog {
    id: rootProcess
    anchors.centerIn: parent
    implicitWidth: parent.width * 0.9
    implicitHeight: parent.height * 0.6

    modal: true
    closePolicy: Popup.NoAutoClose

    property alias processContent: processLabel.text
    property alias processTitle: processTitle.text

    property int timerCount: 0
    property int duringSeconds: 0

    property int cmds_index: 0
    property int cmd_delay: 0

    property string operation
    property string name

    Overlay.modal: Rectangle {
        color: Global.overlayColor
    }

    enter: Transition {
        NumberAnimation {
            from: 0
            to: 1
            property: "opacity"
            duration: 200
        }
    }
    exit: Transition {
        NumberAnimation {
            from: 1
            to: 0
            property: "opacity"
            duration: 200
        }
    }
    background: Background {}
    Column {
        anchors.fill: parent
        anchors.margins: height * 0.05
        Text {
            id: processTitle
            width: parent.width
            height: parent.height * 0.3
            text: "信息"
            font.pixelSize: height * 0.4
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: Global.textColor
        }

        Rectangle {
            width: processTitle.width
            height: 2
            color: Global.textColor
        }

        Text {
            id: processLabel
            width: parent.width
            height: parent.height * 0.5
            font.pixelSize: height * 0.25
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: Global.textColor
        }

        Rectangle {
            id: processBar
            property real processValue: 0
            width: parent.width * processValue
            height: parent.height * 0.02
            gradient: Gradient {
                GradientStop {
                    position: 1.0
                    color: Qt.lighter(Global.textColor, 1.2)
                }
                GradientStop {
                    position: 0.6
                    color: Global.textColor
                }
                GradientStop {
                    position: 0.0
                    color: Qt.lighter(Global.textColor, 1.4)
                }
            }
            PropertyAnimation {
                id: processAnimation
                target: processBar
                property: "processValue"
                from: 0.0
                to: 1.0
                duration: rootProcess.duringSeconds * 1000
            }
        }
    }

    Timer {
        id: processTimer
        repeat: true
        triggeredOnStart: true
        interval: 1000
        onTriggered: {
            if (rootProcess.cmd_delay === rootProcess.timerCount) {
                Tendzone.runCmd(
                            Tendzone.Commands_List[rootProcess.operation]["Commands"][rootProcess.cmds_index].Name,
                            Tendzone.Commands_List[rootProcess.operation]["Commands"][rootProcess.cmds_index].Value)

                rootProcess.cmd_delay += Tendzone.Commands_List[rootProcess.operation]["Commands"][rootProcess.cmds_index].Delay

                rootProcess.cmds_index++
            }
            rootProcess.timerCount++
            if (rootProcess.cmds_index
                    === Tendzone.Commands_List[rootProcess.operation]["Commands"].length) {
                rootProcess.timerCount = 0
                rootProcess.cmds_index = 0
                rootProcess.cmd_delay = 0

                processBar.processValue = 0
                processTimer.stop()
                rootProcess.accept()
            }
        }
    }

    onOpened: {
        processBar.processValue = 0
        duringSeconds = Tendzone.getCmdsDuring(operation)
        processAnimation.start()
        processTimer.start()
    }
}
