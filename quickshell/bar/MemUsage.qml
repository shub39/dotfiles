import Quickshell.Io
import QtQuick
import qs

Text {
    property int memUsage: 0

    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var total = parseInt(parts[1]) || 1;
                var used = parseInt(parts[2]) || 0;
                memUsage = Math.round(100 * used / total);
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            memProc.running = true;
        }
    }

    text: " " + memUsage + "%"
    color: ShellGlobals.colors.brightYellow
    font.pixelSize: ShellGlobals.fontSize
    font.bold: true
    font.family: ShellGlobals.fontFamily
}
