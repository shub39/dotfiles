import QtQuick
import Quickshell

Item {
	id: root
	
	required property ShellScreen screen;
	property alias asynchronous: image.asynchronous;

	readonly property real remainingSize: image.sourceSize.height - root.height

	Image {
		id: image
		source: Qt.resolvedUrl("flowers-2.jpg")
		fillMode: Image.PreserveAspectFit
		width: 1920
	}
}
