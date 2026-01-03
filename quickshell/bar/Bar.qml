import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    margins {
        top: 0
        bottom: 0
        left: 0
        right: 0
    }
    implicitHeight: 30
    color: ShellGlobals.colors.bg

    property int cpuUsage: 0
    property int memUsage: 0
    property string activeWindow: "Window"

    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    // CPU usage
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

    // Memory usage
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

    // Active window title
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

    // Slow timer for system stats
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true;
            memProc.running = true;
        }
    }

    // Listener for Hyprland events
    Connections {
        target: Hyprland
        function onRawEvent(event) {
            windowProc.running = true;
        }
    }

    Rectangle {
        anchors.fill: parent
        color: ShellGlobals.colors.bg

        RowLayout {
            anchors.fill: parent
            anchors.margins: 6

            Text {
                property var index: Hyprland.focusedWorkspace?.id - 1 ?? -1

                text: "[" + (index + 1) + "]"
                font.family: ShellGlobals.fontFamily
                font.pixelSize: ShellGlobals.fontSize
                color: ShellGlobals.colors.brightYellow
            }

            Text {
                id: clockText
                text: Qt.formatDateTime(new Date(), "[HH:mm] ddd MMM dd")
                color: ShellGlobals.colors.brightYellow
                font.pixelSize: ShellGlobals.fontSize
                font.family: ShellGlobals.fontFamily
                Layout.rightMargin: 8

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: clockText.text = Qt.formatDateTime(new Date(), "[HH:mm] ddd MMM dd")
                }
            }

            Text {
                text: activeWindow
                color: ShellGlobals.colors.brightGreen
                font.pixelSize: ShellGlobals.fontSize
                font.family: ShellGlobals.fontFamily
                Layout.leftMargin: 4
                Layout.fillWidth: true
                elide: Text.ElideRight
                maximumLineCount: 1
            }

            Text {
                text: "[CPU] " + cpuUsage + "%" + " [MEM] " + memUsage + "%"
                color: ShellGlobals.colors.fg
                font.pixelSize: ShellGlobals.fontSize
                font.family: ShellGlobals.fontFamily
            }
        }
    }
}