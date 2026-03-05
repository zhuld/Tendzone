import QtQuick
import QtWebSockets

import "../"

Item {
    states: [
        State {
            name: WebSocket.Error
            PropertyChanges {
                target: socketStatusProgress
                color: "#ED1C24" //red
            }
        },
        State {
            name: WebSocket.Connecting
            PropertyChanges {
                target: socketStatusProgSoress
                color: "#22B14C" //green
            }
        },
        State {
            name: WebSocket.Closed
            PropertyChanges {
                target: socketStatusProgress
                color: "#75FA8D" //lightgreen
            }
        },
        State {
            name: WebSocket.Open
            PropertyChanges {
                target: socketStatusProgress
                color: Global.textColor //lightBlue
            }
        },
        State {
            name: WebSocket.Closing
            PropertyChanges {
                target: socketStatusProgress
                color: "#16417C" //blue
            }
        }
    ]
}
