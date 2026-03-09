import QtQuick
import QtQuick.Controls.impl
import "../"

IconLabel {
    icon.height: height * 0.4
    icon.width: height * 0.4
    icon.color: Global.buttonTextColor
    color: Global.buttonTextColor
    spacing: height * 0.05
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
