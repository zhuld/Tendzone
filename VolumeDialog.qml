import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import QtQuick.Controls.Fusion

import "./tendzone.js" as Tendzone

Dialog {
    id:rootVolume
    implicitHeight: parent.height*0.9
    implicitWidth: parent.width*0.1
    visible: false

    property int miniVolume
    property int maxVolume

    property alias volumeLabel: volumeBarLabel.text

    modal: true;
    x:parent.width*0.9-width
    y:parent.height*0.05

    Column{
        anchors.fill: parent
        z:98
        Text {
            id: volumeBarLabel
            text: "VOL"
            width: parent.width
            height: parent.height*0.1
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height*0.5
            color: "#33B5E5"
        }
        Slider{
            id:volumeBar
            width: parent.width
            height: parent.height*0.8
            orientation: Qt.Vertical

            handle.width: volumeBar.width*0.7
            handle.height: volumeBar.width*0.7
            handle.opacity: 0.9


            stepSize: 1/(maxVolume-miniVolume)
            snapMode: Slider.SnapAlways


            onMoved: {
                var newVol = ((1-volumeBar.visualPosition)*(maxVolume- miniVolume))+miniVolume
                if (newVol != settingDialog.settings.volume){
                    settingDialog.settings.volume = newVol
                    settingDialog.settings.sync()
                    Tendzone.runCmd(Tendzone.Command.globalVolume, 15-newVol)
                }
            }

            ToolTip {
                parent: volumeBar.handle
                width: volumeBar.width/2
                height: width
                visible: volumeBar.pressed
                Text {
                    text: ((1-volumeBar.visualPosition)*(maxVolume- miniVolume))+miniVolume
                    font.pixelSize: parent.height*0.8
                }
            }

            Shape{ //刻度线
                ShapePath{
                    strokeColor: "#33B5E5"
                    strokeWidth: 2
                    startX: volumeBar.width*0
                    startY: volumeBar.handle.width/2
                    PathLine{
                        x:volumeBar.width*0.4
                        y:volumeBar.handle.width/2
                    }
                }
                ShapePath{
                    strokeColor: "#33B5E5"
                    strokeWidth: 2
                    startX: volumeBar.width*0
                    startY: volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)/6
                    PathLine{
                        x:volumeBar.width*0.4
                        y:volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)/6
                    }
                }
                ShapePath{
                    strokeColor: "#33B5E5"
                    strokeWidth: 2
                    startX: volumeBar.width*0
                    startY: volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)/3
                    PathLine{
                        x:volumeBar.width*0.4
                        y:volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)/3
                    }
                }
                ShapePath{
                    strokeColor: "#33B5E5"
                    strokeWidth: 2
                    startX: volumeBar.width*0
                    startY: volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)/2
                    PathLine{
                        x:volumeBar.width*0.4
                        y:volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)/2
                    }
                }
                ShapePath{
                    strokeColor: "#33B5E5"
                    strokeWidth: 2
                    startX: volumeBar.width*0
                    startY: volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)/3*2
                    PathLine{
                        x:volumeBar.width*0.4
                        y:volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)/3*2
                    }
                }
                ShapePath{
                    strokeColor: "#33B5E5"
                    strokeWidth: 2
                    startX: volumeBar.width*0
                    startY: volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)/6*5
                    PathLine{
                        x:volumeBar.width*0.4
                        y:volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)/6*5
                    }
                }
                ShapePath{
                    strokeColor: "#33B5E5"
                    strokeWidth: 2
                    startX: volumeBar.width*0
                    startY: volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)
                    PathLine{
                        x:volumeBar.width*0.4
                        y:volumeBar.handle.width/2+(volumeBar.availableHeight-volumeBar.handle.width)
                    }
                }
            }
        }

        Text {
            text: ((1-volumeBar.visualPosition)*(maxVolume- miniVolume))+miniVolume+"dB"
            width: parent.width
            height: parent.height*0.1
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height*0.5
            color: "#33B5E5"
        }
    }

    Rectangle {
        width: volumeBar.width*0.5
        height: volumeBar.handle.height/2
        x:volumeBar.width*0.6
        y:volumeBarLabel.height+height/2+(volumeBar.availableHeight-volumeBar.handle.width)/6*0
        color: "#00000000"
        Text {
            width: parent.width
            height: parent.height
            text: "0"
            color: "#33B5E5"
            font.pixelSize: height*0.8
        }
    }
    Rectangle {
        width: volumeBar.width*0.5
        height: volumeBar.handle.height/2
        x:volumeBar.width*0.6
        y:volumeBarLabel.height+height/2+(volumeBar.availableHeight-volumeBar.handle.width)/6
        color: "#00000000"
        Text {
            width: parent.width
            height: parent.height
            text: "-5"
            color: "#33B5E5"
            font.pixelSize: height*0.8
        }
    }
    Rectangle {
        width: volumeBar.width*0.5
        height: volumeBar.handle.height/2
        x:volumeBar.width*0.6
        y:volumeBarLabel.height+height/2+(volumeBar.availableHeight-volumeBar.handle.width)/6*2
        color: "#00000000"
        Text {
            width: parent.width
            height: parent.height
            text: "-10"
            color: "#33B5E5"
            font.pixelSize: height*0.8
        }
    }
    Rectangle {
        width: volumeBar.width*0.5
        height: volumeBar.handle.height/2
        x:volumeBar.width*0.6
        y:volumeBarLabel.height+height/2+(volumeBar.availableHeight-volumeBar.handle.width)/6*3
        color: "#00000000"
        Text {
            width: parent.width
            height: parent.height
            text: "-15"
            color: "#33B5E5"
            font.pixelSize: height*0.8
        }
    }
    Rectangle {
        width: volumeBar.width*0.5
        height: volumeBar.handle.height/2
        x:volumeBar.width*0.6
        y:volumeBarLabel.height+height/2+(volumeBar.availableHeight-volumeBar.handle.width)/6*4
        color: "#00000000"
        Text {
            width: parent.width
            height: parent.height
            text: "-20"
            color: "#33B5E5"
            font.pixelSize: height*0.8
        }
    }
    Rectangle {
        width: volumeBar.width*0.5
        height: volumeBar.handle.height/2
        x:volumeBar.width*0.6
        y:volumeBarLabel.height+height/2+(volumeBar.availableHeight-volumeBar.handle.width)/6*5
        color: "#00000000"
        Text {
            width: parent.width
            height: parent.height
            text: "-25"
            color: "#33B5E5"
            font.pixelSize: height*0.8
        }
    }
    Rectangle {
        width: volumeBar.width*0.5
        height: volumeBar.handle.height/2
        x:volumeBar.width*0.6
        y:volumeBarLabel.height+height/2+(volumeBar.availableHeight-volumeBar.handle.width)/6*6
        color: "#00000000"
        Text {
            width: parent.width
            height: parent.height
            text: "-30"
            color: "#33B5E5"
            font.pixelSize: height*0.8
        }
    }

    Overlay.modal: Rectangle{
        color:"#A0000000"
    }

    Component.onCompleted: {
        volumeBar.value = ((settingDialog.settings.volume - miniVolume)/(maxVolume- miniVolume))
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
}

