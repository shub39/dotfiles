import QtQuick
import Quickshell

Item {
	id: root
	
	required property ShellScreen screen;
	property alias asynchronous: image.asynchronous;

	readonly property real remainingSize: image.sourceSize.height - root.height

	Image {
		id: image
		anchors.fill: parent
		source: "file://" + Quickshell.shellPath("../Wallpaper.png")
		fillMode: Image.PreserveAspectCrop
	}
}
