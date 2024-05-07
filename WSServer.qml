import QtQuick
import QtWebSockets

import "./tendzone.js" as Tendzone

WebSocketServer {
    id: server
    port: 9880
    listen: settings.webSocketServer
    //accept: false
    onClientConnected: function(webSocket) {
        webSocket.onTextMessageReceived.connect(function(message) {
            //console.info("Server Text receive:", message);
        });
        webSocket.onBinaryMessageReceived.connect(function(message) {
            //console.info("Server Bin Received:", new Uint8Array(message));
        });
        console.info("Client Connected", webSocket.url)
    }
    onErrorStringChanged: {
        console.info("Server error: ", errorString);
    }
}
