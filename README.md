# MacOS Nix-Darwin Dotfiles

Declarative macOS system configuration using:

- nix-darwin
- home-manager
- nix-homebrew

---

## Fresh Installation (Clean Machine)

### 1. Install Nix

```bash
sh <(curl -L https://nixos.org/nix/install)
```

---

### 2. Enable Flakes

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

---

### 3. Clone Dotfiles

```bash
nix-shell -p git --run 'git clone https://github.com/leopoldsprenger/dotfiles.git ~/dotfiles'
```

---

### 4. Activate System

#### Mac Mini

```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles#macmini
```

#### MacBook

```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles#macbook
```

---

### 5. Future updates

```bash
darwin-rebuild switch --flake ~/dotfiles#macmini
```

or

```bash
darwin-rebuild switch --flake ~/dotfiles#macbook
```

---

## Updating the Nix Flake

```bash
nix flake update
```
