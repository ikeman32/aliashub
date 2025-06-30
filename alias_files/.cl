#!/usr/bin/env bash

# Commandline shortcuts
alias refresh='clear && exec bash' # Reload bash without closing terminal
alias reboot='systemctl reboot -i' # Reboot the system
alias chmodx='chmod +x' # Make a file executable
alias sysinfo='inxi -Fxz' # Show system info
alias showpath='echo $PATH' # Show the PATH variable
alias bye='exit' # Exit the shell

alias mvit='mv */*.txt .' # Move all text files in child directorys to parent directory
alias rad='rmdir */' # Remove all child directories

# Window prompt throw backs
alias cls='clear' # Clear the screen
alias rd='rm -rf' # Remove directory recursively
alias rdnow='sudo rm -r' # Remove directory recursively with elevated privileges
alias md='mkdir' # Make directory 
alias mdnow='sudo mkdir' # Make directory with elevated privileges
alias del='rm' # Delete a file
alias delnow='sudo rm -i' # Delete file interactively with elevated privileges

alias path='echo $PATH'