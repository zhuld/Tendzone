pragma Singleton

import QtQuick
import QtCore

QtObject {
    readonly property color textColor: settings.darkTheme ? "#33B5E5" : "#33B5E5"
    readonly property color warnColor: settings.darkTheme ? "darkRed" : "Red"
    readonly property color confirmColor: settings.darkTheme ? "darkGreen" : "green"
    readonly property color buttonColor: settings.darkTheme ? "steelblue" : "steelblue"
    readonly property color buttonTextColor: settings.darkTheme ? "whitesmoke" : "whitesmoke"
    readonly property color bgColor: settings.darkTheme ? "#085360" : "#085360"
    readonly property color overlayColor: settings.darkTheme ? "#A0000000" : "#A0000000"

    property var settings: Settings {
        property bool darkTheme: true
        property string ipAddress: "192.168.1.1"
        property string ipPort: "9880"
        property int projector: 0
        property bool whiteboard: true
        property bool wireless: true
        property bool fullscreen: true
        property string settingPassword: "123"
        property string lockPassword: "123"
        property bool lock: false
        property int socketError: 30
        property bool webSocketServer: false
        property int webSocketServerPort: 9880
        property bool debugInfo: false
        property string phoneNumber: ""
        property int volumeHDMI: -10
        property int volumeMic1: -10
        property int volumeMic2: -10
        property int volumeIR1: -10
        property int volumeIR2: -10
        property int volumeIP: -10
        property bool volumeMute: false
        property bool volumeHDMIMute: false
        property bool volumeMic1Mute: false
        property bool volumeMic2Mute: false
        property bool volumeIR1Mute: false
        property bool volumeIR2Mute: false
        property bool volumeIPMute: false
    }
}
