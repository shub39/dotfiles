pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property int workspaces: 4
    
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 14
    
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
    
   	readonly property var popoutXCurve: EasingCurve {
		curve.type: Easing.OutQuint
	}
   
	readonly property var popoutYCurve: EasingCurve {
		curve.type: Easing.InQuart
	}
   
	function interpolateColors(x: real, a: color, b: color): color {
		const xa = 1.0 - x;
		return Qt.rgba(a.r * xa + b.r * x, a.g * xa + b.g * x, a.b * xa + b.b * x, a.a * xa + b.a * x);
	}
}