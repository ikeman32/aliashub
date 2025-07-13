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

**Changes**
I've made some drastic changes to the prompt configuration because the original method sucked.
After discovering [starship](https://starship.rs/). Starship offers way better configurations for the
commandline than my feeble attempt at it. It is truned off by default because if you want to use it you have to choses to install it. 

13 July 2025
- Install script now has the ability to install starship and enable it.
- Typing prompts at the command line wil allow the user to change starship config on the fly
  with persistence.
- added man page very basic for now


# TODO

- remove personal additions to aliases
- detect Arch based distro and change package management from apt to pacman on install
- install figlet app and allow user to change the personal logo for the commandline
  currently set to Thunderbox
- add option to change default commandline editor for the aliases currently nano


## Installation

1. Clone the AliasHub repository:
git clone https://github.com/yourusername/AliasHub.git ~/.aliashub


2. Navigate to the AliasHub directory:
cd aliashub


3. Run the installation script:
chmod +x install.sh && ./install.sh

or 

bash install.sh


This script will automatically add the necessary line to your `~/.bashrc` file to set up AliasHub.

4. Reload your Bash configuration or restart your terminal:
source ~/.bashrc


## Usage

After installation, you can start using the pre-configured aliases immediately. Here are some examples:

- `pyrun`: Run a Python script
- `clone`: Clone a git repository
- `edalias`: Edit your bash aliases
- `upgrade`: Update and upgrade system packages

For a full list of available aliases, use the command:
alias


## Configuration

AliasHub's configuration files are located in the `~/.aliashub` directory. Key files include:

- `.bash_aliases`: Main alias definitions
- `.bash_functions`: Custom Bash functions
- `.cl`: Command-line shortcuts
- `.package`: Package management aliases
- `.prompts`: Prompt configurations

## Customization

To add your own aliases or modify existing ones:

1. Edit the appropriate configuration file (e.g., `~/.aliashub/.bash_aliases`)
2. Add your new alias or modify an existing one
3. Save the file and run `refresh` to reload your Bash configuration

## Contributing

Contributions to AliasHub are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.