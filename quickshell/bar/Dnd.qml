// import QtQuick
// import qs

// Text {

//     text: !ShellGlobals.isDnd ? "" : ""
//     font.family: ShellGlobals.fontFamily
//     font.pixelSize: ShellGlobals.fontSize
//     color: ShellGlobals.isDnd ? ShellGlobals.colors.brightRed : ShellGlobals.colors.orange
// }

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs

Rectangle {
    color: ShellGlobals.materialColors.primarycontainer
    radius: 1000

    implicitHeight: row.height + 16
    implicitWidth: row.width + 32

    MouseArea {
        onClicked: ShellGlobals.isDnd = !ShellGlobals.isDnd
        anchors.fill: parent
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
                source: !ShellGlobals.isDnd ? "icons/notifications_active.png" : "icons/notifications_off.png"
                visible: false
            }

            ColorOverlay {
                anchors.fill: parent
                source: icon
                color: ShellGlobals.materialColors.onprimarycontainer
            }
        }
    }
}
