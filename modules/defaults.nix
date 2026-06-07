{ pkgs, ... }:

{
  system.defaults = {

    dock = {
      autohide = true;
      orientation = "left";
      show-recents = false;
      tilesize = 24;
      persistent-apps = [
        "/Applications/Zen Browser.app"
        
        "/Applications/Things3.app"
        "/System/Applications/Calendar.app"

        "/Applications/Logseq.app"
        "/System/Applications/Notes.app"

        "/System/Applications/Messages.app"
        "/Applications/WhatsApp.app"
        "/Applications/Signal.app"
        "/System/Applications/Mail.app"
        
        "/Applications/Ghostty.app"
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

      # sidebar icon size medium
      NSTableViewDefaultSizeMode = 2;

      # show scrollbar based on mouse or trackpad
      AppleShowScrollBars = "Automatic";
      # jump to spot that was clicked on scrollbar
      AppleScrollerPagingBehavior = true;

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
      # tint window color to wallpaper
      "NSGlobalDomain" = {
        AppleReduceDesktopTinting = false;
      };
      "com.apple.screensaver" = {
        showLargeClock = false;
      };
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # disable spotlight trigger and file search
          "64" = { enabled = false; };
          "65" = { enabled = false; };
          # set keyboard layout switching to cmd shift l
          "60" = {
            enabled = true;
            value = {
              parameters = [
                108
                37
                1179648
              ];
              type = "standard";
            };
          };
          # disable secondary hotkey for switching languages
          "61" = {
            enabled = false;
          };
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
      # define keyboard layouts
      "com.apple.HIToolbox" = {
        AppleEnabledInputSources = [
          {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 0;
            "KeyboardLayout Name" = "U.S.";
          }
          {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 9;
            "KeyboardLayout Name" = "German";
          }
          {
            BundleID = "com.apple.inputmethod.Kotoeri";
            InputSourceKind = "Input Mode";
            "InputModeName" = "com.apple.inputmethod.Japanese";
          }
          {
            BundleID = "com.apple.inputmethod.Kotoeri";
            InputSourceKind = "Keyboard Input Method";
          }
        ];
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
      WALLPAPER_PATH="$HOME/dotfiles/resources/wallpapers/dark-mountains.jpg"
      if [ -f "$WALLPAPER_PATH" ]; then
        ${pkgs.desktoppr}/bin/desktoppr "$WALLPAPER_PATH"
      fi

      # show hidden files
      defaults write com.apple.finder AppleShowAllFiles YES
      
      MYSIDES="${pkgs.mysides}/bin/mysides"
      
      # remove apple default favorites and recents
      $MYSIDES remove all

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
      
      # map individual icloud subfolders into favorites layout
      add_favorite "01 Life Admin" "$ICLOUD_BASE/01 Life Admin"
      add_favorite "02 Health" "$ICLOUD_BASE/02 Health"
      add_favorite "03 Personal" "$ICLOUD_BASE/03 Personal"
      add_favorite "04 Academics" "$ICLOUD_BASE/04 Academics"
      add_favorite "05 Business" "$ICLOUD_BASE/05 Business"
      add_favorite "06 Archive" "$ICLOUD_BASE/06 Archive"

      # add library and applications at the bottom
      add_favorite "Library" "$HOME/Library"
      add_favorite "Applications" "/Applications"

      # restart finder
      killall Finder

      # flush preferences cache for CustomUserPreferences to take effect
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
EOF
  '';
}
