#!bash
#
# terminitor-completion
# ===================
# 
# Bash completion support for terminitor
# 
# 
# Installation
# ------------
# 
#  1. Install this file. Either:
# 
#     a. Place it in a `bash-completion.d` folder:
# 
#        * /etc/bash-completion.d
#        * /usr/local/etc/bash-completion.d
#        * ~/bash-completion.d
# 
#     b. Or, copy it somewhere (e.g. ~/.terminitor-completion.sh) and put the following line in
#        your .bashrc:
# 
#            source ~/.terminitor-completion.sh
# 
# 
# 
# The Fine Print
# --------------
# 
# Copyright (c) 2010 [Justin Hileman](http://justinhileman.com)
# 
# Distributed under the [MIT License](http://creativecommons.org/licenses/MIT/)

_terminitor()
{
    COMPREPLY=()
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Subcommand list
    local actions="delete generate help list open setup start"
    [[ ${COMP_CWORD} -eq 1 ]] && {
        COMPREPLY=( $(compgen -W "${actions}" -- ${cur}) )
        return
    }

    case "${prev}" in
    delete|open|start)
        COMPREPLY=( $(compgen -W "$( terminitor list | grep '*' | awk '{ print $2 }' )" -- ${cur}) )
        return 0
        ;;
    help)
        COMPREPLY=( $(compgen -W "${actions}" -- ${cur}) )
        return 0
        ;;
    *)
        ;;
    esac
}

complete -F _terminitor terminitor
