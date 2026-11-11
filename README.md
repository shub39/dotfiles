# **`shub39's` Dotfiles**

## Hosts

| Host         | Machine          | Role                              |
| ------------ | ---------------- | --------------------------------- |
| `rher`       | Desktop PC       | Gaming + development              |
| `gro-goroth` | ThinkPad laptop  | Laptop + home server (Jellyfin)   |

Capabilities are toggled per host through the `my.*` options in
`modules/options.nix`. For example, `gro-goroth` sets:

```nix
my = {
  gaming.enable = false;   # Steam
  devTools.enable = false; # android-tools, godot, nixfmt, uv
  editor.enable = true;    # zed-editor, nixd, nil
};
```

## Niri

`niri/config.kdl` holds the shared configuration. Host-specific input
settings live in `niri/hosts/`. Point `~/.config/niri/config.kdl` at the
shared config plus the file for the current machine:

```kdl
// rher
include "~/.config/dotfiles/niri/config.kdl"
include "~/.config/dotfiles/niri/hosts/rher.kdl"

// gro-goroth
include "~/.config/dotfiles/niri/config.kdl"
include "~/.config/dotfiles/niri/hosts/gro-goroth.kdl"
```
