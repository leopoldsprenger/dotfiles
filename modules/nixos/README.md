# NixOS modules

Empty on purpose. This is where shared NixOS-side modules would live,
mirroring `modules/darwin/` — e.g. `system.nix` for `nix.settings` and
`system.stateVersion`, `packages.nix` for `environment.systemPackages`.

Anything that isn't actually platform-specific (most of `home/`, plus
`git.nix`'s and `nvim.nix`'s home-manager modules in particular) can be
reused as-is by a NixOS host's home-manager profile — only the
darwin-only modules (`aerospace.nix`, `sketchybar.nix`, `borders.nix`,
`cursorcerer.nix`, `mousecape.nix`, `raycast.nix`'s `targets.darwin.*`
block) would need a Linux-side equivalent or to be left out of that
host's `home/leopold.nix`-equivalent import list.
