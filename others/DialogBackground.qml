import QtQuick
import "../"

Rectangle {
    id: rootRect
    property color bgColor: Global.bgColor
    property real bgRadius: parent.width * 0.03
    property real titleHeight: 0.28

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: Qt.lighter(rootRect.bgColor, 1.5)
        }
        GradientStop {
            position: rootRect.titleHeight - 0.01
            color: Qt.lighter(rootRect.bgColor, 1.2)
        }
        GradientStop {
            position: rootRect.titleHeight
            color: Qt.darker(rootRect.bgColor, 2)
        }
        GradientStop {
            position: rootRect.titleHeight + 0.06
            color: rootRect.bgColor
        }
    }
    radius: bgRadius
}
