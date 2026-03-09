pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Templates as T

import "../"

T.Button {
    id: controlMyButton
    property color btnColor: Global.buttonColor
    property color btnCheckColor: Global.buttonCheckedColor

    property real radius: controlMyButton.height / 5

    property color textColor: controlMyButton.checked
                              || controlMyButton.pressed ? Global.buttonTextCheckedColor : Global.buttonTextColor

    implicitHeight: parent.height
    implicitWidth: parent.width
    font.pixelSize: height * 0.35
    opacity: enabled ? 1 : Global.disableOpacity
    Behavior on opacity {
        OpacityAnimator {
            duration: Global.durationDelay
        }
    }
    contentItem: MyIconLabel {
        anchors.fill: back
        font.pixelSize: controlMyButton.font.pixelSize
        color: controlMyButton.textColor
        icon.color: controlMyButton.textColor
        icon.source: controlMyButton.icon.source
        text: controlMyButton.text
    }
    background: Shape {
        id: back
        height: parent.height
        width: parent.width
        y: controlMyButton.checked ? height / 40 : 0
        Behavior on y {
            NumberAnimation {
                duration: Global.durationDelay
            }
        }
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: controlMyButton.enabled ? (controlMyButton.checked
                                                             || controlMyButton.pressed ? Global.shadowHeight / 2 : Global.shadowHeight) : Global.shadowHeight / 4
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: Global.durationDelay
                }
            }
        }
        ShapePath {
            strokeWidth: 0
            strokeColor: "transparent"
            PathRectangle {
                id: pathRect
                x: 0
                y: 0
                radius: controlMyButton.radius
                width: back.width
                height: back.height
            }
            fillGradient: RadialGradient {
                centerX: back.width * 0.5
                centerY: back.height * 0.5
                centerRadius: back.width
                focalX: 0
                focalY: 0
                GradientStop {
                    position: 0
                    color: controlMyButton.checked
                           || controlMyButton.pressed ? Qt.darker(
                                                            controlMyButton.btnCheckColor,
                                                            1.4) : Qt.darker(
                                                            controlMyButton.btnColor,
                                                            1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                GradientStop {
                    position: 1
                    color: controlMyButton.checked
                           || controlMyButton.pressed ? Qt.lighter(
                                                            controlMyButton.btnCheckColor,
                                                            1.2) : Qt.lighter(
                                                            controlMyButton.btnColor,
                                                            1.2)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
            }
        }
    }
}
