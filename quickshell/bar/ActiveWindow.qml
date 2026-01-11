import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import Quickshell.Hyprland
import qs

Rectangle {
    color: ShellGlobals.materialColors.secondary
    radius: 1000

    implicitHeight: row.height + 16
    implicitWidth: row.width + 32

    property string activeWindow: "Open Something cuh"

    Process {
        id: windowProc
        command: ["sh", "-c", "hyprctl activewindow -j | jq -r '.title // empty'"]
        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim()) {
                    activeWindow = ShellGlobals.adjustTextOverflow(data.trim(), 30);
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
    
    RowLayout {
        id: row
        spacing: 8
        anchors.centerIn: parent

        Text {
            id: text
            text: activeWindow
            font.family: ShellGlobals.fontFamily
            font.pixelSize: 20
            font.bold: true
            font.letterSpacing: ShellGlobals.letterSpacing
            elide: Text.ElideRight
            color: ShellGlobals.materialColors.secondarycontainer
        }
    }
}
