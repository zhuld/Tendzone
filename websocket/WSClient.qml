import QtQuick
import QtWebSockets

import "../js/tendzone.js" as Tendzone

WebSocket {
    id: socket
    url: "ws://"+settings.ipAddress+":"+settings.ipPort

    onTextMessageReceived: (message)=> {
        messageBox.text = messageBox.text + "\nReceived message: " + message
    }
    onBinaryMessageReceived: (message)=> {
        console.info("Client Bin Received:", new Uint8Array(message))
        Tendzone.messageCheck(message)
    }
    onStatusChanged: {
        webSocketStatus.state = socket.status
        if ((socket.status === WebSocket.Error)|(socket.status === WebSocket.Closed)){
            socketAnimation.restart()
            //socketStatusTimer.restart()
            socket.active = false
            roomName = ""
        }else if (socket.status == WebSocket.Open){
            Tendzone.runCmd(Tendzone.Command.subHDMIProjector,true)
            Tendzone.runCmd(Tendzone.Command.subHDMIExtend,true)
            Tendzone.runCmd(Tendzone.Command.subPowerParm,true)
            Tendzone.runCmd(Tendzone.Command.subMachineName,true)
        }
    }
    active: false
}
