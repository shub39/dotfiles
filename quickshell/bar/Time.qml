import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs

Rectangle {
    color: ShellGlobals.materialColors.tertiary
    radius: 0

    implicitHeight: column.height + 10
    implicitWidth: column.width + 16

    property var clockText: Qt.formatDateTime(new Date(), "HH\nmm")
    
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clockText = Qt.formatDateTime(new Date(), "HH\nmm")
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
            font.pixelSize: ShellGlobals.fontSize + 4
            font.bold: true
            font.letterSpacing: ShellGlobals.letterSpacing
            color: ShellGlobals.materialColors.ontertiary
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
