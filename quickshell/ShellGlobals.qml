pragma Singleton

import Quickshell
import QtQuick

Singleton {
    property bool isLocked: false
    property bool isDnd: false
    
    // Font Config
    readonly property string fontFamily: "Google Sans"
    readonly property double letterSpacing: 0
    readonly property int fontSize: 11
    
    // material colors
    readonly property var materialColors: QtObject {
        readonly property color primary: "#0a0a0a"
        readonly property color onprimary: "#ffffff"
        readonly property color primarycontainer: "#111111"
        readonly property color onprimarycontainer: "#ffffff"
        readonly property color inverseprimary: "#ffffff"
        readonly property color secondary: "#ffffff"
        readonly property color onsecondary: "#000000"
        readonly property color secondarycontainer: "#0a0a0a"
        readonly property color onsecondarycontainer: "#ffffff"
        readonly property color tertiary: "#111111"
        readonly property color ontertiary: "#ffffff"
        readonly property color tertiarycontainer: "#000000"
        readonly property color ontertiarycontainer: "#ffffff"
        readonly property color background: "#000000"
        readonly property color onbackground: "#ffffff"
        readonly property color surface: "#000000"
        readonly property color onsurface: "#ffffff"
        readonly property color surfacevariant: "#111111"
        readonly property color onsurfacevariant: "#ffffff"
        readonly property color surfacetint: "#ffffff"
        readonly property color inversesurface: "#ffffff"
        readonly property color inverseonsurface: "#000000"
        readonly property color error: "#ffffff"
        readonly property color onerror: "#000000"
        readonly property color errorcontainer: "#ffffff"
        readonly property color onerrorcontainer: "#000000"
        readonly property color outline: "#000000"
        readonly property color outlinevariant: "#000000"
        readonly property color scrim: "#000000"
        readonly property color surfacebright: "#111111"
        readonly property color surfacecontainer: "#0a0a0a"
        readonly property color surfacecontainerhigh: "#111111"
        readonly property color surfacecontainerhighest: "#161616"
        readonly property color surfacecontainerlow: "#050505"
        readonly property color surfacecontainerlowest: "#000000"
        readonly property color surfacedim: "#000000"
    }
    
    // Theme
    readonly property var colors: QtObject {
        // Core
        readonly property color bg:    "#000000";
        readonly property color fg:    "#ffffff";
    
        // Normal colors
        readonly property color red:    "#ffffff";
        readonly property color green:  "#ffffff";
        readonly property color yellow: "#ffffff";
        readonly property color blue:   "#ffffff";
        readonly property color purple: "#ffffff";
        readonly property color aqua:   "#ffffff";
        readonly property color gray:   "#ffffff";
    
        // Bright colors
        readonly property color brightRed:    "#ffffff";
        readonly property color brightGreen:  "#ffffff";
        readonly property color brightYellow: "#ffffff";
        readonly property color brightBlue:   "#ffffff";
        readonly property color brightPurple: "#ffffff";
        readonly property color brightAqua:   "#ffffff";
        readonly property color brightGray:   "#ffffff";
    
        // Background shades
        readonly property color bg0_h: "#000000";
        readonly property color bg0:   "#000000";
        readonly property color bg0_s: "#050505";
        readonly property color bg1:   "#0a0a0a";
        readonly property color bg2:   "#111111";
        readonly property color bg3:   "#161616";
        readonly property color bg4:   "#202020";
    
        // Foreground shades
        readonly property color fg0: "#ffffff";
        readonly property color fg1: "#ffffff";
        readonly property color fg2: "#eeeeee";
        readonly property color fg3: "#dddddd";
        readonly property color fg4: "#cccccc";
    
        // Extra
        readonly property color orange:       "#ffffff";
        readonly property color brightOrange: "#ffffff";
    }
    
    function adjustTextOverflow(text, maxWidth) {
        if (text.length > maxWidth) {
            return text.substring(0, maxWidth - 3) + "...";
        }
        return text;
    }
}
