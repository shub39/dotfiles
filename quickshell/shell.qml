import Quickshell
import QtQuick

import "bar"
import "wallpaper"
import "logout"
import "lockscreen"
import "launcher" as Launcher

Scope {
    Component.onCompleted: [Launcher.Controller.init()] 
    
    Bar {}
    Wallpaper {}
    Logout {}
}