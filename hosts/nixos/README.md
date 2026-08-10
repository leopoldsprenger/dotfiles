# NixOS hosts

Empty on purpose. When there's a real NixOS machine to configure, its host
file goes here as `hosts/nixos/<hostname>.nix`, next to a generated
`hosts/nixos/<hostname>-hardware.nix` (from `nixos-generate-config`).

This directory is intentionally not scaffolded with a fake example host —
a `hardware-configuration.nix` is meaningless without real hardware to
generate it from, and a placeholder host would just be something to delete
later. See `modules/nixos/README.md` and the note at the bottom of
`flake.nix` for how this plugs in.
