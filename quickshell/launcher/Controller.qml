pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Singleton {
	PersistentProperties {
		id: persist
		property bool launcherOpen: false;
	}

	GlobalShortcut {
	    name: "launcher"
		onPressed: persist.launcherOpen = !persist.launcherOpen
	}

	LazyLoader {
		id: loader
		activeAsync: persist.launcherOpen

		PanelWindow {
			id: launcherWindow
			color: "transparent"
			implicitWidth: content.width
			implicitHeight: content.height
			WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
			WlrLayershell.namespace: "shell:launcher"

			HyprlandWindow.visibleMask: Region {
				item: content
			}

			HyprlandFocusGrab {
				windows: [launcherWindow]
				active: true
				onCleared: persist.launcherOpen = false
			}

			MouseArea {
				anchors.fill: parent

				onPressed: persist.launcherOpen = false

				MouseArea {
					anchors.centerIn: parent
					width: content.width
					height: content.height

					LaunchContent { id: content }
				}
			}
		}
	}

	function init() {}
}
