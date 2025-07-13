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

# Function to install .alias folder and files
install_env_folder() {
    local source_dir="./alias_files"  # Directory containing your .alias files
    local target_dir="$HOME/.alias"

    # Create .alias directory if it doesn't exist
    mkdir -p "$target_dir"

    # Copy all files, including hidden ones, from source directory to .alias
    shopt -s dotglob  # Enable including hidden files in * expansion
    cp -R "$source_dir"/* "$target_dir" 2>/dev/null || true
    shopt -u dotglob  # Disable including hidden files in * expansion

    echo "Installed .alias folder and files successfully."
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

    # Install .alias folder and files
    install_env_folder

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