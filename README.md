# **`shub39's` Dotfiles**

## Hosts

| Host         | Machine          | Role                                |
| ------------ | ---------------- | ----------------------------------- |
| `rher`       | Desktop PC       | Gaming + development                |
| `gro-goroth` | ThinkPad laptop  | Laptop + home server (Jellyfin)     |
| `sylvian`    | Home computer    | GNOME drawing workstation + Immich  |
| `alll-mer`   | Macbook          | development                         |

## Module layout

| Directory          | Scope                                                          |
| ------------------ | -------------------------------------------------------------- |
| `modules/common`   | Cross-platform modules (options, nix, shell, fonts, packages)  |
| `modules/nixos`    | NixOS-only modules (`environment.nix` = base, `default.nix` = base + packages) |
| `modules/darwin`   | nix-darwin-only modules                                        |
| `modules/features` | Opt-in capabilities, gated by `my.*` flags                     |

Each platform has an aggregator (`modules/nixos/default.nix`,
`modules/darwin/default.nix`) that imports the shared `common` modules plus its
own platform modules. Host files must **not** list module paths: they import
only their own `hardware-configuration.nix` and the platform aggregator, then
choose capabilities with `my.*` flags.

`modules/nixos/environment.nix` is the base aggregator: boot, networking,
locale, audio, desktop plumbing, users, shell and git, with **no** application
packages. `modules/nixos/default.nix` adds the shared desktop packages on top.
Hosts that should stay minimal (like `sylvian`) import `environment.nix` plus
the features they need instead of the full aggregator.

## Capabilities (`my.*`)

| Option                 | Default | Effect                                                          |
| ---------------------- | ------- | --------------------------------------------------------------- |
| `my.gaming.enable`     | `true`  | Steam and gaming support                                        |
| `my.devTools.enable`   | `true`  | Android tools, Godot, formatters, uv, audacity                  |
| `my.editor.enable`     | `true`  | Zed editor and the Nix language servers (nixd, nil)             |
| `my.laptop.enable`     | `false` | Laptop power management, ThinkPad charge cap, bluetooth         |
| `my.homeserver.enable` | `false` | Jellyfin, qbittorrent, slskd, tailscale                           |
| `my.hermes.enable`     | `false` | Hermes agent container (docker) with its web UI                 |
| `my.immich.enable`     | `false` | Immich photo server (mount data disk at `/var/lib/immich`)      |
| `my.niri.enable`       | `true`  | Niri compositor, `ly` display manager, and Niri-only desktop packages |
| `my.gnome.enable`      | `false` | GNOME desktop environment with GDM                              |

A host picks exactly one desktop environment with `my.niri.enable` /
`my.gnome.enable` (niri is the default). For example, `sylvian` sets:

```nix
my = {
  niri.enable = false;
  gnome.enable = true;
  immich.enable = true;
};
```

`sylvian` imports only the base environment plus the Immich feature, so it does
not pull in the shared desktop packages (alacritty, chromium, etc.).
`gro-goroth` sets:

```nix
my = {
  gaming.enable = false;
  devTools.enable = false;
  laptop.enable = true;
  homeserver.enable = true;
  hermes.enable = true;
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
