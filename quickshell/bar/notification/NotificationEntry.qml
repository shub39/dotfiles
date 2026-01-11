import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import Qt5Compat.GraphicalEffects
import qs

Item {
    id: root
    required property var notif
    property string body: notif?.body ?? ""
    property string appName: notif?.appName ?? ""
    property string summary: notif?.summary ?? ""
    property list<NotificationAction> actions: notif?.actions ?? []

    implicitHeight: field.height + 10

    Rectangle {
        id: field

        anchors.centerIn: parent
        width: parent.width - 10
        height: sumText.height + bodText.height + 45
        color: ShellGlobals.materialColors.tertiary
        radius: 16

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
                color: ShellGlobals.materialColors.onprimary
                font.pixelSize: 20
                font.family: ShellGlobals.fontFamily
            }

            Text {
                id: bodText
                Layout.fillWidth: true
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: root.body
                color: ShellGlobals.materialColors.onprimary
                font.family: ShellGlobals.fontFamily
                font.pixelSize: 16
            }
        }
    }

    Rectangle {
        id: header
        anchors.left: parent.left
        anchors.top: parent.top

        width: text.width + 20
        height: text.height + 4
        color: ShellGlobals.materialColors.primarycontainer
        radius: 8

        Text {
            id: text
            anchors.centerIn: parent
            text: root.appName
            font.family: ShellGlobals.fontFamily
            color: ShellGlobals.materialColors.onprimarycontainer
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top

        width: header.height
        height: header.height
        color: ShellGlobals.materialColors.errorcontainer
        radius: 1000

        Item {
            anchors.fill: parent
            
            Image {
                id: clear_all
                source: `icons/close.png`
                anchors.fill: parent
                visible: false
            }

            ColorOverlay {
                anchors.fill: parent
                source: clear_all
                color: ShellGlobals.materialColors.onerrorcontainer
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.notif.dismiss()
        }
    }

    RowLayout {
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
                implicitWidth: text2.width + 20
                implicitHeight: text2.height + 10
                radius: 1000
                color: ShellGlobals.materialColors.secondary
                Text {
                    id: text2
                    anchors.centerIn: parent
                    text: actionRect?.modelData?.text ?? "Activate"
                    color: ShellGlobals.materialColors.onsecondary
                    font.family: ShellGlobals.fontFamily
                    
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
