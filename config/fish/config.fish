
#####################################################
# GLOBAL VARIABLES
#####################################################
# set -gx TERM "tmux-256color"
set -gx TERM "xterm-256color"
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
set -gx BROWSER /Applications/Firefox.app/Contents/MacOS/firefox
set -gx GPG_TTY (tty)
set -gx KUBE_EDITOR "lvim"

set -gx AWS_PROFILE motimatic
set -gx AWS_DEFAULT_PROFILE default
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/ruby@3.1/lib/pkgconfig"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx NNN_OPENER "$XDG_CONFIG_HOME/nnn/plugins/nuke"

set -gx LANG "en_US.UTF-8"
set -gx OPENAI_KEY ""

set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

#####################################################
# PATH
#####################################################
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.npm/bin
fish_add_path $PYENV_ROOT/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/opt/ruby@3.1/bin
fish_add_path /opt/homebrew/opt/libpq/bin
fish_add_path /opt/homebrew/opt/ffmpeg@5/bin
fish_add_path $HOME/.config/emacs/bin
fish_add_path $HOME/.rd/bin
fish_add_path /usr/local/bin
fish_add_path $GOBIN

#####################################################
# ALIAS
#####################################################
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --icons --color=always --group-directories-first' # all files and dirs
alias ll='eza -l --color=always --group-directories-first' # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias lh='eza -a | egrep "^\."'
alias l.='eza -al --color=always --group-directories-first ../' # ls on the PARENT directory
alias l..='eza -al --color=always --group-directories-first ../../' # ls on directory 2 levels up
alias l...='eza -al --color=always --group-directories-first ../../../' # ls on directory 3 levels up


alias today="date +'%Y_%m_%d'"
alias clip="pbcopy"
alias notes='cd ~/.notes && lvim .'
alias cat='bat -pp --theme="neofusion"'
alias less='bat --theme="neofusion"'

alias qr="pbpaste | qrencode -o ~/Desktop/qrcode.png && open ~/Desktop/qrcode.png"
alias lzd="lazydocker"
alias gj="git jump"

alias emacs="emacsclient -c -a 'emacs'"
alias temacs="emacsclient -t -a ''"
alias em='/opt/homebrew/bin/emacs -nw'
alias pyink="~/.pyenv/versions/py3nvim/bin/pyink"
alias rem="killall emacs || killall Emacs-arm64-11 || echo 'Emacs server not running'; /opt/homebrew/bin/emacs --daemon"

alias cb="git rev-parse --abbrev-ref HEAD | tr -d '\n' | pbcopy"
alias dev="git checkout development && git pull origin development"
alias mybranches="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n | rg Arredondo | rg remote"

alias gogh='bash -c "$(curl -sLo- https://git.io/vQgMr)"'
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias nf='neofetch'
alias ff='fastfetch'
alias pf='pfetch'

# FZF neofusion theme
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#031B26,bg:#06101e,spinner:#fd5e3a,hl:#e2d9c5 \
--color=fg:#08435E,header:#e2d9c5,info:#35b5ff,pointer:#fa7a61 \
--color=marker:#fd5e3a,fg+:#66def9,prompt:#35b5ff,hl+:#fd5e3a"

#####################################################
# FUNCTIONS
#####################################################
function cls
  clear
  # if set -q TMUX
  #    exec tmux clear-history
  # end
  tmux clear-history
end

function geek-tmux-session
  if not set -q TMUX
      exec tmux new-session -ADs geek-1
  end
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

function rm-git-untraked
  git ls-files --others --exclude-standard | fzf -m | xargs rm
  echo "removed untracked files from project"
end

# if command -sq ngrok > /dev/null
#     eval (ngrok completion)
# end

#####################################################
# PROMPT
#####################################################
if status is-interactive

    eval (/opt/homebrew/bin/brew shellenv)

    # if not set -q TMUX
    #     exec tmux new-session -ADs geek-1
    # end

    # Commands to run in interactive sessions can go here
    # source ~/.env
    # The next line updates PATH for the Google Cloud SDK.
    if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end

    source ~/.asdf/asdf.fish
    pyenv init - | source
    starship init fish | source
end


