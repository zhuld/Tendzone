import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Layouts

import QtQuick.Controls.Fusion

import "../js/tendzone.js" as Tendzone

Dialog {
    id:rootVolume
    implicitHeight: parent.height*0.9
    implicitWidth: parent.width*0.56
    y:parent.height*0.05

    readonly property int miniVolume: -30
    readonly property int maxVolume: 0

    property int globalVolume

    property alias volumeLabel: volumeGlobalLabel.text
    property alias volumeHDMiLabel: volumeHDMILabel.text

    property real volumeWidth : 0.18

    modal: true;

    Row{
        anchors.fill: parent
        anchors.leftMargin: width*0.05
        spacing: width*0.07

        Column{ //volumeGlobal
            width: parent.width*volumeWidth
            height: parent.height
            spacing: parent.height*0.02
            Text {
                id: volumeGlobalLabel
                text: "VOL"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.6
                color: "#33B5E5"
            }
            Slider{
                id:volumeGlobal
                width: parent.width*0.6
                height: parent.height*0.67
                orientation: Qt.Vertical

                handle: Rectangle{
                    implicitWidth: parent.width*0.5
                    implicitHeight: parent.width*1.2
                    x:parent.leftPadding+parent.availableWidth/2-width/2
                    y:parent.topPadding+parent.visualPosition*(parent.availableHeight-height)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#57111B" }
                        GradientStop { position: 0.1; color: "#A598CF" }
                        GradientStop { position: 0.2; color: "#682632" }
                        GradientStop { position: 0.48; color: "#8F4E69" }
                        GradientStop { position: 0.49; color: "#FFFFFF" }
                        GradientStop { position: 0.52; color: "#FFFFFF" }
                        GradientStop { position: 0.53; color: "#885E7E" }
                        GradientStop { position: 0.90; color: "#8F6C94" }
                        GradientStop { position: 1.0; color: "#57111B" }
                    }
                    radius: parent.width*0.1
                }


                stepSize: 1/(maxVolume-miniVolume)
                snapMode: Slider.SnapAlways

                value: ((globalVolume - miniVolume)/(maxVolume- miniVolume))

                onMoved: {
                    var newVol = ((1-visualPosition)*(maxVolume- miniVolume))+miniVolume
                    if (newVol !== globalVolume){
                        Tendzone.runCmd(Tendzone.Command.globalVolume, 15-newVol)
                    }
                }

                Repeater{
                    model: ListModel{
                        ListElement{ value: 0}
                        ListElement{ value: 1}
                        ListElement{ value: 2}
                        ListElement{ value: 3}
                        ListElement{ value: 4}
                        ListElement{ value: 5}
                        ListElement{ value: 6}
                    }
                    Item{
                        anchors.fill: parent
                        Shape{ //刻度线
                            anchors.fill: parent
                            ShapePath{
                                strokeColor: "#33B5E5"
                                strokeWidth: 2
                                startX: 0
                                startY: parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                PathLine{
                                    x:parent.width*0.4
                                    y:parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                }
                            }
                        }
                        Shape{ //刻度线
                            anchors.fill: parent
                            ShapePath{
                                strokeColor: "#33B5E5"
                                strokeWidth: 2
                                startX: parent.width*0.6
                                startY: parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                PathLine{
                                    x:parent.width*0.9
                                    y:parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                }
                            }
                        }
                        Text {
                            text: -5*value
                            width: parent.parent.width
                            height: parent.parent.handle.height
                            x:parent.parent.width
                            y: (parent.parent.availableHeight - parent.parent.handle.height)/6*value
                            color: "#33B5E5"
                            font.pixelSize: height*0.4
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            Button{
                height: parent.height*0.1
                width: height
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    anchors.centerIn: parent
                    text: "M"
                    color: parent.checked? "red":"#33B5E5"
                    font.pixelSize: parent.height*0.6
                }
                checked: settingDialog.settings.volumeMute
                onClicked: Tendzone.runCmd(Tendzone.Command.Amp,checked?1:0)
            }

            Text {
                text: ((1-volumeGlobal.visualPosition)*(maxVolume- miniVolume))+miniVolume+"dB"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height*0.5
                color: "#33B5E5"
            }
        }

        Column{ //volumeHDMI
            width: parent.width*volumeWidth
            height: parent.height
            spacing: parent.height*0.02
            Text {
                id: volumeHDMILabel
                text: "PC"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.6
                color: "#33B5E5"
            }
            Slider{
                id:volumeHDMI
                width: parent.width*0.6
                height: parent.height*0.67
                orientation: Qt.Vertical

                handle: Rectangle{
                    implicitWidth: parent.width*0.5
                    implicitHeight: parent.width*1.2
                    x:parent.leftPadding+parent.availableWidth/2-width/2
                    y:parent.topPadding+parent.visualPosition*(parent.availableHeight-height)
                    //opacity: 0.9
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#07111B" }
                        GradientStop { position: 0.1; color: "#5598CF" }
                        GradientStop { position: 0.2; color: "#182632" }
                        GradientStop { position: 0.48; color: "#2F4E69" }
                        GradientStop { position: 0.49; color: "#FFFFFF" }
                        GradientStop { position: 0.52; color: "#FFFFFF" }
                        GradientStop { position: 0.53; color: "#385E7E" }
                        GradientStop { position: 0.90; color: "#3F6C94" }
                        GradientStop { position: 1.0; color: "#07111B" }
                    }
                    radius: parent.width*0.1
                }

                stepSize: 1/(maxVolume-miniVolume)
                snapMode: Slider.SnapAlways

                value: ((settingDialog.settings.volumeHDMI - miniVolume)/(maxVolume- miniVolume))

                onMoved: {
                    var newVol = ((1-visualPosition)*(maxVolume- miniVolume))+miniVolume
                    if (newVol != settingDialog.settings.volumeHDMI){
                        settingDialog.settings.volumeHDMI = newVol
                        settingDialog.settings.sync()
                        Tendzone.runCmd(Tendzone.Command.lineVolume,
                                        new Uint8Array([Tendzone.Audio_Line["HDMI"],Tendzone.Audio_Type["VOLUME"],0,0,15-newVol]))
                    }
                }

                Repeater{
                    model: ListModel{
                        ListElement{ value: 0}
                        ListElement{ value: 1}
                        ListElement{ value: 2}
                        ListElement{ value: 3}
                        ListElement{ value: 4}
                        ListElement{ value: 5}
                        ListElement{ value: 6}
                    }
                    Item{
                        anchors.fill: parent
                        Shape{ //刻度线
                            anchors.fill: parent
                            ShapePath{
                                strokeColor: "#33B5E5"
                                strokeWidth: 2
                                startX: 0
                                startY: parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                PathLine{
                                    x:parent.width*0.4
                                    y:parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                }
                            }
                        }
                        Shape{ //刻度线
                            anchors.fill: parent
                            ShapePath{
                                strokeColor: "#33B5E5"
                                strokeWidth: 2
                                startX: parent.width*0.6
                                startY: parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                PathLine{
                                    x:parent.width*0.9
                                    y:parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                }
                            }
                        }
                        Text {
                            text: -5*value
                            width: parent.parent.width
                            height: parent.parent.handle.height
                            x:parent.parent.width
                            y: (parent.parent.availableHeight - parent.parent.handle.height)/6*value
                            color: "#33B5E5"
                            font.pixelSize: height*0.4
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            Button{
                height: parent.height*0.1
                width: height
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    anchors.centerIn: parent
                    text: "M"
                    color: parent.checked? "red":"#33B5E5"
                    font.pixelSize: parent.height*0.6
                }
                checked: settingDialog.settings.volumeHDMIMute
                onClicked: {
                    Tendzone.runCmd(Tendzone.Command.lineVolume,
                                    new Uint8Array([Tendzone.Audio_Line["HDMI"],Tendzone.Audio_Type["MUTE"],0,0,checked?0:1]))
                    settingDialog.settings.volumeHDMIMute = !checked
                }
            }


            Text {
                text: ((1-volumeHDMI.visualPosition)*(maxVolume- miniVolume))+miniVolume+"dB"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height*0.5
                color: "#33B5E5"
            }
        }

        Column{ //volumeMic1
            width: parent.width*volumeWidth
            height: parent.height
            spacing: parent.height*0.02
            Text {
                id: volumeMic1Label
                text: "Mic1"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.6
                color: "#33B5E5"
            }
            Slider{
                id:volumeMic1
                width: parent.width*0.6
                height: parent.height*0.67
                orientation: Qt.Vertical

                handle: Rectangle{
                    implicitWidth: parent.width*0.5
                    implicitHeight: parent.width*1.2
                    x:parent.leftPadding+parent.availableWidth/2-width/2
                    y:parent.topPadding+parent.visualPosition*(parent.availableHeight-height)
                    //opacity: 0.9
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#07111B" }
                        GradientStop { position: 0.1; color: "#5598CF" }
                        GradientStop { position: 0.2; color: "#182632" }
                        GradientStop { position: 0.48; color: "#2F4E69" }
                        GradientStop { position: 0.49; color: "#FFFFFF" }
                        GradientStop { position: 0.52; color: "#FFFFFF" }
                        GradientStop { position: 0.53; color: "#385E7E" }
                        GradientStop { position: 0.90; color: "#3F6C94" }
                        GradientStop { position: 1.0; color: "#07111B" }
                    }
                    radius: parent.width*0.1
                }
                stepSize: 1/(maxVolume-miniVolume)
                snapMode: Slider.SnapAlways

                value: ((settingDialog.settings.volumeMic1 - miniVolume)/(maxVolume- miniVolume))

                onMoved: {
                    var newVol = ((1-visualPosition)*(maxVolume- miniVolume))+miniVolume
                    if (newVol != settingDialog.settings.volumeMic1){
                        settingDialog.settings.volumeMic1 = newVol
                        settingDialog.settings.sync()
                        Tendzone.runCmd(Tendzone.Command.lineVolume,
                                        new Uint8Array([Tendzone.Audio_Line["MICIN"],Tendzone.Audio_Type["VOLUME"],0,0,15-newVol]))
                    }
                }

                Repeater{
                    model: ListModel{
                        ListElement{ value: 0}
                        ListElement{ value: 1}
                        ListElement{ value: 2}
                        ListElement{ value: 3}
                        ListElement{ value: 4}
                        ListElement{ value: 5}
                        ListElement{ value: 6}
                    }
                    Item{
                        anchors.fill: parent
                        Shape{ //刻度线
                            anchors.fill: parent
                            ShapePath{
                                strokeColor: "#33B5E5"
                                strokeWidth: 2
                                startX: 0
                                startY: parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                PathLine{
                                    x:parent.width*0.4
                                    y:parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                }
                            }
                        }
                        Shape{ //刻度线
                            anchors.fill: parent
                            ShapePath{
                                strokeColor: "#33B5E5"
                                strokeWidth: 2
                                startX: parent.width*0.6
                                startY: parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                PathLine{
                                    x:parent.width*0.9
                                    y:parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                }
                            }
                        }
                        Text {
                            text: -5*value
                            width: parent.parent.width
                            height: parent.parent.handle.height
                            x:parent.parent.width
                            y: (parent.parent.availableHeight - parent.parent.handle.height)/6*value
                            color: "#33B5E5"
                            font.pixelSize: height*0.4
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            Button{
                height: parent.height*0.1
                width: height
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    anchors.centerIn: parent
                    text: "M"
                    color: parent.checked? "red":"#33B5E5"
                    font.pixelSize: parent.height*0.6
                }
                checked: settingDialog.settings.volumeMic1Mute
                onClicked: {
                    Tendzone.runCmd(Tendzone.Command.lineVolume,
                                    new Uint8Array([Tendzone.Audio_Line["MICIN"],Tendzone.Audio_Type["MUTE"],0,0,checked?0:1]))
                    settingDialog.settings.volumeMic1Mute = !checked
                }
            }

            Text {
                text: ((1-volumeMic1.visualPosition)*(maxVolume- miniVolume))+miniVolume+"dB"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height*0.5
                color: "#33B5E5"
            }
        }

        Column{ //volumeMic2
            width: parent.width*volumeWidth
            height: parent.height
            spacing: parent.height*0.02
            Text {
                id: volumeMic2Label
                text: "Mic2"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.6
                color: "#33B5E5"
            }
            Slider{
                id:volumeMic2
                width: parent.width*0.6
                height: parent.height*0.67
                orientation: Qt.Vertical

                handle: Rectangle{
                    implicitWidth: parent.width*0.5
                    implicitHeight: parent.width*1.2
                    x:parent.leftPadding+parent.availableWidth/2-width/2
                    y:parent.topPadding+parent.visualPosition*(parent.availableHeight-height)
                    //opacity: 0.9
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#07111B" }
                        GradientStop { position: 0.1; color: "#5598CF" }
                        GradientStop { position: 0.2; color: "#182632" }
                        GradientStop { position: 0.48; color: "#2F4E69" }
                        GradientStop { position: 0.49; color: "#FFFFFF" }
                        GradientStop { position: 0.52; color: "#FFFFFF" }
                        GradientStop { position: 0.53; color: "#385E7E" }
                        GradientStop { position: 0.90; color: "#3F6C94" }
                        GradientStop { position: 1.0; color: "#07111B" }
                    }
                    radius: parent.width*0.1
                }

                stepSize: 1/(maxVolume-miniVolume)
                snapMode: Slider.SnapAlways

                value: ((settingDialog.settings.volumeMic2 - miniVolume)/(maxVolume- miniVolume))

                onMoved: {
                    var newVol = ((1-visualPosition)*(maxVolume- miniVolume))+miniVolume
                    if (newVol != settingDialog.settings.volumeMic2){
                        settingDialog.settings.volumeMic2 = newVol
                        settingDialog.settings.sync()
                        Tendzone.runCmd(Tendzone.Command.lineVolume,
                                        new Uint8Array([Tendzone.Audio_Line["MICIN"],Tendzone.Audio_Type["VOLUME"],1,0,15-newVol]))
                    }
                }

                Repeater{
                    model: ListModel{
                        ListElement{ value: 0}
                        ListElement{ value: 1}
                        ListElement{ value: 2}
                        ListElement{ value: 3}
                        ListElement{ value: 4}
                        ListElement{ value: 5}
                        ListElement{ value: 6}
                    }
                    Item{
                        anchors.fill: parent
                        Shape{ //刻度线
                            anchors.fill: parent
                            ShapePath{
                                strokeColor: "#33B5E5"
                                strokeWidth: 2
                                startX: 0
                                startY: parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                PathLine{
                                    x:parent.width*0.4
                                    y:parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                }
                            }
                        }
                        Shape{ //刻度线
                            anchors.fill: parent
                            ShapePath{
                                strokeColor: "#33B5E5"
                                strokeWidth: 2
                                startX: parent.width*0.6
                                startY: parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                PathLine{
                                    x:parent.width*0.9
                                    y:parent.handle.height/2+(parent.availableHeight-parent.handle.height)/6*value
                                }
                            }
                        }
                        Text {
                            text: -5*value
                            width: parent.parent.width
                            height: parent.parent.handle.height
                            x:parent.parent.width
                            y: (parent.parent.availableHeight - parent.parent.handle.height)/6*value
                            color: "#33B5E5"
                            font.pixelSize: height*0.4
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            Button{
                height: parent.height*0.1
                width: height
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    anchors.centerIn: parent
                    text: "M"
                    color: parent.checked? "red":"#33B5E5"
                    font.pixelSize: parent.height*0.6
                }
                checked: settingDialog.settings.volumeMic2Mute
                onClicked: {
                    Tendzone.runCmd(Tendzone.Command.lineVolume,
                                    new Uint8Array([Tendzone.Audio_Line["MICIN"],Tendzone.Audio_Type["MUTE"],1,0,checked?0:1]))
                    settingDialog.settings.volumeMic2Mute = !checked
                }
            }

            Text {
                text: ((1-volumeMic2.visualPosition)*(maxVolume- miniVolume))+miniVolume+"dB"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height*0.5
                color: "#33B5E5"
            }
        }
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

    onOpened: Tendzone.runCmd(Tendzone.Command.subGlobalVolume,false)
    onClosed: Tendzone.runCmd(Tendzone.Command.subGlobalVolume,true)

}

