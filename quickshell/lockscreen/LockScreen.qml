import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import qs

ShellRoot {
    GlobalShortcut {
        name: "lockscreen"
        onPressed: ShellGlobals.isLocked = true
    }
    
	LockContext {
		id: lockContext

		onUnlocked: {
			ShellGlobals.isLocked = false;
		}
	}

	WlSessionLock {
		id: lock

		locked: ShellGlobals.isLocked

		WlSessionLockSurface {
			LockSurface {
				anchors.fill: parent
				context: lockContext
			}
		}
	}
}