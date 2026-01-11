import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import qs

Rectangle {
    color: ShellGlobals.materialColors.tertiarycontainer
    radius: 1000

    implicitHeight: row.height + 16
    implicitWidth: row.width + 32

    property string playingMedia: "Nothing Playing..."

    Process {
        id: mediaProc
        command: ["sh", "-c", "playerctl metadata title"]
        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim()) {
                    playingMedia = ShellGlobals.adjustTextOverflow(data.trim(), 30);
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
                source: "icons/music.png"
                visible: false
            }

            ColorOverlay {
                anchors.fill: parent
                source: icon
                color: ShellGlobals.materialColors.ontertiarycontainer
            }
        }

        Text {
            id: text
            text: playingMedia
            font.family: ShellGlobals.fontFamily
            font.pixelSize: 20
            font.bold: true
            font.letterSpacing: ShellGlobals.letterSpacing
            elide: Text.ElideLeft
            color: ShellGlobals.materialColors.ontertiarycontainer
        }
    }
}
