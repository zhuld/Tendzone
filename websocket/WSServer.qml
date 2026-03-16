import QtQuick
import QtWebSockets

import "../js/tendzone.js" as Tendzone

WebSocketServer {
    id: server

    signal binReceived(var message)
    signal textReceived(var message)

    onClientConnected: webSocket => {
        webSocket.textMessageReceived.connect(message => {
            console.info("Server Text receive:", message);
            textReceived(message);
        });
        webSocket.binaryMessageReceived.connect(message => {
            console.info("Server Bin Received:", new Uint8Array(message));
            binReceived(new Uint8Array(message));
        });
        console.info("Client Connected", webSocket.url);
        webSocket.sendBinaryMessage(Tendzone.replyMachineName("Room101"));
    }
    onErrorStringChanged: {
        console.info("Server error: ", errorString);
    }
}
