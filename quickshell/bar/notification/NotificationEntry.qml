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

    implicitHeight: field.implicitHeight

    Rectangle {
        id: field

        anchors.fill: parent
        implicitHeight: content.implicitHeight + 16
        color: ShellGlobals.materialColors.tertiary
        radius: 0

        ColumnLayout {
            id: content
            spacing: 4
            anchors.fill: parent
            anchors.margins: 8

            RowLayout {
                Layout.fillWidth: true
                spacing: 6

                Text {
                    id: appText
                    Layout.fillWidth: true
                    text: root.appName
                    color: ShellGlobals.materialColors.onprimary
                    font.family: ShellGlobals.fontFamily
                    font.pixelSize: 12
                    elide: Text.ElideRight
                }

                Item {
                    Layout.preferredWidth: 14
                    Layout.preferredHeight: 14

                    Image {
                        id: closeIcon
                        source: `icons/close.png`
                        anchors.fill: parent
                        visible: false
                    }

                    ColorOverlay {
                        anchors.fill: parent
                        source: closeIcon
                        color: ShellGlobals.materialColors.onprimary
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.notif.dismiss()
                    }
                }
            }

            Text {
                id: sumText
                Layout.fillWidth: true
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: root.summary
                font.bold: true
                color: ShellGlobals.materialColors.onprimary
                font.pixelSize: 15
                font.family: ShellGlobals.fontFamily
            }

            Text {
                id: bodText
                Layout.fillWidth: true
                visible: root.body.length > 0
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: root.body
                color: ShellGlobals.materialColors.onprimary
                font.family: ShellGlobals.fontFamily
                font.pixelSize: ShellGlobals.fontSize + 2
                maximumLineCount: 3
                elide: Text.ElideRight
            }

            RowLayout {
                Layout.alignment: Qt.AlignRight
                visible: root.actions.length > 0
                spacing: 4

                Repeater {
                    model: root.actions

                    Rectangle {
                        id: actionRect
                        required property NotificationAction modelData
                        implicitWidth: actionText.width + 12
                        implicitHeight: actionText.height + 6
                        radius: 0
                        color: ShellGlobals.materialColors.secondary

                        Text {
                            id: actionText
                            anchors.centerIn: parent
                            text: actionRect?.modelData?.text ?? "Activate"
                            color: ShellGlobals.materialColors.onsecondary
                            font.family: ShellGlobals.fontFamily
                            font.pixelSize: 12
                        }

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
}
