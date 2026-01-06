import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import qs

Text {
    property string activeWindow: ""

    Process {
        id: windowProc
        command: ["sh", "-c", "hyprctl activewindow -j | jq -r '.title // empty'"]
        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim()) {
                    activeWindow = data.trim();
                }
            }
        }
        Component.onCompleted: running = true
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            windowProc.running = true;
        }
    }

    text: activeWindow
    color: ShellGlobals.colors.brightGreen
    font.pixelSize: ShellGlobals.fontSize
    font.family: ShellGlobals.fontFamily
    elide: Text.ElideLeft
    maximumLineCount: 1
}
