import QtQuick
import QtQuick.Controls

import "./tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

Dialog {
    id:rootConfirm
    anchors.centerIn: parent
    implicitWidth: parent.width*0.8
    implicitHeight: parent.height*0.4

    modal: true;
    closePolicy: Popup.NoAutoClose

    property alias confirmContent: confirmLabel.text
    property alias confirmTitle: confirmTitle.text

    property alias confirmOK: confirmOK.text
    property alias confirmCancel: confirmCancel.text

    property string operation

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
        Text {
            id:confirmTitle
            width: parent.width
            height: parent.height*0.2
            text: "提示"
            font.pixelSize: height*0.8
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            color: "#33B5E5"
        }

        Text {
            id:confirmLabel
            width: parent.width
            height: parent.height*0.5
            text: "确定执行操作?"
            font.pixelSize: height*0.4
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            color: "#33B5E5"
        }

        Row{
            id:confirmButtons
            width: parent.width
            height: parent.height*0.3
            spacing: width*0.01
            layoutDirection: Qt.RightToLeft
            Button{
                id:confirmCancel
                width: parent.width*0.2
                height: parent.height
                text: "取消"
                font.pixelSize: height*0.4
                onClicked: rootConfirm.reject()
            }
            Button{
                id:confirmOK
                width: parent.width*0.2
                height: parent.height
                text: "确定"
                font.pixelSize: height*0.4
                onClicked: rootConfirm.accept()
            }
        }
    }

    onAccepted: {
        if(Tendzone.Commands_List[operation]["Commands"].length > 1){
            processDialog.operation = operation
            processDialog.open()
        }else if(Tendzone.Commands_List[operation]["Commands"].length === 1){
            Tendzone.runCmd(Tendzone.Commands_List[operation]["Commands"][0].Name)
        }
    }
}
