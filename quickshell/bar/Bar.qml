import Quickshell
import Quickshell.Wayland
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

    Rectangle {
        anchors.fill: parent
        color: ShellGlobals.colors.bg

        RowLayout {
            anchors.fill: parent
            anchors.margins: 6

            Repeater {
                model: ShellGlobals.workspaces

                Rectangle {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignAbsolute
                    Layout.preferredWidth: 20
                    Layout.maximumHeight: parent.height
                    color: "transparent"

                    property var ws: Hyprland.workspaces.values.find(ws => ws.id === index + 1) ?? null
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                    Text {
                        text: isActive ? "[*]" : (ws ? "[_]" : "[ ]")
                        font.family: ShellGlobals.fontFamily
                        font.pixelSize: ShellGlobals.fontSize
                        color: isActive ? ShellGlobals.colors.brightYellow : (ws ? ShellGlobals.colors.brightAqua : ShellGlobals.colors.fg)
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + (index + 1))
                    }
                }
            }

            Rectangle {
                Layout.preferredWidth: 1
                Layout.preferredHeight: 16
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 8
                Layout.rightMargin: 8
                color: "transparent"
            }
        }
    }
}
