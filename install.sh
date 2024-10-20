#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print error messages
error() {
    echo "Error: $1" >&2
    exit 1
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
        echo "The specified path was not found in .bashrc. No changes made."
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

# Main installation function
main_install() {
    echo "Starting installation process..."

    # Install .alias folder and files
    install_env_folder

    # Update .bashrc
    update_bashrc

    echo "Installation completed successfully!"
}

# Run the script
main_install