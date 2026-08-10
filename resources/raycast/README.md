# Raycast backup

There's no exported config checked into this repo (there's nothing to
export from this delivery — that has to come from your actual Raycast
setup). This file just documents the workflow described in
`home/raycast.nix`:

**Backing up (one-time setup per machine):**

1. Raycast → Settings → Advanced → Export
2. Pick a backup frequency (Daily / Weekly / Monthly)
3. Set the output folder to `~/dotfiles/backup/raycast/`
4. Set an export passphrase — Raycast reuses it for future scheduled exports

From then on, a fresh `.rayconfig` file lands in `backup/raycast/` on
schedule. That folder is already excluded by `.gitignore`, so backups
happen locally without pushing encrypted extension/API-token data to
GitHub. If you want it to survive a full reinstall (not just live on the
one machine), sync `~/dotfiles/backup/raycast/` somewhere off-machine
yourself — e.g. point the export folder at an iCloud Drive path instead of
straight into the repo, or copy the file to iCloud/Bitwarden after export.

**Restoring on a fresh machine:**

1. Let `darwin-rebuild switch` install Raycast via the `raycast` cask
2. Open Raycast, run "Import Settings & Data"
3. Point it at the newest file in `backup/raycast/`
4. Enter the passphrase, pick which categories to bring in

Steps 2–4 are manual because Raycast doesn't expose an importer over the
command line or a URL scheme that skips the passphrase prompt — same
category of limitation as the Mail profile install in
`modules/darwin/mail.nix`.
