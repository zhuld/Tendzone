import QtQuick
import QtWebSockets

import "../js/tendzone.js" as Tendzone

WebSocketServer {
    id: server

    property ListModel clientList: ListModel {}

    signal binReceived(var message)
    signal textReceived(var message)

    onClientConnected: webSocket => {
        // 1. 将新连接的对象存储起来，防止被回收
        clientList.append({
            "socket": webSocket
        });

        // 2. 绑定信号
        webSocket.textMessageReceived.connect(message => {
            console.info("Server Text receive:", message);
            textReceived(message);
        });
        webSocket.binaryMessageReceived.connect(message => {
            console.info("Server Bin Received:", new Uint8Array(message));
            binReceived(new Uint8Array(message));
        });

        //3. 处理断开
        webSocket.onStatusChanged.connect(status => {
            if (status === WebSocket.Closed) {
                console.info("Client Disconnected", webSocket.url);
                for (let i = 0; i < clientList.count; i++) {
                    if (clientList.get(i).socket === webSocket) {
                        clientList.remove(i);
                        break;
                    }
                }
            }
        });

        console.info("Client Connected", webSocket.url);
        webSocket.sendBinaryMessage(Tendzone.replyMachineName("Room101"));
    }
    onErrorStringChanged: {
        console.info("Server error: ", errorString);
    }
}
