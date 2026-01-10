import Quickshell.Io
import QtQuick
import qs

Text {
    property string playingMedia: ""

    Process {
        id: mediaProc
        command: ["sh", "-c", "playerctl metadata title"]
        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim()) {
                    playingMedia = "  " + ShellGlobals.adjustTextOverflow(data.trim(), 100);
                } else {
                    playingMedia = "";
                }
            }
        }
        Component.onCompleted: running = true
    }
    
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            mediaProc.running = true;
        }
    }

    text: playingMedia
    color: ShellGlobals.colors.brightPurple
    font.pixelSize: ShellGlobals.fontSize
    font.family: ShellGlobals.fontFamily
    font.italic: true
    elide: Text.ElideRight
    maximumLineCount: 1
}
