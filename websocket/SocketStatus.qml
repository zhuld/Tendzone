import QtQuick
import QtWebSockets

import "../"

Item {
    states: [
        State {
            name: WebSocket.Error
            PropertyChanges {
                socketStatusProgress {
                    color: "#ED1C24" //red
                }
            }
        },
        State {
            name: WebSocket.Connecting
            PropertyChanges {
                socketStatusProgress {
                    color: "#22B14C" //green
                }
            }
        },
        State {
            name: WebSocket.Closed
            PropertyChanges {
                socketStatusProgress {
                    color: "#75FA8D" //lightgreen
                }
            }
        },
        State {
            name: WebSocket.Open
            PropertyChanges {
                socketStatusProgress {
                    color: Global.textColor //lightBlue
                }
            }
        },
        State {
            name: WebSocket.Closing
            PropertyChanges {
                socketStatusProgress {
                    color: "#16417C" //blue
                }
            }
        }
    ]
}
