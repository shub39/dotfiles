pragma Singleton

import Quickshell
import QtQuick

Singleton {
    property bool isLocked: false
    property bool isDnd: false
    
    // Font Config
    readonly property string fontFamily: "Google Sans"
    readonly property double letterSpacing: 0.1
    readonly property int fontSize: 14
    
    // material colors
    readonly property var materialColors: QtObject {
        readonly property color primary: "#ffba2c"
        readonly property color onprimary: "#563b00"
        readonly property color primarycontainer: "#eaa702"
        readonly property color onprimarycontainer: "#452f00"
        readonly property color inverseprimary: "#7e5800"
        readonly property color secondary: "#dac3a1"
        readonly property color onsecondary: "#4d3e24"
        readonly property color secondarycontainer: "#483920"
        readonly property color onsecondarycontainer: "#d3bc9a"
        readonly property color tertiary: "#ffc5a6"
        readonly property color ontertiary: "#693c21"
        readonly property color tertiarycontainer: "#f6b591"
        readonly property color ontertiarycontainer: "#5e3318"
        readonly property color background: "#110e08"
        readonly property color onbackground: "#f2e3d1"
        readonly property color surface: "#110e08"
        readonly property color onsurface: "#f2e3d1"
        readonly property color surfacevariant: "#2c2519"
        readonly property color onsurfacevariant: "#b6a998"
        readonly property color surfacetint: "#ffba2c"
        readonly property color inversesurface: "#fff8f3"
        readonly property color inverseonsurface: "#5a544c"
        readonly property color error: "#f97758"
        readonly property color onerror: "#450900"
        readonly property color errorcontainer: "#85230a"
        readonly property color onerrorcontainer: "#ff9b82"
        readonly property color outline: "#7f7464"
        readonly property color outlinevariant: "#504739"
        readonly property color scrim: "#000000"
        readonly property color surfacebright: "#332b1f"
        readonly property color surfacecontainer: "#1e1910"
        readonly property color surfacecontainerhigh: "#251f15"
        readonly property color surfacecontainerhighest: "#2c2519"
        readonly property color surfacecontainerlow: "#17130b"
        readonly property color surfacecontainerlowest: "#000000"
        readonly property color surfacedim: "#110e08"
    }
    
    // Theme
    readonly property var colors: QtObject {
        // Core
        readonly property color bg:    "#282828";
        readonly property color fg:    "#ebdbb2";
    
        // Normal colors
        readonly property color red:    "#cc241d";
        readonly property color green:  "#98971a";
        readonly property color yellow: "#d79921";
        readonly property color blue:   "#458588";
        readonly property color purple: "#b16286";
        readonly property color aqua:   "#689d6a";
        readonly property color gray:   "#a89984";
    
        // Bright colors
        readonly property color brightRed:    "#fb4934";
        readonly property color brightGreen:  "#b8bb26";
        readonly property color brightYellow: "#fabd2f";
        readonly property color brightBlue:   "#83a598";
        readonly property color brightPurple: "#d3869b";
        readonly property color brightAqua:   "#8ec07c";
        readonly property color brightGray:   "#928374";
    
        // Background shades
        readonly property color bg0_h: "#1d2021";
        readonly property color bg0:   "#282828";
        readonly property color bg0_s: "#32302f";
        readonly property color bg1:   "#3c3836";
        readonly property color bg2:   "#504945";
        readonly property color bg3:   "#665c54";
        readonly property color bg4:   "#7c6f64";
    
        // Foreground shades
        readonly property color fg0: "#fbf1c7";
        readonly property color fg1: "#ebdbb2";
        readonly property color fg2: "#d5c4a1";
        readonly property color fg3: "#bdae93";
        readonly property color fg4: "#a89984";
    
        // Extra
        readonly property color orange:       "#d65d0e";
        readonly property color brightOrange: "#fe8019";
    }
    
    function adjustTextOverflow(text, maxWidth) {
        if (text.length > maxWidth) {
            return text.substring(0, maxWidth - 3) + "...";
        }
        return text;
    }
}