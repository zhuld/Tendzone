import QtQuick

import "../js/tendzone.js" as Tendzone

Image {
    width: parent.width / 8
    x: width / 6
    y: width / 6

    fillMode: Image.PreserveAspectFit
    source: Tendzone.Commands_List["Logo"].Url
}
