import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import Quickshell.Hyprland

import qs

PopupWindow {
    id: panel
    property bool debug: false
    required property PanelWindow bar
    color: ShellGlobals.colors.bg1
    visible: debug

    anchor.window: bar
    anchor.rect.x: bar.width - width - 10
    anchor.rect.y: bar.height + 10
    implicitWidth: 480
    implicitHeight: cardbox.height

    function toggleVisibility() {
        if (panel.visible) {
            cardbox.state = "Closed";
        } else {
            panel.visible = true;
            grab.active = true;
            cardbox.state = "Open";
        }
    }

    GlobalShortcut {
        name: "notifications"
        onPressed: toggleVisibility()
    }

    HyprlandFocusGrab {
        id: grab
        windows: [panel]

        onActiveChanged: {
            if (!grab.active) {
                cardbox.state = "Closed";
            }
        }
    }

    ColumnLayout {
        id: cardbox
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 8

        state: (panel.debug) ? "Open" : "Closed"
        states: [
            State {
                name: "Open"
                PropertyChanges {
                    cardbox.opacity: 1
                }
            },
            State {
                name: "Closed"
                PropertyChanges {
                    cardbox.opacity: 0
                }
            }
        ]

        onOpacityChanged: {
            if (opacity == 0) {
                panel.visible = false;
                grab.active = false;
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 160
            }
        }

        ListView { // Notification Inbox
            id: listView
            Layout.fillWidth: true
            Layout.minimumHeight: 0
            Layout.preferredHeight: childrenRect.height + 20
            Layout.maximumHeight: Screen.height * 0.95 - this.y
            clip: true
            model: NotifServer.notifications
            delegate: NotificationEntry {
                id: toast
                width: parent?.width
                required property Notification modelData
                notif: modelData

                // no destruction animation for now
                NumberAnimation on opacity {
                    from: 0
                    to: 1
                    duration: 320
                }
            }
        }
    }
}
