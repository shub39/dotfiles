import Quickshell
import QtQuick
import QtQuick.Layouts
import qs
import "notification"

PanelWindow {
    id: bar
    readonly property int componentWidth: 40

    anchors {
        top: true
        right: true
        bottom: true
    }
    implicitWidth: componentWidth + 8
    color: ShellGlobals.materialColors.background

    Menu {
        id: menu
        bar: bar
    }

    NotificationPopup {
        id: notificationPopup
        bar: bar
        menu: menu
    }

    ColumnLayout {
        id: columnLayout

        width: bar.componentWidth
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        
        anchors.rightMargin: 4
        anchors.topMargin: 4
        anchors.bottomMargin: 4
        
        spacing: 4

        Time {
            Layout.fillWidth: true
            Layout.preferredWidth: bar.componentWidth
            Layout.minimumWidth: bar.componentWidth
            Layout.maximumWidth: bar.componentWidth
        }

        Item {
            Layout.fillHeight: true
        }
        PlayingMedia {
            Layout.fillWidth: true
            Layout.preferredWidth: bar.componentWidth
            Layout.minimumWidth: bar.componentWidth
            Layout.maximumWidth: bar.componentWidth
        }
        CpuUsage {
            Layout.fillWidth: true
            Layout.preferredWidth: bar.componentWidth
            Layout.minimumWidth: bar.componentWidth
            Layout.maximumWidth: bar.componentWidth
        }
        MemUsage {
            Layout.fillWidth: true
            Layout.preferredWidth: bar.componentWidth
            Layout.minimumWidth: bar.componentWidth
            Layout.maximumWidth: bar.componentWidth
        }
        Dnd {
            Layout.fillWidth: true
            Layout.preferredWidth: bar.componentWidth
            Layout.minimumWidth: bar.componentWidth
            Layout.maximumWidth: bar.componentWidth
        }
    }
}
