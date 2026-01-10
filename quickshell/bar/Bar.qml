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
    margins {
        top: 10
        bottom: 0
        left: 10
        right: 10
    }
    implicitHeight: 30
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

    Rectangle {
        anchors.fill: parent
        color: ShellGlobals.colors.bg0_s
        border.width: 2
        border.color: ShellGlobals.colors.yellow
        
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            Workspace {}
            Break {}
            Time {}
            Break {}
            ActiveWindow {}
            Item {
                Layout.fillWidth: true
            }
            PlayingMedia {}
            Break {}
            CpuUsage {}
            Break {}
            MemUsage {}
            Break {}
            Dnd {}
        }
    }
}
