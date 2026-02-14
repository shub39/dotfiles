import Quickshell
import QtQuick
import QtQuick.Layouts
import qs
import "notification"

PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: rowLayout.implicitHeight + 8
    color: "transparent"

    Menu {
        id: menu
        bar: bar
    }

    NotificationPopup {
        id: notificationPopup
        bar: bar
        menu: menu
    }

    RowLayout {
        id: rowLayout

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        anchors.topMargin: 8
        
        spacing: 8

        Time {}
        Item {
            Layout.fillWidth: true
        }
        PlayingMedia {}
        CpuUsage {}
        MemUsage {}
        Dnd {}
    }
}
