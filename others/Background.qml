import QtQuick
import "../"

Rectangle {
    id: rootRect
    property color bgColor: Global.bgColor
    property real bgRadius: parent.height * 0.03

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: rootRect.bgColor
        }
        GradientStop {
            position: 0.4
            color: Qt.darker(rootRect.bgColor, 2)
        }
        GradientStop {
            position: 1.0
            color: Qt.darker(rootRect.bgColor, 4)
        }
    }
    radius: bgRadius
}
