import QtQuick

import "./tendzone.js" as Tendzone

Image {

    width: root.width/8
    x:width/6
    y:width/6

    source: Tendzone.Commands_List["Logo"].Url

    fillMode: Image.PreserveAspectFit
    MouseArea{
        id:mouseArea
        anchors.fill: parent

        //pressAndHoldInterval:1000
        onPressAndHold: {
            if(settings.password ===""){
                settingDialog.open()
            }else{
                passwordDialog.passtype = PasswordDialog.Type.Settings
                passwordDialog.open()
            }
        }
    }
}
