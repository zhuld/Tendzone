import QtQuick

import "../"

Item {
    id: root
    property string label
    property string text
    property color color: Global.textColor

    signal clicked
    Column {
        id: rect
        width: parent.width
        height: parent.height
        spacing: height * 0.02
        Text {
            width: parent.width
            height: parent.height * 0.6
            font.pixelSize: height * 0.7
            horizontalAlignment: Text.AlignHCenter
            color: root.color
            text: root.label
        }
        Text {
            width: parent.width
            height: parent.height * 0.3
            font.pixelSize: height * 0.7
            horizontalAlignment: Text.AlignHCenter
            color: root.color
            text: root.text
        }
        Rectangle {
            width: parent.width
            height: parent.height * 0.03
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 1.0
                    color: "transparent"
                }
                GradientStop {
                    position: 0.6
                    color: root.color
                }
                GradientStop {
                    position: 0.0
                    color: "transparent"
                }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
