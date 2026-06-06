{ pkgs, ... }:

{
  system.defaults = {

    dock = {
      autohide = true;
      orientation = "left";
      show-recents = false;
      persistent-apps = [
        "/Applications/Nix Apps/Zen Browser.app"
        
        "/Applications/Things3.app"
        "/System/Applications/Calendar.app"

        "/Applications/Nix Apps/Logseq.app"
        "/System/Applications/Notes.app"

        "/System/Applications/Messages.app"
        "/Applications/WhatsApp.app"
        "/Applications/Nix Apps/Signal.app"
        "/System/Applications/Mail.app"
        
        "/Applications/Nix Apps/Ghostty.app"
      ];
    };

    finder = {
      FXPreferredViewStyle = "clmv";
      # limit default search scope to current folder
      FXDefaultSearchScope = "SCcf";
      ShowPathbar = true;
      ShowStatusBar = true;
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleICUForce24HourTime = true;
      ApplePressAndHoldEnabled = false;

      KeyRepeat = 2;
      InitialKeyRepeat = 15;

      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;

      _HIHideMenuBar = true;
      
      # enable natural scroll
      "com.apple.swipescrolldirection" = true;
      # set fn keys as default function keys (usable without fn+fkey combination)
      "com.apple.keyboard.fnState" = true;
    };

    screencapture = {
      location = "~leopoldsprenger/Downloads";
      type = "png";
    };

    spaces = {
      # this enables each monitor to have a its own space
      spans-displays = true;
    };

    loginwindow = {
      # disable guest user
      GuestEnabled = false;
    };

    LaunchServices = {
      # disable warning from apps downloaded from the web
      LSQuarantine = false;
    };

    CustomUserPreferences = {
      "com.apple.screensaver" = {
        showLargeClock = false;
      };
      # disable spotlight trigger and file search
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          "64" = { enabled = false; };
          "65" = { enabled = false; };
        };
      };
      # disable crash report dialog box
      "com.apple.CrashReporter" = {
        DialogType = "none";
      };
      "com.apple.dock" = {
        # disable the top two hot corners
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-tl-modifier = 0;
        wvous-tr-modifier = 0;

        # set bottom left to show desktop with cmd modifier
        wvous-bl-corner = 4;
        wvous-bl-modifier = 1048576;

        # set bottom right to quick note with cmd modifier
        wvous-br-corner = 14;
        wvous-br-modifier = 1048576;
      };
    };
  };

  system.activationScripts.postActivation.text = ''
    # set fire wall into stealth mode
    /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

    sudo -u leopoldsprenger HOME=/Users/leopoldsprenger bash <<'EOF'
      export PATH="/usr/bin:/bin:/usr/sbin:/sbin"

      # disable dock hide animation
      defaults write com.apple.dock autohide-time-modifier -float 0
      defaults write com.apple.dock autohide-delay -float 0
      killall Dock

      # set wallpaper
      WALLPAPER_PATH="$HOME/dotfiles/wallpapers/dark-mountains.jpg"
      if [ -f "$WALLPAPER_PATH" ]; then
        ${pkgs.desktoppr}/bin/desktoppr "$WALLPAPER_PATH"
      fi

      # show hidden files
      defaults write com.apple.finder AppleShowAllFiles YES
      
      MYSIDES="${pkgs.mysides}/bin/mysides"
      add_favorite() {
        local name="$1"
        local path="$2"
        if [ -d "$path" ]; then
          $MYSIDES add "$name" "file://$path"
        fi
      }
      
      # ensure relevant directories exist
      mkdir -p "$HOME/Documents/projects"

      # add favorites with script, since there is no official nix config
      add_favorite "Downloads" "$HOME/Downloads"
      add_favorite "Documents" "$HOME/Documents"
      add_favorite "Projects" "$HOME/Documents/projects"
      add_favorite "iCloud" "$HOME/Library/Mobile Documents/com~apple~CloudDocs"

      # restart finder
      killall Finder
EOF
  '';
}

