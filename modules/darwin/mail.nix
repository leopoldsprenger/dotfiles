# Declaratively provisions a Mail.app account via a generated .mobileconfig
# configuration profile, so a fresh machine's Mail app doesn't need manual
# IMAP/SMTP setup after signing into the Apple ID.
#
# Honest limits of this approach (macOS, not this config, imposes these):
#   - Since macOS Big Sur, `profiles install` can no longer install a
#     configuration profile fully unattended from the command line — the
#     user has to click "Install" once and enter their password. There is
#     no supported API to skip this. What this module *does* remove is
#     everything else: typing in the mail address, host names, ports,
#     SSL/auth settings, and the account password by hand.
#   - iCloud Mail specifically can't be provisioned this way at all — it
#     requires interactive Apple ID/OAuth sign-in, which is by design not
#     scriptable. This is for a regular IMAP/SMTP account (TU Berlin,
#     Gmail with an app password, etc).
#
# Fill in the real account details below, then follow README → "Apple Mail"
# to create the encrypted password secret this depends on.
{ config, lib, pkgs, ... }:

let
  secretsFile = ../../secrets/secrets.yaml;
  secretsBootstrapped = builtins.pathExists secretsFile;

  # --- none of this is secret; only the password goes through sops ---
  mailAddress = "leopold.sprenger@REPLACE_ME.tu-berlin.de"; # TODO: your real address
  imapHost = "REPLACE_ME"; # TODO: e.g. mail.tu-berlin.de
  smtpHost = "REPLACE_ME"; # TODO: usually the same host

  profileName = "leopold-mail.mobileconfig";
  profilePath = "/Users/leopoldsprenger/Library/Application Support/dotfiles/${profileName}";
  markerPath = "/Users/leopoldsprenger/.dotfiles-mail-profile-installed";
in
{
  config = lib.mkIf secretsBootstrapped {
    sops.templates.${profileName} = {
      path = profilePath;
      owner = "leopoldsprenger";
      content = builtins.replaceStrings
        [ "__MAIL_ADDRESS__" "__IMAP_HOST__" "__SMTP_HOST__" "__IMAP_PASSWORD__" ]
        [
          mailAddress
          imapHost
          smtpHost
          config.sops.placeholder."mail/imap_password"
        ]
        (builtins.readFile ../../resources/mail/leopold-mail.mobileconfig.tpl);
    };

    system.activationScripts.postActivation.text = ''
      # Offer to install the generated Mail profile once. macOS requires an
      # interactive click-through for configuration profiles, so this opens
      # it for you instead of pretending that step can be skipped.
      if [ -f "${profilePath}" ] && [ ! -f "${markerPath}" ]; then
        sudo -u leopoldsprenger open "${profilePath}"
        sudo -u leopoldsprenger touch "${markerPath}"
      fi
    '';
  };
}
