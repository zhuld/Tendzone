import QtQuick


import QtQuick.Controls.Fusion
Item {
    id:root
    property alias label: label.text
    property alias text: text.text
    property alias color: label.color

    signal clicked()
    Rectangle {
        id:rect
        width: parent.width
        height: parent.height*0.97

        color: "transparent"
        Text {
            width: parent.width
            height: parent.height*0.70
            font.pixelSize: height*0.8
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#33B5E5"
            id: label
            text: label
        }
        Text {
            width: parent.width
            height: parent.height*0.3
            anchors.top: label.bottom
            font.pixelSize: height*0.7
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: label.color
            id: text
            text: text
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true;
            onClicked: root.clicked()
            onEntered: enterAnim.start()
            onExited: exitAnim.start()
        }
        ColorAnimation {
            id:enterAnim
            target: rect
            property: "color"
            from: "transparent"
            to: Qt.alpha(label.color,0.3)
            duration: 300
        }
        ColorAnimation {
            id:exitAnim
            target: rect
            property: "color"
            to: "transparent"
            from: Qt.alpha(label.color,0.3)
            duration: 300
        }
    }
    Rectangle{
        width: parent.width
        height: parent.height*0.03
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 1.0; color: "transparent" }
            GradientStop { position: 0.6; color: label.color }
            GradientStop { position: 0.0; color: "transparent" }
        }
        anchors.top: rect.bottom
    }
}
