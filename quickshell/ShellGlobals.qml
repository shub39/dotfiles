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
    
    // Gruvbox dark material-style roles
    readonly property var materialColors: QtObject {
        readonly property color primary: "#3c3836"
        readonly property color onprimary: "#ebdbb2"
        readonly property color primarycontainer: "#504945"
        readonly property color onprimarycontainer: "#fbf1c7"
        readonly property color inverseprimary: "#d65d0e"
        readonly property color secondary: "#d79921"
        readonly property color onsecondary: "#282828"
        readonly property color secondarycontainer: "#32302f"
        readonly property color onsecondarycontainer: "#ebdbb2"
        readonly property color tertiary: "#665c54"
        readonly property color ontertiary: "#fbf1c7"
        readonly property color tertiarycontainer: "#3c3836"
        readonly property color ontertiarycontainer: "#ebdbb2"
        readonly property color background: "#1d2021"
        readonly property color onbackground: "#ebdbb2"
        readonly property color surface: "#282828"
        readonly property color onsurface: "#ebdbb2"
        readonly property color surfacevariant: "#3c3836"
        readonly property color onsurfacevariant: "#d5c4a1"
        readonly property color surfacetint: "#d79921"
        readonly property color inversesurface: "#ebdbb2"
        readonly property color inverseonsurface: "#282828"
        readonly property color error: "#fb4934"
        readonly property color onerror: "#282828"
        readonly property color errorcontainer: "#cc241d"
        readonly property color onerrorcontainer: "#fbf1c7"
        readonly property color outline: "transparent"
        readonly property color outlinevariant: "transparent"
        readonly property color scrim: "#1d2021"
        readonly property color surfacebright: "#504945"
        readonly property color surfacecontainer: "#282828"
        readonly property color surfacecontainerhigh: "#3c3836"
        readonly property color surfacecontainerhighest: "#504945"
        readonly property color surfacecontainerlow: "#1d2021"
        readonly property color surfacecontainerlowest: "#1d2021"
        readonly property color surfacedim: "#1d2021"
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
