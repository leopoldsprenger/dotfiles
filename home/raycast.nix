# Replaces supercmd.nix. Raycast itself is installed via the "raycast" cask
# in modules/darwin/homebrew.nix.
#
# Unlike SuperCmd, Raycast doesn't keep its configuration in one plain JSON
# file that can be dropped into place — extensions, snippets, hotkeys,
# aliases, and quicklinks live in an internal SQLite database plus an
# encrypted .rayconfig bundle when exported. There is no supported way to
# generate or unpack that file from Nix, so this module doesn't fake one.
#
# What this gets you instead: Raycast's own scheduled-export feature writes
# a fresh, password-protected .rayconfig backup on a schedule you pick, and
# this points it at backup/raycast/ — already excluded by .gitignore, so
# your extensions/snippets/hotkeys get backed up to disk on a schedule
# without ever being committed in plaintext-adjacent form to git.
#
# One-time setup on each machine (Raycast doesn't expose this as a
# scriptable default, so it has to be done by hand once):
#   1. Raycast → Settings → Advanced → Export
#   2. Set a backup frequency (Daily/Weekly/Monthly)
#   3. Set the output folder to ~/dotfiles/backup/raycast/
#   4. Set a passphrase (Raycast remembers it for future exports)
#
# Restoring on a fresh machine: run "Import Settings & Data" in Raycast,
# point it at the newest file in backup/raycast/, enter the passphrase you
# used, and pick which categories to bring in. This one click is a macOS
# limitation the same way the Mail profile install is — Raycast's own
# import command isn't scriptable from the command line.
# Nothing to declare here yet — see modules/darwin/defaults.nix for the
# `mkdir -p backup/raycast` line that makes sure the scheduled-export target
# folder above actually exists before you go looking for it in Settings.
{ ... }:

{ }
