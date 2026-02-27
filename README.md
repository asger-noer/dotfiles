# Dotfiles

This is a collection of my dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Restoring Settings on a New Machine

Follow these steps to set up your dotfiles on a fresh machine.

### Prerequisites

Install the required tools:

```sh
# macOS
brew install stow

# Linux (Debian/Ubuntu)
sudo apt install stow

# Linux (Arch)
sudo pacman -S stow
```

### Installation Steps

1. **Clone the repository**

```sh
cd ~
git clone https://github.com/asger-noer/dotfiles.git ~/github.com/asger-noer/dotfiles
cd ~/github.com/asger-noer/dotfiles
```

2. **Backup existing configs (optional but recommended)**

```sh
# Backup any existing configs you want to keep
mv ~/.zshrc ~/.zshrc.backup
mv ~/.config/nvim ~/.config/nvim.backup
# ... backup other configs as needed
```

3. **Deploy dotfiles with Stow**

```sh
stow -t ~ zsh
stow -t ~ git
# ... stow other packages as needed
```

4. **Verify symlinks**

Check that symlinks were created correctly:

```sh
ls -la ~/.zshrc
ls -la ~/.config/git
```

You should see symlinks pointing to your dotfiles directory.

### Package Structure

This repository uses the following structure:

```
dotfiles/
├── zsh/
│   └── .zshrc
├── nvim/
│   └── .config/
│       └── nvim/
└── package-name/
    └── .config/
        └── app-name/
```

Each package directory mirrors the structure that will be created in your home directory.

## GPG Setup

You need to have GPG installed and a GPG key set up to sign commits. Follow the steps below to fetch and trust the GPG key used for signing.

### Fetch GPG public key

Fetch the GPG public key used to sign commits:

```sh
gpg --edit-card # Opens the GPG card interface
```

```sh
fetch # Fetch the public key from the card
quit  # Exits the GPG card interface
```

### Trust the key locally

```sh
gpg --edit-key <EMAIL> # Replace <EMAIL> with the email associated with the GPG key
```

```sh
trust # Start the trust command
5     # Set the trust level to "I trust ultimately"
y     # Confirm the trust level
quit  # Exit the GPG key interface
```

## Adding New Configs

To add an existing config from your home directory to this repository:

### Method 1: Manual Move

```sh
cd ~/github.com/asger-noer/dotfiles

# Create package structure
mkdir -p package-name/.config

# Move existing config
mv ~/.config/app-name package-name/.config/

# Stow it
stow -t ~ package-name
```

### Method 2: Using --adopt

```sh
cd ~/github.com/asger-noer/dotfiles

# Create package structure
mkdir -p package-name/.config/app-name

# Adopt existing config (moves files from ~ to dotfiles)
stow --adopt -t ~ package-name

# Review changes
git diff

# Commit if satisfied
git add .
git commit -m "Add package-name configuration"
```

## Removing Dotfiles

To remove symlinks and restore your home directory:

```sh
cd ~/github.com/asger-noer/dotfiles

# Unstow all packages
stow -D -t ~ */

# Or unstow individual packages
stow -D -t ~ zsh
```

## Troubleshooting

### Conflicts

If Stow reports conflicts, it means files already exist at the target location. Remove or backup the existing files first:

```sh
mv ~/.zshrc ~/.zshrc.backup
stow -t ~ zsh
```

### Wrong Symlinks

If symlinks point to the wrong location, unstow and restow:

```sh
stow -D -t ~ package-name
stow -t ~ package-name
```

### Checking What Would Happen

Use the `-n` (dry-run) flag to see what Stow would do without making changes:

```sh
stow -n -t ~ zsh
```
