import QtQuick
import QtQuick.Controls
import QtMultimedia

Dialog {
    id:rootCamera
    implicitHeight: parent.height*0.9
    implicitWidth: parent.height*1.6

    y:parent.height*0.05
    modal: true;


    MediaPlayer {
        id: videoPlayer
        source: "d:/Users/ld_zh/Videos/Sample Videos/sample_1280x720_surfing_with_audio.mp4"
        //source: "rtsp://admin:HSdj4891@10.90.22.19:554//ch1/main/av_stream"
        //muted: true
        autoPlay: false
        videoOutput: camera
    }

    VideoOutput {
        id: camera
        anchors.fill: parent
        //anchors.horizontalCenter: parent.horizontalCenter
    }

    Overlay.modal: Rectangle{
        color:"#A0000000"
    }

    enter: Transition {
        NumberAnimation{
            from: 0
            to: 1
            property: "opacity"
            duration: 200
        }
    }
    exit: Transition {
        NumberAnimation{
            from: 1
            to: 0
            property: "opacity"
            duration: 200
        }
    }

    onOpened: videoPlayer.play()
    onClosed: videoPlayer.stop()
}
