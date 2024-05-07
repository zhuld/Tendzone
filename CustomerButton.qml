import QtQuick
import QtQuick.Controls

Button {
    id:control
    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        gradient: Gradient {
            GradientStop { position: 1.0; color: "#00A2E8" }
            GradientStop { position: 0.0; color: "#99D9EA" }
        }
        radius: height*0.2
        border.color: control.down ? "#17a81a" : "#21be2b"
        border.width: 1
    }
}

