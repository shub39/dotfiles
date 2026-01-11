import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion

import qs

Rectangle {
    id: root
    required property LockContext context

    color: ShellGlobals.materialColors.background

    Label {
        id: clock
        property var date: new Date()

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 100
        }

        renderType: Text.NativeRendering
        font.pixelSize: 80
        font.family: ShellGlobals.fontFamily
        font.letterSpacing: ShellGlobals.letterSpacing
        font.bold: true
        color: ShellGlobals.materialColors.onsurface

        Timer {
            running: true
            repeat: true
            interval: 1000

            onTriggered: {
                clock.date = new Date();
            }
        }

        text: {
            const hours = this.date.getHours().toString().padStart(2, '0');
            const minutes = this.date.getMinutes().toString().padStart(2, '0');
            return `${hours}:${minutes}`;
        }
    }

    ColumnLayout {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.verticalCenter
        }

        RowLayout {
            TextField {
                id: passwordBox
                horizontalAlignment: Qt.AlignHCenter

                implicitWidth: 400
                padding: 10
                color: ShellGlobals.materialColors.onsurface
                focus: true
                enabled: !root.context.unlockInProgress
                font.pixelSize: 24
                font.family: ShellGlobals.fontFamily
                font.letterSpacing: ShellGlobals.letterSpacing
                echoMode: TextInput.Password
                inputMethodHints: Qt.ImhSensitiveData
                onTextChanged: root.context.currentText = this.text
                onAccepted: root.context.tryUnlock()
                Connections {
                    target: root.context

                    function onCurrentTextChanged() {
                        passwordBox.text = root.context.currentText;
                    }
                }
            }
        }

        Label {
            visible: root.context.showFailure
            text: "Incorrect password"
            color: ShellGlobals.materialColors.error
        }
    }
}
