import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import qs

Rectangle {
    color: ShellGlobals.materialColors.tertiarycontainer
    radius: 0

    implicitHeight: column.height + 10
    implicitWidth: column.width + 16

    property string playingMedia: "Nothing Playing..."

    Process {
        id: mediaProc
        command: ["sh", "-c", "playerctl metadata title"]
        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim()) {
                    playingMedia = ShellGlobals.adjustTextOverflow(data.trim(), 50);
                } else {
                    playingMedia = "";
                }
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            mediaProc.running = true;
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
            rotation: 90
            
            Image {
                id: icon
                anchors.fill: parent
                source: "icons/music.png"
                visible: false
            }

            ColorOverlay {
                anchors.fill: parent
                source: icon
                color: ShellGlobals.materialColors.ontertiarycontainer
            }
        }

        Item {
            Layout.preferredWidth: text.implicitHeight
            Layout.preferredHeight: text.implicitWidth
            Layout.alignment: Qt.AlignHCenter

            Text {
                id: text
                anchors.centerIn: parent
                text: playingMedia
                font.family: ShellGlobals.fontFamily
                font.pixelSize: ShellGlobals.fontSize + 3
                font.bold: true
                font.letterSpacing: ShellGlobals.letterSpacing
                color: ShellGlobals.materialColors.ontertiarycontainer
                horizontalAlignment: Text.AlignHCenter
                rotation: 90
                transformOrigin: Item.Center
            }
        }
    }
}
