import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: window

    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.namespace: "shell:background"

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    BackgroundImage {
        anchors.fill: parent
        screen: window.screen
    }
}
