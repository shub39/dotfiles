import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import qs

Item {
	id: root
	height: 10 + searchContainer.implicitHeight + list.topMargin * 2 + list.delegateHeight * 10;
	width: 500

	Rectangle {
		id: content
		height: 7 + searchContainer.implicitHeight + list.topMargin + list.bottomMargin + Math.min(list.contentHeight, list.delegateHeight * 10)
		Behavior on height { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
		width: parent.width
		color: ShellGlobals.colors.bg
		border.color: ShellGlobals.colors.yellow
		border.width: 2

		ColumnLayout {
			anchors.fill: parent
			anchors.margins: 7
			anchors.bottomMargin: 0
			spacing: 0

			Rectangle {
				id: searchContainer
				Layout.fillWidth: true
				implicitHeight: searchbox.implicitHeight + 10
				color: ShellGlobals.colors.bg
				border.color: ShellGlobals.colors.yellow
				border.width: 2

				RowLayout {
					id: searchbox
					anchors.fill: parent
					anchors.margins: 5

					TextInput {
						id: search
						Layout.fillWidth: true
						color: ShellGlobals.colors.brightYellow

						focus: true
						Keys.forwardTo: [list]
						Keys.onEscapePressed: persist.launcherOpen = false

						Keys.onPressed: event => {
							if (event.modifiers & Qt.ControlModifier) {
								if (event.key == Qt.Key_J) {
									list.currentIndex = list.currentIndex == list.count - 1 ? 0 : list.currentIndex + 1;
									event.accepted = true;
								} else if (event.key == Qt.Key_K) {
									list.currentIndex = list.currentIndex == 0 ? list.count - 1 : list.currentIndex - 1;
									event.accepted = true;
								}
							}
						}

						onAccepted: {
							if (list.currentItem) {
								list.currentItem.clicked(null);
							}
						}

						onTextChanged: {
							list.currentIndex = 0;
						}
					}
				}
			}

			ListView {
				id: list
				Layout.fillWidth: true
				Layout.fillHeight: true
				clip: true
				cacheBuffer: 0
				model: ScriptModel {
					values: DesktopEntries.applications.values
						.map(object => {
							const stxt = search.text.toLowerCase();
							const ntxt = object.name.toLowerCase();
							let si = 0;
							let ni = 0;

							let matches = [];
							let startMatch = -1;

							for (let si = 0; si != stxt.length; ++si) {
								const sc = stxt[si];

								while (true) {
									if (ni == ntxt.length) return null;

									const nc = ntxt[ni++];

									if (nc == sc) {
										if (startMatch == -1) startMatch = ni;
										break;
									} else {
										if (startMatch != -1) {
											matches.push({
												index: startMatch,
												length: ni - startMatch,
											});

											startMatch = -1;
										}
									}
								}
							}

							if (startMatch != -1) {
								matches.push({
									index: startMatch,
									length: ni - startMatch + 1,
								});
							}

							return {
								object: object,
								matches: matches,
							};
						})
						.filter(entry => entry !== null)
						.sort((a, b) => {
							let ai = 0;
							let bi = 0;
							let s = 0;

							while (ai != a.matches.length && bi != b.matches.length) {
								const am = a.matches[ai];
								const bm = b.matches[bi];

								s = bm.length - am.length;
								if (s != 0) return s;

								s = am.index - bm.index;
								if (s != 0) return s;

								++ai;
								++bi;
							}

							s = a.matches.length - b.matches.length;
							if (s != 0) return s;

							s = a.object.name.length - b.object.name.length;
							if (s != 0) return s;

							return a.object.name.localeCompare(b.object.name);
						})
						.map(entry => entry.object);

					onValuesChanged: list.currentIndex = 0
				}

				topMargin: 7
				bottomMargin: list.count == 0 ? 0 : 7

				add: Transition {
					NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 100 }
				}

				displaced: Transition {
					NumberAnimation { property: "y"; duration: 200; easing.type: Easing.OutCubic }
					NumberAnimation { property: "opacity"; to: 1; duration: 100 }
				}

				move: Transition {
					NumberAnimation { property: "y"; duration: 200; easing.type: Easing.OutCubic }
					NumberAnimation { property: "opacity"; to: 1; duration: 100 }
				}

				remove: Transition {
					NumberAnimation { property: "y"; duration: 200; easing.type: Easing.OutCubic }
					NumberAnimation { property: "opacity"; to: 0; duration: 100 }
				}

				highlight: Rectangle {
					color: ShellGlobals.colors.bg1
					border.color: ShellGlobals.colors.yellow
					border.width: 1
				}

				keyNavigationEnabled: true
				keyNavigationWraps: true
				highlightMoveVelocity: -1
				highlightMoveDuration: 100
				preferredHighlightBegin: list.topMargin
				preferredHighlightEnd: list.height - list.bottomMargin
				highlightRangeMode: ListView.ApplyRange
				snapMode: ListView.SnapToItem

				readonly property real delegateHeight: 44

				delegate: MouseArea {
					required property DesktopEntry modelData;

					implicitHeight: list.delegateHeight
					implicitWidth: ListView.view.width

					onClicked: {
						modelData.execute();
						persist.launcherOpen = false;
					}

					RowLayout {
						id: delegateLayout
						anchors {
							verticalCenter: parent.verticalCenter
							left: parent.left
							leftMargin: 5
						}

						IconImage {
							Layout.alignment: Qt.AlignVCenter
							asynchronous: true
							implicitSize: 30
							source: Quickshell.iconPath(modelData.icon)
						}
						Text {
							text: modelData.name
							color: ShellGlobals.colors.fg1
							Layout.alignment: Qt.AlignVCenter
						}
					}
				}
			}
		}
	}

	Rectangle {
		id: preview

		anchors {
     	left: content.right
			leftMargin: 5
		}

		property real listYOffset: 7 + searchContainer.implicitHeight
		property real yCenter: list.contentY
		y: listYOffset - yCenter - height / 2 + (list.currentItem?.y ?? 0) + list.delegateHeight / 2

		implicitWidth: previewContent.implicitWidth + previewContent.anchors.margins * 2
		implicitHeight: previewContent.implicitHeight + previewContent.anchors.margins * 2

		color: ShellGlobals.colors.bg
		radius: 5
		border.color: ShellGlobals.colors.aqua
		border.width: 1

		property DesktopEntry entry: list.currentItem?.modelData ?? null
		property var toplevels: !entry ? []: ToplevelManager.toplevels.values
			.filter(toplevel => toplevel.appId.toLowerCase() == entry.id.toLowerCase())

		property real scaleMul: previewLayout.implicitWidth != 0 ? 1 : 0;
		Behavior on scaleMul { SmoothedAnimation { velocity: 5 } }

		opacity: scaleMul

		transform: Scale {
			origin.x: 0
			origin.y: preview.height / 2
			xScale: 0.9 + preview.scaleMul * 0.1
			yScale: xScale
		}

		Item {
			id: previewContent
			anchors.fill: parent
			anchors.margins: 10
			implicitWidth: previewLayout.implicitWidth
			implicitHeight: previewLayout.implicitHeight

	   	RowLayout {
				id: previewLayout

	   		Repeater {
     			model: preview.toplevels

     			Rectangle {
						id: delegate
     				required property Toplevel modelData;
						color: "transparent"

						visible: view.hasContent
						implicitWidth: previewContent.implicitWidth
						implicitHeight: previewContent.implicitHeight

				   	ColumnLayout {
				   		id: previewContent
				   		anchors.centerIn: parent
				   		width: 240

				   		ScreencopyView {
				   			id: view
				   			implicitWidth: 240
				   			implicitHeight: 200
				   			captureSource: modelData
				   			live: true
				   		}

				   		Label {
				   			text: modelData.title
				   			Layout.fillWidth: true
				   			elide: Text.ElideRight
				   			horizontalAlignment: Text.AlignHCenter
				   		}
				   	}
     			}
	   		}
	   	}
		}
	}
}
