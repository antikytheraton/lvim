
#####################################################
# GLOBAL VARIABLES
#####################################################
set -gx GOPATH "$HOME/go"
set -gx GOBIN "$GOPATH/bin"
set -gx PYENV_ROOT "$HOME/.pyenv"
# set -gx DOCKER_HOST "unix:///run/docker.sock"
# set -gx DOCKER_HOST "unix:///home/antikytheraton/.local/share/containers/podman/machine/podman-machine-default/podman.sock"
set -gx DOCKER_CONFIG "$HOME/.docker"

set -gx PAGER "less -rR"
set -gx LESS "--mouse --wheel-lines=3"
set -gx VISUAL "lvim"
set -gx EDITOR "lvim"
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx BROWSER firefox
set -gx GPG_TTY (tty)

set -gx AWS_PROFILE default
set -gx AWS_DEFAULT_PROFILE default
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/ruby@3.1/lib/pkgconfig"


#####################################################
# PATH
#####################################################
fish_add_path $GOBIN
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.npm/bin
fish_add_path $PYENV_ROOT/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/opt/ruby@3.1/bin


#####################################################
# ALIAS
#####################################################
alias la='exa -al --color=always --icons --group-directories-first' # my preferred listing
alias ls='exa -a --color=always --icons --group-directories-first' # all files and dirs
alias ll='exa -l --color=always --icons --group-directories-first' # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

alias notes='cd ~/.notes && lvim .'
alias cat='bat -pp --theme="Dracula"'

alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

#####################################################
# FUNCTIONS
#####################################################
function cls
    clear
    tmux clear-history
end

function env_export --argument filename
  export (grep "^[^#]" $filename | xargs -L 1)
end

function poetry_env
  jq \
    --null-input \
    --arg venv "$(basename $(poetry env info -p))" \
    --arg venvPath "$(dirname $(poetry env info -p))" \
    '{ "venv": $venv, "venvPath": $venvPath }' \
    > pyrightconfig.json
end

function last_changes
  git diff $(git branch --show-current)@{1} $(git branch --show-current)
end

#####################################################
# PROMPT
#####################################################
if status is-interactive

    eval (/opt/homebrew/bin/brew shellenv)

    if not set -q TMUX
        exec tmux new-session -ADs geek-1
    end
    # Commands to run in interactive sessions can go here
    # source ~/.env
    # The next line updates PATH for the Google Cloud SDK.
    if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end

end

pyenv init - | source
starship init fish | source
