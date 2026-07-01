import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import qs

Rectangle {
    color: memCritical ? ShellGlobals.materialColors.errorcontainer : ShellGlobals.materialColors.primary
    radius: 0
    border.width: 0
    border.color: "transparent"

    implicitHeight: column.height + 10
    implicitWidth: column.width + 16

    property int memUsage: 0
    property bool memCritical: memUsage >= 90

    Behavior on color {
        ColorAnimation {
            duration: 180
        }
    }

    SequentialAnimation on opacity {
        running: memCritical
        loops: Animation.Infinite
        NumberAnimation {
            to: 0.72
            duration: 420
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            to: 1
            duration: 420
            easing.type: Easing.InOutQuad
        }
        onStopped: opacity = 1
    }

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

    ColumnLayout {
        id: column
        spacing: 4
        anchors.centerIn: parent

        Item {
            Layout.preferredWidth: 18
            Layout.preferredHeight: 18
            Layout.alignment: Qt.AlignHCenter

            Image {
                id: icon
                anchors.fill: parent
                source: "icons/memory.png"
                visible: false
            }

            ColorOverlay {
                anchors.fill: parent
                source: icon
                color: memCritical ? ShellGlobals.materialColors.onerrorcontainer : ShellGlobals.materialColors.onprimary
            }
        }

        Text {
            id: text
            text: memUsage + "%"
            font.family: ShellGlobals.fontFamily
            font.pixelSize: ShellGlobals.fontSize
            font.bold: true
            font.letterSpacing: ShellGlobals.letterSpacing
            elide: Text.ElideLeft
            color: memCritical ? ShellGlobals.materialColors.onerrorcontainer : ShellGlobals.materialColors.onprimary
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
