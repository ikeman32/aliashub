# AliasHub

AliasHub is a comprehensive alias management system for Bash, designed to enhance your command-line productivity and streamline your workflow. 

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Customization](#customization)
- [Contributing](#contributing)
- [License](#license)

## Features

- Centralized management of Bash aliases
- Pre-configured aliases for common tasks
- Easy-to-use command-line shortcuts
- Customizable prompt configurations via starship
- Organized structure for different types of aliases (e.g., git, navigation, package management)
- Flexible and extensible design

### Changelog

**July 2024**
- Replaced the previous custom prompt with [Starship](https://starship.rs/) for more powerful and flexible customization.
- The installer now interactively prompts the user to install Starship and enables it on confirmation.
- Added a basic man page for `aliashub`.
- The installation script now automatically detects the user's package manager (`apt` or `pacman`) and installs the correct aliases.
- Added support for Arch-based distributions.
- The installer checks for `figlet` and offers to install it, allowing the user to set a custom ASCII logo for their terminal startup.
- Users can now set their preferred command-line editor during installation.

## TODO

- **Create an `uninstall.sh` script:** A script to safely remove `~/.alias` and revert changes to `.bashrc`.
- **Add support for more distributions:** Extend package manager support to include `dnf` (Fedora) and `zypper` (openSUSE).
- **Review personal aliases:** Generalize any remaining user-specific aliases in files like `.cl` to be useful for a wider audience.
- **Add more alias modules:** Create new alias files for common developer tools like Docker, `kubectl`, etc.
- **Add support for other shells** `zsh`, `fish`, etc

## Installation

1. Clone the AliasHub repository:
```bash
git clone https://github.com/yourusername/AliasHub.git
```


2. Navigate to the AliasHub directory:
```bash
cd AliasHub
```


3. Run the installation script:
```bash
chmod +x install.sh
./install.sh
```


This script will automatically add the necessary line to your `~/.bashrc` file to set up AliasHub.

4. Reload your Bash configuration or restart your terminal:
```bash
source ~/.bashrc
```


## Usage

After installation, you can start using the pre-configured aliases immediately. Here are some examples:

- `pyrun`: Run a Python script
- `gcl`: Clone a git repository
- `edalias`: Edit your bash aliases
- `upgrade`: Update and upgrade system packages

For a full list of available aliases, use the command:
alias


## Configuration

AliasHub's configuration files are located in the `~/.alias` directory. Key files include:

- `.bash_aliases`: Main alias definitions
- `.bash_functions`: Custom Bash functions
- `.confedit`: Defines the editor used by `edalias`.
- `.cl`: Command-line shortcuts
- `.gitcmd`: Aliases for common Git commands.
- `.package`: Package management aliases
- `.python`: Aliases and functions for Python development.
- `.prompts`: Prompt configurations
- `.starship_config`: Configuration for the Starship prompt.

## Customization

To add your own aliases or modify existing ones:

1. Edit the appropriate configuration file (e.g., `~/.alias/.bash_aliases`)
2. Add your new alias or modify an existing one
3. Save the file and run `refresh` to reload your Bash configuration

## Contributing

Contributions to AliasHub are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.