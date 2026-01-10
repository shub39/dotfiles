import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import qs

Variants {
    id: root
    property color backgroundColor: "#e60c0c0c"
    property color buttonColor: ShellGlobals.colors.bg0
    property color buttonHoverColor: ShellGlobals.colors.bg1
    default property list<LogoutButton> buttons

    model: Quickshell.screens
    PanelWindow {
        id: w

        property var modelData
        screen: modelData

        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        color: "transparent"
        visible: false

        GlobalShortcut {
            name: "logout"
            onPressed: w.visible = !w.visible
        }

        contentItem {
            focus: true
            Keys.onPressed: event => {
                if (event.key == Qt.Key_Escape)
                    w.visible = false;
                else {
                    for (let i = 0; i < buttons.length; i++) {
                        let button = buttons[i];
                        if (event.key == button.keybind) {
                            button.exec();
                            w.visible = false;
                        }
                    }
                }
            }
        }

        anchors {
            top: true
            left: true
            bottom: true
            right: true
        }

        Rectangle {
            color: backgroundColor
            anchors.fill: parent

            MouseArea {
                anchors.fill: parent
                onClicked: w.visible = false

                GridLayout {
                    anchors.centerIn: parent

                    width: parent.width * 0.75
                    height: parent.height * 0.75

                    columns: 3
                    columnSpacing: 0
                    rowSpacing: 0

                    Repeater {
                        model: buttons
                        delegate: Rectangle {
                            required property LogoutButton modelData

                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            color: ma.containsMouse ? buttonHoverColor : buttonColor
                            border.color: ShellGlobals.colors.yellow
                            border.width: 1

                            MouseArea {
                                id: ma
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    modelData.exec();
                                    w.visible = false;
                                }
                            }

                            Image {
                                id: icon
                                anchors.centerIn: parent
                                source: `icons/${modelData.icon}.png`
                                width: parent.width * 0.25
                                height: parent.width * 0.25
                            }

                            Text {
                                anchors {
                                    top: icon.bottom
                                    topMargin: 20
                                    horizontalCenter: parent.horizontalCenter
                                }

                                text: modelData.text
                                font.pointSize: 20
                                color: ShellGlobals.colors.fg0
                            }
                        }
                    }
                }
            }
        }
    }
}
