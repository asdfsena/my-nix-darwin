{
  description = "Aryasena's nix-darwin system flake";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url   = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {

      # ── System ────────────────────────────────────────────────────────────
      nixpkgs.hostPlatform        = "aarch64-darwin";
      system.primaryUser          = "asdfsena";
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion         = 6;

      # ── User ──────────────────────────────────────────────────────────────
      users.users.asdfsena.shell = pkgs.fish;

      # ── Networking ────────────────────────────────────────────────────────
      networking.hostName                          = "m1n1kyute";
      networking.applicationFirewall.enable        = true;
      networking.applicationFirewall.enableStealthMode = true;

      # ── Security ──────────────────────────────────────────────────────────
      security.pam.services.sudo_local.touchIdAuth = true;

      # ── Nix ───────────────────────────────────────────────────────────────
      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.trusted-users         = [ "root" "asdfsena" ];
      nix.gc = {
        automatic = true;
        options   = "--delete-older-than 30d";
        interval  = { Weekday = 0; Hour = 0; Minute = 0; };
      };

      # ── Environment ───────────────────────────────────────────────────────
      environment.variables.GHQ_ROOT = "$HOME/Sources";
      environment.systemPackages = with pkgs; [
        git gh ghq
        curl wget
        neovim btop fastfetch
        ffmpeg-full yt-dlp
        devenv gnupg
      ];

      # ── Programs ──────────────────────────────────────────────────────────
      programs.fish.enable   = true;
      programs.direnv.enable = true;
      programs.tmux = {
        enable      = true;
        enableVim   = true;
        enableMouse = true;
      };
      programs.gnupg.agent = {
        enable         = true;
        enableSSHSupport = true;
      };

      # ── Homebrew ──────────────────────────────────────────────────────────
      homebrew.enable = true;
      homebrew.casks  = [
        "zed"
        "github"
        "betterdisplay"
      ];
    };
  in
  {
    # darwin-rebuild build --flake .#m1n1kyute
    darwinConfigurations."m1n1kyute" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
