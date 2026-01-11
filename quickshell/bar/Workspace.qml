import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs

Rectangle {
    color: ShellGlobals.materialColors.primary
    radius: 1000

    implicitHeight: row.height + 16
    implicitWidth: row.width + 32

    property var index: Hyprland.focusedWorkspace?.id - 1 ?? -1

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
                source: "icons/workspace.png"
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
            text: "Workspace " + (index + 1)
            font.family: ShellGlobals.fontFamily
            font.pixelSize: 20
            font.bold: true
            font.letterSpacing: ShellGlobals.letterSpacing
            color: ShellGlobals.materialColors.onprimary
        }
    }
}
