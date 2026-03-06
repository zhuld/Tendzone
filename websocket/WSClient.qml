import QtQuick
import QtWebSockets

import "../js/tendzone.js" as Tendzone
import "../"

WebSocket {
    id: socket
    url: "ws://" + Global.settings.ipAddress + ":" + Global.settings.ipPort
    onTextMessageReceived: message => {
                               console.info("Client Text Received:", message)
                           }
    onBinaryMessageReceived: message => {
                                 console.info("Client Bin Received:",
                                              new Uint8Array(message))
                                 Tendzone.messageCheck(message)
                             }

    active: false
}
