import QtQuick
import Quickshell.Io

QtObject {
	required property string command
	required property string text
	required property string icon
	property var keybind: null

	id: button

	readonly property var process: Process {
		command: ["sh", "-c", button.command]
	}

	function exec() {
		process.startDetached();
	}
}