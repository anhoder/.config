{ pkgs, ... }:
###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#
###################################################################################
{
  system = {
    stateVersion = 5;

    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      NSGlobalDomain = {
        AppleShowAllFiles = true;
        AppleEnableMouseSwipeNavigateWithScrolls = false;
        AppleEnableSwipeNavigateWithScrolls = false;
        AppleFontSmoothing = 1;
        AppleICUForce24HourTime = true;
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSScrollAnimationEnabled = true;
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        "com.apple.swipescrolldirection" = true;
      };
      finder = {
        AppleShowAllFiles = true;
        ShowStatusBar = false;
        ShowPathbar = true;
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = false;
        _FXSortFoldersFirst = true;
      };
      ActivityMonitor = {
        # ShowCategory = 103;
        IconType = 3;
        SortColumn = "CPUUsage";
        SortDirection = 0;
        OpenMainWindow = true;
      };
      menuExtraClock.Show24Hour = true; # show 24 hour clock
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  services.nix-daemon.enable = true;
}
