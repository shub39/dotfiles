import Quickshell
import QtQuick

import "bar"
import "wallpaper"
import "logout"
import "lock"
import "launcher" as Launcher

Scope {
    Component.onCompleted: [Launcher.Controller.init()] 
    
    Bar {}
    Wallpaper {}
    Logout {}
    Lock {}
}