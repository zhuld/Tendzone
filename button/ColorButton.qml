import QtQuick
import QtQuick.Controls

import QtQuick.Controls.Fusion

Button {
    id:button
    property color btnColor: "steelblue"
    property color textColor: "whitesmoke"

    text: qsTr("Button")

    background:  Rectangle{
        id: rect
        border.color: Qt.darker(button.btnColor, 3)
        border.width: 2

        gradient: Gradient {
            GradientStop {
                position: 0
                color: button.down | button.checked?  Qt.darker(button.btnColor, 2.5): button.hovered?  Qt.lighter(button.btnColor, 1.2):Qt.lighter(button.btnColor, 1)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            GradientStop {
                position: 0.45
                color: button.down | button.checked?  Qt.darker(button.btnColor, 1.5): button.hovered?  Qt.lighter(button.btnColor, 1): Qt.darker(button.btnColor, 1.3)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            GradientStop {
                position: 0.55
                color: button.down | button.checked?  Qt.darker(button.btnColor, 1.5): button.hovered?  Qt.lighter(button.btnColor, 1): Qt.darker(button.btnColor, 1.3)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            GradientStop {
                position: 1
                color: button.down | button.checked?  Qt.darker(button.btnColor, 1.3): button.hovered?  Qt.darker(button.btnColor, 1.8):Qt.darker(button.btnColor, 2)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
        }

        radius: height*0.1
    }

    contentItem: Text {
        text: button.text
        font.pixelSize: button.height*0.4
        color: button.down | button.checked? Qt.lighter(button.textColor, 1.4) :Qt.darker(button.textColor, 1.2)
        wrapMode: Text.Wrap
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
    }
    //opacity: enabled? 1:0.5
}
