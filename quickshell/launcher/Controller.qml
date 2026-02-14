pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

Singleton {
	PersistentProperties {
		id: persist
		property bool launcherOpen: false;
	}
	
	IpcHandler {
		target: "launcher"
		
		function toggle() {
			persist.launcherOpen = !persist.launcherOpen;
		}
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
