
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
fish_add_path /opt/homebrew/opt/libpq/bin


#####################################################
# ALIAS
#####################################################
alias la='exa -al --color=always --icons --group-directories-first' # my preferred listing
alias ls='exa -a --color=always --icons --group-directories-first' # all files and dirs
alias ll='exa -l --color=always --icons --group-directories-first' # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

alias today="date +'%Y_%m_%d'"
alias clip="pbcopy"
alias notes='cd ~/.notes && lvim .'
alias cat='bat -pp --theme="Dracula"'
alias less='bat'

alias qr="pbpaste | qrencode -o ~/Desktop/qrcode.png && open ~/Desktop/qrcode.png"

alias cb="git rev-parse --abbrev-ref HEAD | tr -d '\n' | pbcopy"
alias dev="git checkout development && git pull origin development"
alias mybranches="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n | rg Arredondo | rg remote"

alias gogh='bash -c "$(curl -sLo- https://git.io/vQgMr)"'
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
  # git diff $(git branch --show-current)@{1} $(git branch --show-current)
  git diff $(__git.current_branch)@{1} $(__git.current_branch)
end

function fix_git_date
  # To fix the date on squashed commits to be today
  GIT_COMMITTER_DATE="$(date)" git commit --amend --no-edit --date "$(date)"
end

function create --argument filename
  mkdir -p "$(dirname "$filename")" && touch "$filename"
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
