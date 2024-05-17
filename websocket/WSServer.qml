import QtQuick
import QtWebSockets

import "../js/tendzone.js" as Tendzone

WebSocketServer {
    id: server
    port: settings.webSocketServerPort

    listen: settings.webSocketServer
    signal binReceived(var message)
    signal textReceived(var message)

    onClientConnected: (webSocket) =>{
        webSocket.onTextMessageReceived.connect((message)=> {
            console.info("Server Text receive:", message);
            textReceived(message)
        });
        webSocket.onBinaryMessageReceived.connect((message)=> {
            console.info("Server Bin Received:", new Uint8Array(message))
            binReceived(new Uint8Array(message))

        });
        console.info("Client Connected", webSocket.url)
    }
    onErrorStringChanged: {
        console.info("Server error: ", errorString);
    }
}
