# Nix Dotfiles

Declarative macOS system configuration using nix-darwin, home-manager,
nix-homebrew, and sops-nix. Structured so a NixOS host can sit alongside
the darwin machines without a rewrite — see the bottom of `flake.nix`.

Goal: two machines (`macbook`, `macmini`) that stay identical, and a
reinstall that's `git clone` + one command instead of manual cleanup.

---

## What changed from the old layout

**Bugs fixed:**

- `$ICLOUD_BASE` was used in the Finder-favorites activation script but
  never defined, so every iCloud subfolder favorite silently failed to
  add. Now set from the real `~/Library/Mobile Documents/com~apple~CloudDocs`
  path.
- `home/zsh.nix` and `home/ohmyposh.nix` existed on disk but were never
  imported anywhere, so `programs.zsh` and the oh-my-posh prompt were
  never actually applied. Now imported in `home/leopold.nix`.
- The Zoom launchd agent pointed at `/Applications/Zoom.app`. The `zoom`
  cask actually installs `zoom.us.app` — fixed.
- The Dock's `persistent-apps` referenced `/Applications/Zen Browser.app`.
  The `zen` cask installs `Zen.app` — fixed.
- `flake.nix` defined `macmini` and `macbook` as two fully duplicated
  ~40-line blocks. Extracted into `lib/mkdarwin.nix`, a builder function —
  each host is now one line in `flake.nix` plus its `hosts/darwin/*.nix`.
- `modules/packages.nix` took a `customPackages` argument it never used;
  removed. The flake's `packages.${system}.mousecape` output was
  independently re-derived instead of reusing `customPackages`; now shares
  the same derivation.

**Structure**, modernized and split by platform so NixOS can join later:

```
lib/mkdarwin.nix        shared darwinSystem builder
hosts/darwin/*.nix       per-machine differences only
hosts/nixos/             empty, documented — see its README
modules/darwin/*.nix     system-level config (was modules/*.nix)
modules/nixos/           empty, documented — see its README
home/*.nix               home-manager modules (unchanged set, minus supercmd, plus raycast)
packages/                custom package derivations (unchanged)
resources/               static config files consumed by the modules above
secrets/                 sops-nix encrypted secrets (see below — empty until you bootstrap it)
```

`flake.lock` isn't included — run `nix flake lock` once after cloning to
generate it fresh with the new `sops-nix` input pinned. I didn't want to
hand-assemble a lock file's hashes without `nix` available to actually
verify them.

---

## Fresh Installation (Clean Machine)

### 1. Install Nix

```bash
sh <(curl -L https://nixos.org/nix/install)
```

### 2. Enable Flakes

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

### 3. Clone Dotfiles

```bash
nix-shell -p git --run 'git clone https://github.com/leopoldsprenger/dotfiles.git ~/dotfiles'
cd ~/dotfiles
nix flake lock
```

### 4. Secrets (sops-nix) — do this before the first switch if you want Mail provisioning

The Mail account feature (below) needs a decryptable secret to exist, but
everything else in this repo works fine without it — `sops.secrets` and
the Mail module are gated on `secrets/secrets.yaml` actually existing, so
skipping this section just means Mail.app isn't auto-provisioned yet.

```bash
nix-shell -p age sops --run '
  mkdir -p "$HOME/Library/Application Support/sops/age"
  age-keygen -o "$HOME/Library/Application Support/sops/age/keys.txt"
'
```

This prints a line like `Public key: age1...`. Copy it into `.sops.yaml`,
replacing `age1REPLACE_WITH_YOUR_AGE_PUBLIC_KEY`. Then:

```bash
nix-shell -p sops --run 'sops secrets/secrets.yaml'
```

This opens `$EDITOR` on a decrypted buffer; on save it encrypts to disk.
Fill in the structure shown in `secrets/secrets.example.yaml`:

```yaml
mail:
    imap_password: "your real IMAP/app-specific password"
```

**Keeping both machines identical**: either generate one age key and copy
`keys.txt` to the second machine yourself (e.g. via Bitwarden's secure
notes, which you already have installed), or run `age-keygen` on each
machine and list both public keys under `.sops.yaml`'s `keys:` — either
way this one file has to move between machines out-of-band, since it's the
literal key that makes the rest of the secrets recoverable. That's not a
gap in this config; it's the one thing that can't be bootstrapped from
inside the system it unlocks.

Before filling in `secrets/secrets.yaml`, also edit
`modules/darwin/mail.nix` and replace the three `REPLACE_ME` placeholders
(`mailAddress`, `imapHost`, `smtpHost`) with your real TU Berlin (or other
IMAP) account details — none of those three are secret, so they're plain
Nix strings, not sops entries.

### 5. Activate System

```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles#macmini
```

or

```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles#macbook
```

### 6. Future updates

```bash
darwin-rebuild switch --flake ~/dotfiles#macmini   # or #macbook
```

```bash
nix flake update   # bump all inputs
```

---

## What's automated vs. what still needs a click

The goal was "anything Nix can do on a fresh machine, it should do." Two
things Apple deliberately keeps un-automatable, both handled as gracefully
as macOS allows:

- **Mail account** (`modules/darwin/mail.nix`): generates a `.mobileconfig`
  with your IMAP/SMTP host, ports, and password pre-filled from sops, and
  opens it once at activation. macOS has required an interactive
  "Install" click + password for configuration profiles since Big Sur —
  there's no supported way around that click. iCloud Mail specifically
  can't be provisioned this way at all (interactive Apple ID sign-in only).
- **Raycast config** (`home/raycast.nix`, `resources/raycast/README.md`):
  extensions/snippets/hotkeys live in an encrypted export Raycast
  generates on a schedule you set once in Settings → Advanced → Export,
  pointed at `backup/raycast/`. Restoring on a new machine is one
  "Import Settings & Data" run — Raycast doesn't expose a headless
  importer.

Everything else — Finder favorites, Dock layout, keyboard/trackpad
settings, fonts, shell, prompt, terminal, editor, window manager, all
Homebrew casks/App Store apps, UTM — is fully declarative and needs zero
manual steps after step 5 above.

---

## Adding a NixOS host later

See `hosts/nixos/README.md` and `modules/nixos/README.md`, and the comment
block at the bottom of `flake.nix`. In short: `lib/mkdarwin.nix` is the
pattern to copy into a `lib/mknixos.nix` that calls
`nixpkgs.lib.nixosSystem` instead of `nix-darwin.lib.darwinSystem` — the
rest of the repo (packages/, most of home/) doesn't need to change.
