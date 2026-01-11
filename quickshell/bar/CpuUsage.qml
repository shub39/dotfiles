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

    property int cpuUsage: 0
    property int lastCpuTotal: 0
    property int lastCpuIdle: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var user = parseInt(parts[1]) || 0;
                var nice = parseInt(parts[2]) || 0;
                var system = parseInt(parts[3]) || 0;
                var idle = parseInt(parts[4]) || 0;
                var iowait = parseInt(parts[5]) || 0;
                var irq = parseInt(parts[6]) || 0;
                var softirq = parseInt(parts[7]) || 0;

                var total = user + nice + system + idle + iowait + irq + softirq;
                var idleTime = idle + iowait;

                if (lastCpuTotal > 0) {
                    var totalDiff = total - lastCpuTotal;
                    var idleDiff = idleTime - lastCpuIdle;
                    if (totalDiff > 0) {
                        cpuUsage = Math.round(100 * (totalDiff - idleDiff) / totalDiff);
                    }
                }
                lastCpuTotal = total;
                lastCpuIdle = idleTime;
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true;
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
                source: "icons/cpu.png"
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
            text: cpuUsage + "%"
            font.family: ShellGlobals.fontFamily
            font.pixelSize: 20
            font.bold: true
            font.letterSpacing: ShellGlobals.letterSpacing
            elide: Text.ElideLeft
            color: ShellGlobals.materialColors.onprimary
        }
    }
}
