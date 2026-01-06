import Quickshell
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
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: ShellGlobals.colors.bg0_s
        bottomLeftRadius: 32
        bottomRightRadius: 32

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            Workspace {}
            Break {}
            Time {}
            Break {}
            ActiveWindow {}
            Item {
                Layout.fillWidth: true
            }
            PlayingMedia {}
            Break {}
            CpuUsage {}
            Break {}
            MemUsage {}
        }
    }
}
