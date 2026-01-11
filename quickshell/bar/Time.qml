import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs

Rectangle {
    color: ShellGlobals.materialColors.tertiary
    radius: 1000

    implicitHeight: row.height + 16
    implicitWidth: row.width + 32

    property var clockText: Qt.formatDateTime(new Date(), "HH:mm")
    
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clockText = Qt.formatDateTime(new Date(), "HH:mm")
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
                source: "icons/clock.png"
                visible: false
            }
        
            ColorOverlay {
                anchors.fill: parent
                source: icon
                color: ShellGlobals.materialColors.ontertiary
            }
        }
        
        Text {
            id: text
            text: clockText
            font.family: ShellGlobals.fontFamily
            font.pixelSize: 20
            font.bold: true
            font.letterSpacing: ShellGlobals.letterSpacing
            color: ShellGlobals.materialColors.ontertiary
        }
    }
}