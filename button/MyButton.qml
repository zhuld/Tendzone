pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Templates as T

import "../"

T.Button {
    id: controlMyButton
    property bool switched: controlMyButton.checked || controlMyButton.pressed
    property color btnColor: Global.buttonColor
    property color btnCheckColor: Global.buttonCheckedColor

    property real radius: controlMyButton.height / 5

    property color textColor: switched ? Global.buttonTextCheckedColor : Global.buttonTextColor

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
        Behavior on color {
            ColorAnimation {
                duration: Global.durationDelay
            }
        }
        Behavior on icon.color {
            ColorAnimation {
                duration: Global.durationDelay
            }
        }
    }
    background: Shape {
        id: back
        height: parent.height
        width: parent.width
        y: controlMyButton.switched || !controlMyButton.enabled ? Global.shadowHeight / 2 : 0
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
            shadowVerticalOffset: controlMyButton.enabled ? (controlMyButton.switched ? Global.shadowHeight / 2 : Global.shadowHeight) : Global.shadowHeight / 4
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: Global.durationDelay
                }
            }
        }
        ShapePath {
            strokeWidth: Math.ceil(controlMyButton.width * 0.004)
            strokeColor: Qt.darker(controlMyButton.btnColor, 1.5)
            PathRectangle {
                id: pathRect
                x: 0
                y: 0
                radius: controlMyButton.radius
                width: back.width
                height: back.height
            }

            fillGradient: RadialGradient {
                id: gradient
                property real pos: controlMyButton.switched ? 1 : 0
                centerX: back.width * 0.5
                centerY: back.height * 0.5
                focalX: back.width * 0.5
                focalY: back.height
                centerRadius: Math.max(back.width, back.height)
                Behavior on pos {
                    NumberAnimation {
                        duration: Global.durationDelay
                    }
                }
                GradientStop {
                    position: -0.8 + gradient.pos
                    color: controlMyButton.btnCheckColor
                }
                GradientStop {
                    position: 0 + gradient.pos
                    color: Qt.darker(controlMyButton.btnColor, 1.5)
                }
                GradientStop {
                    position: 1 + gradient.pos
                    color: controlMyButton.btnColor
                }
            }
        }
    }
}
