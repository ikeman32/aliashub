#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print error messages
error() {
    echo "Error: $1" >&2
    exit 1
}

# Function to enable Starship configuration by uncommenting lines
enable_starship_config() {
    local starship_config_file="$HOME/.alias/.starship_config"
    local prompts_file="$HOME/.alias/.prompts"

    echo "Enabling Starship configuration..."

    if [ -f "$starship_config_file" ]; then
        # Uncomment the line in .starship_config.
        sed -i 's/^# *//' "$starship_config_file"
        echo "Enabled starship theme in $starship_config_file."
    else
        echo "Warning: Starship config file not found at $starship_config_file."
    fi

    if [ -f "$prompts_file" ]; then
        # Uncomment the line 'eval "$(starship init bash)"'
        sed -i 's/^# *\(eval "$(starship init bash)"\)/\1/' "$prompts_file"
        echo "Enabled starship prompt in $prompts_file."
    else
        echo "Warning: Prompts file not found at $prompts_file."
    fi
}

# Function to check for and optionally install Starship
check_and_install_starship() {
    if command -v starship &> /dev/null; then
        echo "Starship is already installed."
        enable_starship_config
        return
    fi

    echo "Starship prompt not found."
    read -p "It is recommended for an enhanced prompt. Would you like to install it now? (y/n) " -n 1 -r
    echo # Move to a new line

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Installing Starship..."
        if ! command -v curl &> /dev/null; then
            error "curl is required to install Starship automatically. Please install curl and run the script again."
        fi

        # The '-- --yes' passes the '--yes' flag to the install script, not the shell
        sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes || error "Starship installation failed."

        echo "Starship installed successfully."
        enable_starship_config
    else
        echo "Skipping Starship installation. You can install it manually later."
    fi
}

# Function to configure the startup logo
configure_logo() {
    local bash_functions_file="$HOME/.alias/.bash_functions"
    local default_logo="Thunderbox"
    local chosen_logo=""

    read -p "Enter the text for your startup logo [default: Thunderbox]: " chosen_logo
    # If user enters nothing, use the default
    chosen_logo=${chosen_logo:-$default_logo}

    if [ -f "$bash_functions_file" ]; then
        # Use sed to replace the LOGO variable value.
        sed -i "s|^LOGO=.*|LOGO=\"$chosen_logo\"|" "$bash_functions_file"
        echo "Startup logo set to '$chosen_logo'."
    else
        echo "Warning: .bash_functions file not found at $bash_functions_file. Cannot set logo."
    fi
}

# Function to enable the logo by uncommenting the call in .bash_aliases
enable_logo() {
    local bash_aliases_file="$HOME/.alias/.bash_aliases"

    if [ -f "$bash_aliases_file" ]; then
        # Uncomment the 'logo' call at the end of the file
        sed -i 's/^# *\(logo\)$/\1/' "$bash_aliases_file"
        echo "Enabled startup logo display."
    else
        echo "Warning: .bash_aliases file not found at $bash_aliases_file. Cannot enable logo."
    fi
}

# Function to check for and optionally install figlet
check_and_install_figlet() {
    if command -v figlet &> /dev/null; then
        echo "Figlet is already installed."
        configure_logo
        enable_logo
        return
    fi

    echo "Figlet is not found."
    read -p "It is required to display the startup logo. Would you like to install it now? (y/n) " -n 1 -r
    echo # Move to a new line

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Installing figlet..."
        if command -v apt &> /dev/null; then
            sudo apt update && sudo apt install -y figlet || error "figlet installation failed."
        elif command -v pacman &> /dev/null; then
            sudo pacman -S --noconfirm figlet || error "figlet installation failed."
        else
            error "Cannot install figlet. Unsupported package manager. Please install it manually."
        fi
        echo "Figlet installed successfully."
        configure_logo
        enable_logo
    else
        echo "Skipping figlet installation. The startup logo will not be displayed."
    fi
}

