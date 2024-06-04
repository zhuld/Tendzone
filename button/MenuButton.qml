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
            height: parent.height*0.7
            font.pixelSize: height*0.7
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
