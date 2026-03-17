pragma Singleton

import QtQuick
import QtCore

QtObject {
    readonly property color textColor: settings.darkTheme ? "#FFCFD2EC" : "#FF0C2B5D"
    readonly property color splitterColor: settings.darkTheme ? "#5A70A8" : "#AEB8C7"
    readonly property color warnColor: settings.darkTheme ? "darkRed" : "orangered"
    readonly property color confirmColor: settings.darkTheme ? "darkGreen" : "green"
    readonly property color overlayColor: settings.darkTheme ? "#C0000000" : "#C0000000"

    readonly property color buttonColor: settings.darkTheme ? "#FF0B79BD" : "#FF81D7FC"
    readonly property color buttonCheckedColor: "#FFFF8E47"
    readonly property color bgColor: settings.darkTheme ? "#FF455681" : "#FFDEEBFE"
    readonly property color buttonTextColor: settings.darkTheme ? "#FFCFD2EC" : "#FF0C2B5D"
    readonly property color buttonTextCheckedColor: settings.darkTheme ? "#FF064063" : "#FFE6E6E6"
    readonly property color buttonShadowColor: settings.darkTheme ? "#FF2E2E4C" : "#FF666C75"

    readonly property int durationDelay: 100
    readonly property real disableOpacity: 0.6

    readonly property real shadowHeight: 4
    readonly property string password: "314159"

    property int projectorHDMI
    property int extendHDMI
    property int monitorHDMI
    property int mubuPower
    property int projectorPower
    property int extensionPower
    property int lockPower

    property string roomName: ""

    enum DialogType {
        PassWordSettings,
        PassWordLockScreen,
        Settings,
        Volume
    }

    property var settings: Settings {
        property bool darkTheme: false
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
        property int volume: -10
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
        property string language: "zh_CN"
    }
}
