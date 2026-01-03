import Quickshell
import Quickshell.Wayland
import QtQuick

import "bar"
import "background"

Scope {
    Variants {
        model: Quickshell.screens

        Scope {
            property var modelData
            
            Bar {}
            PanelWindow {
				id: window
            
				screen: modelData
            
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
        }
    }
}
