import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Layouts

import QtQuick.Controls.Fusion

import "./tendzone.js" as Tendzone

Dialog {
    id:rootVolume
    //implicitHeight: parent.height*0.9
    //implicitWidth: parent.width*0.1
    visible: false

    property int miniVolume
    property int maxVolume

    property alias volumeLabel: volumeGlobalLabel.text
    property alias volumeHDMiLabel: volumeHDMILabel.text

    modal: true;

    Row{
        anchors.fill: parent
        anchors.leftMargin: width*0.06
        spacing: width*0.04

        Column{ //volumeGlobal
            width: parent.width*0.12
            height: parent.height
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
                width: parent.width
                height: parent.height*0.7
                orientation: Qt.Vertical

                handle.width: width*0.7
                handle.height: width*0.7
                handle.opacity: 0.9

                stepSize: 1/(maxVolume-miniVolume)
                snapMode: Slider.SnapAlways

                value: ((settingDialog.settings.volume - miniVolume)/(maxVolume- miniVolume))

                onMoved: {
                    var newVol = ((1-visualPosition)*(maxVolume- miniVolume))+miniVolume
                    if (newVol != settingDialog.settings.volume){
                        settingDialog.settings.volume = newVol
                        settingDialog.settings.sync()
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
                                startX: parent.width*0
                                startY: parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                PathLine{
                                    x:parent.width*0.4
                                    y:parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                }
                            }
                        }
                        Text {
                            text: -5*value
                            width: parent.parent.width/2
                            height: parent.parent.handle.height/2
                            x:parent.parent.width*0.6
                            y:height/2+(parent.parent.availableHeight-parent.parent.handle.width)/6*value
                            color: "#33B5E5"
                            font.pixelSize: height*0.8
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
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.5
                color: "#33B5E5"
            }
        }

        Column{ //volumeHDMI
            width: parent.width*0.12
            height: parent.height
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
                width: parent.width
                height: parent.height*0.7
                orientation: Qt.Vertical

                handle.width: width*0.7
                handle.height: width*0.7
                handle.opacity: 0.9

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
                                startX: parent.width*0
                                startY: parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                PathLine{
                                    x:parent.width*0.4
                                    y:parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                }
                            }
                        }
                        Text {
                            text: -5*value
                            width: parent.parent.width/2
                            height: parent.parent.handle.height/2
                            x:parent.parent.width*0.6
                            y:height/2+(parent.parent.availableHeight-parent.parent.handle.width)/6*value
                            color: "#33B5E5"
                            font.pixelSize: height*0.8
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
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.5
                color: "#33B5E5"
            }
        }

        Column{ //volumeMic1
            width: parent.width*0.12
            height: parent.height
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
                width: parent.width
                height: parent.height*0.7
                orientation: Qt.Vertical

                handle.width: width*0.7
                handle.height: width*0.7
                handle.opacity: 0.9

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
                                startX: parent.width*0
                                startY: parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                PathLine{
                                    x:parent.width*0.4
                                    y:parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                }
                            }
                        }
                        Text {
                            text: -5*value
                            width: parent.parent.width/2
                            height: parent.parent.handle.height/2
                            x:parent.parent.width*0.6
                            y:height/2+(parent.parent.availableHeight-parent.parent.handle.width)/6*value
                            color: "#33B5E5"
                            font.pixelSize: height*0.8
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
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.5
                color: "#33B5E5"
            }
        }

        Column{ //volumeMic2
            width: parent.width*0.12
            height: parent.height
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
                width: parent.width
                height: parent.height*0.7
                orientation: Qt.Vertical

                handle.width: width*0.7
                handle.height: width*0.7
                handle.opacity: 0.9

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
                                startX: parent.width*0
                                startY: parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                PathLine{
                                    x:parent.width*0.4
                                    y:parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                }
                            }
                        }
                        Text {
                            text: -5*value
                            width: parent.parent.width/2
                            height: parent.parent.handle.height/2
                            x:parent.parent.width*0.6
                            y:height/2+(parent.parent.availableHeight-parent.parent.handle.width)/6*value
                            color: "#33B5E5"
                            font.pixelSize: height*0.8
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
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.5
                color: "#33B5E5"
            }
        }

        Column{ //volumeIR1
            width: parent.width*0.12
            height: parent.height
            Text {
                id: volumeIR1Label
                text: "IR1"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.6
                color: "#33B5E5"
            }
            Slider{
                id:volumeIR1
                width: parent.width
                height: parent.height*0.7
                orientation: Qt.Vertical

                handle.width: width*0.7
                handle.height: width*0.7
                handle.opacity: 0.9

                stepSize: 1/(maxVolume-miniVolume)
                snapMode: Slider.SnapAlways

                value: ((settingDialog.settings.volumeIR1 - miniVolume)/(maxVolume- miniVolume))

                onMoved: {
                    var newVol = ((1-visualPosition)*(maxVolume- miniVolume))+miniVolume
                    if (newVol != settingDialog.settings.volumeIR1){
                        settingDialog.settings.volumeIR1 = newVol
                        settingDialog.settings.sync()
                        Tendzone.runCmd(Tendzone.Command.lineVolume,
                                        new Uint8Array([Tendzone.Audio_Line["IRMIC"],Tendzone.Audio_Type["VOLUME"],0,0,15-newVol]))
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
                                startX: parent.width*0
                                startY: parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                PathLine{
                                    x:parent.width*0.4
                                    y:parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                }
                            }
                        }
                        Text {
                            text: -5*value
                            width: parent.parent.width/2
                            height: parent.parent.handle.height/2
                            x:parent.parent.width*0.6
                            y:height/2+(parent.parent.availableHeight-parent.parent.handle.width)/6*value
                            color: "#33B5E5"
                            font.pixelSize: height*0.8
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
                checked: settingDialog.settings.volumeIR1Mute
                onClicked: {
                    Tendzone.runCmd(Tendzone.Command.lineVolume,
                                    new Uint8Array([Tendzone.Audio_Line["IRMIC"],Tendzone.Audio_Type["MUTE"],0,0,checked?0:1]))
                    settingDialog.settings.volumeIR1Mute = !checked
                }
            }

            Text {
                text: ((1-volumeIR1.visualPosition)*(maxVolume- miniVolume))+miniVolume+"dB"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.5
                color: "#33B5E5"
            }
        }

        Column{ //volumeIR2
            width: parent.width*0.12
            height: parent.height
            Text {
                id: volumeIR2Label
                text: "IR2"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.6
                color: "#33B5E5"
            }
            Slider{
                id:volumeIR2
                width: parent.width
                height: parent.height*0.7
                orientation: Qt.Vertical

                handle.width: width*0.7
                handle.height: width*0.7
                handle.opacity: 0.9

                stepSize: 1/(maxVolume-miniVolume)
                snapMode: Slider.SnapAlways

                value: ((settingDialog.settings.volumeIR2 - miniVolume)/(maxVolume- miniVolume))

                onMoved: {
                    var newVol = ((1-visualPosition)*(maxVolume- miniVolume))+miniVolume
                    if (newVol != settingDialog.settings.volumeIR2){
                        settingDialog.settings.volumeIR2 = newVol
                        settingDialog.settings.sync()
                        Tendzone.runCmd(Tendzone.Command.lineVolume,
                                        new Uint8Array([Tendzone.Audio_Line["IRMIC"],Tendzone.Audio_Type["VOLUME"],1,0,15-newVol]))
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
                                startX: parent.width*0
                                startY: parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                PathLine{
                                    x:parent.width*0.4
                                    y:parent.handle.width/2+(parent.availableHeight-parent.handle.width)/6*value
                                }
                            }
                        }
                        Text {
                            text: -5*value
                            width: parent.parent.width/2
                            height: parent.parent.handle.height/2
                            x:parent.parent.width*0.6
                            y:height/2+(parent.parent.availableHeight-parent.parent.handle.width)/6*value
                            color: "#33B5E5"
                            font.pixelSize: height*0.8
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
                checked: settingDialog.settings.volumeIR2Mute
                onClicked: {
                    Tendzone.runCmd(Tendzone.Command.lineVolume,
                                    new Uint8Array([Tendzone.Audio_Line["IRMIC"],Tendzone.Audio_Type["MUTE"],1,0,checked?0:1]))
                    settingDialog.settings.volumeIR2Mute = !checked
                }
            }

            Text {
                text: ((1-volumeIR2.visualPosition)*(maxVolume- miniVolume))+miniVolume+"dB"
                width: parent.width
                height: parent.height*0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
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
}

