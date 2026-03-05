pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import "../button/"
import "../others/"
import "../"
import "../js/tendzone.js" as Tendzone

import QtQuick.Controls.Fusion

Dialog {
    id: rootVolume
    implicitHeight: parent.height * 0.9
    implicitWidth: parent.width * 0.70

    readonly property int miniVolume: -30
    readonly property int maxVolume: 0

    property int globalVolume

    property alias volumeLabel: volumeGlobalLabel.text
    property alias volumeHDMiLabel: volumeHDMILabel.text

    property real volumeWidth: 0.13

    anchors.centerIn: parent

    modal: true

    background: Background {}

    Row {
        anchors.fill: parent
        anchors.leftMargin: width * 0.05
        spacing: width * 0.07

        Column {
            //volumeGlobal
            width: parent.width * rootVolume.volumeWidth
            height: parent.height
            spacing: parent.height * 0.02
            Text {
                id: volumeGlobalLabel
                text: "VOL"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.6
                color: Global.textColor
            }
            Slider {
                id: volumeGlobalSlider
                width: parent.width * 0.6
                height: parent.height * 0.67
                orientation: Qt.Vertical
                handle: Rectangle {
                    id: volumeGlobalHandle
                    implicitWidth: parent.width * 0.5
                    implicitHeight: parent.width * 1.2
                    x: volumeGlobalSlider.leftPadding
                       + volumeGlobalSlider.availableWidth / 2 - width / 2
                    y: volumeGlobalSlider.topPadding + volumeGlobalSlider.visualPosition
                       * (volumeGlobalSlider.availableHeight - height)
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
                            position: 0.52
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.53
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
                    radius: parent.width * 0.1
                }

                stepSize: 1 / (rootVolume.maxVolume - rootVolume.miniVolume)
                snapMode: Slider.SnapAlways

                value: ((rootVolume.globalVolume - rootVolume.miniVolume)
                        / (rootVolume.maxVolume - rootVolume.miniVolume))

                onMoved: {
                    var newVol = ((1 - visualPosition) * (rootVolume.maxVolume
                                                          - rootVolume.miniVolume))
                    + rootVolume.miniVolume
                    if (newVol !== rootVolume.globalVolume) {
                        Tendzone.runCmd(Tendzone.Command.globalVolume,
                                        15 - newVol)
                    }
                }

                Repeater {
                    model: ListModel {
                        ListElement {
                            value: 0
                        }
                        ListElement {
                            value: 1
                        }
                        ListElement {
                            value: 2
                        }
                        ListElement {
                            value: 3
                        }
                        ListElement {
                            value: 4
                        }
                        ListElement {
                            value: 5
                        }
                        ListElement {
                            value: 6
                        }
                    }
                    Item {
                        id: volumeGlobalShape
                        required property int value
                        anchors.fill: parent
                        Shape {
                            //刻度线左
                            anchors.fill: parent
                            ShapePath {
                                //required property int value
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: 0
                                startY: volumeGlobalHandle.height / 2
                                        + (volumeGlobalShape.height - volumeGlobalHandle.height)
                                        / 6 * volumeGlobalShape.value
                                PathLine {
                                    x: volumeGlobalShape.width * 0.4
                                    y: volumeGlobalHandle.height / 2
                                       + (volumeGlobalShape.height - volumeGlobalHandle.height)
                                       / 6 * volumeGlobalShape.value
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
                                startY: volumeGlobalHandle.height / 2
                                        + (volumeGlobalShape.height - volumeGlobalHandle.height)
                                        / 6 * volumeGlobalShape.value
                                PathLine {
                                    x: volumeGlobalShape.width * 0.9
                                    y: volumeGlobalHandle.height / 2
                                       + (volumeGlobalShape.height - volumeGlobalHandle.height)
                                       / 6 * volumeGlobalShape.value
                                }
                            }
                        }
                        Text {
                            text: -5 * volumeGlobalShape.value
                            width: volumeGlobalShape.width
                            height: volumeGlobalHandle.height
                            x: volumeGlobalShape.width
                            y: (volumeGlobalShape.height - volumeGlobalHandle.height)
                               / 6 * volumeGlobalShape.value
                            color: Global.textColor
                            font.pixelSize: height * 0.4
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            ColorButton {
                height: parent.height * 0.1
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: "M"
                textColor: checked | pressed ? Global.warnColor : Global.textColor
                checked: Global.settings.volumeMute
                onClicked: Tendzone.runCmd(Tendzone.Command.Amp,
                                           checked ? 1 : 0)
            }

            Text {
                text: ((1 - volumeGlobalSlider.visualPosition)
                       * (rootVolume.maxVolume - rootVolume.miniVolume))
                      + rootVolume.miniVolume + "dB"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height * 0.5
                color: Global.textColor
            }
        }

        Column {
            //volumeHDMI
            width: parent.width * rootVolume.volumeWidth
            height: parent.height
            spacing: parent.height * 0.02
            Text {
                id: volumeHDMILabel
                text: "PC"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.6
                color: Global.textColor
            }
            Slider {
                id: volumeHDMISlider
                width: parent.width * 0.6
                height: parent.height * 0.67
                orientation: Qt.Vertical

                handle: Rectangle {
                    id: volumeHDMIHandle
                    implicitWidth: parent.width * 0.5
                    implicitHeight: parent.width * 1.2
                    x: volumeHDMISlider.leftPadding
                       + volumeHDMISlider.availableWidth / 2 - width / 2
                    y: volumeHDMISlider.topPadding + volumeHDMISlider.visualPosition
                       * (volumeHDMISlider.availableHeight - height)
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
                            position: 0.52
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.53
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
                    radius: parent.width * 0.1
                }

                stepSize: 1 / (rootVolume.maxVolume - rootVolume.miniVolume)
                snapMode: Slider.SnapAlways

                value: ((Global.settings.volumeHDMI - rootVolume.miniVolume)
                        / (rootVolume.maxVolume - rootVolume.miniVolume))

                onMoved: {
                    var newVol = ((1 - visualPosition) * (rootVolume.maxVolume
                                                          - rootVolume.miniVolume))
                    + rootVolume.miniVolume
                    if (newVol != Global.settings.volumeHDMI) {
                        Global.settings.volumeHDMI = newVol
                        Global.settings.sync()
                        Tendzone.runCmd(
                            Tendzone.Command.lineVolume,
                            new Uint8Array([Tendzone.Audio_Line["HDMI"], Tendzone.Audio_Type["VOLUME"], 0, 0, 15 - newVol]))
                    }
                }

                Repeater {
                    model: ListModel {
                        ListElement {
                            value: 0
                        }
                        ListElement {
                            value: 1
                        }
                        ListElement {
                            value: 2
                        }
                        ListElement {
                            value: 3
                        }
                        ListElement {
                            value: 4
                        }
                        ListElement {
                            value: 5
                        }
                        ListElement {
                            value: 6
                        }
                    }
                    Item {
                        id: volumeHDMIShape
                        required property int value
                        anchors.fill: parent
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                //required property int value
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: 0
                                startY: volumeHDMIHandle.height / 2
                                        + (volumeHDMIShape.height - volumeHDMIHandle.height)
                                        / 6 * volumeHDMIShape.value
                                PathLine {
                                    x: volumeHDMIShape.width * 0.4
                                    y: volumeHDMIHandle.height / 2
                                       + (volumeHDMIShape.height - volumeHDMIHandle.height)
                                       / 6 * volumeHDMIShape.value
                                }
                            }
                        }
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                //required property int value
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: volumeHDMIShape.width * 0.6
                                startY: volumeHDMIHandle.height / 2
                                        + (volumeHDMIShape.height - volumeHDMIHandle.height)
                                        / 6 * volumeHDMIShape.value
                                PathLine {
                                    x: volumeHDMIShape.width * 0.9
                                    y: volumeHDMIHandle.height / 2
                                       + (volumeHDMIShape.height - volumeHDMIHandle.height)
                                       / 6 * volumeHDMIShape.value
                                }
                            }
                        }
                        Text {
                            text: -5 * volumeHDMIShape.value
                            width: volumeHDMIShape.width
                            height: volumeHDMIHandle.height
                            x: volumeHDMIShape.width
                            y: (volumeHDMIShape.height - volumeHDMIHandle.height)
                               / 6 * volumeHDMIShape.value
                            color: Global.textColor
                            font.pixelSize: height * 0.4
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            ColorButton {
                height: parent.height * 0.1
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: "M"
                textColor: checked | pressed ? Global.warnColor : Global.textColor
                checked: Global.settings.volumeHDMIMute
                onClicked: {
                    Tendzone.runCmd(
                        Tendzone.Command.lineVolume,
                        new Uint8Array([Tendzone.Audio_Line["HDMI"], Tendzone.Audio_Type["MUTE"], 0, 0, checked ? 0 : 1]))
                    Global.settings.volumeHDMIMute = !checked
                }
            }

            Text {
                text: ((1 - volumeHDMISlider.visualPosition)
                       * (rootVolume.maxVolume - rootVolume.miniVolume))
                      + rootVolume.miniVolume + "dB"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height * 0.5
                color: Global.textColor
            }
        }

        Column {
            //volumeMic1
            width: parent.width * rootVolume.volumeWidth
            height: parent.height
            spacing: parent.height * 0.02
            Text {
                id: volumeMic1Label
                text: "Mic1"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.6
                color: Global.textColor
            }
            Slider {
                id: volumeMic1Slider
                width: parent.width * 0.6
                height: parent.height * 0.67
                orientation: Qt.Vertical

                handle: Rectangle {
                    id: volumeMic1Handle
                    implicitWidth: parent.width * 0.5
                    implicitHeight: parent.width * 1.2
                    x: volumeMic1Slider.leftPadding
                       + volumeMic1Slider.availableWidth / 2 - width / 2
                    y: volumeMic1Slider.topPadding + volumeMic1Slider.visualPosition
                       * (volumeMic1Slider.availableHeight - height)
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
                            position: 0.52
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.53
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
                    radius: parent.width * 0.1
                }
                stepSize: 1 / (rootVolume.maxVolume - rootVolume.miniVolume)
                snapMode: Slider.SnapAlways

                value: ((Global.settings.volumeMic1 - rootVolume.miniVolume)
                        / (rootVolume.maxVolume - rootVolume.miniVolume))

                onMoved: {
                    var newVol = ((1 - visualPosition) * (rootVolume.maxVolume
                                                          - rootVolume.miniVolume))
                    + rootVolume.miniVolume
                    if (newVol != Global.settings.volumeMic1) {
                        Global.settings.volumeMic1 = newVol
                        Global.settings.sync()
                        Tendzone.runCmd(
                            Tendzone.Command.lineVolume,
                            new Uint8Array([Tendzone.Audio_Line["MICIN"], Tendzone.Audio_Type["VOLUME"], 0, 0, 15 - newVol]))
                    }
                }

                Repeater {
                    model: ListModel {
                        ListElement {
                            value: 0
                        }
                        ListElement {
                            value: 1
                        }
                        ListElement {
                            value: 2
                        }
                        ListElement {
                            value: 3
                        }
                        ListElement {
                            value: 4
                        }
                        ListElement {
                            value: 5
                        }
                        ListElement {
                            value: 6
                        }
                    }
                    Item {
                        id: volumeMic1Shape
                        required property int value
                        anchors.fill: parent
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: 0
                                startY: volumeMic1Handle.height / 2
                                        + (volumeMic1Shape.height - volumeMic1Handle.height)
                                        / 6 * volumeMic1Shape.value
                                PathLine {
                                    x: volumeMic1Shape.width * 0.4
                                    y: volumeMic1Handle.height / 2
                                       + (volumeMic1Shape.height - volumeMic1Handle.height)
                                       / 6 * volumeMic1Shape.value
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
                                startY: volumeMic1Handle.height / 2
                                        + (volumeMic1Shape.height - volumeMic1Handle.height)
                                        / 6 * volumeMic1Shape.value
                                PathLine {
                                    x: volumeMic1Shape.width * 0.9
                                    y: volumeMic1Handle.height / 2
                                       + (volumeMic1Shape.height - volumeMic1Handle.height)
                                       / 6 * volumeMic1Shape.value
                                }
                            }
                        }
                        Text {
                            text: -5 * volumeMic1Shape.value
                            width: volumeMic1Shape.width
                            height: volumeMic1Handle.height
                            x: volumeMic1Shape.width
                            y: (volumeMic1Shape.height - volumeMic1Handle.height)
                               / 6 * volumeMic1Shape.value
                            color: Global.textColor
                            font.pixelSize: height * 0.4
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
            ColorButton {
                height: parent.height * 0.1
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: "M"
                textColor: checked | pressed ? Global.warnColor : Global.textColor
                checked: Global.settings.volumeMic1Mute
                onClicked: {
                    Tendzone.runCmd(
                        Tendzone.Command.lineVolume,
                        new Uint8Array([Tendzone.Audio_Line["MICIN"], Tendzone.Audio_Type["MUTE"], 0, 0, checked ? 0 : 1]))
                    Global.settings.volumeMic1Mute = !checked
                }
            }

            Text {
                text: ((1 - volumeMic1Slider.visualPosition)
                       * (rootVolume.maxVolume - rootVolume.miniVolume))
                      + rootVolume.miniVolume + "dB"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height * 0.5
                color: Global.textColor
            }
        }

        Column {
            //volumeMic2
            width: parent.width * rootVolume.volumeWidth
            height: parent.height
            spacing: parent.height * 0.02
            Text {
                id: volumeMic2Label
                text: "Mic2"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.6
                color: Global.textColor
            }
            Slider {
                id: volumeMic2Slider
                width: parent.width * 0.6
                height: parent.height * 0.67
                orientation: Qt.Vertical

                handle: Rectangle {
                    id: volumeMic2Handle
                    implicitWidth: parent.width * 0.5
                    implicitHeight: parent.width * 1.2
                    x: volumeMic2Slider.leftPadding
                       + volumeMic2Slider.availableWidth / 2 - width / 2
                    y: volumeMic2Slider.topPadding + volumeMic2Slider.visualPosition
                       * (volumeMic2Slider.availableHeight - height)
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
                            position: 0.52
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.53
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
                    radius: parent.width * 0.1
                }

                stepSize: 1 / (rootVolume.maxVolume - rootVolume.miniVolume)
                snapMode: Slider.SnapAlways

                value: ((Global.settings.volumeMic2 - rootVolume.miniVolume)
                        / (rootVolume.maxVolume - rootVolume.miniVolume))

                onMoved: {
                    var newVol = ((1 - visualPosition) * (rootVolume.maxVolume
                                                          - rootVolume.miniVolume))
                    + rootVolume.miniVolume
                    if (newVol != Global.settings.volumeMic2) {
                        Global.settings.volumeMic2 = newVol
                        Global.settings.sync()
                        Tendzone.runCmd(
                            Tendzone.Command.lineVolume,
                            new Uint8Array([Tendzone.Audio_Line["MICIN"], Tendzone.Audio_Type["VOLUME"], 1, 0, 15 - newVol]))
                    }
                }

                Repeater {
                    model: ListModel {
                        ListElement {
                            value: 0
                        }
                        ListElement {
                            value: 1
                        }
                        ListElement {
                            value: 2
                        }
                        ListElement {
                            value: 3
                        }
                        ListElement {
                            value: 4
                        }
                        ListElement {
                            value: 5
                        }
                        ListElement {
                            value: 6
                        }
                    }
                    Item {
                        id: volumeMic2Shapes
                        required property int value
                        anchors.fill: parent
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: 0
                                startY: volumeMic2Handle.height / 2
                                        + (volumeMic2Shapes.height - volumeMic2Handle.height)
                                        / 6 * volumeMic2Shapes.value
                                PathLine {
                                    x: volumeMic2Shapes.width * 0.4
                                    y: volumeMic2Handle.height / 2
                                       + (volumeMic2Shapes.height - volumeMic2Handle.height)
                                       / 6 * volumeMic2Shapes.value
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
                                startY: volumeMic2Handle.height / 2
                                        + (volumeMic2Shapes.height - volumeMic2Handle.height)
                                        / 6 * volumeMic2Shapes.value
                                PathLine {
                                    x: volumeMic2Shapes.width * 0.9
                                    y: volumeMic2Handle.height / 2
                                       + (volumeMic2Shapes.height - volumeMic2Handle.height)
                                       / 6 * volumeMic2Shapes.value
                                }
                            }
                        }
                        Text {
                            text: -5 * volumeMic2Shapes.value
                            width: volumeMic2Shapes.width
                            height: volumeMic2Handle.height
                            x: volumeMic2Shapes.width
                            y: (volumeMic2Shapes.height - volumeMic2Handle.height)
                               / 6 * volumeMic2Shapes.value
                            color: Global.textColor
                            font.pixelSize: height * 0.4
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            ColorButton {
                height: parent.height * 0.1
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: "M"
                textColor: checked | pressed ? Global.warnColor : Global.textColor
                checked: Global.settings.volumeMic2Mute
                onClicked: {
                    Tendzone.runCmd(
                        Tendzone.Command.lineVolume,
                        new Uint8Array([Tendzone.Audio_Line["MICIN"], Tendzone.Audio_Type["MUTE"], 1, 0, checked ? 0 : 1]))
                    Global.settings.volumeMic2Mute = !checked
                }
            }

            Text {
                text: ((1 - volumeMic2Slider.visualPosition)
                       * (rootVolume.maxVolume - rootVolume.miniVolume))
                      + rootVolume.miniVolume + "dB"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height * 0.5
                color: Global.textColor
            }
        }

        Column {
            //volIP
            width: parent.width * rootVolume.volumeWidth
            height: parent.height
            spacing: parent.height * 0.02
            Text {
                id: volumeIPLabel
                text: "IP"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.6
                color: Global.textColor
            }
            Slider {
                id: volumeIPSlider
                width: parent.width * 0.6
                height: parent.height * 0.67
                orientation: Qt.Vertical

                handle: Rectangle {
                    id: volumeIPHandle
                    implicitWidth: parent.width * 0.5
                    implicitHeight: parent.width * 1.2
                    x: volumeIPSlider.leftPadding + volumeIPSlider.availableWidth / 2 - width / 2
                    y: volumeIPSlider.topPadding + volumeIPSlider.visualPosition
                       * (volumeIPSlider.availableHeight - height)
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
                            position: 0.52
                            color: "#FFFFFF"
                        }
                        GradientStop {
                            position: 0.53
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
                    radius: parent.width * 0.1
                }

                stepSize: 1 / (rootVolume.maxVolume - rootVolume.miniVolume)
                snapMode: Slider.SnapAlways

                value: ((Global.settings.volumeIP - rootVolume.miniVolume)
                        / (rootVolume.maxVolume - rootVolume.miniVolume))

                onMoved: {
                    var newVol = ((1 - visualPosition) * (rootVolume.maxVolume
                                                          - rootVolume.miniVolume))
                    + rootVolume.miniVolume
                    if (newVol != Global.settings.volumeIP) {
                        Global.settings.volumeIP = newVol
                        Global.settings.sync()
                        Tendzone.runCmd(
                            Tendzone.Command.lineVolume,
                            new Uint8Array([Tendzone.Audio_Line["NETIN"], Tendzone.Audio_Type["VOLUME"], 2, 0, 15 - newVol]))
                    }
                }

                Repeater {
                    model: ListModel {
                        ListElement {
                            value: 0
                        }
                        ListElement {
                            value: 1
                        }
                        ListElement {
                            value: 2
                        }
                        ListElement {
                            value: 3
                        }
                        ListElement {
                            value: 4
                        }
                        ListElement {
                            value: 5
                        }
                        ListElement {
                            value: 6
                        }
                    }
                    Item {
                        id: volumeIPShape
                        required property int value
                        anchors.fill: parent
                        Shape {
                            //刻度线
                            anchors.fill: parent
                            ShapePath {
                                strokeColor: Global.textColor
                                strokeWidth: 2
                                startX: 0
                                startY: volumeIPHandle.height / 2
                                        + (volumeIPShape.height - volumeIPHandle.height)
                                        / 6 * volumeIPShape.value
                                PathLine {
                                    x: volumeIPShape.width * 0.4
                                    y: volumeIPHandle.height / 2
                                       + (volumeIPShape.height - volumeIPHandle.height)
                                       / 6 * volumeIPShape.value
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
                                startY: volumeIPHandle.height / 2
                                        + (volumeIPShape.height - volumeIPHandle.height)
                                        / 6 * volumeIPShape.value
                                PathLine {
                                    x: volumeIPShape.width * 0.9
                                    y: volumeIPHandle.height / 2
                                       + (volumeIPShape.height - volumeIPHandle.height)
                                       / 6 * volumeIPShape.value
                                }
                            }
                        }
                        Text {
                            text: -5 * volumeIPShape.value
                            width: volumeIPShape.width
                            height: volumeIPHandle.height
                            x: parent.parent.width
                            y: (volumeIPShape.height - volumeIPHandle.height)
                               / 6 * volumeIPShape.value
                            color: Global.textColor
                            font.pixelSize: height * 0.4
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            ColorButton {
                height: parent.height * 0.1
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: "M"
                textColor: checked | pressed ? Global.warnColor : Global.textColor
                checked: Global.settings.volumeIPMute
                onClicked: {
                    Tendzone.runCmd(
                        Tendzone.Command.lineVolume,
                        new Uint8Array([Tendzone.Audio_Line["NETIN"], Tendzone.Audio_Type["MUTE"], 2, 2, checked ? 0 : 1]))
                    Global.settings.volumeIPMute = !checked
                }
            }

            Text {
                text: ((1 - volumeIPSlider.visualPosition)
                       * (rootVolume.maxVolume - rootVolume.miniVolume))
                      + rootVolume.miniVolume + "dB"
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.pixelSize: height * 0.5
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

    onOpened: Tendzone.runCmd(Tendzone.Command.subGlobalVolume, false)
    onClosed: Tendzone.runCmd(Tendzone.Command.subGlobalVolume, true)
}
