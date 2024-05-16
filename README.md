# Dotfiles

some of my dotfiles

## Installation

i am very sure you will forget how to set this up so here's some instructions

To set up your environment using these dotfiles, follow these steps:

1. **Clone the Repository**

    ```sh
    git clone https://github.com/haidousm/dotfiles.git
    cd dotfiles
    ```

2. **Run the Setup Script**

    The setup script will check for GNU Stow and Homebrew, install them if necessary, and then stow the current directory.

    ```sh
    ./setup.sh
    ```

## Using GNU Stow

GNU Stow is used to manage the dotfiles. It creates symlinks from the dotfiles directory to the appropriate locations in your home directory.

