import QtQuick
import QtQuick.Controls

import "../others/"
import "../js/tendzone.js" as Tendzone

import "../"

Popup {
    id: rootProcess
    anchors.centerIn: parent
    implicitWidth: parent.width * 0.7
    implicitHeight: parent.height * 0.6

    modal: true
    focus: true

    parent: Overlay.overlay
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
    background: DialogBackground {}
    Column {
        anchors.fill: parent
        anchors.margins: height * 0.05
        spacing: height * 0.05
        Text {
            id: processTitle
            width: parent.width
            height: parent.height * 0.3
            text: "信息"
            font.pixelSize: height * 0.4
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            color: Global.textColor
        }

        Text {
            id: processLabel
            width: parent.width
            height: parent.height * 0.4
            font.pixelSize: height * 0.3
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: Global.textColor
        }

        Rectangle {
            id: processBar
            property real processValue: 0
            width: parent.width * processValue
            height: parent.height * 0.04
            color: Qt.lighter(Global.textColor, 2)
            radius: height * 0.3
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
                Tendzone.runCmd(Tendzone.Commands_List[rootProcess.operation]["Commands"][rootProcess.cmds_index].Name, Tendzone.Commands_List[rootProcess.operation]["Commands"][rootProcess.cmds_index].Value);

                rootProcess.cmd_delay += Tendzone.Commands_List[rootProcess.operation]["Commands"][rootProcess.cmds_index].Delay;

                rootProcess.cmds_index++;
            }
            rootProcess.timerCount++;
            if (rootProcess.cmds_index === Tendzone.Commands_List[rootProcess.operation]["Commands"].length) {
                rootProcess.timerCount = 0;
                rootProcess.cmds_index = 0;
                rootProcess.cmd_delay = 0;

                processBar.processValue = 0;
                processTimer.stop();
                rootProcess.close();
            }
        }
    }

    onOpened: {
        processBar.processValue = 0;
        duringSeconds = Tendzone.getCmdsDuring(operation);
        processAnimation.start();
        processTimer.start();
    }
}
