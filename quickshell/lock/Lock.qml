pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Pam
import qs
import "../wallpaper"

ShellRoot {
    id: root

    WlSessionLock {
        id: sessionLock
        locked: false

        WlSessionLockSurface {
            id: surface
            color: ShellGlobals.materialColors.background

            // Only the first pam prompt is answered automatically, so re-prompts
            // after a failed attempt wait for the user to type again.
            property bool autoRespond: false

            BackgroundImage {
                anchors.fill: parent
                screen: surface.screen
            }

            Column {
                anchors {
                    top: parent.top
                    right: parent.right
                    margins: 24
                }
                width: 260
                spacing: 8

                Text {
                    id: clock
                    width: parent.width
                    horizontalAlignment: Text.AlignRight
                    text: Qt.formatDateTime(new Date(), "HH:mm")
                    color: ShellGlobals.materialColors.onbackground
                    font.family: ShellGlobals.fontFamily
                    font.pixelSize: 28
                    font.bold: true
                }

                Text {
                    id: date
                    width: parent.width
                    horizontalAlignment: Text.AlignRight
                    text: Qt.formatDateTime(new Date(), "dddd, d MMMM")
                    color: ShellGlobals.materialColors.onsurfacevariant
                    font.family: ShellGlobals.fontFamily
                    font.pixelSize: 12
                }

                Rectangle {
                    width: parent.width
                    height: 40
                    color: ShellGlobals.materialColors.surfacecontainer

                    TextInput {
                        id: password
                        anchors.fill: parent
                        anchors.margins: 10

                        horizontalAlignment: TextInput.AlignRight
                        verticalAlignment: TextInput.AlignVCenter

                        color: ShellGlobals.materialColors.onsurface
                        font.family: ShellGlobals.fontFamily
                        font.pixelSize: 14

                        echoMode: TextInput.Password
                        passwordCharacter: "•"
                        selectionColor: ShellGlobals.materialColors.secondary
                        selectedTextColor: ShellGlobals.materialColors.onsecondary

                        focus: true
                        onAccepted: surface.submit()

                        Component.onCompleted: forceActiveFocus()
                    }
                }

                Text {
                    id: errorLabel
                    width: parent.width
                    horizontalAlignment: Text.AlignRight
                    color: ShellGlobals.materialColors.error
                    font.family: ShellGlobals.fontFamily
                    font.pixelSize: 11
                    text: ""
                }
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                triggeredOnStart: true

                onTriggered: {
                    const now = new Date();
                    clock.text = Qt.formatDateTime(now, "HH:mm");
                    date.text = Qt.formatDateTime(now, "dddd, d MMMM");
                }
            }

            PamContext {
                id: pam
                config: "login"

                onResponseRequiredChanged: {
                    if (responseRequired && surface.autoRespond) {
                        surface.autoRespond = false;
                        pam.respond(password.text);
                        password.text = "";
                    }
                }

                onCompleted: result => {
                    surface.autoRespond = false;

                    if (result === PamResult.Success) {
                        Qt.callLater(() => sessionLock.locked = false);
                    } else {
                        errorLabel.text = "Incorrect password";
                        password.text = "";
                        password.forceActiveFocus();
                    }
                }
            }

            function submit() {
                if (password.text.length === 0)
                    return;

                errorLabel.text = "";

                if (!pam.active) {
                    surface.autoRespond = true;

                    if (!pam.start()) {
                        surface.autoRespond = false;
                        errorLabel.text = "Could not start authentication";
                        return;
                    }
                } else if (pam.responseRequired) {
                    pam.respond(password.text);
                    password.text = "";
                }
            }
        }
    }

    IdleMonitor {
        id: idleMonitor
        timeout: 30 * 60

        onIsIdleChanged: {
            if (isIdle)
                sessionLock.locked = true;
        }
    }

    IpcHandler {
        target: "lock"

        function lock() {
            sessionLock.locked = true;
        }

        function unlock() {
            sessionLock.locked = false;
        }

        function toggle() {
            sessionLock.locked = !sessionLock.locked;
        }
    }
}
