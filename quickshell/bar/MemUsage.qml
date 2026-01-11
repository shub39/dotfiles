import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import qs

Rectangle {
    color: ShellGlobals.materialColors.primary
    radius: 1000

    implicitHeight: row.height + 16
    implicitWidth: row.width + 32

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

    RowLayout {
        id: row
        spacing: 8
        anchors.centerIn: parent

        Item {
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24

            Image {
                id: icon
                anchors.fill: parent
                source: "icons/memory.png"
                visible: false
            }

            ColorOverlay {
                anchors.fill: parent
                source: icon
                color: ShellGlobals.materialColors.onprimary
            }
        }

        Text {
            id: text
            text: memUsage + "%"
            font.family: ShellGlobals.fontFamily
            font.pixelSize: 20
            font.bold: true
            font.letterSpacing: ShellGlobals.letterSpacing
            elide: Text.ElideLeft
            color: ShellGlobals.materialColors.onprimary
        }
    }
}
