import QtQuick
import Quickshell

ShellRoot {
	LogoutMenu {
		LogoutButton {
			command: "systemctl suspend"
			keybind: Qt.Key_S
			text: "Suspend"
			icon: "suspend"
		}

		LogoutButton {
			command: "systemctl poweroff"
			keybind: Qt.Key_P
			text: "Shutdown"
			icon: "shutdown"
		}

		LogoutButton {
			command: "systemctl reboot"
			keybind: Qt.Key_R
			text: "Reboot"
			icon: "reboot"
		}
	}
}