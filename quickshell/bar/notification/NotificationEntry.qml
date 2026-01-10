pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications

Item {
    id: root
    required property var notif
    property string body: notif?.body ?? ""
    property string appName: notif?.appName ?? ""
    property string summary: notif?.summary ?? ""
    property list<NotificationAction> actions: notif?.actions ?? []

    implicitHeight: field.height + 10 // unholy I know, maybe I'll clean it up later, but yk if it works, don't break it .w.

    Rectangle {
        id: field
        anchors.centerIn: parent
        width: parent.width - 10
        height: sumText.height + bodText.height + 45

        border {
            width: 2
        }

        ColumnLayout {
            id: content
            spacing: 0
            anchors.fill: parent
            anchors.topMargin: 25
            anchors.bottomMargin: 15
            anchors.margins: 20

            Text {
                id: sumText
                Layout.fillWidth: true
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: root.summary
                font.bold: true
            }

            Text {
                id: bodText
                Layout.fillWidth: true
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: root.body
            }
        }
    }

    Rectangle {
        id: header
        anchors.left: parent.left
        anchors.top: parent.top

        width: text.width + 10
        height: text.height + 2

        Text {
            id: text
            anchors.centerIn: parent
            text: root.appName
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top

        width: header.height
        height: header.height

        Text {
            anchors.centerIn: parent
            text: ""
            font.bold: true
            font.pointSize: 10
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.notif.dismiss()
        }
    }

    RowLayout {
        // actions
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 15

        height: header.height
        spacing: 15

        Repeater {
            model: root.actions

            Rectangle {
                id: actionRect
                required property NotificationAction modelData
                Layout.fillHeight: true
                implicitWidth: text2.width + 10
                Text {
                    id: text2
                    anchors.centerIn: parent
                    text: actionRect?.modelData?.text ?? "Activate"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: event => {
                            actionRect.modelData.invoke();
                        }
                    }
                }
            }
        }
    }
}
