#!/usr/bin/env bash

#!/bin/bash
#==============================================================================
#
#          FILE: .bash_aliases
#
#         USAGE: This file is sourced by .bashrc
#
#   DESCRIPTION: Central hub for custom Bash aliases and environment variable
#                exports. This file imports and organizes all custom alias
#                files and environment settings.
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#         NOTES: This file should be in the $HOME/.alias folder
#        AUTHOR: David H. Isakson II <david.isakson.ii@gmail.com>
#       CREATED: October 20, 2024
#      REVISION: 1.0
#==============================================================================

# import bash exports
if [ -f ~/.alias/.bash_exports ]; then
    . ~/.alias/.bash_exports
fi

# import bash functions
if [ -f ~/.alias/.bash_functions ]; then
    . ~/.alias/.bash_functions
fi

# import commandline aliases
if [ -f ~/.alias/.cl ]; then
    . ~/.alias/.cl
fi

# import apps
if [ -f ~/.alias/.apps ]; then
    . ~/.alias/.apps
fi

# import configuration edit
if [ -f ~/.alias/.confedit ]; then
    . ~/.alias/.confedit
fi

# import git commands
if [ -f ~/.alias/.gitcmd ]; then
    . ~/.alias/.gitcmd
fi

# import bash history configuration
if [ -f ~/.alias/.history_conf ]; then
    . ~/.alias/.history_conf
fi

# import navigation aliases
if [ -f ~/.alias/.navigation ]; then
    . ~/.alias/.navigation
fi

# import package management
if [ -f ~/.alias/.package ]; then
    . ~/.alias/.package
fi

# Import prompts
if [ -f ~/.alias/.prompts ]; then
    . ~/.alias/.prompts
fi

# Import python command
if [ -f ~/.alias/.python ]; then
    . ~/.alias/.python
fi

# Import ssh aliases
if [ -f ~/.alias/.ssh ]; then
    . ~/.alias/.ssh
fi


# Run logo function from .bash_functions
logo