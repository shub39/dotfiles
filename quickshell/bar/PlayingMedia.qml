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
                    playingMedia = data.trim();
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

    text: "Now Playing - " + playingMedia
    color: ShellGlobals.colors.brightPurple
    font.pixelSize: ShellGlobals.fontSize
    font.italic: true
    font.family: ShellGlobals.fontFamily
    elide: Text.ElideRight
    maximumLineCount: 1
}
