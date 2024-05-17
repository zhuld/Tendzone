import QtQuick
import "../dialog/"

Image {

    width: root.width/8
    x:width/6
    y:width/6

    fillMode: Image.PreserveAspectFit
    MouseArea{
        id:mouseArea
        anchors.fill: parent

        onPressAndHold: {
            if(settings.settingPassword ===""){
                settingDialog.open()
            }else{
                passwordDialog.passtype = PasswordDialog.Type.Settings
                passwordDialog.open()
            }
        }
    }
}
