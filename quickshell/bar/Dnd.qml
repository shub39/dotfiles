import QtQuick
import qs

Text {
    MouseArea {
        onClicked: ShellGlobals.isDnd = !ShellGlobals.isDnd
        anchors.fill: parent
    }
    
    text: !ShellGlobals.isDnd ? "" : ""
    font.family: ShellGlobals.fontFamily
    font.pixelSize: ShellGlobals.fontSize
    color: ShellGlobals.isDnd ? ShellGlobals.colors.brightRed : ShellGlobals.colors.orange
}
