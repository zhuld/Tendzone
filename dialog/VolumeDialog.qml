pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Effects

import "../button/"
import "../others/"
import "../"
import "../js/tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

Dialog {
    id: rootVolume
    implicitHeight: parent.height * 0.9
    implicitWidth: parent.width * 0.6

    readonly property int minVolume: -30
    readonly property int maxVolume: 5

    property int volumeCount: 5
    property alias volumeHDMILabel: volumeHDMILabel.text
    property alias volumeLabel: volumeGlobalLabel.text
    property alias volumeIPLabel: volumeIPLabel.text

    anchors.centerIn: parent

    modal: true

    background: DialogBackground {
        titleHeight: 0.11
    }

    Row {
        width: parent.width * 0.94
        height: parent.height
        anchors.centerIn: parent
        spacing: width * 0.08

        Column {
            //volumeGlobal
            width: (parent.width + parent.spacing) / rootVolume.volumeCount - parent.spacing
            height: parent.height
            spacing: parent.height * 0.02
            Text {
                id: volumeGlobalLabel
                text: "VOL"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.5
                color: Global.textColor
            }
            Slider {
                id: volumeGlobalSlider
                width: parent.width * 0.8
                height: parent.height * 0.67
                anchors.horizontalCenter: parent.horizontalCenter
                orientation: Qt.Vertical

                stepSize: 1 / (rootVolume.maxVolume - rootVolume.minVolume)
                snapMode: Slider.SnapAlways

                value: ((Global.settings.volume - rootVolume.minVolume) / (rootVolume.maxVolume - rootVolume.minVolume))

                onMoved: {
                    var newVol = Math.floor(((1 - visualPosition) * (rootVolume.maxVolume - rootVolume.minVolume))) + rootVolume.minVolume;
                    if (newVol !== Global.settings.volume) {
                        Global.settings.volume = newVol;
                        Global.settings.sync();
                        Tendzone.runCmd(Tendzone.Command.globalVolume, 15 - newVol);
                    }
                }
                handle: Rectangle {
                    id: volumeGlobalHandle
                    implicitWidth: parent.width * 0.4
                    implicitHeight: parent.width * 0.8
                    x: volumeGlobalSlider.availableWidth / 2 - width / 2
                    y: volumeGlobalSlider.topPadding + volumeGlobalSlider.visualPosition * (volumeGlobalSlider.availableHeight - height)
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#57111B"
                        }
                        GradientStop {
                            position: 0.1
                            color: "#A598CF"
                        }
                        GradientStop {
                            position: 0.2
                            color: "#682632"
                        }
                        GradientStop {
                            position: 0.48
                            color: "#8F4E69"
                        }
                        GradientStop {
                            position: 0.49
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.50
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.51
                            color: "#885E7E"
                        }
                        GradientStop {
                            position: 0.90
                            color: "#8F6C94"
                        }
                        GradientStop {
                            position: 1.0
                            color: "#57111B"
                        }
                    }
                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: Global.buttonShadowColor
                        shadowHorizontalOffset: volumeGlobalSlider.pressed ? Global.shadowHeight / 2 : Global.shadowHeight
                        shadowVerticalOffset: shadowHorizontalOffset * (1 - volumeGlobalSlider.position)
                        Behavior on shadowHorizontalOffset {
                            NumberAnimation {
                                duration: Global.durationDelay
                            }
                        }
                    }
                    radius: parent.width * 0.1
                }

                background: Shape {
                    id: volumeGlobalBack
                    height: parent.height - volumeGlobalHandle.height + width
                    width: parent.width * 0.1
                    y: volumeGlobalHandle.height / 2 - width / 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: volumeGlobalPathRect
                            x: 0
                            y: volumeGlobalBack.height - height
                            radius: width / 3
                            width: volumeGlobalBack.width
                            height: volumeGlobalBack.height
                        }
                        fillGradient: LinearGradient {
                            y1: volumeGlobalPathRect.height
                            y2: 0
                            x1: volumeGlobalPathRect.width / 2
                            x2: volumeGlobalPathRect.width / 2
                            GradientStop {
                                position: 0.6
                                color: "green"
                            }
                            GradientStop {
                                position: 0.8
                                color: "orange"
                            }
                            GradientStop {
                                position: 1
                                color: "red"
                            }
                        }
                    }
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: volumeGlobalPathRectangle
                            x: 0
                            y: 0
                            radius: width / 3
                            width: volumeGlobalBack.width
                            height: volumeGlobalSlider.visualPosition * volumeGlobalBack.height
                        }
                        fillGradient: LinearGradient {
                            y1: volumeGlobalPathRectangle.height / 2
                            y2: volumeGlobalPathRectangle.height / 2
                            x1: 0
                            x2: volumeGlobalPathRectangle.width
                            GradientStop {
                                position: 0
                                color: Qt.darker(Global.buttonColor, 1.4)
                            }
                            GradientStop {
                                position: 1
                                color: Global.buttonColor
                            }
                        }
                    }
                }

                contentItem: Repeater {
                    model: (rootVolume.maxVolume - rootVolume.minVolume) / 5 + 1
                    Item {
                        id: volumeGlobalShape
                        required property int index
                        anchors.fill: parent
                        Shape {
                            //刻度线左
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: 0
                                startY: volumeGlobalHandle.height / 2 + (volumeGlobalShape.height - volumeGlobalHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeGlobalShape.index
                                PathLine {
                                    x: volumeGlobalShape.width * 0.4
                                    y: volumeGlobalHandle.height / 2 + (volumeGlobalShape.height - volumeGlobalHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeGlobalShape.index
                                }
                            }
                        }
                        Shape {
                            //刻度线右
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: volumeGlobalShape.width * 0.6
                                startY: volumeGlobalHandle.height / 2 + (volumeGlobalShape.height - volumeGlobalHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeGlobalShape.index
                                PathLine {
                                    x: volumeGlobalShape.width
                                    y: volumeGlobalHandle.height / 2 + (volumeGlobalShape.height - volumeGlobalHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeGlobalShape.index
                                }
                            }
                        }
                        Text {
                            text: -5 * volumeGlobalShape.index + rootVolume.maxVolume
                            width: volumeGlobalShape.width * 0.3
                            height: volumeGlobalHandle.height
                            horizontalAlignment: Text.AlignRight
                            x: -volumeGlobalShape.width * 0.1
                            y: (volumeGlobalShape.height - volumeGlobalHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeGlobalShape.index - height * 0.2
                            color: Global.textColor
                            font.pixelSize: height * 0.25
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            MyButton {
                height: parent.height * 0.1
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: Global.settings.language === "zh_CN" ? "静音" : checked ? "UnMute" : "Mute"
                textColor: checked || pressed ? Global.warnColor : Global.textColor
                checked: Global.settings.volumeMute
                onClicked: Tendzone.runCmd(Tendzone.Command.Amp, checked ? 1 : 0)
            }

            Text {
                text: Math.floor(((1 - volumeGlobalSlider.visualPosition) * (rootVolume.maxVolume - rootVolume.minVolume))) + rootVolume.minVolume + "dB"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height * 0.4
                color: Global.textColor
            }
        }

        Column {
            //volumeHDMI
            width: (parent.width + parent.spacing) / rootVolume.volumeCount - parent.spacing
            height: parent.height
            spacing: parent.height * 0.02
            Text {
                id: volumeHDMILabel
                text: "PC"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.5
                color: Global.textColor
            }
            Slider {
                id: volumeHDMISlider
                width: parent.width * 0.8
                height: parent.height * 0.67
                anchors.horizontalCenter: parent.horizontalCenter
                orientation: Qt.Vertical

                handle: Rectangle {
                    id: volumeHDMIHandle
                    implicitWidth: parent.width * 0.4
                    implicitHeight: parent.width * 0.8
                    x: volumeHDMISlider.availableWidth / 2 - width / 2
                    y: volumeHDMISlider.topPadding + volumeHDMISlider.visualPosition * (volumeHDMISlider.availableHeight - height)
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#07111B"
                        }
                        GradientStop {
                            position: 0.1
                            color: "#5598CF"
                        }
                        GradientStop {
                            position: 0.2
                            color: "#182632"
                        }
                        GradientStop {
                            position: 0.48
                            color: "#2F4E69"
                        }
                        GradientStop {
                            position: 0.49
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.50
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.51
                            color: "#385E7E"
                        }
                        GradientStop {
                            position: 0.90
                            color: "#3F6C94"
                        }
                        GradientStop {
                            position: 1.0
                            color: "#07111B"
                        }
                    }
                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: Global.buttonShadowColor
                        shadowHorizontalOffset: volumeHDMISlider.pressed ? Global.shadowHeight / 2 : Global.shadowHeight
                        shadowVerticalOffset: shadowHorizontalOffset * (1 - volumeHDMISlider.position)
                        Behavior on shadowHorizontalOffset {
                            NumberAnimation {
                                duration: Global.durationDelay
                            }
                        }
                    }
                    radius: parent.width * 0.1
                }

                stepSize: 1 / (rootVolume.maxVolume - rootVolume.minVolume)
                snapMode: Slider.SnapAlways

                value: ((Global.settings.volumeHDMI - rootVolume.minVolume) / (rootVolume.maxVolume - rootVolume.minVolume))

                onMoved: {
                    var newVol = Math.floor(((1 - visualPosition) * (rootVolume.maxVolume - rootVolume.minVolume))) + rootVolume.minVolume;
                    if (newVol != Global.settings.volumeHDMI) {
                        Global.settings.volumeHDMI = newVol;
                        Global.settings.sync();
                        Tendzone.runCmd(Tendzone.Command.lineVolume, new Uint8Array([Tendzone.Audio_Line["HDMI"], Tendzone.Audio_Type["VOLUME"], 0, 0, 15 - newVol]));
                    }
                }

                background: Shape {
                    id: volumeHDMIBack
                    height: parent.height - volumeHDMIHandle.height + width
                    width: parent.width * 0.1
                    y: volumeHDMIHandle.height / 2 - width / 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: volumeHDMIPathRect
                            x: 0
                            y: volumeHDMIBack.height - height
                            radius: width / 3
                            width: volumeHDMIBack.width
                            height: volumeHDMIBack.height
                        }
                        fillGradient: LinearGradient {
                            y1: volumeHDMIPathRect.height
                            y2: 0
                            x1: volumeHDMIPathRect.width / 2
                            x2: volumeHDMIPathRect.width / 2
                            GradientStop {
                                position: 0.6
                                color: "green"
                            }
                            GradientStop {
                                position: 0.8
                                color: "orange"
                            }
                            GradientStop {
                                position: 1
                                color: "red"
                            }
                        }
                    }
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: volumeHDMIPathRectangle
                            x: 0
                            y: 0
                            radius: width / 3
                            width: volumeHDMIBack.width
                            height: volumeHDMISlider.visualPosition * volumeHDMIBack.height
                        }
                        fillGradient: LinearGradient {
                            y1: volumeHDMIPathRectangle.height / 2
                            y2: volumeHDMIPathRectangle.height / 2
                            x1: 0
                            x2: volumeHDMIPathRectangle.width
                            GradientStop {
                                position: 0
                                color: Qt.darker(Global.buttonColor, 1.4)
                            }
                            GradientStop {
                                position: 1
                                color: Global.buttonColor
                            }
                        }
                    }
                }

                contentItem: Repeater {
                    model: (rootVolume.maxVolume - rootVolume.minVolume) / 5 + 1
                    Item {
                        id: volumeHDMIShape
                        required property int index
                        anchors.fill: parent
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: 0
                                startY: volumeHDMIHandle.height / 2 + (volumeHDMIShape.height - volumeHDMIHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeHDMIShape.index
                                PathLine {
                                    x: volumeHDMIShape.width * 0.4
                                    y: volumeHDMIHandle.height / 2 + (volumeHDMIShape.height - volumeHDMIHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeHDMIShape.index
                                }
                            }
                        }
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: volumeHDMIShape.width * 0.6
                                startY: volumeHDMIHandle.height / 2 + (volumeHDMIShape.height - volumeHDMIHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeHDMIShape.index
                                PathLine {
                                    x: volumeHDMIShape.width
                                    y: volumeHDMIHandle.height / 2 + (volumeHDMIShape.height - volumeHDMIHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeHDMIShape.index
                                }
                            }
                        }
                        Text {
                            text: -5 * volumeHDMIShape.index + rootVolume.maxVolume
                            width: volumeHDMIShape.width * 0.3
                            height: volumeHDMIHandle.height
                            horizontalAlignment: Text.AlignRight
                            x: -volumeHDMIShape.width * 0.1
                            y: (volumeHDMIShape.height - volumeHDMIHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeHDMIShape.index - height * 0.2
                            color: Global.textColor
                            font.pixelSize: height * 0.25
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            MyButton {
                height: parent.height * 0.1
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: Global.settings.language === "zh_CN" ? "静音" : checked ? "UnMute" : "Mute"
                textColor: checked | pressed ? Global.warnColor : Global.textColor
                checked: Global.settings.volumeHDMIMute
                onClicked: {
                    Tendzone.runCmd(Tendzone.Command.lineVolume, new Uint8Array([Tendzone.Audio_Line["HDMI"], Tendzone.Audio_Type["MUTE"], 0, 0, checked ? 0 : 1]));
                    Global.settings.volumeHDMIMute = !checked;
                }
            }

            Text {
                text: Math.floor(((1 - volumeHDMISlider.visualPosition) * (rootVolume.maxVolume - rootVolume.minVolume))) + rootVolume.minVolume + "dB"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height * 0.4
                color: Global.textColor
            }
        }

        Column {
            //volumeMic1
            width: (parent.width + parent.spacing) / rootVolume.volumeCount - parent.spacing
            height: parent.height
            spacing: parent.height * 0.02
            Text {
                id: volumeMic1Label
                text: "Mic1"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.5
                color: Global.textColor
            }
            Slider {
                id: volumeMic1Slider
                width: parent.width * 0.8
                height: parent.height * 0.67
                anchors.horizontalCenter: parent.horizontalCenter
                orientation: Qt.Vertical

                handle: Rectangle {
                    id: volumeMic1Handle
                    implicitWidth: parent.width * 0.4
                    implicitHeight: parent.width * 0.8
                    x: volumeMic1Slider.availableWidth / 2 - width / 2
                    y: volumeMic1Slider.topPadding + volumeMic1Slider.visualPosition * (volumeMic1Slider.availableHeight - height)
                    //opacity: 0.9
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#07111B"
                        }
                        GradientStop {
                            position: 0.1
                            color: "#5598CF"
                        }
                        GradientStop {
                            position: 0.2
                            color: "#182632"
                        }
                        GradientStop {
                            position: 0.48
                            color: "#2F4E69"
                        }
                        GradientStop {
                            position: 0.49
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.50
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.51
                            color: "#385E7E"
                        }
                        GradientStop {
                            position: 0.90
                            color: "#3F6C94"
                        }
                        GradientStop {
                            position: 1.0
                            color: "#07111B"
                        }
                    }
                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: Global.buttonShadowColor
                        shadowHorizontalOffset: volumeMic1Slider.pressed ? Global.shadowHeight / 2 : Global.shadowHeight
                        shadowVerticalOffset: shadowHorizontalOffset * (1 - volumeMic1Slider.position)
                        Behavior on shadowHorizontalOffset {
                            NumberAnimation {
                                duration: Global.durationDelay
                            }
                        }
                    }
                    radius: parent.width * 0.1
                }
                stepSize: 1 / (rootVolume.maxVolume - rootVolume.minVolume)
                snapMode: Slider.SnapAlways

                value: ((Global.settings.volumeMic1 - rootVolume.minVolume) / (rootVolume.maxVolume - rootVolume.minVolume))

                onMoved: {
                    var newVol = Math.floor(((1 - visualPosition) * (rootVolume.maxVolume - rootVolume.minVolume))) + rootVolume.minVolume;
                    if (newVol != Global.settings.volumeMic1) {
                        Global.settings.volumeMic1 = newVol;
                        Global.settings.sync();
                        Tendzone.runCmd(Tendzone.Command.lineVolume, new Uint8Array([Tendzone.Audio_Line["MICIN"], Tendzone.Audio_Type["VOLUME"], 0, 0, 15 - newVol]));
                    }
                }
                background: Shape {
                    id: volumeMic1Back
                    height: parent.height - volumeMic1Handle.height + width
                    width: parent.width * 0.1
                    y: volumeMic1Handle.height / 2 - width / 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: volumeMic1PathRect
                            x: 0
                            y: volumeMic1Back.height - height
                            radius: width / 3
                            width: volumeMic1Back.width
                            height: volumeMic1Back.height
                        }
                        fillGradient: LinearGradient {
                            y1: volumeMic1PathRect.height
                            y2: 0
                            x1: volumeMic1PathRect.width / 2
                            x2: volumeMic1PathRect.width / 2
                            GradientStop {
                                position: 0.6
                                color: "green"
                            }
                            GradientStop {
                                position: 0.8
                                color: "orange"
                            }
                            GradientStop {
                                position: 1
                                color: "red"
                            }
                        }
                    }
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: volumeMic1PathRectangle
                            x: 0
                            y: 0
                            radius: width / 3
                            width: volumeMic1Back.width
                            height: volumeMic1Slider.visualPosition * volumeMic1Back.height
                        }
                        fillGradient: LinearGradient {
                            y1: volumeMic1PathRectangle.height / 2
                            y2: volumeMic1PathRectangle.height / 2
                            x1: 0
                            x2: volumeMic1PathRectangle.width
                            GradientStop {
                                position: 0
                                color: Qt.darker(Global.buttonColor, 1.4)
                            }
                            GradientStop {
                                position: 1
                                color: Global.buttonColor
                            }
                        }
                    }
                }
                contentItem: Repeater {
                    model: (rootVolume.maxVolume - rootVolume.minVolume) / 5 + 1
                    Item {
                        id: volumeMic1Shape
                        required property int index
                        anchors.fill: parent
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: 0
                                startY: volumeMic1Handle.height / 2 + (volumeMic1Shape.height - volumeMic1Handle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeMic1Shape.index
                                PathLine {
                                    x: volumeMic1Shape.width * 0.4
                                    y: volumeMic1Handle.height / 2 + (volumeMic1Shape.height - volumeMic1Handle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeMic1Shape.index
                                }
                            }
                        }
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: volumeMic1Shape.width * 0.6
                                startY: volumeMic1Handle.height / 2 + (volumeMic1Shape.height - volumeMic1Handle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeMic1Shape.index
                                PathLine {
                                    x: volumeMic1Shape.width
                                    y: volumeMic1Handle.height / 2 + (volumeMic1Shape.height - volumeMic1Handle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeMic1Shape.index
                                }
                            }
                        }
                        Text {
                            text: -5 * volumeMic1Shape.index + rootVolume.maxVolume
                            width: volumeMic1Shape.width * 0.3
                            height: volumeMic1Handle.height
                            horizontalAlignment: Text.AlignRight
                            x: -volumeMic1Shape.width * 0.1
                            y: (volumeMic1Shape.height - volumeMic1Handle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeMic1Shape.index - height * 0.2
                            color: Global.textColor
                            font.pixelSize: height * 0.25
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
            MyButton {
                height: parent.height * 0.1
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: Global.settings.language === "zh_CN" ? "静音" : checked ? "UnMute" : "Mute"
                textColor: checked | pressed ? Global.warnColor : Global.textColor
                checked: Global.settings.volumeMic1Mute
                onClicked: {
                    Tendzone.runCmd(Tendzone.Command.lineVolume, new Uint8Array([Tendzone.Audio_Line["MICIN"], Tendzone.Audio_Type["MUTE"], 0, 0, checked ? 0 : 1]));
                    Global.settings.volumeMic1Mute = !checked;
                }
            }

            Text {
                text: Math.floor(((1 - volumeMic1Slider.visualPosition) * (rootVolume.maxVolume - rootVolume.minVolume))) + rootVolume.minVolume + "dB"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height * 0.4
                color: Global.textColor
            }
        }

        Column {
            //volumeMic2
            width: (parent.width + parent.spacing) / rootVolume.volumeCount - parent.spacing
            height: parent.height
            spacing: parent.height * 0.02
            Text {
                id: volumeMic2Label
                text: "Mic2"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.5
                color: Global.textColor
            }
            Slider {
                id: volumeMic2Slider
                width: parent.width * 0.8
                height: parent.height * 0.67
                anchors.horizontalCenter: parent.horizontalCenter
                orientation: Qt.Vertical

                handle: Rectangle {
                    id: volumeMic2Handle
                    implicitWidth: parent.width * 0.4
                    implicitHeight: parent.width * 0.8
                    x: volumeMic2Slider.availableWidth / 2 - width / 2
                    y: volumeMic2Slider.topPadding + volumeMic2Slider.visualPosition * (volumeMic2Slider.availableHeight - height)
                    //opacity: 0.9
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#07111B"
                        }
                        GradientStop {
                            position: 0.1
                            color: "#5598CF"
                        }
                        GradientStop {
                            position: 0.2
                            color: "#182632"
                        }
                        GradientStop {
                            position: 0.48
                            color: "#2F4E69"
                        }
                        GradientStop {
                            position: 0.49
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.50
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.51
                            color: "#385E7E"
                        }
                        GradientStop {
                            position: 0.90
                            color: "#3F6C94"
                        }
                        GradientStop {
                            position: 1.0
                            color: "#07111B"
                        }
                    }
                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: Global.buttonShadowColor
                        shadowHorizontalOffset: volumeMic2Slider.pressed ? Global.shadowHeight / 2 : Global.shadowHeight
                        shadowVerticalOffset: shadowHorizontalOffset * (1 - volumeMic2Slider.position)
                        Behavior on shadowHorizontalOffset {
                            NumberAnimation {
                                duration: Global.durationDelay
                            }
                        }
                    }
                    radius: parent.width * 0.1
                }

                stepSize: 1 / (rootVolume.maxVolume - rootVolume.minVolume)
                snapMode: Slider.SnapAlways

                value: ((Global.settings.volumeMic2 - rootVolume.minVolume) / (rootVolume.maxVolume - rootVolume.minVolume))

                onMoved: {
                    var newVol = Math.floor(((1 - visualPosition) * (rootVolume.maxVolume - rootVolume.minVolume))) + rootVolume.minVolume;
                    if (newVol != Global.settings.volumeMic2) {
                        Global.settings.volumeMic2 = newVol;
                        Global.settings.sync();
                        Tendzone.runCmd(Tendzone.Command.lineVolume, new Uint8Array([Tendzone.Audio_Line["MICIN"], Tendzone.Audio_Type["VOLUME"], 1, 0, 15 - newVol]));
                    }
                }
                background: Shape {
                    id: volumeMic2Back
                    height: parent.height - volumeMic2Handle.height + width
                    width: parent.width * 0.1
                    y: volumeMic2Handle.height / 2 - width / 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: volumeMic2PathRect
                            x: 0
                            y: volumeMic2Back.height - height
                            radius: width / 3
                            width: volumeMic2Back.width
                            height: volumeMic2Back.height
                        }
                        fillGradient: LinearGradient {
                            y1: volumeMic2PathRect.height
                            y2: 0
                            x1: volumeMic2PathRect.width / 2
                            x2: volumeMic2PathRect.width / 2
                            GradientStop {
                                position: 0.6
                                color: "green"
                            }
                            GradientStop {
                                position: 0.8
                                color: "orange"
                            }
                            GradientStop {
                                position: 1
                                color: "red"
                            }
                        }
                    }
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: volumeMic2PathRectangle
                            x: 0
                            y: 0
                            radius: width / 3
                            width: volumeMic2Back.width
                            height: volumeMic2Slider.visualPosition * volumeMic2Back.height
                        }
                        fillGradient: LinearGradient {
                            y1: volumeMic2PathRectangle.height / 2
                            y2: volumeMic2PathRectangle.height / 2
                            x1: 0
                            x2: volumeMic2PathRectangle.width
                            GradientStop {
                                position: 0
                                color: Qt.darker(Global.buttonColor, 1.4)
                            }
                            GradientStop {
                                position: 1
                                color: Global.buttonColor
                            }
                        }
                    }
                }
                contentItem: Repeater {
                    model: (rootVolume.maxVolume - rootVolume.minVolume) / 5 + 1
                    Item {
                        id: volumeMic2Shapes
                        required property int index
                        anchors.fill: parent
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: 0
                                startY: volumeMic2Handle.height / 2 + (volumeMic2Shapes.height - volumeMic2Handle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeMic2Shapes.index
                                PathLine {
                                    x: volumeMic2Shapes.width * 0.4
                                    y: volumeMic2Handle.height / 2 + (volumeMic2Shapes.height - volumeMic2Handle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeMic2Shapes.index
                                }
                            }
                        }
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: volumeMic2Shapes.width * 0.6
                                startY: volumeMic2Handle.height / 2 + (volumeMic2Shapes.height - volumeMic2Handle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeMic2Shapes.index
                                PathLine {
                                    x: volumeMic2Shapes.width
                                    y: volumeMic2Handle.height / 2 + (volumeMic2Shapes.height - volumeMic2Handle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeMic2Shapes.index
                                }
                            }
                        }
                        Text {
                            text: -5 * volumeMic2Shapes.index + rootVolume.maxVolume
                            width: volumeMic2Shapes.width * 0.3
                            height: volumeMic2Handle.height
                            horizontalAlignment: Text.AlignRight
                            x: -volumeMic2Shapes.width * 0.1
                            y: (volumeMic2Shapes.height - volumeMic2Handle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeMic2Shapes.index - height * 0.2
                            color: Global.textColor
                            font.pixelSize: height * 0.25
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            MyButton {
                height: parent.height * 0.1
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: Global.settings.language === "zh_CN" ? "静音" : checked ? "UnMute" : "Mute"
                textColor: checked | pressed ? Global.warnColor : Global.textColor
                checked: Global.settings.volumeMic2Mute
                onClicked: {
                    Tendzone.runCmd(Tendzone.Command.lineVolume, new Uint8Array([Tendzone.Audio_Line["MICIN"], Tendzone.Audio_Type["MUTE"], 1, 0, checked ? 0 : 1]));
                    Global.settings.volumeMic2Mute = !checked;
                }
            }

            Text {
                text: Math.floor(((1 - volumeMic2Slider.visualPosition) * (rootVolume.maxVolume - rootVolume.minVolume))) + rootVolume.minVolume + "dB"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height * 0.4
                color: Global.textColor
            }
        }

        Column {
            //volIP
            width: (parent.width + parent.spacing) / rootVolume.volumeCount - parent.spacing
            height: parent.height
            spacing: parent.height * 0.02
            Text {
                id: volumeIPLabel
                text: "IP"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.5
                color: Global.textColor
            }
            Slider {
                id: volumeIPSlider
                width: parent.width * 0.8
                height: parent.height * 0.67
                anchors.horizontalCenter: parent.horizontalCenter
                orientation: Qt.Vertical

                handle: Rectangle {
                    id: volumeIPHandle
                    implicitWidth: parent.width * 0.4
                    implicitHeight: parent.width * 0.8
                    x: volumeIPSlider.availableWidth / 2 - width / 2
                    y: volumeIPSlider.topPadding + volumeIPSlider.visualPosition * (volumeIPSlider.availableHeight - height)
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#07111B"
                        }
                        GradientStop {
                            position: 0.1
                            color: "#5598CF"
                        }
                        GradientStop {
                            position: 0.2
                            color: "#182632"
                        }
                        GradientStop {
                            position: 0.48
                            color: "#2F4E69"
                        }
                        GradientStop {
                            position: 0.49
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.50
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.51
                            color: "#385E7E"
                        }
                        GradientStop {
                            position: 0.90
                            color: "#3F6C94"
                        }
                        GradientStop {
                            position: 1.0
                            color: "#07111B"
                        }
                    }
                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: Global.buttonShadowColor
                        shadowHorizontalOffset: volumeIPSlider.pressed ? Global.shadowHeight / 2 : Global.shadowHeight
                        shadowVerticalOffset: shadowHorizontalOffset * (1 - volumeIPSlider.position)
                        Behavior on shadowHorizontalOffset {
                            NumberAnimation {
                                duration: Global.durationDelay
                            }
                        }
                    }
                    radius: parent.width * 0.1
                }

                stepSize: 1 / (rootVolume.maxVolume - rootVolume.minVolume)
                snapMode: Slider.SnapAlways

                value: ((Global.settings.volumeIP - rootVolume.minVolume) / (rootVolume.maxVolume - rootVolume.minVolume))

                onMoved: {
                    var newVol = Math.floor(((1 - visualPosition) * (rootVolume.maxVolume - rootVolume.minVolume))) + rootVolume.minVolume;
                    if (newVol != Global.settings.volumeIP) {
                        Global.settings.volumeIP = newVol;
                        Global.settings.sync();
                        Tendzone.runCmd(Tendzone.Command.lineVolume, new Uint8Array([Tendzone.Audio_Line["NETIN"], Tendzone.Audio_Type["VOLUME"], 2, 0, 15 - newVol]));
                    }
                }
                background: Shape {
                    id: volumeIPBack
                    height: parent.height - volumeIPHandle.height + width
                    width: parent.width * 0.1
                    y: volumeIPHandle.height / 2 - width / 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: volumeIPPathRect
                            x: 0
                            y: volumeIPBack.height - height
                            radius: width / 3
                            width: volumeIPBack.width
                            height: volumeIPBack.height
                        }
                        fillGradient: LinearGradient {
                            y1: volumeIPPathRect.height
                            y2: 0
                            x1: volumeIPPathRect.width / 2
                            x2: volumeIPPathRect.width / 2
                            GradientStop {
                                position: 0.6
                                color: "green"
                            }
                            GradientStop {
                                position: 0.8
                                color: "orange"
                            }
                            GradientStop {
                                position: 1
                                color: "red"
                            }
                        }
                    }
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: volumeIPPathRectangle
                            x: 0
                            y: 0
                            radius: width / 3
                            width: volumeIPBack.width
                            height: volumeIPSlider.visualPosition * volumeIPBack.height
                        }
                        fillGradient: LinearGradient {
                            y1: volumeIPPathRectangle.height / 2
                            y2: volumeIPPathRectangle.height / 2
                            x1: 0
                            x2: volumeIPPathRectangle.width
                            GradientStop {
                                position: 0
                                color: Qt.darker(Global.buttonColor, 1.4)
                            }
                            GradientStop {
                                position: 1
                                color: Global.buttonColor
                            }
                        }
                    }
                }
                contentItem: Repeater {
                    model: (rootVolume.maxVolume - rootVolume.minVolume) / 5 + 1
                    Item {
                        id: volumeIPShape
                        required property int index
                        anchors.fill: parent
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: 0
                                startY: volumeIPHandle.height / 2 + (volumeIPShape.height - volumeIPHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeIPShape.index
                                PathLine {
                                    x: volumeIPShape.width * 0.4
                                    y: volumeIPHandle.height / 2 + (volumeIPShape.height - volumeIPHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeIPShape.index
                                }
                            }
                        }
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: volumeIPShape.width * 0.6
                                startY: volumeIPHandle.height / 2 + (volumeIPShape.height - volumeIPHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeIPShape.index
                                PathLine {
                                    x: volumeIPShape.width
                                    y: volumeIPHandle.height / 2 + (volumeIPShape.height - volumeIPHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeIPShape.index
                                }
                            }
                        }
                        Text {
                            text: -5 * volumeIPShape.index + rootVolume.maxVolume
                            width: volumeIPShape.width * 0.3
                            height: volumeIPHandle.height
                            horizontalAlignment: Text.AlignRight
                            x: -parent.parent.width * 0.1
                            y: (volumeIPShape.height - volumeIPHandle.height) / (rootVolume.maxVolume - rootVolume.minVolume) * 5 * volumeIPShape.index - height * 0.2
                            color: Global.textColor
                            font.pixelSize: height * 0.25
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            MyButton {
                height: parent.height * 0.1
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: Global.settings.language === "zh_CN" ? "静音" : checked ? "UnMute" : "Mute"
                textColor: checked | pressed ? Global.warnColor : Global.textColor
                checked: Global.settings.volumeIPMute
                onClicked: {
                    Tendzone.runCmd(Tendzone.Command.lineVolume, new Uint8Array([Tendzone.Audio_Line["NETIN"], Tendzone.Audio_Type["MUTE"], 2, 2, checked ? 0 : 1]));
                    Global.settings.volumeIPMute = !checked;
                }
            }

            Text {
                text: Math.floor(((1 - volumeIPSlider.visualPosition) * (rootVolume.maxVolume - rootVolume.minVolume))) + rootVolume.minVolume + "dB"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height * 0.4
                color: Global.textColor
            }
        }
    }

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

    onOpened: Tendzone.runCmd(Tendzone.Command.subGlobalVolume, false)
    onClosed: Tendzone.runCmd(Tendzone.Command.subGlobalVolume, true)
}
