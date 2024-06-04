import QtQuick
import QtQuick.Controls

import "../js/tendzone.js" as Tendzone

Item {
    id:splash

    signal closed()

    property alias duration: processAnimation.duration
    property alias source: image.source
    property color processColor : "#33B5E5"

    implicitWidth: parent.width
    implicitHeight: parent.height
    z:99

    Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "../pic/splash.jpg"
    }

    Rectangle{
        id:processBar
        property real processValue: 0
        width: parent.width*processValue*0.8
        height: parent.height*0.05
        x:parent.width*0.1
        y:parent.height*0.8
        gradient: Gradient {
            GradientStop { position: 0.6; color: processColor }
            GradientStop { position: 1.0; color: Qt.lighter(processColor,1.2)}
            GradientStop { position: 0.0; color: Qt.lighter(processColor,1.4)}
        }
        NumberAnimation {
            id: processAnimation
            target: processBar
            property: "processValue"
            from: 0.0
            to: 1.0
            duration: 3000
            onFinished: splash.visible = false
        }
    }
    Text {
        id: text
        text: Application.version + " - " + Tendzone.Commands_List["Version"]
        width: parent.width
        height: parent.height*0.04
        color: "#33B5E5"
        font.pixelSize: height
        horizontalAlignment: Text.AlignRight
    }
    MouseArea{
        anchors.fill: parent
        onClicked: processAnimation.finished()
    }

    Component.onCompleted:  processAnimation.start()

    onVisibleChanged: {
        if(visible === false){
            closed()
        }
    }
}
