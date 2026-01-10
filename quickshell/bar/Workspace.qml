import Quickshell.Hyprland
import QtQuick
import qs

Text {
    property var index: Hyprland.focusedWorkspace?.id - 1 ?? -1

    text: " " + (index + 1)
    font.family: ShellGlobals.fontFamily
    font.pixelSize: ShellGlobals.fontSize
    font.bold: true
    color: ShellGlobals.colors.brightYellow
}