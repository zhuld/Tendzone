import QtQuick
import QtQuick.Controls.Fusion
Window {
    id: splash
    color: "transparent"
    title: "Splash Window"
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen
    property int timeoutInterval: 2000
    signal timeout

    width: Screen.width
    height: Screen.height

    Image {
        id: splashImage
        anchors.fill: parent
        source: "pic/splash.jpg"
        fillMode: Image.Stretch
    }
    Rectangle{
        id:splashProcessBar
        property real processValue: 0
        width: parent.width*processValue
        height: parent.height*0.02
        anchors.bottom:  parent.bottom

        gradient: Gradient {
            GradientStop { position: 1.0; color: "#12B545" }
            GradientStop { position: 0.0; color: "#2233B5E5" }
        }
        NumberAnimation {
            id: processAnimation
            target: splashProcessBar
            property: "processValue"
            from: 0.0
            to: 1.0
            duration: splash.timeoutInterval
        }
    }

    Timer{
        id: splashTimer
        interval: splash.timeoutInterval
        running: true
        onTriggered:  {
            splash.timeout()
            splash.close()
        }
    }

    Component.onCompleted: processAnimation.start()
}
