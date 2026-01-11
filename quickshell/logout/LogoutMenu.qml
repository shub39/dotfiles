import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects

import qs

Variants {
    id: root
    property color backgroundColor: ShellGlobals.materialColors.background
    property color buttonColor: ShellGlobals.materialColors.tertiarycontainer
    property color buttonHoverColor: ShellGlobals.materialColors.tertiary
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
                    columnSpacing: 8
                    rowSpacing: 8

                    Repeater {
                        model: buttons
                        delegate: Rectangle {
                            required property LogoutButton modelData

                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            color: ma.containsMouse ? buttonHoverColor : buttonColor
                            radius: 1000

                            MouseArea {
                                id: ma
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    modelData.exec();
                                    w.visible = false;
                                }
                            }

                            Item {
                                id: icon
                                anchors {
                                    top: parent.top
                                    topMargin: 120
                                    horizontalCenter: parent.horizontalCenter
                                }
                                width: parent.width * 0.25
                                height: width

                                Image {
                                    id: image
                                    anchors.fill: parent
                                    source: `icons/${modelData.icon}.png`
                                    visible: false
                                }

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: image
                                    color: ShellGlobals.materialColors.ontertiary
                                }
                            }

                            Text {
                                anchors {
                                    top: icon.bottom
                                    topMargin: 20
                                    horizontalCenter: parent.horizontalCenter
                                }

                                text: modelData.text
                                font.pointSize: 20
                                color: ShellGlobals.materialColors.ontertiary
                                font.bold: true
                                font.family: ShellGlobals.fontFamily
                            }
                        }
                    }
                }
            }
        }
    }
}
