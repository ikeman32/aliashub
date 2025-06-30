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

bluetooth(){
    sudo hcitool cc 28:6F:40:BB:0D:BD
}

mkds() {
    # Check if two arguments are provided
    if [ $# -ne 2 ]; then
        echo "Usage: create_dirs <start_number> <end_number>"
        return 1
    fi

    # Extract start and end numbers from the arguments
    n1=$1
    n=$2

    # Create directories from n1 to n
    for ((i=n1; i<=n; i++)); do
        mkdir "$i"
    done

    echo "Directories created from $n1 to $n"
}

mvrf() {
    # Check if three arguments are provided
    if [ $# -ne 3 ]; then
        echo "Usage: move_random_files <source_directory> <destination_directory> <number_of_files>"
        return 1
    fi

    # Extract arguments
    source_dir=$1
    dest_dir=$2
    num_files=$3

    # Get a list of all .txt files in the source directory
    # Use find instead of globs to handle spaces and special characters correctly
    files=($(find "$source_dir" -maxdepth 1 -type f -name "*.txt"))

    # Get the total number of .txt files
    total_files=${#files[@]}

    # Check if there are enough files to move
    if [ $num_files -gt $total_files ]; then
        echo "There are only $total_files .txt files in $source_dir, but you requested $num_files."
        return 1
    fi

    # Shuffle the files and move the first n files
    selected_files=($(shuf -e "${files[@]}" | head -n $num_files))

    for file in "${selected_files[@]}"; do
        mv "$file" "$dest_dir"
        echo "Moved $file to $dest_dir"
    done
    msg="$num_files files have been moved"
    clear
    echo "$msg"
}

