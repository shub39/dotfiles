# **`shub39's` Dotfiles**

## Hosts

| Host         | Machine          | Role                              |
| ------------ | ---------------- | --------------------------------- |
| `rher`       | Desktop PC       | Gaming + development              |
| `gro-goroth` | ThinkPad laptop  | Laptop + home server (Jellyfin)   |
| `alll-mer`   | Macbook          | development                       |

## Module layout

| Directory          | Scope                                                          |
| ------------------ | -------------------------------------------------------------- |
| `modules/common`   | Cross-platform modules (options, nix, shell, fonts, packages)  |
| `modules/nixos`    | NixOS-only modules                                             |
| `modules/darwin`   | nix-darwin-only modules                                        |
| `modules/features` | Opt-in capabilities, gated by `my.*` flags                     |

Each platform has an aggregator (`modules/nixos/default.nix`,
`modules/darwin/default.nix`) that imports the shared `common` modules plus its
own platform modules. Host files must **not** list module paths: they import
only their own `hardware-configuration.nix` and the platform aggregator, then
choose capabilities with `my.*` flags.

## Capabilities (`my.*`)

| Option                 | Default | Effect                                                          |
| ---------------------- | ------- | --------------------------------------------------------------- |
| `my.gaming.enable`     | `true`  | Steam and gaming support                                        |
| `my.devTools.enable`   | `true`  | Android tools, Godot, formatters, uv, audacity                  |
| `my.editor.enable`     | `true`  | Zed editor and the Nix language servers (nixd, nil)             |
| `my.laptop.enable`     | `false` | Laptop power management, ThinkPad charge cap, bluetooth         |
| `my.homeserver.enable` | `false` | Jellyfin, immich, qbittorrent, slskd, tailscale, hermes-agent   |

For example, `gro-goroth` sets:

```nix
my = {
  gaming.enable = false;
  devTools.enable = false;
  laptop.enable = true;
  homeserver.enable = true;
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
