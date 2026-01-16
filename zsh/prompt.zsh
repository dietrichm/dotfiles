# NvimLightBlue: #a6dbff
# NvimLightGreen: #b3f6c0
# NvimLightGrey4: #9a9da4
PROMPT='%F{#a6dbff}%~ %B%F{#b3f6c0}%#%f%b '
RPROMPT='%F{#9a9da4}%*%f'
ZLE_RPROMPT_INDENT=0

function _dotfiles_prompt_newline() {
    if [ -z "$_dotfiles_first_prompt_done" ]; then
        _dotfiles_first_prompt_done=1
        return
    fi
    printf "\n"
}

typeset -ag precmd_functions
precmd_functions+=(_dotfiles_prompt_newline)
