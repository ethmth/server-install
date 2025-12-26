#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

if ! ( cat "$HOME/.bashrc" | grep -q "osc7_cwd()" ); then
echo "osc7_cwd() {
    local strlen=\${#PWD}
    local encoded=\"\"
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=\${PWD:\$pos:1}
        case \"\$c\" in
            [-/:_.!\'\(\)~[:alnum:]] ) o=\"\${c}\" ;;
            * ) printf -v o '%%%02X' \"'\${c}\" ;;
        esac
        encoded+=\"\${o}\"
    done
    printf '\e]7;file://%s%s\e\\\' \"\${HOSTNAME}\" \"\${encoded}\"
}
PROMPT_COMMAND=\${PROMPT_COMMAND:+\$PROMPT_COMMAND; }osc7_cwd" >> "$HOME/.bashrc"
fi

## This should already be included in .profile/.bash_profile
#if ! ( cat "$HOME/.bashrc" | grep -q "PATH=\$PATH:$HOME/.local/bin" ); then
#echo "PATH=\$PATH:$HOME/.local/bin" >> "$HOME/.bashrc"
#fi
