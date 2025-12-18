# Dotfiles

This is a collection of my dotfiles. I use [GNU Stow](https://www.gnu.org/software/stow/) to manage them.

## GPG setup

You need to have GPG installed and a GPG key set up to sign commits. Follow the steps below to fetch and trust the GPG key used for signing.

### Fetch GPG public key

Fetch the gpg public key used to sign commits:

```sh
gpg --edit-card # Opens the GPG card interface
```

```sh
fetch # Fetch the public key from the card
quit # Exits the GPG card interface
```

### Trust the key locally

```sh
gpg --edit-key <EMAIL> # Replace <EMAIL> with the email associated with the GPG key
```

```sh
trust # Start the trust command
5    # Set the trust level to "I trust ultimately"
y    # Confirm the trust level 
quit # Exit the GPG key interface
```

## Installation

```sh
# Clone the repository
git clone https://github.com/asger-noer/dotfiles.git

# Change to the dotfiles directory
cd dotfiles

# Stow the dotfiles to the home directory
stow --dotfiles -t ~ .
```
