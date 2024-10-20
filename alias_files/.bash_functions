#!/usr/bin/env bash
# Change this variable to change the ASCII art logo
LOGO="Thunderbox"

# Function to add an app to the environment
addpath() {
    # Prompt the user for the path
    read -p "Enter the path to add to \$PATH: " new_path

    # Validate the path
    if [ ! -d "$new_path" ]; then
        echo "Error: The specified path does not exist or is not a directory."
        return 1
    fi

    # Path to config file
    config_file="$HOME/.env/.bash_exports"

    # Validate the file
    if [ ! -f "$config_file" ]; then
        echo "Error: The specified file does not exist."
        return 1
    fi

    # Check if the path is already in PATH
    if [[ ":$PATH:" == *":$new_path:"* ]]; then
        echo "The path is already in \$PATH. No changes made."
        return 0
    fi

    # Add the export statement to the specified file
    echo "export PATH=\"\$PATH:$new_path\"" >> "$config_file"

    echo "Path added successfully. Please run 'source $config_file' to apply changes."
}

# Function to create a logo requires figlet
logo(){
    figlet -c "$LOGO"
}

pyinit() {
    # $1: Accept an argument for a project
    project=$1 # Set project to first argument

    # Check if project name is provided
    if [ -z "$project" ]; then
        echo "Error: No project name provided."
        return 1
    fi

    # Import license variables
    if [ -f ~/.env/.license ]; then
        . ~/.env/.license
    else
        echo "Error: License file not found."
        return 1
    fi

    # Check for license or default to MIT License
    case "$2" in
        "gpl2")
            license="$gpl2"
            ;;
        "gpl3")
            license="$gpl3"
            ;;
        *)
            license="$mit"
            ;;
    esac

    # Make the project directory and if successful navigate to the directory
    if mkdir "$project"; then
        cd "$project" || { echo "Error: Failed to change directory to $project"; return 1; }
    else
        echo "Error: Failed to create project directory $project"
        return 1
    fi

    # Make a src directory
    mkdir 'src'

    # Create empty README file
    touch README.md

    # Write the license to a LICENSE file
    echo "$license" > LICENSE

    # Create virtual environment called myvenv
    if ! python3 -m venv myvenv; then
        echo "Error: Failed to create virtual environment."
        return 1
    fi

    echo "Project $project initialized successfully."
}