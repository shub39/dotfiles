import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs

Item {
    id: root
    height: 50 + searchContainer.implicitHeight + list.topMargin * 2 + list.delegateHeight * 10
    width: 600

    Rectangle {
        id: content
        height: 24 + searchContainer.implicitHeight + list.topMargin + list.bottomMargin + Math.min(list.contentHeight, list.delegateHeight * 10)
        Behavior on height {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
        width: parent.width
        color: ShellGlobals.materialColors.tertiarycontainer
        radius: 32

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            anchors.bottomMargin: 0
            spacing: 0

            Rectangle {
                id: searchContainer
                Layout.fillWidth: true
                implicitHeight: searchbox.implicitHeight + 10
                color: ShellGlobals.materialColors.secondarycontainer
                radius: 1000

                RowLayout {
                    id: searchbox
                    anchors.fill: parent
                    anchors.margins: 5

                    Item {
                        width: 10
                    }

                    TextInput {
                        id: search
                        Layout.fillWidth: true
                        color: ShellGlobals.materialColors.onsecondarycontainer

                        font.family: ShellGlobals.fontFamily
                        font.pixelSize: 36
                        font.bold: true
                        font.letterSpacing: ShellGlobals.letterSpacing

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
                    values: DesktopEntries.applications.values.map(object => {
                        const stxt = search.text.toLowerCase();
                        const ntxt = object.name.toLowerCase();
                        let si = 0;
                        let ni = 0;

                        let matches = [];
                        let startMatch = -1;

                        for (let si = 0; si != stxt.length; ++si) {
                            const sc = stxt[si];

                            while (true) {
                                if (ni == ntxt.length)
                                    return null;

                                const nc = ntxt[ni++];

                                if (nc == sc) {
                                    if (startMatch == -1)
                                        startMatch = ni;
                                    break;
                                } else {
                                    if (startMatch != -1) {
                                        matches.push({
                                            index: startMatch,
                                            length: ni - startMatch
                                        });

                                        startMatch = -1;
                                    }
                                }
                            }
                        }

                        if (startMatch != -1) {
                            matches.push({
                                index: startMatch,
                                length: ni - startMatch + 1
                            });
                        }

                        return {
                            object: object,
                            matches: matches
                        };
                    }).filter(entry => entry !== null).sort((a, b) => {
                        let ai = 0;
                        let bi = 0;
                        let s = 0;

                        while (ai != a.matches.length && bi != b.matches.length) {
                            const am = a.matches[ai];
                            const bm = b.matches[bi];

                            s = bm.length - am.length;
                            if (s != 0)
                                return s;

                            s = am.index - bm.index;
                            if (s != 0)
                                return s;

                            ++ai;
                            ++bi;
                        }

                        s = a.matches.length - b.matches.length;
                        if (s != 0)
                            return s;

                        s = a.object.name.length - b.object.name.length;
                        if (s != 0)
                            return s;

                        return a.object.name.localeCompare(b.object.name);
                    }).map(entry => entry.object)

                    onValuesChanged: list.currentIndex = 0
                }

                topMargin: 7
                bottomMargin: list.count == 0 ? 0 : 7

                add: Transition {
                    NumberAnimation {
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 100
                    }
                }

                displaced: Transition {
                    NumberAnimation {
                        property: "y"
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                    NumberAnimation {
                        property: "opacity"
                        to: 1
                        duration: 100
                    }
                }

                move: Transition {
                    NumberAnimation {
                        property: "y"
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                    NumberAnimation {
                        property: "opacity"
                        to: 1
                        duration: 100
                    }
                }

                remove: Transition {
                    NumberAnimation {
                        property: "y"
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                    NumberAnimation {
                        property: "opacity"
                        to: 0
                        duration: 100
                    }
                }

                highlight: Rectangle {
                    color: ShellGlobals.materialColors.tertiary
                    radius: 1000
                }

                keyNavigationEnabled: true
                keyNavigationWraps: true
                highlightMoveVelocity: -1
                highlightMoveDuration: 100
                preferredHighlightBegin: list.topMargin
                preferredHighlightEnd: list.height - list.bottomMargin
                highlightRangeMode: ListView.ApplyRange
                snapMode: ListView.SnapToItem

                readonly property real delegateHeight: 48

                delegate: MouseArea {
                    required property DesktopEntry modelData

                    implicitHeight: list.delegateHeight
                    implicitWidth: ListView.view.width

                    onClicked: {
                        modelData.execute();
                        persist.launcherOpen = false;
                    }

                    RowLayout {
                        id: delegateLayout
                        spacing: 8
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                            leftMargin: 16
                        }

                        IconImage {
                            Layout.alignment: Qt.AlignVCenter
                            asynchronous: true
                            implicitSize: 32
                            source: Quickshell.iconPath(modelData.icon)
                        }

                        Text {
                            text: modelData.name
                            color: ShellGlobals.materialColors.ontertiarycontainer
                            font.pixelSize: 24
                            font.family: ShellGlobals.fontFamily
                            font.bold: true
                            Layout.alignment: Qt.AlignVCenter
                        }
                    }
                }
            }
        }
    }
}