# Function to update .bashrc
update_bashrc() {
    local bashrc_file="$HOME/.bashrc"
    local old_alias="~/.bash_aliases"
    local new_alias="~/.alias/.bash_aliases"

    if grep -q "$old_alias" "$bashrc_file"; then
        sed -i "s|$old_alias|$new_alias|g" "$bashrc_file"
        echo "Updated .bashrc successfully."
    else
        echo "Adding AliasHub configuration to .bashrc..."
        # Append the AliasHub sourcing block to .bashrc
        {
            echo ""
            echo "# AliasHub configuration"
            echo "if [ -f \"$new_alias\" ]; then"
            echo "    . \"$new_alias\""
            echo "fi"
        } >> "$bashrc_file"
        echo "Configuration added to .bashrc successfully."
    fi
}

# Function to detect distro and copy appropriate alias files
install_aliases() {
    local source_dir="./alias_files"
    local target_dir="$HOME/.alias"
    local distro=""

    echo "Installing alias files..."
    mkdir -p "$target_dir"

    # Copy all common (non-directory) alias files from the root of alias_files
    find "$source_dir" -maxdepth 1 -type f -exec cp {} "$target_dir" \;
    echo "Common alias files installed."

    # Detect distribution by checking for package managers
    if command -v pacman &> /dev/null; then
        distro="arch"
    elif command -v apt &> /dev/null; then
        distro="debian"
    else
        echo "Warning: Unsupported package manager. Could not determine distribution."
        echo "Package management aliases will not be installed. Please copy one manually from the 'alias_files' directory."
        return
    fi

    echo "Detected $distro-based distribution."

    # Copy the distribution-specific package alias file
    local pkg_alias_source="$source_dir/${distro}_aliases/.package"
    local pkg_alias_target="$target_dir/.package"

    if [ -f "$pkg_alias_source" ]; then
        cp "$pkg_alias_source" "$pkg_alias_target"
        echo "Installed package management aliases for $distro."
    else
        echo "Warning: Package alias file for $distro not found at '$pkg_alias_source'."
        echo "Defaulting to no package management aliases."
    fi
}

# Function to configure the default editor
configure_editor() {
    local confedit_file="$HOME/.alias/.confedit"
    local default_editor="nano"
    local chosen_editor=""

    # Ensure the target file exists before trying to modify it
    if [ ! -f "$confedit_file" ]; then
        echo "Warning: Configuration edit file not found at $confedit_file. Skipping editor setup."
        return
    fi

    read -p "Enter your preferred command-line editor [default: nano]: " chosen_editor
    # If user enters nothing, use the default
    chosen_editor=${chosen_editor:-$default_editor}

    # Check if the chosen editor is a valid command
    if ! command -v "$chosen_editor" &> /dev/null; then
        echo "Warning: Editor '$chosen_editor' not found in your PATH. Defaulting to '$default_editor'."
        chosen_editor=$default_editor
    fi

    # Update the .confedit file with the chosen editor
    sed -i "s|^edit=.*|edit='$chosen_editor'|" "$confedit_file"
    echo "Default editor set to '$chosen_editor'."
}

# Function to install the man page
install_man_page() {
    local man_source_file="./man/aliashub.1"
    local man_target_dir="/usr/local/share/man/man1"
    local man_target_file="$man_target_dir/aliashub.1"

    if [ ! -f "$man_source_file" ]; then
        echo "Warning: Man page source file not found at $man_source_file. Skipping installation."
        return
    fi

    echo "Attempting to install man page..."
    if command -v sudo &> /dev/null; then
        echo "Sudo privileges may be required to install the man page."
        sudo mkdir -p "$man_target_dir"
        sudo cp "$man_source_file" "$man_target_file" && echo "Man page installed to $man_target_file."
        if command -v mandb &> /dev/null; then
            sudo mandb &> /dev/null
        fi
    else
        echo "Warning: 'sudo' command not found. Cannot install man page system-wide."
        echo "Please copy '$man_source_file' to '$man_target_dir' manually."
    fi
}

# Main installation function
main_install() {
    echo "Starting installation process..."

    # Install alias files, detecting the distribution for package management
    install_aliases

    # Configure the default editor
    configure_editor

    # Check for figlet, offer to install, and configure the logo
    check_and_install_figlet

    # Update .bashrc
    update_bashrc

    # Check for Starship, offer to install, and configure it
    check_and_install_starship

    # Install the man page
    install_man_page

    echo "Installation completed successfully!"
}

# Run the script
main_install