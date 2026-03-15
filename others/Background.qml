import QtQuick
import "../"

Rectangle {
    id: rootRect
    property color bgColor: Global.bgColor
    property real bgRadius: parent.width * 0.03

    gradient: Gradient {
        GradientStop {
            position: 1
            color: Qt.lighter(rootRect.bgColor, 1.5)
        }
        GradientStop {
            position: 0.6
            color: rootRect.bgColor
        }
    }
    radius: bgRadius
}
