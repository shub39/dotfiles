import QtQuick
import qs

Text {
    id: clockText
    text: Qt.formatDateTime(new Date(), "HH:mm")
    color: ShellGlobals.colors.brightAqua
    font.pixelSize: ShellGlobals.fontSize
    font.family: ShellGlobals.fontFamily
    font.bold: true

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "HH:mm")
    }
}
