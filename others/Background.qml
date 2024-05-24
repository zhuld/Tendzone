import QtQuick

Rectangle{
    property color bgColor: "#085360"
    property real bgRadius: parent.height*0.03

    gradient: Gradient {
        GradientStop { position: 0.0; color: bgColor }
        GradientStop { position: 0.4; color: Qt.darker(bgColor,2) }
        GradientStop { position: 1.0; color: Qt.darker(bgColor,4) }
    }
    radius: bgRadius
}
