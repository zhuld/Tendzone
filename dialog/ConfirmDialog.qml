import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import "../button/"
import "../others/"

import "../js/tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

Dialog {
    id:rootConfirm
    anchors.centerIn: parent
    implicitWidth: parent.width*0.9
    implicitHeight: parent.height*0.4

    modal: true;
    closePolicy: Popup.NoAutoClose

    property alias confirmContent: confirmLabel.text
    property alias confirmTitle: confirmTitle.text

    property alias confirmOK: confirmOK.text
    property alias confirmCancel: confirmCancel.text

    property int during: 30
    property string operation
    property string name

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

    background: Background{}

    Column{
        anchors.fill: parent
        anchors.margins: height*0.05
        Text {
            id:confirmTitle
            width: parent.width
            height: parent.height*0.3
            text: "提示"
            font.pixelSize: height*0.5
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "#33B5E5"
        }

        Rectangle{
            id:countDownBar
            width: confirmTitle.width
            height: 2
            color: "#33B5E5"
        }

        Text {
            id:confirmLabel
            width: parent.width
            height: parent.height*0.4
            text: "确定执行"+name+"操作?"
            font.pixelSize: height*0.5
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#33B5E5"
        }

        Row{
            id:confirmButtons
            width: parent.width
            height: parent.height*0.3
            spacing: width*0.02
            layoutDirection: Qt.RightToLeft
            ColorButton{
                id:confirmCancel
                width: parent.width*0.2
                height: parent.height
                text: "取消"
                onClicked: rootConfirm.reject()
            }
            ColorButton{
                id:confirmOK
                width: parent.width*0.2
                height: parent.height
                text: "确定"
                onClicked: rootConfirm.accept()
                btnColor: "darkgreen"
            }

            Timer{
                id:countDownTimer
                interval : 1000
                repeat : true
                triggeredOnStart : false
                onTriggered: {
                    during--
                    if(during === 0){
                        rootConfirm.close()
                    }
                }
            }
        }
    }   

    onAccepted: {
        if(Tendzone.Commands_List[operation]["Commands"].length > 1){
            processDialog.operation = operation
            processDialog.name = name
            processDialog.open()
        }else if(Tendzone.Commands_List[operation]["Commands"].length === 1){
            Tendzone.runCmd(Tendzone.Commands_List[operation]["Commands"][0].Name)
        }
    }
    onOpened: countDownTimer.start()

    onClosed: {
        countDownTimer.stop()
        during = 30
    }
}
