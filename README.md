# Installation

> Purely handwritten. No AI. #NPD

```bash
# Install xcode cmdline
xcode-select --install

# Install fish
curl -L https://github.com/fish-shell/fish-shell/releases/download/4.1.2/fish-4.1.2.pkg -o ~/Downloads/fish.pkg # manually install by clicking the bundle

# Setup fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && \
    fisher install jorgebucaran/autopair.fish && \
    fisher install catppuccin/fish && \
    fish_config theme save "catppuccin-mocha"

# System Preferences
# take screenshots as jpg (usually smaller size) and not png
defaults write com.apple.screencapture type jpg && \
    # do not open previous previewed files (e.g. PDFs) when opening a new one
    defaults write com.apple.Preview ApplePersistenceIgnoreState YES && \
    # show Library folder
    chflags nohidden ~/Library && \
    # show hidden files
    defaults write com.apple.finder AppleShowAllFiles YES && \
    # show path bar
    defaults write com.apple.finder ShowPathbar -bool true && \
    # show status bar
    defaults write com.apple.finder ShowStatusBar -bool true && \
    # Restart Finder
    killall Finder;

# Install Homebrew Package Manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Nix Package Manager
curl -L https://github.com/NixOS/experimental-nix-installer/releases/download/0.27.0/nix-installer.sh | sh -s -- install

# Clone this repo to /etc/nix-darwin
sudo git clone https://github.com/sena25519/my-nix-darwin.git /etc/nix-darwin

# Install Nix-Darwin
sudo nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin/master#darwin-rebuild -- switch

# Import gpg keys
gpg --import /path/to/gpgkey

# configure git
git config --global init.defaultBranch main
git config --global user.name "Aryasena Putra"
git config --global user.email "workasena@gmail.com"
git config --global user.signingkey \<YOUR_GPG_KEY_ID\>
git config --global commit.gpgsign true

# optional tmux conf
wget -O ~/.tmux.conf https://raw.githubusercontent.com/dreamsofcode-io/tmux/refs/heads/main/tmux.conf
```
