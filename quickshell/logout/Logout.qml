import QtQuick
import Quickshell

ShellRoot {
	LogoutMenu {
		LogoutButton {
			command: "qs -c ~/.config/dotfiles/quickshell/ ipc call lock lock"
			keybind: Qt.Key_L
			text: "Lock"
			icon: "lock"
		}

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