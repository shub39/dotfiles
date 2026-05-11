import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import qs

PopupWindow {
    id: panel
    property bool debug: false
    required property PanelWindow bar
    color: "transparent"
    visible: debug

    anchor.window: bar
    anchor.rect.x: -width - 8
    anchor.rect.y: 8
    implicitWidth: 320
    implicitHeight: 520

    function toggleVisibility() {
        if (panel.visible) {
            cardbox.state = "Closed";
        } else {
            panel.visible = true;
            cardbox.state = "Open";
        }
    }

    IpcHandler {
        target: "notifications"
        
        function toggle() {
            toggleVisibility()
        }
    }
    
    Rectangle {
        id: background
        anchors.fill: parent
        color: ShellGlobals.materialColors.tertiarycontainer
        opacity: cardbox.opacity
        radius: 0
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
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.bottomMargin: 6
            Layout.topMargin: 6

            Text {
                text: "Notifications"
                font.bold: true
                font.pixelSize: 15
                font.family: ShellGlobals.fontFamily
                font.letterSpacing: ShellGlobals.letterSpacing
                color: ShellGlobals.materialColors.ontertiarycontainer
            }
            Item {
                Layout.fillWidth: true
            }
            Item {
                Layout.preferredWidth: 18
                Layout.preferredHeight: 18

                MouseArea {
                    anchors.fill: parent
                    onClicked: NotifServer.clearNotifs()
                }

                Image {
                    id: clear_all
                    source: `icons/clear_all.png`
                    anchors.fill: parent
                    visible: false
                }

                ColorOverlay {
                    anchors.fill: parent
                    source: clear_all
                    color: ShellGlobals.materialColors.ontertiarycontainer
                }
            }
        }
        
        Rectangle {
            color: ShellGlobals.materialColors.ontertiarycontainer
            width: parent.width
            height: 0
        }

        ListView {
            id: listView

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 0
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.preferredHeight: childrenRect.height + 20
            Layout.maximumHeight: Screen.height * 0.95 - this.y

            clip: true
            model: NotifServer.notifications
            header: Item {
                height: 6
            }
            footer: Item {
                height: 10
            }

            spacing: 6
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
