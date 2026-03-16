pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Templates as T

import "../"

T.Button {
    id: controlMySwitch

    implicitHeight: parent.height
    implicitWidth: parent.width
    height: 30
    width: 60

    indicator: Rectangle {
        width: height * 2
        height: parent.height * 0.5
        radius: height * 0.5
        color: controlMySwitch.checked ? Global.buttonCheckedColor : Global.buttonColor
        border.color: Global.buttonTextColor
        x: height / 2
        anchors.verticalCenter: parent.verticalCenter
        Behavior on color {
            ColorAnimation {
                duration: Global.durationDelay
            }
        }
        Rectangle {
            x: controlMySwitch.checked ? parent.width - parent.height : parent.height - height
            width: parent.height * 1.6
            height: width
            radius: height * 0.5
            color: Global.bgColor
            border.color: Global.buttonTextColor
            anchors.verticalCenter: parent.verticalCenter
            Text {
                anchors.centerIn: parent
                text: "✓"
                opacity: controlMySwitch.checked ? 1 : 0
                color: Global.buttonCheckedColor
                font.pixelSize: parent.height * 0.8
                Behavior on opacity {
                    NumberAnimation {
                        easing.type: Easing.InOutQuad
                        duration: Global.durationDelay
                    }
                }
            }
            Behavior on x {
                NumberAnimation {
                    easing.type: Easing.InOutCubic
                    duration: Global.durationDelay
                }
            }
            layer.enabled: true
            layer.samples: 16
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: Global.buttonShadowColor
                shadowHorizontalOffset: Global.shadowHeight / 2
                shadowVerticalOffset: shadowHorizontalOffset
            }
        }
    }
    contentItem: Text {
        height: parent.height
        text: controlMySwitch.text
        font.pixelSize: height * 0.7
        anchors.left: controlMySwitch.indicator.right
        leftPadding: height * 0.5
        color: Global.buttonTextColor
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }
    onClicked: checked = !checked
}
