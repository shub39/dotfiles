pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

PopupWindow {
    id: root
    required property PanelWindow bar
    required property PopupWindow menu

    visible: false
    anchor.window: bar
    anchor.rect.x: bar.width - width - 10
    anchor.rect.y: bar.height + 10
    implicitWidth: 450
    implicitHeight: popup.height
    color: "transparent"

    NotificationEntry {
        id: popup
        width: parent.width
        notif: null

        onNotifChanged: {
            if (popup.notif == null) {
                root.visible = false;
            }
            timer.restart();
        }

        // Animations
        state: "Empty"

        states: [
            State {
                name: "HasNotif"
                PropertyChanges {
                    popup.opacity: 1
                }
            },
            State {
                name: "Empty"
                PropertyChanges {
                    popup.opacity: 0
                }
            }
        ]

        Behavior on opacity {
            NumberAnimation {
                duration: 320
            }
        }
    }

    Timer {
        id: timer
        interval: 3000
        onTriggered: {
            popup.state = "Empty";
        }
    }

    Component.onCompleted: () => {
        NotifServer.notifServer.onNotification.connect(n => {
            popup.notif = n;
            popup.state = "HasNotif";
            root.visible = true;
            timer.start();
        });

        menu.visibleChanged.connect(() => {
            root.visible = !menu.visible && timer.running && popup.notif;
        });

        popup.opacityChanged.connect(() => {
            if (popup.opacity == 0) {
                root.visible = false;
            }
        });
    }
}
