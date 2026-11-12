import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import qs

Rectangle {
    id: battery

    readonly property var device: UPower.displayDevice

    // Desktops (e.g. rher) have no battery, so the tile hides itself.
    readonly property bool hasBattery: device !== null && device.isPresent

    // UPower.percentage is a 0..1 fraction in Quickshell, so scale it to 0..100.
    readonly property int percentage: hasBattery ? Math.round(device.percentage * 100) : 0
    readonly property bool charging: hasBattery && (device.state === UPowerDeviceState.Charging || device.state === UPowerDeviceState.FullyCharged)
    readonly property bool critical: hasBattery && !charging && percentage <= 15

    readonly property color foreground: critical ? ShellGlobals.materialColors.onerrorcontainer : ShellGlobals.materialColors.onprimary
    readonly property color fillColor: {
        if (charging)
            return ShellGlobals.colors.brightGreen;
        if (critical)
            return ShellGlobals.materialColors.onerrorcontainer;
        if (percentage <= 30)
            return ShellGlobals.colors.brightYellow;
        return ShellGlobals.materialColors.onprimary;
    }

    visible: hasBattery
    color: critical ? ShellGlobals.materialColors.errorcontainer : ShellGlobals.materialColors.primary
    radius: 0

    implicitHeight: column.height + 10
    implicitWidth: column.width + 16

    Behavior on color {
        ColorAnimation {
            duration: 180
        }
    }

    SequentialAnimation on opacity {
        running: critical
        loops: Animation.Infinite
        NumberAnimation {
            to: 0.72
            duration: 420
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            to: 1
            duration: 420
            easing.type: Easing.InOutQuad
        }
        onStopped: opacity = 1
    }

    ColumnLayout {
        id: column
        spacing: 4
        anchors.centerIn: parent

        Item {
            Layout.preferredWidth: 18
            Layout.preferredHeight: 18
            Layout.alignment: Qt.AlignHCenter

            Rectangle {
                id: shell

                width: 13
                height: 9
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -1
                radius: 2
                color: "transparent"
                border.width: 1
                border.color: battery.foreground
            }

            Rectangle {
                id: nub

                width: 2
                height: 4
                radius: 1
                anchors.verticalCenter: shell.verticalCenter
                anchors.left: shell.right
                color: battery.foreground
            }

            Item {
                anchors.fill: shell
                anchors.margins: 2

                Rectangle {
                    height: parent.height
                    width: battery.percentage > 0 ? Math.max(1, parent.width * battery.percentage / 100) : 0
                    radius: 0.5
                    color: battery.fillColor

                    Behavior on width {
                        NumberAnimation {
                            duration: 250
                        }
                    }
                }
            }
        }

        Text {
            id: text
            text: battery.percentage + "%"
            font.family: ShellGlobals.fontFamily
            font.pixelSize: ShellGlobals.fontSize
            font.bold: true
            font.letterSpacing: ShellGlobals.letterSpacing
            elide: Text.ElideLeft
            color: battery.foreground
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
