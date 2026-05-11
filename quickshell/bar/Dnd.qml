import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs

Rectangle {
    color: ShellGlobals.materialColors.primarycontainer
    radius: 0

    implicitHeight: column.height + 10
    implicitWidth: column.width + 16

    MouseArea {
        onClicked: ShellGlobals.isDnd = !ShellGlobals.isDnd
        anchors.fill: parent
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
