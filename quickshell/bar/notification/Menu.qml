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
    color: "transparent"
    visible: debug

    anchor.window: bar
    anchor.rect.x: bar.width - width - 10
    anchor.rect.y: bar.height + 20
    implicitWidth: 500
    implicitHeight: 600

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

    Rectangle {
        id: background
        anchors.fill: parent
        color: ShellGlobals.colors.bg1
        opacity: cardbox.opacity
        border.width: 2
        border.color: ShellGlobals.colors.green
    }

    ColumnLayout {
        id: cardbox
        anchors.fill: parent
        spacing: 0

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

        RowLayout {
            Layout.topMargin: 15
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.bottomMargin: 10

            Text {
                text: "Notifications"
                font.bold: true
                font.pixelSize: ShellGlobals.fontSize
                color: ShellGlobals.colors.brightYellow
            }
            Item {
                Layout.fillWidth: true
            }
            Text {
                MouseArea {
                    anchors.fill: parent
                    onClicked: NotifServer.clearNotifs()
                }

                text: "󰎟 Clear"
                font.bold: true
                font.pixelSize: ShellGlobals.fontSize
                color: ShellGlobals.colors.brightYellow
            }
        }

        Rectangle {
            implicitHeight: 1
            implicitWidth: parent.width
            color: ShellGlobals.colors.green
        }

        ListView {
            id: listView

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 0
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.bottomMargin: 2
            Layout.preferredHeight: childrenRect.height + 20
            Layout.maximumHeight: Screen.height * 0.95 - this.y

            clip: true
            model: NotifServer.notifications
            header: Item { height: 20 }
            footer: Item { height: 100 }
            spacing: 10
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
