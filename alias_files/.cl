#!/usr/bin/env bash

# Commandline shortcuts
alias refresh='clear && exec bash'      # Reload bash without closing terminal
alias reboot='systemctl reboot -i'      # Reboot the system
alias chmodx='chmod +x'                 # Make a file executable
alias sysinfo='inxi -Fxz'               # Show system info (requires inxi)
alias showpath='echo $PATH'             # Show the PATH variable
alias bye='exit'                        # Exit the shell

# Navigation and Listing
alias ..='cd ..'
alias ...='cd ../..'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias his='history'

# Windows/DOS prompt throwbacks (use with caution)
alias cls='clear'                       # Clear the screen
alias md='mkdir'                        # Make directory
alias del='rm -i'                       # Delete a file interactively

# Potentially destructive aliases - aliased to safer, interactive versions
alias rd='rmdir'                        # Remove an empty directory (safer than 'rm -rf')
alias delnow='sudo rm -i'               # Delete file interactively with elevated privileges
alias rdnow='sudo rmdir'                # Remove empty directory with elevated privileges
alias mvit='mv -i -- */*.txt .'         # Interactively move all .txt files from subdirs to parent
alias rad='rmdir -v -- */'              # Verbose remove all empty child directories