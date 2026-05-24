{
  description = "Aryasena's nix-darwin system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
  }: let
    configuration = {pkgs, ...}: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        git
        gh
        ghq
        curl
        wget
        neovim
        btop
        fastfetch
        ffmpeg-full
        yt-dlp
        devenv
        gnupg
      ];

      environment.variables = {
        GHQ_ROOT = "$HOME/Work/Sources";
      };

      homebrew.enable = true;
      homebrew.casks = [
        "zed"
        "github"
        "orbstack"
        "obsidian"
        "obs"
      ];

      system.primaryUser = "asdfsena";
      security.pam.services.sudo_local.touchIdAuth = true;
      time.timeZone = "Asia/Jakarta";
      services.dnscrypt-proxy.enable = true;
      nix.gc = {
        automatic = true;
        interval = {
          Weekday = 0;
          Hour = 0;
          Minute = 0;
        };
        options = "--delete-older-than 30d";
      };

      # Necessary for using flakes on this system.
      nix.settings.trusted-users = ["root" "asdfsena"];
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;
      programs.fish.vendor.config.enable = true;
      programs.fish.vendor.completions.enable = true;
      programs.fish.vendor.functions.enable = true;
      programs.direnv.enable = true;
      users.users.asena.shell = pkgs.fish;

      programs.gnupg.agent.enable = true;
      programs.gnupg.agent.enableSSHSupport = true;

      programs.tmux.enable = true;
      programs.tmux.enableVim = true;
      programs.tmux.enableMouse = true;

      networking.hostName = "m1n1kyute";
      networking.applicationFirewall.enable = true;
      networking.applicationFirewall.enableStealthMode = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#m1n1kyute
    darwinConfigurations."m1n1kyute" = nix-darwin.lib.darwinSystem {
      modules = [configuration];
    };
  };
}
