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

    anchor.margins {
        top: 70
        bottom: 0
        left: 1400
        right: 10
    }
    anchor.window: bar
    implicitWidth: 500
    implicitHeight: 600

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
        radius: 16
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
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            Layout.bottomMargin: 8
            Layout.topMargin: 8

            Text {
                text: "Notifications"
                font.bold: true
                font.pixelSize: 20
                font.family: ShellGlobals.fontFamily
                font.letterSpacing: ShellGlobals.letterSpacing
                color: ShellGlobals.materialColors.ontertiarycontainer
            }
            Item {
                Layout.fillWidth: true
            }
            Item {
                Layout.preferredWidth: 24
                Layout.preferredHeight: 24

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
            height: 1
        }

        ListView {
            id: listView

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 0
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.preferredHeight: childrenRect.height + 20
            Layout.maximumHeight: Screen.height * 0.95 - this.y

            clip: true
            model: NotifServer.notifications
            header: Item {
                height: 20
            }
            footer: Item {
                height: 100
            }
            
           
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
