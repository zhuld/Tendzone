import QtQuick
import QtQuick.Controls

import "./tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

Dialog {
    id:rootProcess
    anchors.centerIn: parent
    implicitWidth: parent.width*0.8
    implicitHeight: parent.height*0.4

    modal: true;
    closePolicy: Popup.NoAutoClose

    property alias processContent: processLabel.text
    property alias processTitle: processTitle.text

    property int timerCount: 0
    property int duringSeconds: 0

    property int cmds_index : 0
    property int cmd_delay : 0

    property string operation

    Column{
        anchors.fill: parent
        anchors.margins: height*0.05
        Text {
            id:processTitle
            width: parent.width
            height: parent.height*0.2
            text: "信息"
            font.pixelSize: height*0.8
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            color: "#33B5E5"
        }
        Text {
            id:processLabel
            width: parent.width
            height: parent.height*0.5
            text: "执行操作中..."
            font.pixelSize: height*0.4
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            color: "#33B5E5"
        }

        Rectangle{
            id:processBar
            property real processValue: 0
            width: parent.width*processValue
            height: parent.height*0.1
            gradient: Gradient {
                GradientStop { position: 1.0; color: "#AA33B5E5" }
                GradientStop { position: 0.6; color: "#33B5E5" }
                GradientStop { position: 0.0; color: "#4433B5E5" }
            }
            PropertyAnimation {
                id: processAnimation
                target: processBar
                property: "processValue"
                from: 0.0
                to: 1.0
                duration: duringSeconds*1000
            }
        }
    }

    Timer{
        id:processTimer
        repeat: true
        triggeredOnStart: true
        onTriggered:{
            if(cmd_delay === timerCount){
                Tendzone.runCmd(Tendzone.Commands_List[operation]["Commands"][cmds_index].Name)

                cmd_delay += Tendzone.Commands_List[operation]["Commands"][cmds_index].Delay

                cmds_index++
            }
            timerCount++
            if(cmds_index === Tendzone.Commands_List[operation]["Commands"].length){
                timerCount = 0
                cmds_index = 0
                cmd_delay = 0

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
